-- FUNÇÕES E PROCEDURES
-- F1: Calculo do INSS
DELIMITER $$

CREATE FUNCTION inss(salario DECIMAL(6,2))
RETURNS DECIMAL(6,2) DETERMINISTIC
BEGIN
	DECLARE inss DECIMAL(6,2) DEFAULT 0.0;
    IF salario <= 1320.00
		THEN SET inss = salario * 0.075;
	ELSEIF salario > 1320.00 AND salario <= 2571.29 
		THEN SET inss = salario * 0.09;
	ELSEIF salario > 2571.29 AND salario <= 3856.94
		THEN SET inss = salario * 0.12;
	ELSEIF salario > 3856.949 AND salario <= 7507.49
		THEN SET inss = salario * 0.14;
	END IF;
    RETURN inss;
END $$

DELIMITER ;

-- F2: Calculo do IRRF
DELIMITER $$

CREATE FUNCTION irrf(salario DECIMAL(6,2))
RETURNS DECIMAL(6,2) DETERMINISTIC
BEGIN
	DECLARE irrf DECIMAL(6,2) DEFAULT 0.0;
    IF salario >= 2259.21 AND salario <= 2826.65
		THEN SET irrf = salario * 0.075;
	ELSEIF salario > 2826.66  AND salario <= 3751.05
		THEN SET irrf = salario * 0.15;
	ELSEIF salario > 3751.06  AND salario <= 4664.68
		THEN SET irrf = salario * 0.225;
	ELSEIF salario > 4664.69
		THEN SET irrf = salario * 0.275;
	END IF;
    RETURN irrf;
END $$

DELIMITER ;