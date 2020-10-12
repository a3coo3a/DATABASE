-- ��ȯ�Լ� (�����߿�)

-- to_char()
-- ��¥ -> ���� : to_char(��¥, ����)
-- ��¥ ���� ������ �빮�ڷ� ǥ��
SELECT
    TO_CHAR(sysdate, 'YYYY-MM-DD')
FROM dual;              -- 2020-10-12 ǥ��

-- ������ �ú��� : ���� MI
SELECT
    to_char(sysdate,'YYYY-MM-DD HH:MI:SS')
FROM dual;              -- 2020-10-12 01:37:47 ǥ��

SELECT
    to_char(sysdate, 'YY-MM-DD HH24:MI')
FROM dual;              -- 20-10-12 13:37 ǥ��

-- ������ ��¥ ���� ������ �ƴ� ���� �����ؼ� ������ �� ���
-- "" �� ���� ���
SELECT
    to_char(sysdate, 'YYYY"��" MM"��" DD"��"')
FROM dual;              -- 2020�� 10�� 12�� ǥ��

SELECT 
    first_name, hire_date, to_char(hire_date, 'YYYY-MM-DD')
FROM EMPLOYEES;

-- ���� -> ���� : to_char(����, ����)
-- 9 : �ڸ����� ǥ��
SELECT
    to_char(20000, '99999') as �ټ��ڸ�,
    to_char(20000, '999999999') as ��ȩ�ڸ�
FROM dual;

-- �ڸ����� ������ ��� (��û�� �ڸ���+1��ŭ)#���� ǥ��
SELECT
    to_char(20000,'99')
FROM dual;

-- �Ҽ����� �߷������� 5�ڸ��� ǥ��Ǵ� ��� ; 20000
SELECT
    to_char(20000.21,'99999')
FROM dual;
-- ������ ǥ����.
SELECT
    to_char(20000.21,'99999.99')
FROM dual;

-- salary�� �������� ǥ��Ǵ°ɷ� ���� �����ΰ� Ȯ��
SELECT
    salary, to_char(SALARY,'$99,999')
FROM EMPLOYEES order by SALARY DESC;

-- ���� -> ���� : to_number(����, ����)
-- ���� ���ڸ� �ִ� ���� �ڵ�����ȯ(verchar2��)�� �Ͼ
-- �ڵ�����ȯ�� �Ͼ�� ���ϴ� Ư���� ����($ or ,)�� ���� ������ ��� ���
SELECT
    '2000' + 2000
FROM dual;          -- �ڵ�����ȯ

SELECT
    to_number('2000') + 2000
FROM dual;          -- ���������ȯ : ���� ����ȯ�ϴ� ���

SELECT
    '$2000' + 2000 
FROM dual;          -- error : �������� $ , ���� Ư�� ���ڸ� ���ϰ� �������� �ڵ�����ȯ�� �Ұ�
-- ���� '2000��' ���� �������� ������ ������ ������ �ƴ� ���
-- ��Ʈ������ �߶� ���� �����ؾ���

-- ������ ���������� �����ϴ� ������ ���� ���, ���������ȯ�� ����.
SELECT
    to_number('$2000','$9999') + 2000
FROM dual;

-- ���� -> ���� : ��to_date(����, ����)
-- �̷����� �ٷ� ���� ����
SELECT
    to_date('2020-03-31'), to_date('2020-03-31')+3
FROM dual;          -- ��¥�� ���� �Ǵ°� ������ ���� �ϴٴ� ��

-- ���ϴ� �������� �̾Ƴ�
SELECT
    to_date('2020/12/12', 'YY/MM/DD')
FROM dual;

SELECT
    to_date('2020-03-21 12:23:03','YYYY-MM-DD HH:MI:SS')
FROM dual;              
-- �ú��� ���±��� �ִµ� �����ϸ� ������ �����ϸ� ���ʿ��� ���� �ִٸ� ��ȯ ���� ����.
-- �׷��� �ú��ʵ� �Բ� ������ �־����.

-- null�� ��ȯ �Լ� : null�� ����
-- ��NVL() : ��, null�� ���
SELECT
    *
FROM dual;
SELECT
    nvl(null, 0)
FROM dual;

SELECT
   first_name, SALARY, COMMISSION_PCT, SALARY + SALARY * COMMISSION_PCT
FROM EMPLOYEES;         -- null���� ����� �ȵǹǷ� null�� ǥ��Ǵ� ���
SELECT
   first_name, SALARY, COMMISSION_PCT, 
   SALARY + SALARY * nvl(COMMISSION_PCT,0)
FROM EMPLOYEES;         -- �������� ������� Ȯ�� �� �� ����.


-- ��NVL2() : ��, null�� �ƴҰ��, null�� ���
SELECT
    nvl2(null, 'null�ƴ�', 'null��')
FROM dual;

SELECT
    first_name, NVL2(commission_pct, 'true', 'false')
FROM EMPLOYEES;

SELECT
    first_name, SALARY, COMMISSION_PCT, 
    NVL2(commission_pct, salary + (salary * commission_pct), salary) as �����޿�
FROM EMPLOYEES;

-- decode(������, �񱳰�, ���, �񱳰�, ���, �񱳰�, ���...., �׿� ���)
SELECT
    decode('A','A','A�Դϴ�')
FROM dual;

SELECT
    decode('��','A','A�Դϴ�',
               'B','B�Դϴ�',
               'C','C�Դϴ�',
               'A,B,C�� �ƴմϴ�')
FROM dual;

SELECT job_id, salary,
    decode(job_id, 'IT_PROG', salary * 100,
                   'AD_VP', salary * 200,
                   'FI_MGR', salary * 300,
                   salary) as �����޿�
FROM EMPLOYEES;

-- case when then end
SELECT job_id, salary,
    CASE job_id WHEN 'IT_PFOG' THEN salary * 100
                WHEN 'AD_VP' THEN salary * 200
                WHEN 'FI_MGR' THEN salary * 300
                ELSE salary 
    END as �����޿�
FROM EMPLOYEES;

-- --------------------��������-----------------------------
--���� 1.
SELECT
    *
FROM EMPLOYEES;
--�������ڸ� �������� EMPLOYEE���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 10�� �̻���
--����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������.
--���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�
SELECT
    EMPLOYEE_ID as �����ȣ,
    concat(first_name,last_name) as �����,
    hire_date as �Ի�����,
    trunc((sysdate - hire_date)/365) as �ټӳ��
FROM EMPLOYEES where trunc((sysdate - hire_date)/365) >= 10 ORDER BY �ټӳ�� DESC; 

--���� 2.
SELECT
    *
FROM EMPLOYEES;
--EMPLOYEE ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
--100�̶�� �������,
--120�̶�� �����ӡ�
--121�̶�� ���븮��
--122��� �����塯
--�������� ���ӿ��� ���� ����մϴ�.
--���� 1) manager_id�� 50�� ������� ������θ� ��ȸ�մϴ�
SELECT first_name, manager_id,
    decode(MANAGER_ID, 100, '���',
                       120, '����',
                       121, '�븮',
                       122, '����',
                       '�ӿ�') as ����,
        DEPARTMENT_ID                    
FROM EMPLOYEES where department_id = 50 ; 

-- ����3.
-- 1�� ���� 12������ �� ���� ������ ��¥�� ����ϼ���
SELECT
    to_char(LAST_DAY(TO_DATE('01','MM')),'dd') as "1��", 
    to_char(last_day(to_date('02','MM')),'dd') as "2��",
    to_char(last_day(to_date('03','MM')),'dd') as "3��",
    to_char(last_day(to_date('04','MM')),'dd') as "4��",
    to_char(last_day(to_date('05','MM')),'dd') as "5��",
    to_char(last_day(to_date('06','MM')),'dd') as "6��",
    to_char(last_day(to_date('07','MM')),'dd') as "7��",
    to_char(last_day(to_date('08','MM')),'dd') as "8��",
    to_char(last_day(to_date('09','MM')),'dd') as "9��",
    to_char(last_day(to_date('10','MM')),'dd') as "10��",
    to_char(last_day(to_date('11','MM')),'dd') as "11��",
    to_char(last_day(to_date('12','MM')),'dd') as "12��"
FROM dual;

