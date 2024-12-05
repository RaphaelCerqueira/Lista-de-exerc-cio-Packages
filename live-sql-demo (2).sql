CREATE OR REPLACE PACKAGE PKG_PROFESSOR AS
    PROCEDURE listar_total_turmas;
    FUNCTION total_turmas_professor(p_id_professor IN NUMBER) RETURN NUMBER;
    FUNCTION professor_disciplina(p_id_disciplina IN NUMBER) RETURN VARCHAR2;
END PKG_PROFESSOR;
/

CREATE OR REPLACE PACKAGE BODY PKG_PROFESSOR AS

    -- Cursor para total de turmas por professor
    PROCEDURE listar_total_turmas IS
        CURSOR c_turmas_prof IS
            SELECT P.NOME, COUNT(T.ID) AS TOTAL_TURMAS
            FROM PROFESSOR P
            JOIN TURMA T ON P.ID = T.ID_PROFESSOR
            GROUP BY P.NOME
            HAVING COUNT(T.ID) > 1;
    BEGIN
        FOR r IN c_turmas_prof LOOP
            DBMS_OUTPUT.PUT_LINE('Professor: ' || r.NOME || ' | Total de Turmas: ' || r.TOTAL_TURMAS);
        END LOOP;
    END listar_total_turmas;

    -- Function para total de turmas de um professor
    FUNCTION total_turmas_professor(p_id_professor IN NUMBER) RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(ID) INTO v_total
        FROM TURMA
        WHERE ID_PROFESSOR = p_id_professor;
        RETURN v_total;
    END total_turmas_professor;

    -- Function para professor de uma disciplina
    FUNCTION professor_disciplina(p_id_disciplina IN NUMBER) RETURN VARCHAR2 IS
        v_nome_professor VARCHAR2(100);
    BEGIN
        SELECT P.NOME INTO v_nome_professor
        FROM PROFESSOR P
        JOIN TURMA T ON P.ID = T.ID_PROFESSOR
        JOIN DISCIPLINA D ON T.ID_DISCIPLINA = D.ID
        WHERE D.ID = p_id_disciplina;
        RETURN v_nome_professor;
    END professor_disciplina;

END PKG_PROFESSOR;
/