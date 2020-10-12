-- ���� �Լ� 

-- �������̺�
SELECT
    *
FROM dual;  -- �Լ� Ȯ�ο����� �ַ� ����
SELECT
    '�ȳ�', '����'
FROM dual;

-- lower : �ҹ��ڷ�
-- upper : �빮�ڷ�
-- initcap : ù���ڸ� �빮�ڷ�
SELECT
    'abcDEF', LOWER('abcDEF'), UPPER('abcDEF'), INITCAP('abcDEF')
FROM dual;

SELECT
    *
FROM EMPLOYEES;

SELECT
    LAST_NAME, LOWER(LAST_NAME), UPPER(LAST_NAME), INITCAP(LAST_NAME)
FROM EMPLOYEES;

-- where �������� ��밡��
-- �ڷḦ �ҹ��ڷ� ��ȯ�Ͽ� �ҹ����� bull�� �������ڸ� ã�� �ڷḦ ������
-- �����ٶ��� �ڷᰡ ������ �ִ� ������ ������
SELECT
    LAST_NAME
FROM EMPLOYEES WHERE LOWER(LAST_NAME) = 'bull';

-- length() : ����
-- instr() : ���ڰ˻�
SELECT FIRST_NAME, 
    length(FIRST_NAME) AS ����, 
    instr(FIRST_NAME,'a') AS ������ġ   -- ������ 0���� ��Ÿ��
FROM EMPLOYEES;

SELECT
    length('abc'), instr('abcdefg', 'a')
FROM dual;

-- substr() : ���ڿ� �ڸ���
-- concat() : ���ڿ� ���̱�
SELECT
    SUBSTR('abcdef',1,3), CONCAT('abc','def')       -- 1 �̻� 3 ���Ϸ� �ڸ�
FROM dual;

SELECT first_name,
    substr(first_name, 1, 3), concat(first_name,last_name)
FROM EMPLOYEES;

-- concat�� 2���� ���ڿ����� ����� �� �����Ƿ�, 
-- 3���� ���ڿ��� �ٷ�� �ʹٸ� ��ø������ ����
SELECT
    first_name,
    concat(concat(first_name,' '),last_name)
FROM EMPLOYEES; 

-- lpad() : ���� ���� ���ڿ� ä���
-- rpad() : ���� ���� ���ڿ� ä���
-- 10ĭ�� Ȯ���ϰ� ���� ���� ������� *�� ä��
SELECT
    lpad('abc', 10,'*')
FROM dual;
-- 10ĭ�� Ȯ���ϰ� ���� ������ ������� *�� ä��
SELECT
    rpad('abc',10,'*')
FROM dual;

SELECT
    lpad(first_name, 10, '-'), rpad(first_name, 10,'-')
FROM EMPLOYEES;

-- ltrim() : ���� ��������, ��������
-- rtrim() : ������ ��������, ��������
SELECT
    ltrim('javascript_java','java')
FROM dual;

SELECT
    rtrim('javascript_java','java')
FROM dual;
-- trim() : ������ ������ ����
SELECT
    trim('    java    ')
FROM dual;

-- replace() : Ư�� ���ڿ��� �ٲٴ� �Լ�, ���ڿ� ġȯ
-- replace( ���ڿ�, A, B) : A�� B�� �ٲ۴�
-- president �� programmer�� �ٲپ� ������
SELECT
    REPLACE('my dream is president','president','programmer')
FROM dual; 

-- ��������
SELECT
    REPLACE('my dream is president',' ','')
FROM dual;

-- ���ڵ� �ٲٰ� ���鵵 �ٲٰ� �ʹٸ� ��ø���� ���
SELECT
   REPLACE(REPLACE('my dream is president','president','programmer'),' ','')
FROM dual;
-- 2�� �̻�, �ٸ� ������ �Լ��ε� ����
-- ���� ������ �Լ����� �ؼ��ؼ� ������ ��.
SELECT
   LTRIM(REPLACE(REPLACE('my dream is president','president','programmer'),' ',''),'my')
FROM dual;

-- -------------------------------��������---------------------------------------
--���� 1. EMPLOYEES ���̺��� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
--���� 1) ���ϱ� ���� ���� �ҹ��ڷ� �Է��ؾ� �մϴ�.(��Ʈ : lower �̿�)
--���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�.
--�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
--���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�.
--�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)
SELECT
    rpad(substr(first_name,1,3),length(first_name),'*') as name, lpad(salary,10,'*') as salary
FROM EMPLOYEES where lower(job_id) = 'it_prog';
-- ***�̸� �� �����ؼ� �ۼ�
SELECT
    lpad(substr(first_name,4,length(first_name)),length(first_name),'*') as name, lpad(salary,10,'*') as salary
FROM EMPLOYEES where lower(job_id) = 'it_prog';

--���� 1.
SELECT * FROM EMPLOYEES;
--EMPLOYEES ���̺� ���� �̸�, �Ի����� �÷����� �����ؼ� �̸������� �������� ��� �մϴ�.
--���� 1) �̸� �÷��� first_name, last_name�� �ٿ��� ����մϴ�.
--���� 2) �Ի����� �÷��� xx/xx/xx�� ����Ǿ� �ֽ��ϴ�. xxxxxx���·� �����ؼ� ����մϴ�.
SELECT
    concat(first_name, last_name) as �̸�,
    replace(hire_date, '/', '') as �Ի�����
FROM EMPLOYEES order by �̸� asc;

--���� 2.
SELECT * FROM EMPLOYEES;
--EMPLOYEES ���̺� ���� phone_numbe�÷��� ###.###.####���·� ����Ǿ� �ִ�
--���⼭ ó�� �� �ڸ� ���� ��� ���� ������ȣ (02)�� �ٿ� ��ȭ ��ȣ�� ����ϵ��� ������ �ۼ��ϼ���
SELECT
    lpad(substr(phone_number,4,length(phone_number)),LENGTH(PHONE_NUMBER)-1,'02')
FROM EMPLOYEES;
SELECT
    REPLACE(phone_number,substr(phone_number,1,3),'02') 
FROM EMPLOYEES;

--���� 3.
SELECT * FROM EMPLOYEES;
--EMPLOYEES ���̺��� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
--���� 1) ���ϱ� ���� ���� �ҹ��ڷ� �Է��ؾ� �մϴ�.(��Ʈ : lower �̿�)
--���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�.
--�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
--���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�.
--�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)
SELECT
    lpad(substr(first_name,4,length(first_name)),length(first_name),'*') as �̸�,
    lpad(salary,10,'*') as �޿�
FROM EMPLOYEES where lower(job_id) = 'it_prog';

