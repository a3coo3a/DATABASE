-- user01 
create table test01(
    id VARCHAR2(20),
    name varchar2(20)
);

INSERT into test01 values('1', 'test');
--��� : ORA-01950: ���̺����̽� 'USERS'�� ���� ������ �����ϴ�.

-- ���� -> ������ ���� ����
-- ���̺��� ��°�� �����ϴ°��� �ƴ϶� ������ ������ �� �����ϴµ� >> ����� ���̺����̽� ��, ���� �������
-- C:\app\user\product\18.0.0\oradata\XE\XEPDB1 �� .dbf��� ���Ϸ� �����.

-- ���̺����̽����� ���� �� 
INSERT into test01 values('1', 'test');
-- ��� : 1 �� ��(��) ���ԵǾ����ϴ�.
-- Ȯ��
select * from test01;

drop table test01;