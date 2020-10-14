-- �������� ����
--���� 1.
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
    -- ���� ����� : 6461
SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT TRUNC(AVG(SALARY))FROM EMPLOYEES);
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
SELECT COUNT(*) AS ��ձ޿��̻�����
FROM EMPLOYEES
WHERE SALARY > (SELECT TRUNC(AVG(SALARY))FROM EMPLOYEES);
---EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿�  --> 5760
-- ���� ���� ������� �����͸� ����ϼ���
SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT TRUNC(AVG(SALARY))FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

--���� 2.
--DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��   -> ���ϰ� : 90
--EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
SELECT *
FROM EMPLOYEES 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS 
                        WHERE MANAGER_ID = 100);

--���� 3.
---EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
SELECT * FROM EMPLOYEES WHERE FIRST_NAME LIKE '%Pat%';  -- 146, 201 �ε� Pat�� 201
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat');
---EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
SELECT * FROM EMPLOYEES WHERE FIRST_NAME LIKE '%James%';  -- 120, 121

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James');

--���� 4.
---EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
SELECT 
    RN, FIRST_NAME
FROM(
    SELECT 
        ROWNUM AS RN, FIRST_NAME
    FROM(SELECT * FROM EMPLOYEES ORDER BY FIRST_NAME ASC)
)
WHERE RN BETWEEN 41 AND 50;

--���� 5.
--EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 
--31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, �Ի����� ����ϼ���.
SELECT *
FROM(
    SELECT 
        ROWNUM AS RR,
        EMPLOYEE_ID, first_name||' '||last_name AS NAME,
        PHONE_NUMBER, HIRE_DATE
    FROM(
        SELECT *
        FROM EMPLOYEES 
        ORDER BY HIRE_DATE DESC
    )
)
WHERE RR BETWEEN 31 AND 40;

--���� 6.
--employees���̺� departments���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����
SELECT 
    EMPLOYEE_ID, 
    CONCAT(CONCAT(FIRST_NAME,' '),LAST_NAME) AS NAME,
    E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT 
    EMPLOYEE_ID, 
    CONCAT(CONCAT(FIRST_NAME,' '),LAST_NAME) AS NAME,
    DEPARTMENT_ID,
    (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPARTMENT_ID
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;

--���� 8.
--departments���̺� locations���̺��� left �����ϼ���
SELECT * FROM LOCATIONS;
SELECT * FROM DEPARTMENTS;
--����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����
SELECT 
    DEPARTMENT_ID, 
    DEPARTMENT_NAME, 
    MANAGER_ID, 
    D.LOCATION_ID, 
    STREET_ADDRESS,
    POSTAL_CODE, 
    CITY
FROM DEPARTMENTS D
LEFT OUTER JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY DEPARTMENT_ID ASC;

--���� 9.
--���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT 
    DEPARTMENT_ID, 
    DEPARTMENT_NAME, 
    MANAGER_ID, 
    D.LOCATION_ID,
    (SELECT 
        STREET_ADDRESS
    FROM LOCATIONS L 
    WHERE D.LOCATION_ID = L.LOCATION_ID) STREET_ADDRESS,
    (SELECT 
        POSTAL_CODE
    FROM LOCATIONS L 
    WHERE D.LOCATION_ID = L.LOCATION_ID) POSTAL_CODE,
    (SELECT 
        CITY
    FROM LOCATIONS L 
    WHERE D.LOCATION_ID = L.LOCATION_ID) CITY
FROM DEPARTMENTS D
ORDER BY DEPARTMENT_ID ASC;

-- --------------------------------------------------------
-- ���� ������ ���� �ʾ� ��� ���� ����.
SELECT 
    (SELECT 
        D.DEPARTMENT_ID
    FROM DEPARTMENTS D 
    WHERE D.LOCATION_ID = L.LOCATION_ID) DEPARTMENT_ID, 
    (SELECT 
        D.DEPARTMENT_NAME
    FROM DEPARTMENTS D 
    WHERE D.LOCATION_ID = L.LOCATION_ID) DEPARTMENT_NAME,
    (SELECT 
      D.MANAGER_ID
    FROM DEPARTMENTS D
    WHERE D.LOCATION_ID = L.LOCATION_ID) MANAGER_ID, 
    L.LOCATION_ID,
    STREET_ADDRESS,
    POSTAL_CODE,
    CITY
FROM LOCATIONS L
ORDER BY DEPARTMENT_ID ASC;
-- --------------------------------------------------------

--���� 10.
--locations���̺� countries ���̺��� left �����ϼ���
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����
SELECT * FROM LOCATIONS;
SELECT * FROM COUNTRIES;   -- KEY ; COUNTRY_ID

SELECT 
    LOCATION_ID,
    STREET_ADDRESS,
    CITY,
    L.COUNTRY_ID,
    COUNTRY_NAME
FROM LOCATIONS L
LEFT OUTER JOIN COUNTRIES C
ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY COUNTRY_NAME ASC;

--���� 11.
--���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT 
    LOCATION_ID,
    STREET_ADDRESS,
    CITY,
    L.COUNTRY_ID,
    (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID) AS COUNTRY_NAME
FROM LOCATIONS L
ORDER BY COUNTRY_NAME ASC;


-- ���ΰ� ��������
--���� 12.
--employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 1-10��° �����͸� ����մϴ�
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, �μ����̵�, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
SELECT 
    ROWNUM,
    EMPLOYEE_ID,
    CONCAT(CONCAT(FIRST_NAME,' '),LAST_NAME) AS NAME,
    PHONE_NUMBER,
    HIRE_DATE,
    E.DEPARTMENT_ID,
    DEPARTMENT_NAME
FROM (SELECT * FROM EMPLOYEES ORDER BY HIRE_DATE) E
LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE ROWNUM BETWEEN 1 AND 10;

--���� 13.
-- EMPLOYEES �� DEPARTMENTS ���̺��� 
-- JOB_ID�� SA_MAN ����� ������ 
-- LAST_NAME, JOB_ID, DEPARTMENT_ID, DEPARTMENT_NAME�� ����ϼ���
SELECT * FROM DEPARTMENTS;

SELECT 
    LAST_NAME, 
    JOB_ID, 
    E.DEPARTMENT_ID, 
    DEPARTMENT_NAME
FROM (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN') E
LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--���� 14
-- DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
-- �ο��� ���� �������� �����ϼ���.
        -- ����� ���� �μ��� ������� ���� �ʽ��ϴ�
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;
SELECT COUNT(*) FROM EMPLOYEES  WHERE DEPARTMENT_ID = 50;

SELECT 
    D.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.MANAGER_ID, COUNT(*)
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID IS NOT NULL
GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.MANAGER_ID
ORDER BY COUNT(*) DESC;

--���� 15
-- �μ��� ���� ���� ���ο�,  --> DEPARTMENTS 
-- �ּ�, �����ȣ,   --> LOCATIONS
-- �μ��� ��� ������ ���ؼ� ����ϼ���  --> EMPLOYEES
-- �μ��� ����� ������ 0���� ����ϼ���
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;
SELECT * FROM EMPLOYEES;

SELECT 
    D.*,
    STREET_ADDRESS,
    POSTAL_CODE,
    NVL(��տ���,0) AS ��տ���
FROM DEPARTMENTS D
LEFT OUTER JOIN 
(
    SELECT 
        DEPARTMENT_ID, 
        TRUNC(AVG(SALARY)) AS ��տ��� 
    FROM EMPLOYEES 
    GROUP BY DEPARTMENT_ID
) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
LEFT OUTER JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;


SELECT 
        DEPARTMENT_ID, 
        TRUNC(AVG(SALARY)) AS ��տ��� 
    FROM EMPLOYEES 
    GROUP BY DEPARTMENT_ID;
--���� 16
-- ���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
-- ����ϼ���
SELECT 
   *
FROM 
(
    SELECT 
        ROWNUM AS RN, A.*
    FROM
    (
        SELECT 
            D.*,
            STREET_ADDRESS,
            POSTAL_CODE,
            NVL(��տ���,0)
        FROM DEPARTMENTS D
        LEFT OUTER JOIN 
        (
            SELECT 
                DEPARTMENT_ID, 
                TRUNC(AVG(SALARY)) AS ��տ��� 
            FROM EMPLOYEES GROUP BY DEPARTMENT_ID
        ) E
        ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
        LEFT OUTER JOIN LOCATIONS L
        ON D.LOCATION_ID = L.LOCATION_ID
        ORDER BY D.DEPARTMENT_ID DESC
    ) A
) 
WHERE RN BETWEEN 1 AND 10;