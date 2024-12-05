CREATE OR REPLACE PACKAGE PKG_DISCIPLINA AS
    PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER);
    PROCEDURE listar_total_alunos_disciplina;
    PROCEDURE listar_media_idade_disciplina(p_id_disciplina IN NUMBER);
    PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER);
END PKG_DISCIPLINA;
/

CREATE OR REPLACE PACKAGE BODY PKG_DISCIPLINA AS

    -- Procedure para cadastro de disciplina
    PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER) IS
    BEGIN
        INSERT INTO DISCIPLINA (NOME, DESCRICAO, CARGA_HORARIA)
        VALUES (p_nome, p_descricao, p_carga_horaria);
        DBMS_OUTPUT.PUT_LINE('Disciplina cadastrada com sucesso.');
    END cadastrar_disciplina;

    -- Cursor para total de alunos por disciplina
    PROCEDURE listar_total_alunos_disciplina IS
        CURSOR c_total_alunos IS
            SELECT D.NOME, COUNT(M.ID_ALUNO) AS TOTAL_ALUNOS
            FROM DISCIPLINA D
            JOIN MATRICULA M ON D.ID = M.ID_DISCIPLINA
            GROUP BY D.NOME
            HAVING COUNT(M.ID_ALUNO) > 10;
    BEGIN
        FOR r IN c_total_alunos LOOP
            DBMS_OUTPUT.PUT_LINE('Disciplina: ' || r.NOME || ' | Total de Alunos: ' || r.TOTAL_ALUNOS);
        END LOOP;
    END listar_total_alunos_disciplina;

    -- Cursor com média de idade por disciplina
    PROCEDURE listar_media_idade_disciplina(p_id_disciplina IN NUMBER) IS
        CURSOR c_media_idade IS
            SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, A.DATA_NASCIMENTO) / 12)) AS MEDIA_IDADE
            FROM ALUNO A
            JOIN MATRICULA M ON A.ID = M.ID_ALUNO
            WHERE M.ID_DISCIPLINA = p_id_disciplina;
    BEGIN
        FOR r IN c_media_idade LOOP
            DBMS_OUTPUT.PUT_LINE('Média de Idade: ' || r.MEDIA_IDADE);
        END LOOP;
    END listar_media_idade_disciplina;

    -- Procedure para listar alunos de uma disciplina
    PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER) IS
        CURSOR c_alunos_disciplina IS
            SELECT A.NOME
            FROM ALUNO A
            JOIN MATRICULA M ON A.ID = M.ID_ALUNO
            WHERE M.ID_DISCIPLINA = p_id_disciplina;
    BEGIN
        FOR r IN c_alunos_disciplina LOOP
            DBMS_OUTPUT.PUT_LINE('Nome: ' || r.NOME);
        END LOOP;
    END listar_alunos_disciplina;

END PKG_DISCIPLINA;
/