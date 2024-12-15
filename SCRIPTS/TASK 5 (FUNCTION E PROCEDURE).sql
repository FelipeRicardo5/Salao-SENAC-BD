-- FUNÇÕES E PROCEDURES
-- 1: Calculo do INSS
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

-- 2: Calculo do IRRF
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

-- 3: Total gasto do cliente
DELIMITER $$

CREATE FUNCTION totalgasto(cliente_cpf VARCHAR(11))
RETURNS DECIMAL(6,2) DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(6,2) DEFAULT 0.0;
    SELECT SUM(v.valor) INTO total
    FROM tbl_venda v
    JOIN tbl_agendamento a ON v.tbl_agendamento_idtbl_agendamento = a.idtbl_agendamento
    JOIN tbl_cadastroCliente c ON a.tbl_cadastroCliente_idtbl_cadastroCliente = c.idtbl_cadastroCliente
    WHERE c.tbl_cliente_cpf = cliente_cpf;
    
    RETURN total;
END $$

DELIMITER ;

select * from tbl_cliente;
select totalgasto('13579135791') from tbl_cliente;

-- 4: Preço unitario do serviço
DELIMITER $$

CREATE FUNCTION precounitservico(tbl_servico_idtbl_servico INT)
RETURNS DECIMAL(6,2) DETERMINISTIC
BEGIN
    DECLARE preco DECIMAL(6,2);
    SELECT iv.precoUnitario
    INTO preco
    FROM tbl_itensservicos iv
    JOIN tbl_servico s ON iv.tbl_servico_idtbl_servico = s.idtbl_servico
    WHERE s.idtbl_servico = tbl_servico_idtbl_servico
    LIMIT 1;
    
    RETURN preco;
END $$

DELIMITER ;

select precounitservico(3) FROM tbl_itensservicos;

-- Nome dos clientes maiusculo
select upper(nome) from tbl_cliente;

-- Total de clientes
SELECT count(nome) AS totalcliente FROM tbl_cliente;

-- Total de funcionário
SELECT count(nome) AS totalfunc FROM tbl_funcionario;

-- Total de profissional
SELECT count(nome) AS totalprofissional FROM tbl_profissional;


-- 5: Faturamento de um servico
delimiter $$
	CREATE FUNCTION Calcfaturamentoservicos(precoUnitario DECIMAL(10, 2), quantidade INT)
	RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
	RETURN precoUnitario * quantidade;
END $$
delimiter ;

SELECT Calcfaturamentoservicos (100, 10);

-- 6: Faturamento mensal de uma venda
DELIMITER $$
	CREATE FUNCTION calcfaturamentomensal(precoUnitario DECIMAL(10, 2), quantidade INT, dias INT)
    RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
	RETURN ((precoUnitario * quantidade) * dias);
END $$
DELIMITER ;
SELECT calcfaturamentomensal(30, 14, 30);

-- 7: Calcular vale transporte
DELIMITER $$

CREATE FUNCTION VT (salario DECIMAL(6, 2))
RETURNS DECIMAL(6, 2) DETERMINISTIC
BEGIN
    DECLARE vale_transporte DECIMAL(6, 2);
    
    -- O desconto máximo do vale-transporte é 6% do salário bruto
    SET vale_transporte = salario * 0.06;
    
    -- Retorna o valor do desconto
    RETURN vale_transporte;
END $$

DELIMITER ;

-- REMOVER CLIENTE
DELIMITER $$
CREATE PROCEDURE remover_clientes(IN p_cpf VARCHAR(11))
BEGIN
	DELETE FROM tbl_cliente
    WHERE cpf = p_cpf;
END $$

DELIMITER ;

CALL remover_clientes('12345678901');

-- ADICIONAR CLIENTE
DELIMITER $$
CREATE PROCEDURE adicionarcliente(p_cpf VARCHAR(11), p_nome VARCHAR(44), p_email VARCHAR(255))
BEGIN 
	INSERT INTO tbl_cliente(cpf, nome, email)
	VALUES(p_cpf, p_nome, p_email);
END $$

DELIMITER ;

-- REGISTRAR SERVIÇO
DELIMITER $$
CREATE PROCEDURE registrarservico(
    r_idtbl_registroServico INT, 
    r_nomeCliente VARCHAR(45), 
    r_valor DECIMAL(6,2), 
    r_status VARCHAR(45), 
    r_data DATETIME, 
    r_tbl_funcionario_cpf VARCHAR(11), 
    r_formapag VARCHAR(45)
)
BEGIN 
    INSERT INTO tbl_registroservico (
        idtbl_registroServico, 
        nomeCliente, 
        valor, 
        status, 
        data, 
        tbl_funcionario_cpf, 
        formapag
    )
    VALUES (
        r_idtbl_registroServico, 
        r_nomeCliente, 
        r_valor, 
        r_status, 
        r_data, 
        r_tbl_funcionario_cpf, 
        r_formapag
    );
END $$
DELIMITER ;
