Este repositório contém pacotes PL/SQL para gerenciar operações relacionadas às entidades Aluno, Disciplina e Professor em um banco de dados Oracle. O objetivo é consolidar o uso de procedures, functions e cursores, com foco em cálculos, manipulação de dados e operações parametrizadas.

Os pacotes desenvolvidos são:

PKG_ALUNO: Gerencia operações relacionadas aos alunos.
PKG_DISCIPLINA: Lida com a criação e consulta de disciplinas e informações relacionadas.
PKG_PROFESSOR: Gerencia operações relacionadas aos professores e suas turmas.
Estrutura dos Pacotes
PKG_ALUNO
excluir_aluno: Exclui um aluno e todas as matrículas associadas, com base no ID do aluno.
listar_alunos_maiores: Lista alunos com idade superior a 18 anos.
listar_alunos_por_curso: Lista os alunos matriculados em um curso específico, com base no ID do curso.
PKG_DISCIPLINA
cadastrar_disciplina: Cadastra uma nova disciplina no banco, recebendo nome, descrição e carga horária como parâmetros.
listar_total_alunos_disciplina: Lista disciplinas com mais de 10 alunos matriculados e a quantidade total de alunos.
listar_media_idade_disciplina: Calcula e exibe a média de idade dos alunos matriculados em uma disciplina específica.
listar_alunos_disciplina: Lista os alunos matriculados em uma disciplina específica.
PKG_PROFESSOR
listar_total_turmas: Lista os professores com mais de uma turma e a quantidade total de turmas de cada um.
total_turmas_professor: Retorna o número total de turmas de um professor específico.
professor_disciplina: Retorna o nome do professor responsável por uma disciplina específica.
Como Executar os Scripts no Oracle
Configurar o Banco de Dados

Certifique-se de que o Oracle Database esteja configurado e em execução.
Crie as tabelas necessárias no banco de dados. Um exemplo de estrutura mínima seria:
sql
Copiar código
CREATE TABLE ALUNO (
    ID NUMBER PRIMARY KEY,
    NOME VARCHAR2(100),
    DATA_NASCIMENTO DATE
);

CREATE TABLE DISCIPLINA (
    ID NUMBER PRIMARY KEY,
    NOME VARCHAR2(100),
    DESCRICAO VARCHAR2(200),
    CARGA_HORARIA NUMBER
);

CREATE TABLE PROFESSOR (
    ID NUMBER PRIMARY KEY,
    NOME VARCHAR2(100)
);

CREATE TABLE MATRICULA (
    ID NUMBER PRIMARY KEY,
    ID_ALUNO NUMBER REFERENCES ALUNO(ID),
    ID_DISCIPLINA NUMBER REFERENCES DISCIPLINA(ID),
    ID_CURSO NUMBER
);

CREATE TABLE TURMA (
    ID NUMBER PRIMARY KEY,
    ID_DISCIPLINA NUMBER REFERENCES DISCIPLINA(ID),
    ID_PROFESSOR NUMBER REFERENCES PROFESSOR(ID)
);
Carregar os Scripts

Abra o Oracle SQL*Plus ou qualquer ferramenta de gerenciamento de banco de dados Oracle, como SQL Developer.
Carregue os scripts em ordem:
Pacote PKG_ALUNO:
sql
Copiar código
@pkg_aluno.sql
Pacote PKG_DISCIPLINA:
sql
Copiar código
@pkg_disciplina.sql
Pacote PKG_PROFESSOR:
sql
Copiar código
@pkg_professor.sql
Executar os Pacotes

Habilite o DBMS_OUTPUT para visualizar as mensagens:
sql
Copiar código
SET SERVEROUTPUT ON;
Exemplo de execução de uma procedure ou function:
sql
Copiar código
BEGIN
    PKG_ALUNO.excluir_aluno(1);
END;
/

BEGIN
    PKG_DISCIPLINA.cadastrar_disciplina('Matemática', 'Disciplina de Cálculo', 80);
END;
/

SELECT PKG_PROFESSOR.total_turmas_professor(1) AS TOTAL_TURMAS FROM DUAL;
Verificar Resultados

As saídas serão exibidas no console, dependendo da procedure ou função chamada. Use consultas adicionais para verificar os efeitos no banco de dados.
