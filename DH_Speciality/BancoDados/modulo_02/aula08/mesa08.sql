USE dhemprestimos;

/* 1. Precisamos criar um procedimento armazenado que insira um cliente, SP_Cliente_Insert, que receba os dados do cliente e os 
insira na tabela clientes, caso não haja cliente com o mesmo número de RG. */

DELIMITER $$
CREATE PROCEDURE sp_cliente_insert(rg VARCHAR(50), sobrenome VARCHAR(50), nome VARCHAR(50), data_nasc DATE)
BEGIN
	IF (SELECT COUNT(*) FROM clientes WHERE clientes.rg = rg) = 0 THEN
		INSERT INTO clientes (rg, sobrenome, nome, data_nasc) 
			   VALUES (rg, sobrenome, nome, data_nasc);
	END IF;
END
$$

CALL sp_cliente_insert('102', 'da Silva', 'Jose', '00-01-12');

/* 2. Criar uma função fn_ValidaIdade que, dada a data de nascimento da pessoa (AAAAMMDD), 
a data de início do empréstimo (AAAAMMDD) e a qtd  de parcelas, verifique se atende à condição de que a pessoa 
não tenha mais de 80 anos no final do empréstimo. */
DELIMITER $$
CREATE FUNCTION fn_validadeIdade(data_nasc DATE, data_inicio_emprestimo DATE, qtd_parcelas INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE dataFinalEmprestimo DATE;
    DECLARE idadeFinalEmprestimo INT;
    
    SET dataFinalEmprestimo = date_add(data_inicio_emprestimo, interval qtd_parcelas MONTH);
    SET idadeFinalEmprestimo = timestampdiff(YEAR, data_nasc, dataFinalEmprestimo); 
    
    IF idadeFinalEmprestimo > 80 THEN
		RETURN 'O cliente terá mais que 80 anos.';
	ELSE 
		RETURN 'O cliente terá menos que 80 anos.';
	END IF;
END
$$

SELECT fn_validadeIdade('2000-01-01', '2022-01-01', 12) AS idade_maior_que_80;
SELECT fn_validadeIdade('1965-01-01', '2023-01-01', 300) AS idade_maior_que_80;

/* 3. Criar uma função fn_diaUtil que, dada uma data (AAAAMMDD), retorne a mesma data se for um dia útil — 
segunda a sexta — ou se não for dia útil — se for sábado ou domingo — retorne a data do primeiro dia útil seguinte. */
DELIMITER $$
CREATE FUNCTION fn_diaUtil(dia DATE)
RETURNS DATE
DETERMINISTIC
BEGIN
	DECLARE dia_semana INT;
    SET dia_semana = dayofweek(dia); 
    
    IF dia_semana IN (1, 7) THEN
		RETURN date_add(dia, interval 9 - dia_semana day);
	ELSE
		RETURN dia;
	END IF;
END
$$

SELECT fn_diaUtil('2022-01-04') AS diaUtil;

/*
4. Criar um stored procedure SP_Gera_Parcela que, dado um valor, data de início e número de parcelas, 
gere os detalhes das parcelas.

Considerar:
- As parcelas são mensais — com intervalo de 30 dias.
- A data de vencimento só pode cair em dias úteis.
- Por exemplo: SP_Genera_Parcela (100000,'20220101',5). O resultado deve ser o seguinte: 

	Nro de parcela   Data        Importe
	1                03/01/2022  20000
	2                31/01/2022  20000
	3                02/03/2022  20000
	4                01/04/2022  20000
	5                02/05/2022  20000
*/
DELIMITER $$
CREATE PROCEDURE sp_gera_parcela(IN valor DECIMAL(10,2), IN data_inicio DATE, IN num_parcelas INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE data_vencimento DATE;
		
	DROP TABLE IF EXISTS parcelas;
	CREATE TEMPORARY TABLE parcelas(valor DECIMAL(10,2), data_vencimento DATE, num_parcela INT);
    
    WHILE i <= num_parcelas DO
        SET data_vencimento = DATE_ADD(data_inicio, INTERVAL (i-1)*30 DAY);
        -- Verificar se a data de vencimento é um dia útil e ajustar se necessário
        INSERT INTO parcelas(valor, data_vencimento, num_parcela) VALUES (valor, data_vencimento, i);
        SET i = i + 1;
    END WHILE;
    SELECT num_parcela AS 'Nro de parcela', 'data_vencimento' AS Data, valor AS 'Importe'
	FROM parcelas;
END 
$$

CALL sp_gera_parcela(100000,'20220101',5);