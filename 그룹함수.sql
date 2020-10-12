-- �׷� �Լ�

-- avg, max, min, sum, count
SELECT
    avg(SALARY), sum(SALARY), min(SALARY), max(SALARY)
FROM EMPLOYEES;

-- count(*) : ��ü �� �������� ����
SELECT
    count(*)
FROM EMPLOYEES;
-- count(�÷���) : �÷��� null���� ������ ������ ����
SELECT
    count(first_name)
FROM EMPLOYEES;     -- 107
SELECT
    count(COMMISSION_PCT)
FROM EMPLOYEES;     -- 35

-- ����! 
-- �׷� �Լ��� �Ϲ� �÷��� ���ÿ� ��� �� �� ����.
SELECT
    DEPARTMENT_ID, sum(SALARY)
FROM EMPLOYEES;


-- group by : �׷���
-- where�� ������ ����
SELECT
    DEPARTMENT_ID
FROM EMPLOYEES group by department_id ORDER BY DEPARTMENT_ID;

SELECT
    DEPARTMENT_ID, sum(SALARY), avg(SALARY), count(*)
FROM EMPLOYEES group by department_id order by DEPARTMENT_ID;

-- ����
-- �׷����� ���� �÷��� ��ȸ�� ����
SELECT
    department_id, job_id
FROM EMPLOYEES group by department_id;

-- 2�� �̻��� �׷�ȭ
SELECT
    DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES group by department_id, job_id order by DEPARTMENT_ID;

-- having
-- group by���� ������
-- �׷��ε� ����� ������ �ְ� ������ where���� ���� ���� �� �� group by���� ����Ǿ� ���ϴ� ����� ������ ����.
SELECT
    department_id, sum(salary)
FROM EMPLOYEES where salary >= 5000 group by department_id;
SELECT
    department_id, sum(salary)
FROM EMPLOYEES group by department_id;

SELECT
    department_id, sum(salary)
FROM EMPLOYEES group by department_id having sum(salary) >= 100000;

-- 20�� �̻��� job_id
SELECT
    job_id, count(*)
FROM EMPLOYEES group by job_id having count(*) >= 20;

