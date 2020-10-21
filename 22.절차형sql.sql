-- 자바보다 기능이 많다. 자바에서 할수 있는건 오라클에서 가능

-- 절차형 SQL문
-- 오라클에서 제공되는 프로그래밍같은 기능
-- 쿼리문을 순서대로 어떤 동작을 일괄처리하기 위해서 사용 (insert, delete, update를 한번에 실행한다는것)

-- 실행방법
-- 실행이 컨트롤 + 엔터가 아닌 컴파일 해야함.
-- 필요한 코드부분만 선택해서 F5로 컴파일함.

-- 오라클 접속시 출력구분을 사용할 수 있게 변경
SET SERVEROUTPUT ON;
DECLARE  -- 변수 선언하는 부분
    v_num number; -- 숫자같은 경우는 크기가 지정되지 않아도 됩니다.
BEGIN
    v_num := 100; -- :=은 대입의 의미
    DBMS_OUTPUT.put_line(v_num);   --출력
END;

-- 결과 :
/*
100


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- 연산자
-- 일반sql문에서 사용하는 모든 연산자가 사용 가능
-- 특별한 연산자는 **제곱
set SERVEROUTPUT on;
DECLARE
    a number := (1+2) ** 2;  -- 3의 제곱
BEGIN
    DBMS_OUTPUT.PUT_LINE('a는 : ' || a);   -- || : 문자열 붙이는 연산자
end;
/*결과
a는 : 9


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/



-- DML문
-- DDL문은 사용이 불가능
-- 일반적인 SQL문의 select구문을 사용하는데,
-- select절 아래에는 into절을 이용해서 변수를 할당 (나머지는 동일)
-- select into from 절
DECLARE
  v_emp_name VARCHAR2(50);  -- 변수 선언 : 문자열은 길이제한을 반드시 해야함
  v_dep_name VARCHAR2(50);
BEGIN
  SELECT
      last_name, department_name   
  into V_EMP_NAME, V_DEP_NAME    -- 각각의 위치에 변수 값이 들어가게됨. V_EMP_NAME := last_name, V_DEP_NAME:=department_name
  FROM EMPLOYEES e
  left outer join DEPARTMENTS d
  on E.DEPARTMENT_ID = D.DEPARTMENT_ID
  where EMPLOYEE_ID = 100;
  
  DBMS_OUTPUT.put_line('이름: ' || V_EMP_NAME || ' , 부서이름:' || V_DEP_NAME);
END;
/*결과
이름: King , 부서이름:Executive


PL/SQL 프로시저가 성공적으로 완료되었습니다.

*/

-- f5로 실행시
SELECT
      *
  FROM EMPLOYEES e
  left outer join DEPARTMENTS d
  on E.DEPARTMENT_ID = D.DEPARTMENT_ID
  where EMPLOYEE_ID = 100;
  
  

-- TYPE 키워드
-- 해당 테이블의 같은 타입의 컬럼을 변수타입으로 선언하려면
-- 사용방법 :  테이블명.컬럼명%type
create table emp_test(emp_name VARCHAR2(50), dep_name VARCHAR2(50)); 
select * from emp_test;
DECLARE
     v_emp_name employees.last_name%TYPE;    -- employees테이블의 last_name의 타입과 동일한 타입을 사용하겠다.
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

