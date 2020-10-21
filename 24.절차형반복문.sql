-- 반복문

-- while문
-- 구구단 출력
DECLARE
    v_dan NUMBER := 3;  -- 3단
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 9
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_dan || ' x ' || v_count || ' = ' || v_dan*v_count);
        v_count := v_count + 1;  -- 1증가
    END LOOP;
END;

-- 탈출문
-- exit when 조건
DECLARE 
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 10
    LOOP
        dbms_output.put_line(v_count);
        
        EXIT WHEN v_count = 5;   -- v_count가 5이면 탈출
        
        v_count := v_count +1;
    END LOOP;
END;


-- for문

DECLARE
    v_dan NUMBER := 3;
BEGIN
    FOR I IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_dan || ' x ' || I || ' = ' ||v_dan*I);
    END LOOP;
END;

-- continue문
DECLARE
BEGIN
    FOR I IN 1..9
    LOOP
        CONTINUE WHEN I = 5;  -- I가 5일때 PASS
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;


-- 모든 구구단 출력
DECLARE
BEGIN
    FOR I IN 2..9
    LOOP
        FOR J IN 1..9
        LOOP
            DBMS_OUTPUT.PUT_LINE(I || ' X ' || J || ' = ' || I*J);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(CHR(10));  -- 개행
    END LOOP;
END;