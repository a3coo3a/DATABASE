-- 서브쿼리
-- 사용법 : ()안에 명시
-- 서브쿼리의 리턴행이 1줄 이하여야 함.

-- 단일행 서브쿼리
-- : 서브쿼리의 결과가 한 행이 나오는 것
SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';  -- SALARY : 12008

-- Nancy보다 급여가 많은 사람
SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');

-- EMPLOYEE_ID가 103인 사람의 JOB_ID와 동일한 사람을 찾아라
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);  -- JOB_ID : IT_PROG

-- 서브쿼리의 리턴행이 여러개라면 일반 비교 연산으로는 구분할 수 없습니다.
SELECT JOB_ID
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

-- 에러!
-- 에러 메시지 : 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
-- 행이 5개로 나와서 그럼.
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');