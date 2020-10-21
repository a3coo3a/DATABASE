-- �ڹٺ��� ����� ����. �ڹٿ��� �Ҽ� �ִ°� ����Ŭ���� ����

-- ������ SQL��
-- ����Ŭ���� �����Ǵ� ���α׷��ְ��� ���
-- �������� ������� � ������ �ϰ�ó���ϱ� ���ؼ� ��� (insert, delete, update�� �ѹ��� �����Ѵٴ°�)

-- ������
-- ������ ��Ʈ�� + ���Ͱ� �ƴ� ������ �ؾ���.
-- �ʿ��� �ڵ�κи� �����ؼ� F5�� ��������.

-- ����Ŭ ���ӽ� ��±����� ����� �� �ְ� ����
SET SERVEROUTPUT ON;
DECLARE  -- ���� �����ϴ� �κ�
    v_num number; -- ���ڰ��� ���� ũ�Ⱑ �������� �ʾƵ� �˴ϴ�.
BEGIN
    v_num := 100; -- :=�� ������ �ǹ�
    DBMS_OUTPUT.put_line(v_num);   --���
END;

-- ��� :
/*
100


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- ������
-- �Ϲ�sql������ ����ϴ� ��� �����ڰ� ��� ����
-- Ư���� �����ڴ� **����
set SERVEROUTPUT on;
DECLARE
    a number := (1+2) ** 2;  -- 3�� ����
BEGIN
    DBMS_OUTPUT.PUT_LINE('a�� : ' || a);   -- || : ���ڿ� ���̴� ������
end;
/*���
a�� : 9


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/



-- DML��
-- DDL���� ����� �Ұ���
-- �Ϲ����� SQL���� select������ ����ϴµ�,
-- select�� �Ʒ����� into���� �̿��ؼ� ������ �Ҵ� (�������� ����)
-- select into from ��
DECLARE
  v_emp_name VARCHAR2(50);  -- ���� ���� : ���ڿ��� ���������� �ݵ�� �ؾ���
  v_dep_name VARCHAR2(50);
BEGIN
  SELECT
      last_name, department_name   
  into V_EMP_NAME, V_DEP_NAME    -- ������ ��ġ�� ���� ���� ���Ե�. V_EMP_NAME := last_name, V_DEP_NAME:=department_name
  FROM EMPLOYEES e
  left outer join DEPARTMENTS d
  on E.DEPARTMENT_ID = D.DEPARTMENT_ID
  where EMPLOYEE_ID = 100;
  
  DBMS_OUTPUT.put_line('�̸�: ' || V_EMP_NAME || ' , �μ��̸�:' || V_DEP_NAME);
END;
/*���
�̸�: King , �μ��̸�:Executive


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

*/

-- f5�� �����
SELECT
      *
  FROM EMPLOYEES e
  left outer join DEPARTMENTS d
  on E.DEPARTMENT_ID = D.DEPARTMENT_ID
  where EMPLOYEE_ID = 100;
  
  

-- TYPE Ű����
-- �ش� ���̺��� ���� Ÿ���� �÷��� ����Ÿ������ �����Ϸ���
-- ����� :  ���̺��.�÷���%type
create table emp_test(emp_name VARCHAR2(50), dep_name VARCHAR2(50)); 
select * from emp_test;
DECLARE
     v_emp_name employees.last_name%TYPE;    -- employees���̺��� last_name�� Ÿ�԰� ������ Ÿ���� ����ϰڴ�.
     v_dep_name departments.department_name%TYPE;
BEGIN
    SELECT 
        last_name, department_name
    INTO v_emp_name, v_dep_name
    FROM employees E
    LEFT OUTER JOIN departments D
    ON E.department_id = D.department_id
    WHERE employee_id = 100;
    
    INSERT INTO emp_test 
    VALUES (V_EMP_NAME,V_DEP_NAME);
    
END;
select * from emp_test;

