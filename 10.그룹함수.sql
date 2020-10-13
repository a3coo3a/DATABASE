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

-- �μ� ���̵� 50�̻��� �÷��� �׷�ȭ ��Ű�� �׷� ����� �޿� 5000�̻� ��ȸ
SELECT
    *
FROM EMPLOYEES;
select 
    department_id, trunc(avg(SALARY)) 
from employees 
    where department_id >= 50 
    group by department_id having trunc(avg(SALARY)) >= 5000 
    ORDER BY DEPARTMENT_ID;


-- ------------------��������-------------------------
-- ���� 1.
-- ��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
SELECT
    JOB_ID, count(*)
FROM EMPLOYEES
GROUP BY JOB_ID;
-- ��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ��� 
SELECT
    JOB_ID, trunc(avg(salary)), count(*)
FROM EMPLOYEES
GROUP BY JOB_ID order by trunc(avg(salary)) desc;

-- ���� 2.
-- ��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
SELECT
    to_char(HIRE_DATE, 'YYYY') as �Ի�⵵, count(*) as �����
FROM EMPLOYEES group by to_char(HIRE_DATE, 'YYYY') order by to_char(HIRE_DATE, 'YYYY');

-- ���� 3.
-- �޿��� 1000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. 
-- �� �μ� ��� �޿��� 2000�̻��� �μ��� ���
SELECT
    DEPARTMENT_ID, trunc(avg(SALARY))
FROM EMPLOYEES 
where SALARY >= 1000
GROUP BY DEPARTMENT_ID having avg(SALARY) >= 2000;

-- ���� 4.
-- ��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
-- department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
-- ���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
-- ���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.
SELECT
    DEPARTMENT_ID, 
    trunc(avg(salary+SALARY*COMMISSION_PCT),2) as ��ձ޿�, 
    sum(SALARY) as �޿��հ�, 
    count(*)
FROM EMPLOYEES
where COMMISSION_PCT is not null
group by DEPARTMENT_ID;