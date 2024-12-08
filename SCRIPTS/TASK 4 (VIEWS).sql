-- Feedbacks
CREATE VIEW feedbacks AS
SELECT c.nome 'Cliente', c.cpf 'CPF', c.email 'E-mail', f.experiencia 'Experiência'
FROM tbl_cliente c 
JOIN feedback f ON c.cpf = f.tbl_cliente_cpf;

-- Profissionais + Serviço prestado
CREATE VIEW profissionais_servicos AS
SELECT p.nome 'Profissional', p.cpf 'CPF', p.ch 'Carga Horária', s.servicoPrestado 'Serviço Prestado'
FROM tbl_profissional p
RIGHT JOIN tbl_servico s ON p.cpf = s.tbl_profissional_cpf;

-- Dependentes dos funcionários
CREATE VIEW dependentes_funcionarios AS
SELECT d.nome 'Dependente', TIMESTAMPDIFF(YEAR, d.dataNasc, now()) 'Idade', d.parentesco 'Parentesco',
f.nome 'Funcionário Responsável', f.nomeSocial 'Nome Social', f.cpf 'CPF', f.email 'Email', f.sexo 'Sexo', f.estadoCivil 'Estado Civil', f.salario 'Remuneração' 
FROM tbl_funcionario f
JOIN tbl_dependente d ON f.cpf = d.tbl_funcionario_cpf; 

-- Dependentes dos profissionais
CREATE VIEW dependentes_profissionais AS
SELECT d.nome 'Dependente', TIMESTAMPDIFF(YEAR, d.dataNasc, now()) 'Idade', d.parentesco 'Parentesco',
p.nome 'Profissional Responsável', p.nomeSocial 'Nome Social', p.cpf 'CPF', p.email 'Email', p.sexo 'Sexo', p.estadoCivil 'Estado Civil', p.salario 'Remuneração' 
FROM tbl_profissional p
JOIN tbl_dependente d ON p.cpf = d.tbl_profissional_cpf; 

-- Telefone dos funcionários
CREATE VIEW telefone_funcionarios AS
SELECT f.nome 'Funcionário', t.numero 'Telefone'
FROM tbl_funcionario f
JOIN tbl_telefone t ON f.cpf = t.tbl_funcionario_cpf;


