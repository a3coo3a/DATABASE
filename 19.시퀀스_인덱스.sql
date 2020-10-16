-- ������
SELECT * FROM user_sequences;
SELECT * FROM user_views;
SELECT * FROM user_constraints;

-- ������ ����
CREATE SEQUENCE dept_seq;
DROP SEQUENCE dept_seq;
-- �ɼ��־� ����
-- ��ǥ ���� ��~~ �̾ �ۼ�
CREATE SEQUENCE dept3_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 10
    NOCYCLE
    NOCACHE;

-- ������ ����
DROP SEQUENCE dept_seq;

-- ������ �����
-- ���̺� ����
CREATE TABLE dept3(
    dept_no NUMBER(3) PRIMARY KEY,
    dept_name VARCHAR2(14),
    dept_date DATE DEFAULT sysdate
);
DESC dept3;

-- ������ ��ȣ ����
INSERT INTO dept3(dept_no, dept_name) VALUES(dept3_seq.NEXTVAL, 'test');  --> 3������
SELECT * FROM dept3;
INSERT INTO dept3(dept_no, dept_name) VALUES(dept3_seq.NEXTVAL, 'test');  --> �ִ�ġ(10��)���� �����
-- ��� : ORA-08004: ������ DEPT3_SEQ.NEXTVAL exceeds MAXVALUE�� ��ʷ� �� �� �����ϴ�
-- ���� ������ �� Ȯ��
SELECT dept3_seq.CURRVAL FROM dual;

-- �������� ����
-- alter sequence dept3_seq �ɼ�
-- �ְ� ����
ALTER SEQUENCE dept3_seq MAXVALUE 9999;
-- ������ ����
ALTER SEQUENCE dept3_seq INCREMENT BY 10;
-- �ּҰ� ����
ALTER SEQUENCE dept3_seq MINVALUE 1;

-- Ȯ��
SELECT dept3_seq.CURRVAL FROM dual;  -- 10
SELECT dept3_seq.NEXTVAL FROM dual;  -- 20
-- �ѹ� ����ϰ� ���� �ǵ��� �� ����
SELECT dept3_seq.CURRVAL FROM dual;
ROLLBACK; -- �ѹ��� �ص� 20�ΰ� �� �� �ִ�.

-- �������� ���� �ٽ� ó������ ������ ���
-- 1. ���� ������ Ȯ��
-- 2. ������ ����(-���������)  
-- 3. nextval ���� : ó�� ������ ������ �ž�
-- 4. ������ 1�� ����
-- 5. ���� 
-- ������ ����
SELECT dept3_seq.CURRVAL FROM dual;  --20
ALTER SEQUENCE dept3_seq INCREMENT BY -19;
SELECT dept3_seq.NEXTVAL FROM dual;   --1
ALTER SEQUENCE dept3_seq INCREMENT BY 1;
SELECT dept3_seq.CURRVAL FROM dual;

SELECT * FROM dept3;

-- ������ Ȱ��
DROP SEQUENCE dept3_seq;
DROP TABLE dept3;

/*
1. dept3_seq����
2. pk�� varchar2�� ����
3. insert�ÿ� to_char(��¥) || - || tlznjstm rkqt 
*/

CREATE TABLE dept3(
    dept_no VARCHAR2(30) PRIMARY KEY,
    dept_name VARCHAR2(30)
);
SELECT * FROM dept3;
CREATE SEQUENCE dept3_seq
    INCREMENT BY 1
    START WITH 1
    NOCACHE;

INSERT INTO dept3 
VALUES(to_char(sysdate,'YYYYMMDD')||'-'||dept3_seq.NEXTVAL,'test');  -- 3������
SELECT * FROM dept3;

-- index
-- index�� primary key, unique �������ǿ��� �ڵ����� �����ǰ�, ��ȸ�� ������ ���ִ� hint����
SELECT * FROM user_indexes;
select * from emps;

SELECT * FROM emps WHERE first_name = 'Lex';

-- �ε��� ���� �߰�
CREATE INDEX emps_first_name_ix ON  emps(first_name);

-- �ε��� ����
DROP INDEX emps_first_name_ix;