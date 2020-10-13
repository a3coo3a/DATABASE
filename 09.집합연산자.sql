-- ���� ������
-- ���� ������ ���ÿ��� �÷� ������ ���� �־�� ��.

SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where hire_date like '04%';

SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where DEPARTMENT_ID = 20;
-- ������ �����ݷ��� ����� ��ĥ �� select ���� ���̿� [���տ�����]�� �ۼ�
-- union : ������, �ߺ�x
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where hire_date like '04%'
union
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where DEPARTMENT_ID = 20;

-- union all : ������, �ߺ�o
-- �÷� ������ �� �������.
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where hire_date like '04%'
union all
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where DEPARTMENT_ID = 20;


-- intersect : ������
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where hire_date like '04%'
intersect
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where DEPARTMENT_ID = 20;

-- minus
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where hire_date like '04%'
minus
SELECT
    employee_id, first_name, hire_date
FROM EMPLOYEES where DEPARTMENT_ID = 20;

-- union all�� ����� ���̵�����
-- ��¥���̺��̶�� ��.
-- �÷����� ù��° �����ͷ� ������� 
SELECT
    'ȫ�浿' as name,'20200211' as year  
FROM dual union all
SELECT
    '�̼���','20200321'    
FROM dual union all
SELECT
    '������','20190231'    
FROM dual union all
SELECT
    '�̼���','20180301'    
FROM dual;