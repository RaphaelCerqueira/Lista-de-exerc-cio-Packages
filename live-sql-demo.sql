CREATE OR REPLACE PACKAGE PKG_ALUNO AS
    PROCEDURE excluir_aluno(p_id_aluno IN NUMBER);
    PROCEDURE listar_alunos_maiores;
    PROCEDURE listar_alunos_por_curso(p_id_curso IN NUMBER);
END PKG_ALUNO;
/

CREATE OR REPLACE PACKAGE BODY PKG_ALUNO AS

    -- Procedure de exclusão de aluno
    PROCEDURE excluir_aluno(p_id_aluno IN NUMBER) IS
    BEGIN
        DELETE FROM MATRICULA WHERE ID_ALUNO = p_id_aluno;
        DELETE FROM ALUNO WHERE ID = p_id_aluno;
        DBMS_OUTPUT.PUT_LINE('Aluno e matrículas associadas excluídos com sucesso.');
    END excluir_aluno;

    -- Cursor de listagem de alunos maiores de 18 anos
    PROCEDURE listar_alunos_maiores IS
        CURSOR c_alunos_maiores IS
            SELECT NOME, DATA_NASCIMENTO
            FROM ALUNO
            WHERE (TRUNC(MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO) / 12)) > 18;
    BEGIN
        FOR r IN c_alunos_maiores LOOP
            DBMS_OUTPUT.PUT_LINE('Nome: ' || r.NOME || ' | Data de Nascimento: ' || r.DATA_NASCIMENTO);
        END LOOP;
    END listar_alunos_maiores;

    -- Cursor parametrizado por curso
    PROCEDURE listar_alunos_por_curso(p_id_curso IN NUMBER) IS
        CURSOR c_alunos_curso IS
            SELECT A.NOME
            FROM ALUNO A
            JOIN MATRICULA M ON A.ID = M.ID_ALUNO
            WHERE M.ID_CURSO = p_id_curso;
    BEGIN
        FOR r IN c_alunos_curso LOOP
            DBMS_OUTPUT.PUT_LINE('Nome: ' || r.NOME);
        END LOOP;
    END listar_alunos_por_curso;

END PKG_ALUNO;
/