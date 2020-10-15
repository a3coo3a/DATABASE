-- ���� ����
-- PK : not null + unique key
-- check : ������ó�� �̰��� ���ǿ� �¾ƾ߸� ���̺� �� �� �־� ��� �ϴ� ��.


-- 1. ������ 
-- ���̺� �����ÿ� ���������� �ɾ��ִ� ��.
-- ���������̸��� ��������
-- not null �� �׳� not null�� �����.
-- constraint ���������̸� ��������  -> �������� �Ŵ� ����
-- check(����) ���� �������ǿ� ����
-- fk �������� ����: REFERENCES ���������̺��(�������÷���(����pk))
--   ������ �������̺��� Ÿ�԰� �����ؾ� ���𰡴�
-- UNIQUE :�ߺ��� ������� �ʴ�

CREATE TABLE DEPT2(
    DEPT_NO NUMBER(2) PRIMARY KEY,
    DEPT_NAME VARCHAR2(14) NOT NULL UNIQUE,    --> NOT NULL �̸鼭 UNIQUE Ű�� ��� �ΰ��� ������ �ذ�
    LOCA NUMBER(4) REFERENCES LOCATIONS(LOCATION_ID),
    DEPT_DATE DATE DEFAULT SYSDATE,    --> �ƹ��͵� �������� ������ �⺻������ �����Ǵ� ���� ����(�ƹ��͵� ������ ����ð����� �����Ѱ���)
    DEPT_BONUS NUMBER(10),
    DEPT_GENDER CHAR(1) CHECK (DEPT_GENDER IN('F', 'M'))
);

DESC DEPT2;
drop table dept2;
-- 2. ���̺���
-- �ϴ� �÷� ����� ���� �Ʒ��ʿ� �������ִ°�
-- ��, Ǯ������ �����ؾ���.
-- ��� ���� ������ �� �Ʒ��ʿ� �������� �߰�
-- not null, default�� �ȵ�.
create table dept2(
    dept_no number(2),
    dept_name VARCHAR2(14) not null,
    loca number(4),
    dept_date date default sysdate,
    dept_bonus number(10),
    dept_gender char(1),
    constraint dept_no_pk PRIMARY KEY (dept_no),
    constraint dept_name_uk unique(dept_name),
    constraint dept_gender_ck check(dept_gender in ('F','M')),
    constraint dept_loca_fk foreign key (loca) REFERENCES locations(location_id)
);


-- 3. alter 
-- �ϴ� �� ����� ���� alter�� ������ �ִ°�