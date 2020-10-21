--COMENTARIOS: 
--ALUNO: João Vitor Patricio Romão - MATRICULA: 118211058

-- Criação do tipo 'farm' como ENUM que pode ser = 'sede' ou 'filial'
-- Criação do tipo 'funcao' como ENUM que pode ser = 'farmaceutico' ou 'vendedor' ou 'entregador' ou 'caixa' ou 'administrador'
-- Criação da constraint foreign key para id farmacia em funcionario referenciando a um id de farmacia existente
-- Criação de foreign key e uso de exclude para evitar repetições
-- Farmacia id em funcionário pode ser NULL
-- Criação do tipo 'endereco' como ENUM que pode ser = 'residencia' ou 'trabalho' ou 'outro'
-- Campo need_receita na criação de medicamento
-- Criação de foreign key entre cliente_entrega_id e cliente id
-- Constraint check que verifica se a idade do cliente > 18 anos
-- Cambo bairro de uma farmacia tratado como unique
-- Exlude para quando houver duas farmacias com campo tipo = 'sede'
-- Criação do campo gerente_funcao na table farmacia e check se essa campo é = 'administrador' ou 'farmaceutico'
-- Criação do campo vendedor_funcao na table vendas e check se esse campo é = 'vendedor'






--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.23
-- Dumped by pg_dump version 9.5.23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.farmacia DROP CONSTRAINT fgk_gerente;
ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT fgk_farmacia;
ALTER TABLE ONLY public.entregas DROP CONSTRAINT fgk_cliente;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT unica_sede;
ALTER TABLE ONLY public.medicamentos DROP CONSTRAINT medicamentos_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT gerente_excl;
ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT funcionarios_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_pkey;
ALTER TABLE ONLY public.entregas DROP CONSTRAINT entregas_pkey;
ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT bairro_unico;
DROP TABLE public.vendas;
DROP TABLE public.medicamentos;
DROP TABLE public.funcionarios;
DROP TABLE public.farmacia;
DROP TABLE public.entregas;
DROP TABLE public.cliente;
DROP TYPE public.funcao;
DROP TYPE public.farm;
DROP TYPE public.estado;
DROP TYPE public.endereco;
DROP EXTENSION btree_gist;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: endereco; Type: TYPE; Schema: public; Owner: joaovpr
--

CREATE TYPE public.endereco AS ENUM (
    'residencia',
    'trabalho',
    'outro'
);


ALTER TYPE public.endereco OWNER TO joaovpr;

--
-- Name: estado; Type: TYPE; Schema: public; Owner: joaovpr
--

CREATE TYPE public.estado AS ENUM (
    'PB',
    'RN',
    'SE',
    'Al',
    'BA',
    'PI',
    'PE',
    'CE',
    'MA'
);


ALTER TYPE public.estado OWNER TO joaovpr;

--
-- Name: farm; Type: TYPE; Schema: public; Owner: joaovpr
--

CREATE TYPE public.farm AS ENUM (
    'sede',
    'filial'
);


ALTER TYPE public.farm OWNER TO joaovpr;

--
-- Name: funcao; Type: TYPE; Schema: public; Owner: joaovpr
--

CREATE TYPE public.funcao AS ENUM (
    'farmaceutico',
    'vendedor',
    'entregador',
    'caixa',
    'administrador'
);


ALTER TYPE public.funcao OWNER TO joaovpr;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: joaovpr
--

CREATE TABLE public.cliente (
    nome character varying(140) NOT NULL,
    id bigint NOT NULL,
    endereco public.endereco NOT NULL,
    idade integer NOT NULL,
    CONSTRAINT idade_valida CHECK ((idade >= 18))
);


ALTER TABLE public.cliente OWNER TO joaovpr;

--
-- Name: entregas; Type: TABLE; Schema: public; Owner: joaovpr
--

CREATE TABLE public.entregas (
    id_entrega bigint NOT NULL,
    cliente_entrega_id bigint NOT NULL
);


ALTER TABLE public.entregas OWNER TO joaovpr;

--
-- Name: farmacia; Type: TABLE; Schema: public; Owner: joaovpr
--

CREATE TABLE public.farmacia (
    id bigint NOT NULL,
    bairro character varying(140) NOT NULL,
    cidade character(140) NOT NULL,
    estado public.estado NOT NULL,
    gerente_cpf character(11),
    tipo public.farm NOT NULL,
    gerente_funcao public.funcao,
    CONSTRAINT funcao_gerente_valida CHECK (((gerente_funcao = 'administrador'::public.funcao) OR (gerente_funcao = 'farmaceutico'::public.funcao)))
);


ALTER TABLE public.farmacia OWNER TO joaovpr;

--
-- Name: funcionarios; Type: TABLE; Schema: public; Owner: joaovpr
--

CREATE TABLE public.funcionarios (
    nome character varying(140) NOT NULL,
    cpf character(11) NOT NULL,
    funcao public.funcao NOT NULL,
    farmacia_id bigint
);


ALTER TABLE public.funcionarios OWNER TO joaovpr;

--
-- Name: medicamentos; Type: TABLE; Schema: public; Owner: joaovpr
--

CREATE TABLE public.medicamentos (
    nome character varying(140) NOT NULL,
    id bigint NOT NULL,
    need_receita character varying(1)
);


ALTER TABLE public.medicamentos OWNER TO joaovpr;

--
-- Name: vendas; Type: TABLE; Schema: public; Owner: joaovpr
--

CREATE TABLE public.vendas (
    id_venda bigint NOT NULL,
    cliente_venda_id bigint NOT NULL,
    medicamento_venda_id bigint NOT NULL,
    funcionario_venda_id bigint NOT NULL,
    vendedor_funcao public.funcao,
    CONSTRAINT funcao_vendedor_valida CHECK ((vendedor_funcao = 'vendedor'::public.funcao))
);


ALTER TABLE public.vendas OWNER TO joaovpr;

--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: joaovpr
--



--
-- Data for Name: entregas; Type: TABLE DATA; Schema: public; Owner: joaovpr
--



--
-- Data for Name: farmacia; Type: TABLE DATA; Schema: public; Owner: joaovpr
--



--
-- Data for Name: funcionarios; Type: TABLE DATA; Schema: public; Owner: joaovpr
--



--
-- Data for Name: medicamentos; Type: TABLE DATA; Schema: public; Owner: joaovpr
--



--
-- Data for Name: vendas; Type: TABLE DATA; Schema: public; Owner: joaovpr
--



--
-- Name: bairro_unico; Type: CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT bairro_unico EXCLUDE USING btree (bairro WITH =);


--
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);


--
-- Name: entregas_pkey; Type: CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.entregas
    ADD CONSTRAINT entregas_pkey PRIMARY KEY (id_entrega);


--
-- Name: farmacia_pkey; Type: CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_pkey PRIMARY KEY (id);


--
-- Name: funcionarios_pkey; Type: CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_pkey PRIMARY KEY (cpf);


--
-- Name: gerente_excl; Type: CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT gerente_excl EXCLUDE USING btree (gerente_cpf WITH =);


--
-- Name: medicamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.medicamentos
    ADD CONSTRAINT medicamentos_pkey PRIMARY KEY (id);


--
-- Name: unica_sede; Type: CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT unica_sede EXCLUDE USING btree (tipo WITH =) WHERE ((tipo = 'sede'::public.farm));


--
-- Name: vendas_pkey; Type: CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_pkey PRIMARY KEY (id_venda);


--
-- Name: fgk_cliente; Type: FK CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.entregas
    ADD CONSTRAINT fgk_cliente FOREIGN KEY (cliente_entrega_id) REFERENCES public.cliente(id);


--
-- Name: fgk_farmacia; Type: FK CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT fgk_farmacia FOREIGN KEY (farmacia_id) REFERENCES public.farmacia(id);


--
-- Name: fgk_gerente; Type: FK CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT fgk_gerente FOREIGN KEY (gerente_cpf) REFERENCES public.funcionarios(cpf);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

