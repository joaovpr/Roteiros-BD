--CLIENTES PODEM TER MAIS DE UM ENDEREÇO
--OS ENDEREÇOS PODEM SER RESIDENCIA, TRABALHO OU OUTRO
--MEDICAMENTOS PODEM TER VENDA EXCLUSIVA COM RECEITA


CREATE TYPE estado AS ENUM('PB','RN','SE','Al','BA','PI','PE','CE','MA'); 

CREATE TABLE farmacia (
  id bigint PRIMARY KEY NOT NULL,
  bairro VARCHAR(140) NOT NULL,
  cidade CHAR(140) NOT NULL,
  estado estado NOT NULL,
  gerente_cpf CHAR(11) 
);


CREATE TYPE funcao AS ENUM('farmaceutico','vendedor','entregador','caixa','administrador'); 


CREATE TABLE funcionarios (
    nome VARCHAR(140) NOT NULL,
    cpf CHAR(11) PRIMARY KEY NOT NULL,
    funcao funcao NOT NULL,
    farmacia_id bigint NOT NULL
);

CREATE TABLE medicamentos(
    nome VARCHAR(140) NOT NULL,
    id bigint PRIMARY KEY NOT NULL,
    need_receita VARCHAR(1)
);

CREATE TABLE vendas(
    id_venda bigint PRIMARY KEY NOT NULL,
    cliente_venda_id bigint NOT NULL,
    medicamento_venda_id bigint NOT NULL,
    funcionario_venda_id bigint NOT NULL
);

CREATE TABLE entregas(
    id_entrega bigint PRIMARY KEY NOT NULL,
    cliente_entrega_id bigint NOT NULL
);

CREATE TYPE endereco AS ENUM('residencia','trabalho','outro'); 

CREATE TABLE cliente(
    nome VARCHAR(140) NOT NULL,
    id bigint NOT NULL PRIMARY KEY,
    endereco endereco NOT NULL
);

-- FARMACIA PODE SER SEDE OU FILIAL
CREATE TYPE farm AS ENUM('sede','filial');

ALTER TABLE farmacia ADD tipo farm NOT NULL;

-- CADA FUNCIONARIO ESTA LOTADO EM UMA FARMACIA 

ALTER TABLE funcionarios ADD CONSTRAINT fgk_farmacia FOREIGN KEY (farmacia_id) REFERENCES farmacia (id);

--CADA FARMACIA TEM APENAS UM GERENTE QUE E FUNCIONARIO

ALTER TABLE FARMACIA ADD CONSTRAINT fgk_gerente FOREIGN KEY (gerente_cpf) REFERENCES funcionarios (cpf);
ALTER TABLE FARMACIA ADD CONSTRAINT gerente_excl EXCLUDE (gerente_cpf WITH=);

--UM FUNCIONARIO PODE NAO ESTAR LOTADO EM NENHUMA FARMACIA

ALTER TABLE funcionarios ALTER COLUMN farmacia_id DROP NOT NULL;

--ENTREGAS PODEM SER FEITAS APENAS PARA CLIENTES CADASTRADOS
ALTER TABLE entregas ADD CONSTRAINT fgk_cliente FOREIGN KEY (cliente_entrega_id) REFERENCES cliente (id);

--CLIENTES CADASTRADOS DEVEM SER MAIORES DE 18 ANOS
ALTER TABLE cliente ADD idade int NOT NULL;
ALTER TABLE cliente ADD CONSTRAINT idade_valida CHECK (idade >= 18);

--SO PODE HAVER UMA FARMACIA POR BAIRRO
ALTER TABLE farmacia ADD CONSTRAINT bairro_unico EXCLUDE(bairro WITH=);

--HA APENAS UMA SEDE
ALTER TABLE farmacia ADD CONSTRAINT unica_sede EXCLUDE(tipo WITH=) WHERE (tipo = 'sede');


--GERENTES PODEM SER APENAS ADMINISTRADORES OU FARMACEUTICOS
ALTER TABLE farmacia add gerente_funcao funcao;
ALTER TABLE farmacia add constraint funcao_gerente_valida check(gerente_funcao = 'administrador' or gerente_funcao = 'farmaceutico');


--VENDA DEVE SER FEITA POR VENDEDOR
ALTER TABLE VENDAS ADD COLUMN vendedor_funcao funcao;
ALTER TABLE VENDAS ADD CONSTRAINT funcao_vendedor_valida CHECK (vendedor_funcao = 'vendedor');

