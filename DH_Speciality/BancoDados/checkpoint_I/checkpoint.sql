# Checkpoint I 
# Disciplina: Banco de Dados
# Lucas Gabriel Fernandes Johann

DELIMITER ;;
-- Distribuição das vacinas entre os centros principais, desconsiderando os secundários
CREATE PROCEDURE sp_distribuir_vacinas(IN data_inicio DATE, IN data_fim DATE) 
BEGIN
    DECLARE qtdCidades INT;
    DECLARE qtdTotalInteressados INT;
    DECLARE idCidade, idPais, qtdInteressados INT;
    DECLARE lotesParaDistribuir INT;
    DECLARE loop_idLote INT;
    DECLARE loop_qtdDosesLote INT;
    DECLARE loop_qtdDosesCidade INT;
    DECLARE loop_idCidade INT;
    DECLARE loop_idCentroVacinacaoPrincipal INT;
    DECLARE loop_qtdRestanteDoses INT;
    
    -- Verifica se há lotes para distribuir
    DECLARE cQtdLotes CURSOR FOR 
    SELECT
       idLote,
       qtd 
    FROM
       lote 
       LEFT JOIN
          centrovacinacao_has_lote AS cvhl 
          ON lote.idLote = cvhl.Lote_idLote 
    WHERE
       Lote_idLote IS NULL;
    
    -- Em caso de erro, a tabela temporária deve estar fora da procedure.
    DECLARE cQtdDosesParaCidade CURSOR FOR 
    SELECT
       interessados,
       idCidade 
    FROM
       tmp_InteressadosCidade;
    
    -- Criação da tabela temporária para armazenamento dos interessados por cidade 
    CREATE TEMPORARY TABLE IF NOT EXISTS tmp_InteressadosCidade (
       idCidade INT,
       idPais INT,
       interessados INT
    ) AS 
    SELECT
       cidade_idcidade AS idCidade,
       c.Pais_idPais AS idPais,
       COUNT(*) AS interessados 
    FROM
       Pessoa 
       INNER JOIN
          cidade AS c 
          ON Pessoa.cidade_idcidade = c.id 
       LEFT JOIN
          turno AS t 
          ON Pessoa.id = t.Pessoa_id 
    WHERE
       t.id IS NULL 
    GROUP BY
       cidade_idcidade;
    
    -- Total de interessados para cálculo base do número de doses suficiente para distribuição
    SELECT
       SUM(interessados) INTO qtdTotalInteressados 
    FROM
       tmp_InteressadosCidade;
    
    -- Percorre a distribuição de lotes
    OPEN cQtdLotes;
    distribuicao_lotes: LOOP 
        FETCH cQtdLotes INTO loop_idLote, loop_qtdDosesLote;
        
        -- Verificar se não há mais registros
        IF @@FETCH_STATUS <> 0 THEN
           LEAVE distribuicao_lotes;
        END IF;
        
        -- Verifica se atende pelo menos 50% da população total
        IF qtdTotalInteressados / 2 <= loop_qtdDosesLote THEN
           -- Verifica se há possibilidade de atender toda a população
           IF qtdTotalInteressados < loop_qtdDosesLote THEN
               -- Distribuir a quantidade de doses para os locais
               distribuir_lotes_para_interessados: LOOP 
                   FETCH cQtdDosesParaCidade INTO loop_qtdDosesCidade, loop_idCidade;
                   
                   -- Captura o centro de vacinação principal
                   SELECT
                       id INTO loop_idCentroVacinacaoPrincipal 
                   FROM
                       centrovacinacao 
                   WHERE
                       cidade_id = loop_idCidade 
                       AND esPrincipal = 1 
                   LIMIT 1;
                   
                   START TRANSACTION;
                   -- Insere 50% das doses necessárias para cada cidade
                   CALL usp_centrovacinacaoLote_Agregar(loop_idCentroVacinacaoPrincipal, loop_idLote, loop_qtdDosesLote, data_inicio, data_fim);
                   
                   IF ROW_COUNT() > 0 THEN
                       COMMIT;
                   ELSE
                       ROLLBACK;
                   END IF;
               END LOOP;
           ELSE
               -- Quantidade de vacinas total
               SET loop_qtdRestanteDoses = loop_qtdDosesLote;
               
               -- Distribui 50% das doses para cada local
               distribuir_lotes_para_interessados: LOOP 
                   FETCH cQtdDosesParaCidade INTO loop_qtdDosesCidade, loop_idCidade;
                   
                   -- Captura o centro de vacinação principal
                   SELECT
                       id INTO loop_idCentroVacinacaoPrincipal 
                   FROM
                       centrovacinacao 
                   WHERE
                       cidade_id = loop_idCidade 
                       AND esPrincipal = 1 
                   LIMIT 1;
                   
                   START TRANSACTION;
                   -- Insere 50% das doses necessárias para a cidade
                   CALL usp_centrovacinacaoLote_Agregar(loop_idCentroVacinacaoPrincipal, loop_idLote, ROUND(loop_qtdDosesLote / 2), data_inicio, data_fim);
                   
                   IF ROW_COUNT() > 0 THEN
                       SET loop_qtdRestanteDoses = loop_qtdRestanteDoses - ROUND(loop_qtdDosesLote / 2);
                       COMMIT;
                   ELSE
                       ROLLBACK;
                   END IF;
               END LOOP;
           END IF;
        ELSE
           SELECT "Quantidade de doses é menor que o necessário";
        END IF;
    END LOOP;
    
    CLOSE cQtdLotes;
END;;
;;
DELIMITER ;

-- 2. Criar a SP 'Cria Certificado'
DELIMITER ;;
CREATE PROCEDURE sp_cria_certificado (IN in_idPessoa INT, IN in_idDose INT) 
BEGIN
    DECLARE nome VARCHAR(45);
    DECLARE sobrenome VARCHAR(45);
    DECLARE diaEntreVacinas INT;
    DECLARE diaDaUltimaVacina DATETIME;
    DECLARE intervaloEntreDoses INT;
    DECLARE infoHTML VARCHAR(255);
    
    -- Inicio da montagem do texto html
    SET infoHTML = "<DIV>";
    
    -- Captura do intervalo entre doses 
    SELECT v.qtdMaximaDiasEntredoses INTO intervaloEntreDoses 
    FROM vacina AS v 
    INNER JOIN doses AS d ON v.idvacina = d.Vacina_idVacina 
    WHERE d.iddoses = in_idDose;
    
    -- Captura a data da ultima dose
    SELECT MAX(dataCriacao) INTO diaDaUltimaVacina 
    FROM certificado 
    WHERE idPessoa = in_idPessoa;
    
    IF diaDaUltimaVacina IS NULL THEN
        SELECT p.Nome INTO nome 
        FROM Pessoa AS p 
        WHERE id = in_idPessoa;
        
        SELECT p.Sobrenome INTO sobrenome 
        FROM Pessoa AS p 
        WHERE id = in_idPessoa;
        
        SET infoHTML = CONCAT(infoHTML, "<p>Nome: &nbsp;", nome, "</p><br><p>Sobrenome: &nbsp;", sobrenome, "</p><p>Dose aplicada: 1</p><p>Data da dose: ", NOW(), "</p></DIV>");
        
        START TRANSACTION;
        INSERT INTO certificado (idPessoa, numero_doses, certificado, dataCriacao) 
        VALUES (in_idPessoa, 1, infoHTML, NOW());
        
        IF ROW_COUNT() > 0 THEN
            COMMIT;
        ELSE
            ROLLBACK;
        END IF;
    ELSE
        IF (DATEDIFF(NOW(), diaDaUltimaVacina) >= intervaloEntreDoses) THEN
            SELECT p.Nome INTO nome 
            FROM Pessoa AS p 
            WHERE id = in_idPessoa;
            
            SELECT p.Sobrenome INTO sobrenome 
            FROM Pessoa AS p 
            WHERE id = in_idPessoa;
            
            SET infoHTML = CONCAT(infoHTML, "<p>Nome: &nbsp;", nome, "</p><br><p>Sobrenome: &nbsp;", sobrenome, "</p><p>Dose aplicada: 1</p><p>Data da dose: ", NOW(), "</p></DIV>");
            
            START TRANSACTION;
            INSERT INTO certificado (idPessoa, numero_doses, certificado, dataCriacao) 
            VALUES (in_idPessoa, 1, infoHTML, NOW());
            
            IF ROW_COUNT() > 0 THEN
                COMMIT;
            ELSE
                ROLLBACK;
            END IF;
        ELSE
            -- ERROR
            SELECT "Houve um erro na criação do certificado";
        END IF;
    END IF;
END;;
DELIMITER ;

CALL sp_cria_certificado(1, 1);
