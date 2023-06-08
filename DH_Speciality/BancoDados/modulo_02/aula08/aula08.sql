DELIMITER $$

CREATE PROCEDURE musimundos.numeros (IN numeros VARCHAR(100), OUT soma DOUBLE, OUT media DOUBLE)
BEGIN
	DECLARE quantidade int default 0;
    SET soma = 0;
    
    numeros_loop: loop
    SET quantidade = quantidade + 1;
    CASE WHEN (cast(left(numeros, locate(';', numeros)-1) as double) > 0) then 
		SET soma=soma + CAST(left(numeros, locate(';', numeros)-1) as double);
	 ELSE SET quantidade = quantidade - 1;
     END CASE;
     
     SET numeros = right(numeros, char_length(numeros) - locate(';', numeros));
     
     if (locate(';', numeros) = 0) then LEAVE numeros_loop;
     END IF;
     
     END loop;
     
     SET media = soma / quantidade;
     
     end  $$$
      
      DELIMITER $$
      CALL musimundos.numeros('10;66;138;37;-72;-5', @soma, @media);

$$