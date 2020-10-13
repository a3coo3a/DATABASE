-- ��������
-- ���� : ()�ȿ� ���
-- ���������� �������� 1�� ���Ͽ��� ��.

-- ������ ��������
-- : ���������� ����� �� ���� ������ ��
SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';  -- SALARY : 12008

-- Nancy���� �޿��� ���� ���
SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');

-- EMPLOYEE_ID�� 103�� ����� JOB_ID�� ������ ����� ã�ƶ�
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);  -- JOB_ID : IT_PROG

-- ���������� �������� ��������� �Ϲ� �� �������δ� ������ �� �����ϴ�.
SELECT JOB_ID
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

-- ����!
-- ���� �޽��� : ���� �� ���� ���ǿ� 2�� �̻��� ���� ���ϵǾ����ϴ�.
-- ���� 5���� ���ͼ� �׷�.
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');