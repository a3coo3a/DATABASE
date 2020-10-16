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
-- ���������� �߰�, ������ ���� -> �����̶�� ���� ����

drop table dept2;
create table dept2(
    dept_no number(2),
    dept_name VARCHAR2(14),
    loca number(4),
    dept_date date default sysdate,
    dept_bonus number(10),
    dept_gender char(1)
);
-- pk �߰�
alter table dept2 
add CONSTRAINT dept_no_pk PRIMARY KEY (dept_no);
-- fk �߰�
alter table dept2
add CONSTRAINT dept_loca_fk FOREIGN key (loca) REFERENCES locations(location_id);
-- check �߰�
alter table dept2 
add CONSTRAINT dept_gender_check CHECK(dept_gender in ('Y','N'));
-- unique �߰�
alter table dept2
add CONSTRAINT dept_name_uk unique (dept_name);
-- not null�� ������ ���·� ����
alter table dept2
MODIFY dept_name VARCHAR2(14) not null;


-- ���������� ����
-- ���������� �̸����� ����
alter table dept2
drop CONSTRAINT dept_no_pk;    --> pk����

-- fk�� �θ����̺��� ���� ���ٸ� ���� �Ұ���
select * from locations;
select * from dept2;
insert into dept2 values(10,'test',100,sysdate,5000,'Y');
-- ��� : ORA-02291: ���Ἲ ��������(HR.DEPT_LOCA_FK)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
-- > locations�� location_id�� 100�� ���� ���̶� ���� ����

-- �������� --------------------------------------------------------------------
--���� 1.
--������ ���� ���̺��� �����ϰ� �����͸� insert�ϼ��� (Ŀ��)
--M_NAME M_NUM REG_DATE     GENDER  LOCA
--AAA    1      2018-07-01  M       1800
--BBB    2      2018-07-02  F       1900
--CCC    3      2018-07-03  M       2000
--DDD    4      ���ó�¥     M       2000
--����) M_NAME �� ����������, �ΰ��� ������� ����
--����) M_NUM �� ������, �̸�(mem_memnum_pk) primary key
--����) REG_DATE �� ��¥��, �ΰ��� ������� ����, �̸�:(mem_regdate_uk) UNIQUEŰ
--����) GENDER ����������
--����) LOCA ������, �̸�:(mem_loca_loc_locid_fk) foreign key ? ���� locations���̺�(location_id)
CREATE table members(
    m_name VARCHAR2(4) not null,
    m_num NUMBER(2) CONSTRAINT mem_memnum_pk PRIMARY key,
    reg_date DATE DEFAULT sysdate not null CONSTRAINT mem_regdate_uk unique,
    gender VARCHAR2(1),
    loca NUMBER(4) CONSTRAINT mem_loca_loc_locid_fk REFERENCES locations(location_id)
);
select * from members;
insert into members 
VALUES('AAA', 1, '2018-07-01', 'M', 1800);
insert into members 
VALUES('BBB', 2, '2018-07-02', 'F', 1900);
insert into members 
VALUES('CCC', 3, '2018-07-03', 'M', 2000);
insert into members(m_name, m_num, gender, loca) 
VALUES('DDD', 4, 'M', 2000);
commit;

alter table members
add CONSTRAINT gender_check CHECK(gender in('F','M'));
commit;
--���� 2.
--MEMBERS���̺�� LOCATIONS���̺��� INNER JOIN �ϰ� 
--m_name, m_mum, street_address, location_id �÷��� ��ȸ
--m_num�������� �������� ��ȸ

select
    m_name, 
    m_num, 
    street_address, 
    l.location_id
from members m
join locations l
on m.loca = l.location_id
order by m_num ASC;
