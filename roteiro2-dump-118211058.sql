--Comentários:
--ALUNO: João Vitor Patricio Romão - MATRICULA: 118211058 - ROTEIRO 2

--QUEST 1: Criação da Table tarefas, e teste das inserções passadas
--QUEST 2: Mudança do tipo do id para BIGINT
--QUEST 3: Adição da constraint para o valor da prioridade não passar de 32767
--QUEST 4: Setando todos atributos da table para NOT NULL
--QUEST 5: Tornando id PRIMARY KEY
--QUEST 6A: Constraint para verificar se cpf tem 11 caracteres
--QUEST 6B: Constraint para verificar se status é P,E ou C
--QUEST 7: Constraint para verificar se prioridade varia de 0 a 5
--QUEST 8: Criação da Table funcionario
--QUEST 9: Testes de inserção de funcionarios
--QUEST 10/11: Inserção da FOREING KEY em DELETE CASCADE

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

ALTER TABLE ONLY public.funcionario DROP CONSTRAINT fk_funcsuperior;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT fk_cpf;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT id_key;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: joaovpr
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    data_nasc date NOT NULL,
    nome character varying(40) NOT NULL,
    funcao character varying(40) NOT NULL,
    nivel character(1) NOT NULL,
    superior_cpf character(11),
    CONSTRAINT checksuperior CHECK (((((funcao)::text = 'LIMPEZA'::text) AND (superior_cpf IS NOT NULL)) OR (((funcao)::text = 'SUP_LIMPEZA'::text) AND (superior_cpf IS NULL)))),
    CONSTRAINT funcionario_funcao_check CHECK (((funcao)::text = ANY ((ARRAY['SUP_LIMPEZA'::character varying, 'LIMPEZA'::character varying])::text[]))),
    CONSTRAINT funcionario_nivel_check CHECK ((nivel = ANY (ARRAY['J'::bpchar, 'P'::bpchar, 'S'::bpchar])))
);


ALTER TABLE public.funcionario OWNER TO joaovpr;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: joaovpr
--

CREATE TABLE public.tarefas (
    id bigint NOT NULL,
    descricao character varying(140) NOT NULL,
    cpf_responsavel character(11) NOT NULL,
    prioridade integer NOT NULL,
    status character(1) NOT NULL,
    CONSTRAINT cpf_valido CHECK ((length(cpf_responsavel) = 11)),
    CONSTRAINT prioridade_valida CHECK (((prioridade >= 0) AND (prioridade <= 5))),
    CONSTRAINT status_valido CHECK (((status = 'P'::bpchar) OR (status = 'E'::bpchar) OR (status = 'C'::bpchar)))
);


ALTER TABLE public.tarefas OWNER TO joaovpr;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: joaovpr
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'S', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-04-15', 'Alvaro Dantas', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678914', '1972-03-25', 'Gabriel Dantas', 'LIMPEZA', 'J', '12345678913');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678915', '1984-03-27', 'Marilane Azevedo', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678916', '1973-01-08', 'Rafaela Dantas', 'LIMPEZA', 'P', '12345678915');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678917', '1972-01-04', 'Clara Miranda', 'LIMPEZA', 'J', '12345678916');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678918', '2000-01-31', 'Aline Miranda', 'LIMPEZA', 'P', '12345678917');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678919', '1997-01-10', 'Alic Miranda', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678920', '1990-01-08', 'Helena Miranda', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678921', '1977-01-31', 'Marli Miranda', 'LIMPEZA', 'S', '12345678920');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678922', '1990-01-08', 'Julia Vitoria', 'SUP_LIMPEZA', 'P', NULL);


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: joaovpr
--

INSERT INTO public.tarefas (id, descricao, cpf_responsavel, prioridade, status) VALUES (2147483648, 'limpar portas do térreo', '32323232955', 4, 'P');
INSERT INTO public.tarefas (id, descricao, cpf_responsavel, prioridade, status) VALUES (2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'P');
INSERT INTO public.tarefas (id, descricao, cpf_responsavel, prioridade, status) VALUES (2147483646, 'limpar chão do corredor central', '98765432111', 0, 'C');
INSERT INTO public.tarefas (id, descricao, cpf_responsavel, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'C');
INSERT INTO public.tarefas (id, descricao, cpf_responsavel, prioridade, status) VALUES (2147483651, 'limpar portas do 1o andar', '32323232911', 5, 'P');
INSERT INTO public.tarefas (id, descricao, cpf_responsavel, prioridade, status) VALUES (2147483652, 'limpar portas do 2o andar', '32323232911', 5, 'P');


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: id_key; Type: CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT id_key PRIMARY KEY (id);


--
-- Name: fk_cpf; Type: FK CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT fk_cpf FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf) ON DELETE CASCADE;


--
-- Name: fk_funcsuperior; Type: FK CONSTRAINT; Schema: public; Owner: joaovpr
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT fk_funcsuperior FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf);


--
-- PostgreSQL database dump complete
--

