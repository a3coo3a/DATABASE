SET SERVEROUTPUT ON;

-- ���ν��� ����
-- in : �ܺ��� �Է¹޴� �Ķ����
/* �Լ��� ����� �������� �Լ��� ���� �־��~
    create or replace procedure ���ν����� (�Է� �Ķ����)
*/
SELECT * FROM jobs;
CREATE OR REPLACE PROCEDURE new_job_proc(
-- �Է��Ķ���� ����
    p_job_id IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_id%TYPE,
    p_min_salary IN jobs.min_salary%TYPE,
    p_max_salary IN jobs.max_salary%TYPE
)
IS
-- �������� ����

BEGIN
    INSERT INTO jobs(job_id, job_title, min_salary, max_salary) 
    VALUES(p_job_id, p_job_title, p_min_salary, p_max_salary);
    
    COMMIT;
END;
-- ��� : Procedure NEW_JOB_PROC��(��) �����ϵǾ����ϴ�.


-- ���ν��� ����
EXECUTE new_job_proc('JOBS1','TEST...',1000,5000);
EXECUTE new_job_proc('JOBS2','TEST2...',2000,10000);  -- �ι������� ���Ἲ�������� ����
SELECT * FROM JOBS;


-- ���ν��������� ������ �̸����� ����
CREATE OR REPLACE PROCEDURE new_job_proc(
    p_job_id IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_id%TYPE,
    p_job_min_salary IN jobs.min_salary%TYPE  := 0,  -- �⺻�� ����
    p_job_max_salary IN jobs.max_salary%TYPE := 100
)
IS
    V_COUNT NUMBER := 0;
BEGIN
    SELECT COUNT(*) -- �ߺ��� ������ 0
    INTO V_COUNT
    FROM JOBS
    WHERE JOB_ID = P_JOB_ID;  -- P_JOB_ID�� ������� ��ȸ�ؼ� ī��Ʈ
    
    -- ���ٸ� INSERT
    IF V_COUNT = 0 THEN
        INSERT INTO JOBS(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
        VALUES (P_JOB_ID, P_JOB_TITLE, P_JOB_MIN_SALARY, P_JOB_MAX_SALARY);
    ELSE   -- �ִٸ� UPDATE
        UPDATE JOBS 
        SET 
            JOB_TITLE = P_JOB_TITLE, 
            MIN_SALARY = P_JOB_MIN_SALARY, 
            MAX_SALARY = P_JOB_MAX_SALARY
        WHERE JOB_ID = P_JOB_ID;
    END IF;
    
    COMMIT;
END;

EXECUTE new_job_proc('JOBS2','TEST2...',2000,10000);
SELECT * FROM JOBS;


-- ���๮
EXECUTE NEW_JOB_PROC('JOBS2','TEST2...',5000, 200000);
EXECUTE NEW_JOB_PROC('JOBS2','TEST2...');  -- ����

-- ������...
EXECUTE NEW_JOB_PROC('JOBS2','TEST2...');  -- �⺻���� �����Ǿ� �����Ƿ� ������ ���� ����.


-- OUT �Ű�����
-- �ܺη��� ����� ���� ����
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC02(
    P_JOB_ID IN JOBS.JOB_ID%TYPE,
    P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
    P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE,
    P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE,
    P_RESULT OUT VARCHAR2  -- ũ�⸦ �����Ҽ� ����. ���� ��. �ܺη��� ����� ���� ����
)IS
    V_COUNT NUMBER := 0;
    V_RESULT VARCHAR2(100) := '���� ��� INSERTó�� �Ǿ����ϴ�.'; -- OUT���� �Ǿ� ������ ����
BEGIN
    -- ������ ���̵� �ִ��� üũ
    SELECT COUNT(*)
    INTO V_COUNT
    FROM JOBS
    WHERE JOB_ID = P_JOB_ID;
    
    IF V_COUNT = 0 THEN
        INSERT INTO JOBS
        VALUES (P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY, P_MAX_SALARY);
    ELSE   -- �ʿ��� ��� ����
        SELECT P_JOB_ID || '�� �ִ� ���� : '|| MAX_SALARY || ', �ּ� ���� : ' || MIN_SALARY
        INTO V_RESULT
        FROM JOBS
        WHERE JOB_ID = P_JOB_ID;
    END IF;
    
    P_RESULT := V_RESULT;  -- OUT ������ ����� �Ҵ�
END;

-- ����
-- OUT������ ����ϴ� ���ν����� �͸��Ͽ��� ������ �մϴ�.
DECLARE
    STR VARCHAR2(100); -- �ݵ�� ���ڿ��� ũ�⸦ �����ؾ���.
BEGIN
    NEW_JOB_PROC02('SM_JOB1','sample job1',2000,6000,STR);
    DBMS_OUTPUT.put_line(STR);
    NEW_JOB_PROC02('CEO','sample ceo',10000,90000,STR);
    DBMS_OUTPUT.put_line(STR);
END;




-- in out ó�� ����
CREATE OR REPLACE PROCEDURE testProc(
    p_var1 IN VARCHAR2,
    p_var2 OUT VARCHAR2,
    p_var3 IN OUT VARCHAR2
)IS
BEGIN
    -- in, out�� ���ٸ� �ܼ� ��븸 ����
    DBMS_OUTPUT.PUT_LINE(p_var1);
    -- out ������ ���ν����� ������ ������ ���� �Ҵ��� �ȵ�.
    DBMS_OUTPUT.PUT_LINE(p_var2);
    -- in out �� �Ѵ� ����� �����մϴ�.
    DBMS_OUTPUT.PUT_LINE(p_var3);
    
    -- p_var1 := '���1';
    -- ���� : Statement ignored / PLS-00363: 'P_VAR1' ���� ���Ҵ��ڷ� ���� �� �����ϴ�
    p_var2 := '���2';
    p_var3 := '���3';
END;

DECLARE
    var1 VARCHAR2(50) := 'A';
    var2 VARCHAR2(50) := 'B';
    var3 VARCHAR2(50) := 'C';
BEGIN
    testproc(var1,var2,var3);
    
    DBMS_OUTPUT.PUT_LINE(var1);
    DBMS_OUTPUT.PUT_LINE(var2);
    DBMS_OUTPUT.PUT_LINE(var3);
END;



-- �������� 
-- 1. employees ���̺��� job_id�� in������ �Է¹޾Ƽ�, �ش� ���̵� �ִ��� Ȯ���ϰ�,
-- ���ٸ�, �ܼ��� ���ν��� �ȿ��� ��¸� ���ݴϴ�.
-- 2. �ִٸ�, ������ job_id�� ���� �޿��� �հ踦 ������ּ���

CREATE OR REPLACE PROCEDURE emp_proc(
    p_job_id IN employees.job_id%TYPE
)
IS
    v_count NUMBER := 0;
    v_salary_sum employees.salary%type := 0;
BEGIN
    SELECT COUNT(*),SUM(salary)
    INTO v_count, v_salary_sum
    FROM employees
    WHERE job_id = p_job_id;
    
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_salary_sum);
    ELSE
        DBMS_OUTPUT.PUT_LINE('job_id: "'||P_JOB_ID||'" �� �����ϴ�');
    END IF;
END;

select * from EMPLOYEES;
EXECUTE emp_proc('AD_V');

SELECT COUNT(*)
FROM employees
WHERE job_id = 'AD_VP';
     
SELECT SUM(salary)
FROM employees
WHERE job_id = 'AD_VP';

-- returnŰ����
-- ���ν����� ����
CREATE OR REPLACE PROCEDURE emp_proc(
    p_job_id IN employees.job_id%TYPE
)
IS
    v_count NUMBER := 0;
    v_salary_sum employees.salary%type := 0;
BEGIN
    SELECT COUNT(*),SUM(salary)
    INTO v_count, v_salary_sum
    FROM employees
    WHERE job_id like '%' || p_job_id || '%';   -- �Է��� ���� ���ԵǾ� ������,
    
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_salary_sum);
        return; -- ���ν����� ���� // ��ȯ�� �ƴ�.
    ELSE
        DBMS_OUTPUT.PUT_LINE('job_id: "'||P_JOB_ID||'" �� �����ϴ�');
    END IF;
END;


-- ����ó��
-- EXCEPTION WHEN OTHERS THEN
DECLARE
    v_num number := 0;
begin
    v_num := 10/0;
    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('0���� ���� �� �����ϴ�.');
end;    
-- ��� : 0���� ���� �� �����ϴ�.


-- ���ν��� ����
drop procedure new_job_proc;
drop PROCEDURE new_job_proc02;

