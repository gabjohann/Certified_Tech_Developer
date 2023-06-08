/* Use pelo menos duas cláusulas revisadas na aula. As cláusulas SELECT e FROM 
não constam para este exercício. 
Resolva as dúvidas propostas por você.
*/
USE DHtube;

SELECT 
    idUsuario, nome
FROM
    usuario
WHERE
    Avatar_idAvatar <= 20;
    
SELECT 
    nome AS nome_pais
FROM
    pais
WHERE
    idPais < 55
ORDER BY nome_pais
LIMIT 10;