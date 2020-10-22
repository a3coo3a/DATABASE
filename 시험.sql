---- ����
--SELECT 
--    JOB_ID, 
--    COUNT(*) AS �����������,
--    SUM(SALARY) AS �������޿���,
--    AVG(SALARY) AS �������޿����
--FROM EMPLOYEES
--GROUP BY JOB_ID;
--
--UPDATE BOARD SET TITLE = '�ٲ�', CONTENT = '�ٹٲ�', UPDATEDATE = SYSDATE WHERE BNO = 2;
--
--SELECT * FROM BOARD WHERE TITLE LIKE '%����%' ORDER BY TITLE ASC;
--
----1) board�Խ����� ���̺� ���� �������� �ۼ��ϼ��� 
----����- bno�� �������� �̿��� �ڵ����� ���� ���´�. 
----���� - writer�� ȸ���� id�� FK�� ���´�. 
----����- regdate��, updatedate�� �⺻������ ����ð��� �����Ѵ�. 
--CREATE SEQUENCE board_bno_seq NOCACHE;
--CREATE TABLE board(
--    bno NUMBER(5) PRIMARY KEY,
--    writer VARCHAR2(20) REFERENCES USER1(ID),
--    title VARCHAR2(100),
--    content VARCHAR2(200),
--    regdate DATE DEFAULT sysdate,
--    updatedate DATE DEFAULT sysdate
--);
--select * from board;
--insert into board(bno, writer, title, content) VALUES(BOARD_BNO_SEQ.NEXTVAL,'ccc','���~','~~');
----2) ��� ���̺��� ���̺� ���� �������� �ۼ��ϼ��� 
----����- rno�� �������� �̿��� �ڵ��������� ���´�. 
----����- bno�� board�� bno�� FK�� ���´�. 
----���� - regdate�� �⺻������ ����ð��� ���´�.
--CREATE SEQUENCE ���_rno_seq NOCACHE;
--CREATE TABLE  ���(
--    rno NUMBER(5) PRIMARY KEY,
--    bno NUMBER(5) REFERENCES board(bno),
--    writer VARCHAR2(20),
--    content VARCHAR2(200),
--    regdate DATE DEFAULT sysdate
--);
--select * from ���;
--insert into ��� VALUES("���_RNO_SEQ".NEXTVAL, 5, 'aaa', '~~', sysdate);
--
--create table user1(
--    id VARCHAR2(20) PRIMARY key,
--    pw VARCHAR2(20),
--    name VARCHAR2(20),
--    address VARCHAR2(50)
--);
--select * from user1;
--insert into user1 VALUES('kkk123','*****','ȫ�浿','����');
--insert into user1 VALUES('aaa','****','ȫ����','���');
--insert into user1 VALUES('bbb','***','�̼���','����');
--insert into user1 VALUES('ccc','****','������','����');
--insert into user1 VALUES('ddd','*****','����ȣ','�λ�');
--
--
--SELECT b.*
--FROM board b
--INNER JOIN user1 u
--ON b.writer = u.id
--WHERE b.writer = 'kkk123';
--
--SELECT ���.*
--FROM ���
--LEFT OUTER JOIN user 
--ON ���.writer = user.id
--WHERE ���.writer = 'aaa';
--
--SELECT 
--    BOARD.BNO AS �Խñ۹�ȣ,
--    BOARD.WRITER AS �Խ����ۼ���,
--    BOARD.TITLE AS ����,
--    BOARD.CONTENT AS ����,
--    BOARD.REGDATE AS �ۼ���,
--    BOARD.UPDATEDATE AS ������,
--    RNO AS ��۹�ȣ,
--    ���.WRITER AS ����ۼ���,
--    ���.CONTENT AS ��۳���,
--    ���.REGDATE AS ����ۼ���
--FROM BOARD
--LEFT OUTER JOIN ���
--ON BOARD.BNO = ���.BNO;
--
--select * from board;
--update board set regdate = '20200415' where bno = 5;
----board���̺��� �����ֽű� ������� ROWNUM�� �ο��Ͽ� 1-10���� �Խñ۸� ��ȸ�ϴ� ����¡ ������������ �ۼ��ϼ���.
--SELECT *
--FROM(
--    SELECT 
--        ROWNUM AS rn, 
--        board.*
--    FROM board
--    ORDER BY regdate
--)
--WHERE rn BETWEEN 1 AND 10;
--
--
--
select bno, count(*)
from ���
GROUP by bno;

SELECT board.*,
    nvl((SELECT COUNT(*)
    FROM ���
    WHERE board.bno = ���.bno
    GROUP BY bno),0) AS ��ۼ�
FROM board;

SELECT board.*,
    (SELECT COUNT(*)
    FROM ���
    WHERE board.bno = ���.bno
    GROUP BY bno) AS ��ۼ�
FROM board;
----------------------------------------------------------------------------
--
--CREATE OR REPLACE PROCEDURE GOGOPROC(
--    P_DAN IN NUMBER    
--)
--IS
--BEGIN
--    FOR I IN 1..9
--    LOOP
--        DBMS_OUTPUT.PUT_LINE(P_DAN || ' x ' || I || ' = ' || P_DAN * I);
--    END LOOP;
--END;
--
--EXECUTE gogoProc(3);
--
--
----1. �������̺����
--CREATE TABLE depts AS (SELECT * FROM departments WHERE 1=1);
--
--select * from depts;
--
--ALTER TABLE depts ADD CONSTRAINT depts_department_id_pk PRIMARY KEY (department_id);
--
----3. �μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
----DEPTS ���̺� ���� INSERT, UPDATE, DELETE �ϴ� 
----deptsProc �� �̸��� ���ν����� �����ϴ� ������ �ۼ��ϼ��� 
----4. ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
--
--CREATE OR REPLACE PROCEDURE deptsproc(
--    p_depts_id IN depts.department_id%TYPE,
--    p_depts_name IN depts.department_name%TYPE,
--    p_flag IN VARCHAR2
--)
--IS
--BEGIN
--    IF p_flag = 'I' THEN
--        INSERT INTO depts(department_id, department_name) VALUES(p_depts_id, p_depts_name);
--    ELSIF p_flag = 'U' THEN
--        UPDATE depts SET department_name = p_depts_name WHERE department_id = p_depts_id;
--    ELSIF p_flag = 'D' THEN
--        DELETE FROM depts WHERE department_id = p_depts_id;
--    END IF;
--        
--    EXCEPTION WHEN OTHERS THEN
--        ROLLBACK;
--    
--    COMMIT;
--END;
--
--desc depts;
--
--
--
----[����5]  ���ν����� - emp_hiredate_proc 
---- employee_id�� �Է¹޾� 
---- employees�� �����ϸ�, 
---- �ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. 
---- ���ٸ� exceptionó���ϼ��� (IN, OUT)������ ����մϴ�
--CREATE OR REPLACE PROCEDURE emp_hiredate_proc(
--    p_emp_id IN employees.employee_id%TYPE,
--    p_emp_date OUT number
--)IS
--    v_count NUMBER := 0;
--    v_date DATE;
--    v_long number := 0;
--BEGIN
--    SELECT COUNT(*)
--    INTO v_count
--    FROM employees
--    WHERE employee_id = p_emp_id;
--   
--    
--    IF v_count > 0 THEN
--        SELECT hire_date
--        INTO v_date
--        FROM employees
--        WHERE employee_id = p_emp_id;
--        v_long := TRUNC((sysdate - v_date)/365);
--    END IF;
--    
--    EXCEPTION WHEN OTHERS THEN
--        dbms_output.put_line(p_emp_id || '�� �������� �ʽ��ϴ�');
--   
--   p_emp_date := v_long;
--END;
--set SERVEROUTPUT ON;
--DECLARE
--    v_num number;
--begin
--    emp_hiredate_proc(100,v_num);
--    DBMS_OUTPUT.put_line(v_num);
--end;
--
--
--SELECT TRUNC((sysdate - hire_date)/365)
--        
--        FROM employees
--        WHERE employee_id = 100;
--        
--desc employees;
--
----���ν����� - emp_merge_proc 
---- employees ���̺��� ���� ���̺� emps�� �����մϴ�. 
----employee_id, last_name, email, hire_date, job_id�� �Է¹޾� 
--
----�����ϸ� �̸�, �̸���, �Ի���, ������ update, 
----���ٸ� insert�ϴ� merge���� �ۼ��ϼ���
drop table emps;
CREATE TABLE emps AS(SELECT * FROM employees WHERE 1=1);
select * from emps;

CREATE OR REPLACE PROCEDURE emp_merge_proc(
    p_emp_id IN emps.employee_id%TYPE,
    p_emp_last_name IN emps.last_name%TYPE,
    p_emp_email IN emps.email%TYPE,
    p_emp_hire_date IN emps.hire_date%TYPE,
    p_emp_job_id IN emps.job_id%TYPE
)
IS
BEGIN
    MERGE INTO emps A
        USING (SELECT * FROM emps WHERE employee_id = p_emp_id) b
        ON (A.employee_id = b.employee_id)
    WHEN MATCHED THEN
        UPDATE SET A.last_name = p_emp_last_name,
                   A.email = p_emp_email,
                   A.hire_date = p_emp_hire_date,
                   A.job_id = p_emp_job_id
    WHEN NOT MATCHED THEN
        INSERT (employee_id, last_name, email, hire_date, job_id) 
        VALUES(p_emp_id,
               p_emp_last_name,
               p_emp_email,
               p_emp_hire_date,
               p_emp_job_id);
    
END;

EXECUTE emp_merge_proc(101,'hi','test',sysdate,'test_te');


--[����7]  ���ν����� - salesProc 
-- sales���̺��� ������ �Ǹų����̴�. 
-- day_of_sales���̺��� �Ǹų��� ������ ���� ������ �Ѹ����� ����ϴ� ���̺��̴�. 
-- ����) day_of_sales�� ���������� �̹� �����ϸ� ������Ʈ ó��

create table sales(  -- �Ǹų���
    sno number(5), -- ��ȣ
    name varchar2(30), -- ��ǰ��
    total number(10), --����
    price number(10), --����
    regdate date default sysdate --��¥
);
insert into sales VALUES(2 ,'aa',10,1000,sysdate);

create table day_of_sales(   -- ������ �������� �Ѹ��� ���
    regdate date,
    final_total number(10)
);

create or REPLACE PROCEDURE salesProc(
    p_date in date
)
is
    v_total number;
begin
    select sum(price)
    into v_total
    from sales
    where to_char(regdate,'YY-MM-DD') = to_char(p_date,'YY-MM-DD');
    
    MERGE INTO day_of_sales A
        USING sales b
        ON (to_char(A.regdate,'YY-MM-DD') = to_char(b.regdate,'YY-MM-DD'))
    WHEN MATCHED THEN
        UPDATE SET a.final_total = v_total
    WHEN NOT MATCHED THEN
        INSERT VALUES(to_char(p_date,'YY-MM-DD'), V_TOTAL);
end;

select * from sales;
select * from day_of_sales;
delete from day_of_sales where to_char(regdate,'YY-MM-DD') = '20-10-22';
EXECUTE salesProc('20-10-22');

select count(*), sum(price)
from sales
group by to_char(regdate,'YY-MM-DD');

select sum(price)
    from sales
    where regdate = sysdate;
    
    
    
    
    
--    
--    
--CREATE OR REPLACE PROCEDURE deptsproc(
--    p_depts_id IN depts.department_id%TYPE,
--    p_depts_name IN depts.department_name%TYPE,
--    p_flag IN VARCHAR2
--)
--IS
--BEGIN
--    IF p_flag = 'I' THEN
--        INSERT INTO depts(department_id, department_name) VALUES(p_depts_id, p_depts_name);
--    ELSIF p_flag = 'U' THEN
--        UPDATE depts SET department_name = p_depts_name WHERE department_id = p_depts_id;
--    ELSIF p_flag = 'D' THEN
--        DELETE FROM depts WHERE department_id = p_depts_id;
--    END IF;
--        
--    EXCEPTION WHEN OTHERS THEN
--        ROLLBACK;
--    
--    COMMIT;
--END;


select board.*,
    nvl((select count(*) from ��� where board.bno = ���.bno group by bno),0) as ��ۼ�
from board;