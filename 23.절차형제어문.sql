-- 랜덤수 뽑기
-- round : 반올림 / ceil : 올림 /  floor : 내림
set SERVEROUTPUT ON;
declare
    -- 0~10미만의 랜덤 실수
    -- round : 반올림하여 정수부분만
    v_num number := round( DBMS_RANDOM.value(0,10) );
begin
    DBMS_OUTPUT.PUT_LINE(V_NUM);
end;


-- if문
DECLARE
    v_num1 NUMBER := 1;
    v_num2 NUMBER := 2;
BEGIN
    IF v_num1 > v_num2 THEN  -- if문 시작
        DBMS_OUTPUT.PUT_LINE(v_num1 || '이 큰 수');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_num2 || '이 큰 수');
    END IF;   -- if문 끝
END;

-- els if문
-- employees에서 salary값을 구함
DECLARE
    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
BEGIN
    -- 선언된 변수 값 변경 가능
    V_DEPARTMENT_ID := round(dbms_random.VALUE(10,110), -1);  -- 소수점 기준으로 양수는 소수점 자리수 음수는 정수자리수
    DBMS_OUTPUT.put_line('v_department_id : '||V_DEPARTMENT_ID);
    
    -- 사원테이블에서 랜덤한 department_id를 뽑아서 salary를 조회
    SELECT salary
    INTO v_salary
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = V_DEPARTMENT_ID AND ROWNUM = 1; -- 첫번째 행만 조회
    
    DBMS_OUTPUT.put_line('v_salary'||V_SALARY);
    
    IF V_SALARY <= 5000 THEN
        DBMS_OUTPUT.put_line('낮음');
    ELSIF v_salary <= 9000 THEN
        DBMS_OUTPUT.put_line('중간');
    ELSE 
        DBMS_OUTPUT.put_line('높음');
    END IF;
END;

select salary
    from EMPLOYEES
    where DEPARTMENT_ID = 100 and rownum = 1;
    
    
    
-- case구문
DECLARE
    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
BEGIN
    V_DEPARTMENT_ID := round(dbms_random.VALUE(10,110), -1);  
    DBMS_OUTPUT.put_line('v_department_id : '||V_DEPARTMENT_ID);
    
    SELECT salary
    INTO v_salary
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = V_DEPARTMENT_ID AND ROWNUM = 1; 
    
    DBMS_OUTPUT.put_line('v_salary : '||V_SALARY);
    
    CASE when V_SALARY <= 5000 then
            DBMS_OUTPUT.put_line('낮음');
        when v_salary <= 9000 then
            DBMS_OUTPUT.put_line('중간');
        else  -- default문
            DBMS_OUTPUT.put_line('높음');
    end case;
END;