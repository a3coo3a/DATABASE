-- ������ �̱�
-- round : �ݿø� / ceil : �ø� /  floor : ����
set SERVEROUTPUT ON;
declare
    -- 0~10�̸��� ���� �Ǽ�
    -- round : �ݿø��Ͽ� �����κи�
    v_num number := round( DBMS_RANDOM.value(0,10) );
begin
    DBMS_OUTPUT.PUT_LINE(V_NUM);
end;


-- if��
DECLARE
    v_num1 NUMBER := 1;
    v_num2 NUMBER := 2;
BEGIN
    IF v_num1 > v_num2 THEN  -- if�� ����
        DBMS_OUTPUT.PUT_LINE(v_num1 || '�� ū ��');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_num2 || '�� ū ��');
    END IF;   -- if�� ��
END;

-- els if��
-- employees���� salary���� ����
DECLARE
    v_salary NUMBER := 0;
    v_department_id NUMBER := 0;
BEGIN
    -- ����� ���� �� ���� ����
    V_DEPARTMENT_ID := round(dbms_random.VALUE(10,110), -1);  -- �Ҽ��� �������� ����� �Ҽ��� �ڸ��� ������ �����ڸ���
    DBMS_OUTPUT.put_line('v_department_id : '||V_DEPARTMENT_ID);
    
    -- ������̺��� ������ department_id�� �̾Ƽ� salary�� ��ȸ
    SELECT salary
    INTO v_salary
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = V_DEPARTMENT_ID AND ROWNUM = 1; -- ù��° �ุ ��ȸ
    
    DBMS_OUTPUT.put_line('v_salary'||V_SALARY);
    
    IF V_SALARY <= 5000 THEN
        DBMS_OUTPUT.put_line('����');
    ELSIF v_salary <= 9000 THEN
        DBMS_OUTPUT.put_line('�߰�');
    ELSE 
        DBMS_OUTPUT.put_line('����');
    END IF;
END;

select salary
    from EMPLOYEES
    where DEPARTMENT_ID = 100 and rownum = 1;
    
    
    
-- case����
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
            DBMS_OUTPUT.put_line('����');
        when v_salary <= 9000 then
            DBMS_OUTPUT.put_line('�߰�');
        else  -- default��
            DBMS_OUTPUT.put_line('����');
    end case;
END;