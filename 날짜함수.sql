-- ��¥ �Լ�

-- SYSDATE  
-- �����
SELECT
    sysdate
FROM dual;

-- SYSTIMESTAMP
-- ����� �ú��� �ð���
SELECT
    systimestamp
FROM dual;

-- ��¥����
SELECT
    sysdate, sysdate + 3, sysdate - 3
FROM dual;

SELECT
    sysdate - HIRE_DATE
FROM EMPLOYEES;

-- �Ի��� ���ݱ��� ���� �ϼ�
SELECT
    (sysdate - HIRE_DATE)
FROM EMPLOYEES;
-- �ּ�
SELECT
    (sysdate - hire_date)/7
FROM EMPLOYEES;
-- ���
SELECT
    (sysdate - hire_date)/365
FROM EMPLOYEES;

-- ��¥�� �ݿø�, ����
SELECT
    trunc(sysdate - hire_date)
FROM EMPLOYEES;

-- Ư�� ���� �������� ��¥ ����
-- �� �������� ���� : ��/01/01
SELECT
    trunc(sysdate, 'year')
FROM dual;
-- �� �������� ���� : ��/��/01
SELECT
    trunc(sysdate, 'month')
FROM dual;
-- �� �������� ���� : �ش����� �Ͽ��ϱ���
SELECT
    trunc(sysdate, 'day')
FROM dual;
