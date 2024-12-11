-- Listar todos os clientes:
SELECT * FROM `salaosenac`.`tbl_cliente`;

-- Consultar os serviços prestados por um profissional específico (por CPF):
SELECT s.servicoPrestado, p.nome AS profissional_nome
FROM `salaosenac`.`tbl_servico` s
JOIN `salaosenac`.`tbl_profissional` p ON s.tbl_profissional_cpf = p.cpf
WHERE p.cpf = '12345678901';  -- CPF utilizado como exemplo

-- Exibir todos os registros de feedback de um cliente específico:
SELECT f.*, s.servicoPrestado
FROM `salaosenac`.`feedback` f
JOIN `salaosenac`.`tbl_servico` s ON f.tbl_servico_idtbl_servico = s.idtbl_servico
WHERE f.tbl_cliente_cpf = '12345678901';  -- Substitua pelo CPF do cliente desejado

-- Listar os agendamentos realizados por um cliente (por CPF):
SELECT a.dia, a.hora, a.tipo
FROM `salaosenac`.`tbl_agendamento` a
JOIN `salaosenac`.`tbl_cadastroCliente` c ON a.tbl_cadastroCliente_idtbl_cadastroCliente = c.idtbl_cadastroCliente
WHERE c.cpf = '12345678901';  -- Substitua pelo CPF do cliente desejado

-- Exibir todos os serviços prestados em um determinado dia:
SELECT s.servicoPrestado, f.data_feedback, f.experiencia
FROM `salaosenac`.`tbl_servico` s
JOIN `salaosenac`.`feedback` f ON s.idtbl_servico = f.tbl_servico_idtbl_servico
WHERE f.data_feedback = '2024-12-05';

-- Listar vendas realizadas para um cliente específico (por CPF):
SELECT v.valor, v.idtbl_venda
FROM `salaosenac`.`tbl_venda` v
JOIN `salaosenac`.`tbl_cadastroCliente` c ON v.tbl_cadastroCliente_idtbl_cadastroCliente = c.idtbl_cadastroCliente
WHERE c.cpf = '12345678901';  -- Substitua pelo CPF do cliente desejado

-- Listar todas as vendas realizadas no sistema:
SELECT * FROM `salaosenac`.`tbl_venda`;

-- Exibir serviços prestados durante um agendamento específico:
SELECT s.servicoPrestado, i.precoUnitario, i.valorTotal
FROM `tbl_itensServicos` i
JOIN `salaosenac`.`tbl_servico` s ON i.tbl_servico_idtbl_servico = s.idtbl_servico
JOIN `salaosenac`.`tbl_agendamento` a ON i.tbl_agendamento_idtbl_agendamento = a.idtbl_agendamento
WHERE a.idtbl_agendamento = 1;  -- Substitua pelo ID do agendamento desejado

-- Exibir o total de vendas realizadas em um período específico:
SELECT FORMAT(SUM(v.valor), 2, 'pt_BR') AS total_vendas
FROM `salaosenac`.`tbl_venda` v
WHERE v.valor BETWEEN 100 AND 200;

-- Listar os serviços prestados e a avaliação do cliente (feedback):
SELECT s.servicoPrestado, f.avaliacao, f.experiencia
FROM `salaosenac`.`tbl_servico` s
JOIN `salaosenac`.`feedback` f ON s.idtbl_servico = f.tbl_servico_idtbl_servico;

-- Exibir os profissionais que prestaram serviços em um agendamento específico:
SELECT p.nome AS profissional_nome
FROM `salaosenac`.`tbl_servico` s
JOIN `salaosenac`.`tbl_profissional` p ON s.tbl_profissional_cpf = p.cpf
JOIN `salaosenac`.`tbl_agendamento` a ON s.tbl_registroServico_idtbl_registroServico = a.idtbl_agendamento
WHERE a.idtbl_agendamento = 1;  -- Substitua pelo ID do agendamento desejado

-- Consultar os serviços realizados em um agendamento e o preço total:
SELECT i.precoUnitario, i.valorTotal
FROM `tbl_itensServicos` i
WHERE i.tbl_agendamento_idtbl_agendamento = 1;

-- Consultar os feedbacks recebidos para um serviço específico:
SELECT f.*, c.nome AS cliente_nome
FROM `salaosenac`.`feedback` f
JOIN `salaosenac`.`tbl_cliente` c ON f.tbl_cliente_cpf = c.cpf
WHERE f.tbl_servico_idtbl_servico = 1; 

-- Exibir todos os agendamentos para um serviço específico:
SELECT a.dia, a.hora
FROM `salaosenac`.`tbl_agendamento` a
JOIN `salaosenac`.`tbl_itensServicos` i ON a.idtbl_agendamento = i.tbl_agendamento_idtbl_agendamento
WHERE i.tbl_servico_idtbl_servico = 1;

-- Listar todos os profissionais que prestaram um determinado serviço:
SELECT DISTINCT p.nome AS profissional_nome
FROM `salaosenac`.`tbl_servico` s
JOIN `salaosenac`.`tbl_profissional` p ON s.tbl_profissional_cpf = p.cpf
WHERE s.idtbl_servico = 1;

-- Exibir todos os serviços realizados com uma avaliação superior a 4:
SELECT s.servicoPrestado, f.avaliacao
FROM `salaosenac`.`tbl_servico` s
JOIN `salaosenac`.`feedback` f ON s.idtbl_servico = f.tbl_servico_idtbl_servico
WHERE f.avaliacao > 4;

-- Consultar todos os serviços com o preço total superior a um valor específico (por exemplo, R$ 150):
SELECT s.servicoPrestado, FORMAT(i.valorTotal, 2, 'pt_BR') valor
FROM `salaosenac`.`tbl_servico` s
JOIN `salaosenac`.`tbl_itensServicos` i ON s.idtbl_servico = i.tbl_servico_idtbl_servico
WHERE i.valorTotal > 50;

-- fornecer informações sobre o registro, incluindo o funcionario que registrou
SELECT 
    r.formapag, 
    COUNT(*) AS quantidade, 
    f.nome AS nome_funcionario
FROM 
    salaosenac.tbl_registroServico r
JOIN 
    salaosenac.tbl_funcionario f
ON 
    r.tbl_funcionario_cpf = f.cpf
GROUP BY 
    r.formapag, f.nome
ORDER BY 
    quantidade DESC, f.nome;

-- VERIFICAR

- Listar os clientes com maior número de agendamentos realizados:
SELECT tbl_cliente_cpf, COUNT(a.idtbl_agendamento) AS total_agendamentos
FROM `salaosenac`.`tbl_cadastroCliente` c
JOIN `salaosenac`.`tbl_agendamento` a ON c.idtbl_cadastroCliente = a.tbl_cadastroCliente_idtbl_cadastroCliente
GROUP BY tbl_cliente_cpf
ORDER BY total_agendamentos DESC;

-- Exibir o valor total de vendas realizadas por cliente:
SELECT tbl_cliente_cpf, SUM(v.valor) AS total_vendas
FROM `salaosenac`.`tbl_venda` v
JOIN `salaosenac`.`tbl_cadastroCliente` c ON v.tbl_cadastroCliente_idtbl_cadastroCliente = c.idtbl_cadastroCliente
GROUP BY tbl_cliente_cpf;
