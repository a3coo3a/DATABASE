-- ���̺� ���� : create
create table dept2(
    dept_no number(2, 0),    -- ���ڸ� ���ڸ� �����ϴµ� �Ǽ��� �������� �ʴ� ����Ÿ��    
    dept_name VARCHAR2(14),  -- byte��� ���� ���ڿ�
    loca VARCHAR2(13),
    dept_date date,
    depf_bouns number(10)
);

insert into dept2 values(99,'����','����',sysdate, 2000000000);

select * from dept2;

-- ���̺� ���� : alter
-- �÷��� ���� ��ɾ� : add, modify, rename column, drop
-- add : �÷� �߰�
alter table dept2
add dept_count number(3);

desc dept2;

-- modify : ����
alter table dept2
modify dept_count number(10);

desc dept2;

-- rename column : �÷� �̸� ����
alter table dept2
rename column dept_count to emp_count;

desc dept2;

-- drop  : �÷� ����
alter table dept2
drop column emp_count;

desc dept2;


-- ���̺� ����
drop table dept2;
-- ���������� �ִ� ���̺� ����
-- �ش� ���̺� �ɷ��ִ� FK(������������)�� �����
-- drop table dept2 cascade constraints(�������Ǹ�)

-- ���̺� ��ü ����
truncate table dept2;