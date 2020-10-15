-- insert

-- ���̺��� �÷� ����, ������ �����ִ� ��
desc DEPARTMENTS;
--�̸�              ��?       ����           
----------------- -------- ------------ 
--DEPARTMENT_ID   NOT NULL NUMBER(4)        -> number������ 4�ڸ�
--DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
--MANAGER_ID               NUMBER(6)    
--LOCATION_ID              NUMBER(4)

-- �����
-- 1. ��� �÷� �����͸� �ѹ��� ����
INSERT INTO DEPARTMENTS
VALUES (280,'developer', null, 1700);
-- ��� : 1 �� ��(��) ���ԵǾ����ϴ�.     --> ���� �������� �ݿ��� �Ȱ� �ƴ�.
-- Ȯ��
SELECT * FROM DEPARTMENTS;
-- �������� �ڷ� �ǵ����� ��
ROLLBACK;
-- ��� : �ѹ� �Ϸ�.
-- Ȯ��
SELECT * FROM DEPARTMENTS;

-- 2. ���� �÷��� �����ϰ� ����
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID) VALUES(280,'developer', 1700);
-- ��� : 1 �� ��(��) ���ԵǾ����ϴ�.
-- Ȯ��
SELECT * FROM DEPARTMENTS;
-- �������� �ڷ� �ǵ����� ��
ROLLBACK;
-- ��� : �ѹ� �Ϸ�.
-- Ȯ��
SELECT * FROM DEPARTMENTS;

-- �ǽ�
INSERT INTO DEPARTMENTS 
VALUES(280,'����1',NULL,1700);
INSERT INTO DEPARTMENTS
VALUES(290, '����2',NULL,1700);
INSERT INTO DEPARTMENTS
VALUES(300, '����3', NULL, 1700);
SELECT * FROM DEPARTMENTS;
ROLLBACK;  -- ����1�� �ֱ� ���� ó���� ����� ������ Ȯ��

-- 3. �������� �������� INSERT
-- �纻���̺� �����
DESC EMPLOYEES;
-- 1 = 2 �� ���� �ʴ� �����̹Ƿ� �����Ͱ� �ȵ�
-- 1 = 1 �̸� �����Ͱ� ��
CREATE TABLE MANAGERS 
AS 
(
    SELECT 
        EMPLOYEE_ID, FIRST_NAME, 
        JOB_ID, SALARY, HIRE_DATE 
    FROM EMPLOYEES 
    WHERE 1 = 2
);
-- ��� : Table MANAGERS��(��) �����Ǿ����ϴ�.

-- Ȯ��
SELECT * FROM MANAGERS;
-- ��� : ���� ���� �÷��� ������ ���

INSERT 
INTO MANAGERS(EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, HIRE_DATE)
(
    SELECT 
        EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, HIRE_DATE
    FROM EMPLOYEES 
    WHERE DEPARTMENT_ID = 60
);
-- ��� : 5�� �� ��(��) ���ԵǾ����ϴ�.

-- Ȯ��
SELECT * FROM MANAGERS;
ROLLBACK;

-- UPDATE --------------------------------
-- �纻���̺� : ��°�� ����
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES);
SELECT * FROM EMPS;

UPDATE EMPS 
SET SALARY = 100000;
-- ��� : 107�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

-- Ȯ��
SELECT * FROM EMPS;
-- ��� : SALARY�� ��� ���� ���� 100000�� �Ǿ� ����.

ROLLBACK;
-- ��� : SALARY�� ���� ������ ������� ���ư�

UPDATE EMPS 
SET SALARY = 100000 
WHERE EMPLOYEE_ID = 100;  --> 100���� ����

-- Ȯ��
SELECT * FROM EMPS;
-- EMPLOYEE_ID�� 100���� ����� SALARY���� ����

ROLLBACK;

-- ������ ���·� �� ���浵 ����
UPDATE EMPS
SET SALARY = SALARY *0.1 + SALARY 
WHERE EMPLOYEE_ID = 100;
-- Ȯ��
SELECT * FROM EMPS;
-- EMPLOYEE_ID�� 100���� ����� SALARY���� 24000->26400���� ����

ROLLBACK;

UPDATE EMPS
SET MANAGER_ID = 100
WHERE EMPLOYEE_ID = 100;
-- ��� : 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT * FROM EMPS;
-- EMPLOYEE_ID�� 100���� MANAGER_ID����� ���� NULL->100���� ����

ROLLBACK;

-- �������� �����͸� ����
UPDATE EMPS
SET 
    PHONE_NUMBER = '031.123.1234',
    MANAGER_ID = 102
WHERE EMPLOYEE_ID = 100;
-- ��� : 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

-- Ȯ��
SELECT * FROM EMPS;
-- EMPLOYEE_ID�� 100���� ����� PHONE_NUMBER, MANAGER_ID�� �����

ROLLBACK;

-- �������� �������� ����, ���� ����
-- �������� �÷��� ����, �����Ҷ� ������.
UPDATE EMPS 
SET
    SALARY = (SELECT 1000 FROM DUAL)
WHERE EMPLOYEE_ID = 100;
-- Ȯ��
SELECT * FROM EMPS;
-- EMPLOYEE_ID�� 100���� ����� SALARY���� 24000->1000���� ����
ROLLBACK;

UPDATE EMPS
SET
    (SALARY, PHONE_NUMBER) = (SELECT SALARY, PHONE_NUMBER FROM EMPS WHERE EMPLOYEE_ID = 101)
WHERE EMPLOYEE_ID = 100;
-- Ȯ��
SELECT * FROM EMPS;
-- EMPLOYEE_ID�� 100���� ����� SALARY, PHONE_NUMBER�� EMPLOYEE_ID�� 101���� ����� ������ ���� �����Ե�.
ROLLBACK;

-- DELETE -------------------------------------------------------------------
-- ������ �׻� Ȯ�� �ϴ� ������ ������ ��.
-- �����ÿ� �ݵ�� ������ ���!
-- �ٸ� ���̺��� �����͸� �����ϰ� ������ ������ �Ұ����մϴ�.
-- EMPS ���̺��� �����̸Ӹ�Ű ����
ALTER TABLE EMPS
ADD CONSTRAINT EMPS_EMP_ID_PK PRIMARY KEY (EMPLOYEE_ID);
--��� : Table EMPS��(��) ����Ǿ����ϴ�.

-- EMPS ���̺��� FOREIGN KEY ����
ALTER TABLE EMPS
ADD CONSTRAINT EMPS_MANAGER_FK FOREIGN KEY (MANAGER_ID) REFERENCES EMPS(EMPLOYEE_ID);
-- ��� : Table EMPS��(��) ����Ǿ����ϴ�.

-- ���� ���Ἲ ��������
-- �ٸ� ���̺��� �����͸� �����ϰ� ������ ������ �Ұ����մϴ�.
DELETE FROM EMPS
WHERE EMPLOYEE_ID = 100;
-- ��� : 
-- ���� ���� -
-- ORA-02292: ���Ἲ ��������(HR.EMPS_MANAGER_FK)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�

-- �纻���̺� ����
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS);
SELECT * FROM DEPTS;   --> �������̺��� ���� ������ �ɷ����� ����.

DELETE FROM DEPTS;  --> ū�ϳ���!

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 10;
-- ��� : 1 �� ��(��) �����Ǿ����ϴ�.

-- Ȯ��
SELECT * FROM DEPTS;
-- DEPARTMENT_ID�� 10���� ����Ǹ�� ������ ������.

ROLLBACK;

-- ��������
-- �������� ���������� ���� ���� �;���
DELETE FROM DEPTS 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPS WHERE EMPLOYEE_ID = 100); -- 90
-- ��� : 1 �� ��(��) �����Ǿ����ϴ�.
-- Ȯ��
SELECT * FROM DEPTS;

ROLLBACK;

-- MERGE -------------------------------------------------------------------
-- ������, ����(UPDATE)�ϰ� ������ �߰�(INSERT)�ϴ�
-- ���̺� ����, �߰��� ����� ��� ���� ���
-- �纻���̺� ���� 
CREATE TABLE EMPS_IT
AS (SELECT * FROM EMPLOYEES WHERE 1=2);
SELECT * FROM EMPS_IT;

INSERT INTO EMPS_IT(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (105, '���̺��', '��', 'davidkim','06/06/06', 'IT_PROG');

SELECT * FROM EMPS_IT;  --> �����̶�� ���� ���⿡ �ٸ� �� ���̴� �ž�

-- A���̺� B���̺��� ������ �����ؼ� �����ž�
-- B���� JOB_ID�� ~~�� ������ A���̺� �ִ°�
MERGE INTO EMPS_IT A  --> A�� ��Ī
    USING(SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG') B --> B�� ��Ī
    ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID)  -- A���̺�� B���̺��� ���� ����
WHEN MATCHED THEN      -- ������ �̰��� ����
    UPDATE SET A.PHONE_NUMBER = B.PHONE_NUMBER,
               A.SALARY = B.SALARY,
               A.COMMISSION_PCT = B.COMMISSION_PCT,
               A.MANAGER_ID = B.MANAGER_ID,
               A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHEN NOT MATCHED THEN  -- ���� ������ �̰��� ����
    INSERT VALUES(
            B.EMPLOYEE_ID, 
            B.FIRST_NAME, 
            B.LAST_NAME, 
            B.EMAIL, 
            B.PHONE_NUMBER, 
            B.HIRE_DATE, 
            B.JOB_ID, 
            B.SALARY, 
            B.COMMISSION_PCT, 
            B.MANAGER_ID, 
            B.DEPARTMENT_ID);
-- ��� ; 5�� �� ��(��) ���յǾ����ϴ�.

--Ȯ��
SELECT * FROM EMPS_IT;
-- 4���� INSERT�� ���� 1���� UPDATE�� ����� ���

-- �ǽ�
INSERT INTO EMPS_IT(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (102, '����', 'Ŵ', 'LEX','01/04/06', 'AD_VP');
INSERT INTO EMPS_IT(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (102, '�ϳ�', 'Ŀ', 'nian','20/04/06', 'AD_VP');
SELECT * FROM EMPS_IT;
ROLLBACK;

-- EMPLOYEES ���̺��� �Ź� �����Ǵ� ���̺��̶�� �����ϰ�.
-- ���������ʹ� EMAIL, PHONE, SALARY, MANAGER_ID, DEPARTMENT_ID�� ������Ʈ �ǵ��� ó��
-- ���� ���Ե� �����ʹ� �׳� �״�� ���� �߰�

MERGE INTO EMPS_IT A
    USING EMPLOYEES B
    ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID)
WHEN MATCHED THEN
    UPDATE SET 
        A.EMAIL = B.EMAIL,
        A.PHONE_NUMBER = B.PHONE_NUMBER,
        A.SALARY = B.SALARY,
        A.MANAGER_ID = B.MANAGER_ID,
        A.DEPARTMENT_ID = B.DEPARTMENT_ID
   
WHEN NOT MATCHED THEN
    INSERT VALUES(
        B.EMPLOYEE_ID, 
        B.FIRST_NAME, 
        B.LAST_NAME,
        B.EMAIL,
        B.PHONE_NUMBER,
        B.HIRE_DATE,
        B.JOB_ID,
        B.SALARY,
        B.COMMISSION_PCT,
        B.MANAGER_ID,
        B.DEPARTMENT_ID);
        
SELECT * FROM EMPS_IT;


-- ������ ����
MERGE INTO EMPS_IT A
    USING EMPLOYEES B
    ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID)
WHEN MATCHED THEN
    UPDATE SET 
        A.EMAIL = B.EMAIL,
        A.PHONE_NUMBER = B.PHONE_NUMBER,
        A.SALARY = B.SALARY,
        A.MANAGER_ID = B.MANAGER_ID,
        A.DEPARTMENT_ID = B.DEPARTMENT_ID
     DELETE WHERE B.EMPLOYEE_ID = 105
WHEN NOT MATCHED THEN
    INSERT VALUES(
        B.EMPLOYEE_ID, 
        B.FIRST_NAME, 
        B.LAST_NAME,
        B.EMAIL,
        B.PHONE_NUMBER,
        B.HIRE_DATE,
        B.JOB_ID,
        B.SALARY,
        B.COMMISSION_PCT,
        B.MANAGER_ID,
        B.DEPARTMENT_ID);
        
SELECT * FROM EMPS_IT;  -- 105�� ���� ������

-- �������� -------------------------------------------------------------------
--���� 1.
--DEPTS���̺��� ������ �߰��ϼ���
--DEPARTMENT_ID DEPARTMENT_NAME MANAGER_ID LOCATION_ID
--280           ����            null          1800
--290           ȸ���           null          1800
--300           ����            301           1800
--310           �λ�            302           1800
--320           ����            303           1700
SELECT * FROM DEPTS; 
desc depts;

INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (280, '����', null, 1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (290, 'ȸ���', null, 1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (300, '����', 301, 1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (310, '�λ�', 302, 1800);
-- ��ü �÷��� �����Ҷ��� ������� �����־�, �Ʒ��� ���� �ۼ��ص� ��
INSERT INTO DEPTS
VALUES (320, '����', 303, 1700);

--���� 2.
--DEPTS���̺��� �����͸� �����մϴ�
SELECT * FROM DEPTS;
--1. department_name �� IT Support �� �������� department_name�� IT bank�� ����
UPDATE DEPTS SET DEPARTMENT_NAME = 'IT bank' WHERE DEPARTMENT_NAME = 'IT Support'; -- 210�� ������
--2. department_id�� 290�� �������� manager_id�� 301�� ����]
UPDATE DEPTS SET MANAGER_ID = 301 WHERE DEPARTMENT_ID = 290;
--3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵�
--1800���� �����ϼ���
UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT Help', MANAGER_ID = 303, location_id = 1800 WHERE DEPARTMENT_NAME = 'IT Helpdesk';
--4. ����, ȸ���, ����, �λ�, ������ �Ŵ������̵� 301�� �ѹ��� �����ϼ���.
SELECT * FROM DEPTS;
UPDATE DEPTS SET MANAGER_ID = 301 WHERE DEPARTMENT_ID BETWEEN 280 AND 320;


--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
--1. �μ��� �����θ� ���� �ϼ���
DELETE FROM DEPTS WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPTS WHERE DEPARTMENT_NAME = '����');
--2. �μ��� NOC�� �����ϼ���
DELETE FROM DEPTS WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC');
SELECT * FROM DEPTS;

--����4
--1. Depts �纻���̺��� department_id �� 200���� ū �����͸� �����ϼ���.
DELETE FROM DEPTS WHERE DEPARTMENT_ID > 200;
--2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
UPDATE DEPTS SET MANAGER_ID = 100 WHERE MANAGER_ID IS NOT NULL;
--3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�
--�������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
MERGE INTO DEPTS A
    USING DEPARTMENTS B
    ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
WHEN MATCHED THEN
    UPDATE SET 
        A.DEPARTMENT_NAME = B.DEPARTMENT_NAME,
        A.MANAGER_ID = B.MANAGER_ID,
        A.LOCATION_ID = B.LOCATION_ID
WHEN NOT MATCHED THEN
    INSERT VALUES(
        B.DEPARTMENT_ID,
        B.DEPARTMENT_NAME,
        B.MANAGER_ID,
        B.LOCATION_ID);
SELECT * FROM DEPTS;

--���� 5
SELECT * FROM JOBS;   -- JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY
--1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE MIN_SALARY >= 6000); 
SELECT * FROM JOBS_IT;
--2. jobs_it ���̺� ���� �����͸� �߰��ϼ���
--JOB_ID   JOB_TITLE     MIN_SALARY MAX_SALARY
--IT_DEV   ����Ƽ������   6000        20000
--NET_DEV  ��Ʈ��ũ������  5000        20000
--SEC_DEV  ���Ȱ�����     6000        19000
INSERT INTO JOBS_IT(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
VALUES ('IT_DEV', '����Ƽ������', 6000, 20000);
INSERT INTO JOBS_IT(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
VALUES ('NET_DEV', '��Ʈ��ũ������', 5000, 20000);
INSERT INTO JOBS_IT(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
VALUES ('SEC_DEV', '���Ȱ�����', 6000, 19000);

--3. jobs_it�� Ÿ�� ���̺� �Դϴ�
--4. jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
--min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
--�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���
SELECT * FROM JOBS;
MERGE INTO JOBS_IT A
    USING (SELECT * FROM JOBS WHERE MIN_SALARY > 0) B
    ON (A.JOB_ID = B.JOB_ID)
WHEN MATCHED THEN
    UPDATE SET 
        A.MIN_SALARY = B.MIN_SALARY,
        A.MAX_SALARY = B.MIN_SALARY
WHEN NOT MATCHED THEN
    INSERT VALUES(
        B.JOB_ID,
        B.JOB_TITLE,
        B.MIN_SALARY,
        B.MAX_SALARY);
        
SELECT * FROM JOBS_IT;
commit;   --> ������ ����