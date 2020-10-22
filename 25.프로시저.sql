SET SERVEROUTPUT ON;

-- 프로시저 생성
-- in : 외부의 입력받는 파라미터
/* 함수랑 비슷해 보이지만 함수는 따로 있어요~
    create or replace procedure 프로시저명 (입력 파라미터)
*/
SELECT * FROM jobs;
CREATE OR REPLACE PROCEDURE new_job_proc(
-- 입력파라미터 영역
    p_job_id IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_id%TYPE,
    p_min_salary IN jobs.min_salary%TYPE,
    p_max_salary IN jobs.max_salary%TYPE
)
IS
-- 변수선언 영역

BEGIN
    INSERT INTO jobs(job_id, job_title, min_salary, max_salary) 
    VALUES(p_job_id, p_job_title, p_min_salary, p_max_salary);
    
    COMMIT;
END;
-- 결과 : Procedure NEW_JOB_PROC이(가) 컴파일되었습니다.


-- 프로시저 실행
EXECUTE new_job_proc('JOBS1','TEST...',1000,5000);
EXECUTE new_job_proc('JOBS2','TEST2...',2000,10000);  -- 두번넣으면 무결성제약조건 에러
SELECT * FROM JOBS;


-- 프로시저수정은 동일한 이름으로 수정
CREATE OR REPLACE PROCEDURE new_job_proc(
    p_job_id IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_id%TYPE,
    p_job_min_salary IN jobs.min_salary%TYPE  := 0,  -- 기본값 지정
    p_job_max_salary IN jobs.max_salary%TYPE := 100
)
IS
    V_COUNT NUMBER := 0;
BEGIN
    SELECT COUNT(*) -- 중복이 없으면 0
    INTO V_COUNT
    FROM JOBS
    WHERE JOB_ID = P_JOB_ID;  -- P_JOB_ID를 기반으로 조회해서 카운트
    
    -- 없다면 INSERT
    IF V_COUNT = 0 THEN
        INSERT INTO JOBS(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
        VALUES (P_JOB_ID, P_JOB_TITLE, P_JOB_MIN_SALARY, P_JOB_MAX_SALARY);
    ELSE   -- 있다면 UPDATE
        UPDATE JOBS 
        SET 
            JOB_TITLE = P_JOB_TITLE, 
            MIN_SALARY = P_JOB_MIN_SALARY, 
            MAX_SALARY = P_JOB_MAX_SALARY
        WHERE JOB_ID = P_JOB_ID;
    END IF;
    
    COMMIT;
END;

EXECUTE new_job_proc('JOBS2','TEST2...',2000,10000);
SELECT * FROM JOBS;


-- 실행문
EXECUTE NEW_JOB_PROC('JOBS2','TEST2...',5000, 200000);
EXECUTE NEW_JOB_PROC('JOBS2','TEST2...');  -- 에러

-- 수정후...
EXECUTE NEW_JOB_PROC('JOBS2','TEST2...');  -- 기본값이 지정되어 있으므로 에러가 뜨지 않음.


-- OUT 매개변수
-- 외부로의 출력을 위한 변수
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC02(
    P_JOB_ID IN JOBS.JOB_ID%TYPE,
    P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
    P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE,
    P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE,
    P_RESULT OUT VARCHAR2  -- 크기를 지정할수 없다. 선언만 함. 외부로의 출력을 위한 변수
)IS
    V_COUNT NUMBER := 0;
    V_RESULT VARCHAR2(100) := '값이 없어서 INSERT처리 되었습니다.'; -- OUT에게 실어 내보낼 변수
BEGIN
    -- 동일한 아이디가 있는지 체크
    SELECT COUNT(*)
    INTO V_COUNT
    FROM JOBS
    WHERE JOB_ID = P_JOB_ID;
    
    IF V_COUNT = 0 THEN
        INSERT INTO JOBS
        VALUES (P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY, P_MAX_SALARY);
    ELSE   -- 필요한 결과 추출
        SELECT P_JOB_ID || '의 최대 연봉 : '|| MAX_SALARY || ', 최소 연봉 : ' || MIN_SALARY
        INTO V_RESULT
        FROM JOBS
        WHERE JOB_ID = P_JOB_ID;
    END IF;
    
    P_RESULT := V_RESULT;  -- OUT 변수에 결과를 할당
END;

-- 실행
-- OUT변수를 사용하는 프로시저는 익명블록에서 실행을 합니다.
DECLARE
    STR VARCHAR2(100); -- 반드시 문자열은 크기를 지정해야함.
BEGIN
    NEW_JOB_PROC02('SM_JOB1','sample job1',2000,6000,STR);
    DBMS_OUTPUT.put_line(STR);
    NEW_JOB_PROC02('CEO','sample ceo',10000,90000,STR);
    DBMS_OUTPUT.put_line(STR);
END;




-- in out 처리 형태
CREATE OR REPLACE PROCEDURE testProc(
    p_var1 IN VARCHAR2,
    p_var2 OUT VARCHAR2,
    p_var3 IN OUT VARCHAR2
)IS
BEGIN
    -- in, out이 없다면 단순 사용만 가능
    DBMS_OUTPUT.PUT_LINE(p_var1);
    -- out 변수는 프로시저가 끝나기 전까지 값의 할당이 안됨.
    DBMS_OUTPUT.PUT_LINE(p_var2);
    -- in out 은 둘다 사용이 가능합니다.
    DBMS_OUTPUT.PUT_LINE(p_var3);
    
    -- p_var1 := '결과1';
    -- 에러 : Statement ignored / PLS-00363: 'P_VAR1' 식은 피할당자로 사용될 수 없습니다
    p_var2 := '결과2';
    p_var3 := '결과3';
END;

DECLARE
    var1 VARCHAR2(50) := 'A';
    var2 VARCHAR2(50) := 'B';
    var3 VARCHAR2(50) := 'C';
BEGIN
    testproc(var1,var2,var3);
    
    DBMS_OUTPUT.PUT_LINE(var1);
    DBMS_OUTPUT.PUT_LINE(var2);
    DBMS_OUTPUT.PUT_LINE(var3);
END;



-- 연습문제 
-- 1. employees 테이블에서 job_id만 in변수로 입력받아서, 해당 아이디가 있는지 확인하고,
-- 없다면, 단순히 프로시저 안에서 출력만 해줍니다.
-- 2. 있다면, 동일한 job_id를 가진 급여의 합계를 출력해주세요

CREATE OR REPLACE PROCEDURE emp_proc(
    p_job_id IN employees.job_id%TYPE
)
IS
    v_count NUMBER := 0;
    v_salary_sum employees.salary%type := 0;
BEGIN
    SELECT COUNT(*),SUM(salary)
    INTO v_count, v_salary_sum
    FROM employees
    WHERE job_id = p_job_id;
    
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_salary_sum);
    ELSE
        DBMS_OUTPUT.PUT_LINE('job_id: "'||P_JOB_ID||'" 가 없습니다');
    END IF;
END;

select * from EMPLOYEES;
EXECUTE emp_proc('AD_V');

SELECT COUNT(*)
FROM employees
WHERE job_id = 'AD_VP';
     
SELECT SUM(salary)
FROM employees
WHERE job_id = 'AD_VP';

-- return키워드
-- 프로시저의 종료
CREATE OR REPLACE PROCEDURE emp_proc(
    p_job_id IN employees.job_id%TYPE
)
IS
    v_count NUMBER := 0;
    v_salary_sum employees.salary%type := 0;
BEGIN
    SELECT COUNT(*),SUM(salary)
    INTO v_count, v_salary_sum
    FROM employees
    WHERE job_id like '%' || p_job_id || '%';   -- 입력한 값이 포함되어 있으면,
    
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_salary_sum);
        return; -- 프로시저의 종료 // 반환이 아님.
    ELSE
        DBMS_OUTPUT.PUT_LINE('job_id: "'||P_JOB_ID||'" 가 없습니다');
    END IF;
END;


-- 예외처리
-- EXCEPTION WHEN OTHERS THEN
DECLARE
    v_num number := 0;
begin
    v_num := 10/0;
    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없습니다.');
end;    
-- 결과 : 0으로 나눌 수 없습니다.


-- 프로시저 삭제
drop procedure new_job_proc;
drop PROCEDURE new_job_proc02;

