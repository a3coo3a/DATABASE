-- �ݺ���

-- while��
-- ������ ���
DECLARE
    v_dan NUMBER := 3;  -- 3��
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 9
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_dan || ' x ' || v_count || ' = ' || v_dan*v_count);
        v_count := v_count + 1;  -- 1����
    END LOOP;
END;

-- Ż�⹮
-- exit when ����
DECLARE 
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 10
    LOOP
        dbms_output.put_line(v_count);
        
        EXIT WHEN v_count = 5;   -- v_count�� 5�̸� Ż��
        
        v_count := v_count +1;
    END LOOP;
END;


-- for��

DECLARE
    v_dan NUMBER := 3;
BEGIN
    FOR I IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_dan || ' x ' || I || ' = ' ||v_dan*I);
    END LOOP;
END;

-- continue��
DECLARE
BEGIN
    FOR I IN 1..9
    LOOP
        CONTINUE WHEN I = 5;  -- I�� 5�϶� PASS
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;


-- ��� ������ ���
DECLARE
BEGIN
    FOR I IN 2..9
    LOOP
        FOR J IN 1..9
        LOOP
            DBMS_OUTPUT.PUT_LINE(I || ' X ' || J || ' = ' || I*J);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(CHR(10));  -- ����
    END LOOP;
END;