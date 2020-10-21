--CRIANDO AS TABLES COM SEUS RESPECTIVOS ATRIBUTOS E SUAS RESPECTIVAS PRIMARY KEYS

CREATE TABLE automovel
(
    modelo VARCHAR(40) NOT NULL,
    marca VARCHAR(40) NOT NULL,
    ano INTEGER NOT NULL,
    chassi CHAR(17) NOT NULL,
    placa CHAR(7) NOT NULL,
    cor CHAR(40) NOT NULL,
    PRIMARY KEY(chassi)

);

CREATE TABLE segurado(
nome_segurado VARCHAR(40) NOT NULL,
num_rg_segurado CHAR(9) NOT NULL,
num_cpf_segurado CHAR(11) NOT NULL,
telefone_segurado CHAR(9) NOT NULL,
PRIMARY KEY(num_cpf_segurado)

);

CREATE TABLE perito(
  nome_perito VARCHAR(40) NOT NULL,
  num_rg_perito CHAR(9) NOT NULL,
  num_cpf_perito CHAR(11) NOT NULL,
  telefone_perito CHAR(9) NOT NULL,
  PRIMARY KEY(num_cpf_perito)

);

CREATE TABLE oficina(
  nome_ofcina VARCHAR(40) NOT NULL,
  cnpj_oficina CHAR(14) NOT NULL,
  localizacao_oficina_cidade VARCHAR(40) NOT NULL,
  PRIMARY KEY(cnpj_oficina)

);

CREATE TABLE seguro(
  seguro_id_apolice CHAR(10) NOT NULL,
  data_validade DATE NOT NULL,
  PRIMARY KEY (seguro_id_apolice)

);

CREATE TABLE sinistro(
  sinistro_id CHAR(20) NOT NULL,
  ocorrencia CHAR(40) NOT NULL,
  descricao_ocorrencia TEXT NOT NULL,
  PRIMARY KEY(sinistro_id)
);

CREATE TABLE pericia(
  pericia_id CHAR(20) NOT NULL,
  descricao_pericia TEXT NOT NULL,
  data_realizacao_pericia DATE NOT NULL,
  PRIMARY KEY(pericia_id)

);

CREATE TABLE reparo(
  tipo_reparo VARCHAR(40) NOT NULL,
  data_reparo DATE NOT NULL,
  reparo_id CHAR(20) NOT NULL,
  custo_reparo NUMERIC NOT NULL,
  PRIMARY KEY(reparo_id)
);

--ADICIONANDO AS FOREIGN KEYS DAS TABLES CRIADAS

ALTER TABLE automovel ADD CONSTRAINT FK_chassiseguro FOREIGN KEY (chassi) REFERENCES seguro (seguro_id_apolice);
ALTER TABLE segurado ADD CONSTRAINT FK_chassisegurado FOREIGN KEY (num_cpf_segurado) REFERENCES automovel(chassi);
ALTER TABLE perito ADD CONSTRAINT FK_peritopericia FOREIGN KEY (num_cpf_perito) REFERENCES pericia(pericia_id);
ALTER TABLE oficina ADD CONSTRAINT FK_oficinareparo FOREIGN KEY (cnpj_oficina) REFERENCES reparo(reparo_id);
ALTER TABLE seguro ADD CONSTRAINT FK_segurosinistro FOREIGN KEY (seguro_id_apolice) REFERENCES sinistro(sinistro_id);
ALTER TABLE seguro ADD CONSTRAINT FK_seguroreparo FOREIGN KEY (seguro_id_apolice) REFERENCES reparo(reparo_id);   
ALTER TABLE pericia ADD CONSTRAINT FK_periciaperito FOREIGN KEY (pericia_id) REFERENCES perito(num_cpf_perito);

--APAGANDO TODAS AS TABLES CRIADAS

DROP TABLE automovel CASCADE;
DROP TABLE oficina CASCADE;
DROP TABLE pericia CASCADE;
DROP TABLE perito CASCADE;
DROP TABLE reparo CASCADE;
DROP TABLE segurado CASCADE;
DROP TABLE seguro CASCADE;
DROP TABLE sinistro CASCADE;

