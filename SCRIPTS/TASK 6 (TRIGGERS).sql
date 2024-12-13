 DELIMITER //
-- 1. Trigger Itens Serviço Quantidade
CREATE TRIGGER trg_aumenta_quantidade_itensServicos -- Se a quantidade for aumentando, ele vai aumentando o valor total
BEFORE UPDATE ON tbl_itensServicos
FOR EACH ROW
BEGIN
    IF NEW.quantidade > OLD.quantidade THEN
        SET NEW.valorTotal = OLD.valorTotal + 
        (NEW.quantidade - OLD.quantidade) * NEW.precoUnitario;
    END IF;
END;
//
-- Ativador da Trigger 
-- UPDATE tbl_itensServicos
-- SET quantidade = quantidade + 2 -- Aumenta a quantidade em 2
-- WHERE tbl_agendamento_idtbl_agendamento = 1 AND tbl_servico_idtbl_servico = 1; -- Substitua pelos IDs correspondentes
DELIMITER ;

DELIMITER //
-- 2. Trigger Itens Serviço Quantidade
CREATE TRIGGER trg_diminui_quantidade_itensServicos -- se a quantidade for diminuindo o valor total também será subtraido 
BEFORE UPDATE ON tbl_itensServicos
FOR EACH ROW
BEGIN
    IF NEW.quantidade < OLD.quantidade THEN
        SET NEW.valorTotal = OLD.valorTotal - 
        (OLD.quantidade - NEW.quantidade) * NEW.precoUnitario;
    END IF;
END;
//
-- Ativador da trigger:
-- UPDATE tbl_itensServicos
-- SET quantidade = quantidade - 1 -- Diminui a quantidade em 1
-- WHERE tbl_agendamento_idtbl_agendamento = 1 AND tbl_servico_idtbl_servico = 1; 
DELIMITER ;

DELIMITER //
-- 3. Trigger Itens Serviço Desconto
CREATE TRIGGER trg_aumenta_desconto_itensServicos -- Quando o desconto for inserido irá alterar o ValorTotal
BEFORE UPDATE ON tbl_itensServicos
FOR EACH ROW
BEGIN
    IF NEW.desconto > OLD.desconto THEN
        SET NEW.valorTotal = NEW.precoUnitario * 
        NEW.quantidade * (1 - NEW.desconto / 100);
    END IF;
END;
//
-- Ativador da trigger
-- UPDATE tbl_itensServicos
-- SET desconto = desconto + 10 -- Aumenta o desconto em 10%
-- WHERE tbl_agendamento_idtbl_agendamento = 1 AND tbl_servico_idtbl_servico = 1; 

DELIMITER ;

DELIMITER //
-- 4. Trigger Itens Serviço Desconto
CREATE TRIGGER trg_diminui_desconto_itensServicos -- Se o Desconto for diminuido o Valor do Total será alterado
BEFORE UPDATE ON tbl_itensServicos
FOR EACH ROW
BEGIN
    IF NEW.desconto < OLD.desconto THEN
        SET NEW.valorTotal = NEW.precoUnitario * NEW.quantidade * (1 - NEW.desconto / 100);
    END IF;
END;
//

DELIMITER ;
-- Ativador da Trigger
-- UPDATE tbl_itensServicos
-- SET desconto = desconto - 5 -- Reduz o desconto em 5%
-- WHERE tbl_agendamento_idtbl_agendamento = 1 AND tbl_servico_idtbl_servico = 1; 

DELIMITER //
-- 5. Trigger Profissional Comissão
CREATE TRIGGER trg_aumenta_comissao_profissional -- O aumento do valor da comissão, aumenta o valor do salário consequentemente.
BEFORE UPDATE ON tbl_profissional
FOR EACH ROW
BEGIN
    IF NEW.comissao > OLD.comissao THEN
        SET NEW.salario = OLD.salario + 
        (NEW.comissao - OLD.comissao);
    END IF;
END;
//
-- Ativador da Trigger
-- UPDATE tbl_profissional
-- SET comissao = comissao + 200 -- Aumenta a comissão em 200
-- WHERE cpf = "12345678901" ; 
DELIMITER ;

DELIMITER //
-- 6. Trigger Profissional Comissão
CREATE TRIGGER trg_diminui_comissao_profissional -- Ao subtrair do valor da comissão, diminui o valor do salário consequentemente.
BEFORE UPDATE ON tbl_profissional
FOR EACH ROW
BEGIN
    IF NEW.comissao < OLD.comissao THEN
        SET NEW.salario = OLD.salario - 
        (OLD.comissao - NEW.comissao);
    END IF;
END;
//
-- Ativador da trigger 
-- UPDATE tbl_profissional
-- SET comissao = comissao - 200 -- Diminui a comissão em 100
-- WHERE cpf = "12345678901";
DELIMITER ;
