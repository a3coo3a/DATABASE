/*
����Ŭ�� �ְ� ������ �������� ������ ��ŵ�ϴ�.
PDB�� ����
*/

-- ���� �������
CREATE USER user01 IDENTIFIED BY user01;
--��� : User USER01��(��) �����Ǿ����ϴ�.

-- ������ ������ ���� �ο�
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW to user01;
-- ��� : Grant��(��) �����߽��ϴ�.

-- ���̺����̽�
-- �����Ͱ� ���������� ����Ǵ� ����
-- ������ ������ ���� �Ǿ�� insert ���� ����� �� �ִ�.

-- ���̺����̽� Ȯ��
-- ���� -> DBA -> +���� ���� ���� -> ���念�� -> ���̺����̽� ���� 
-- ������� �ִ� ���̺����̽��� ����ص� �ǰ� ���� ����ص� ��.
-- ������ ���Ϸ� �� ���� ����Ǿ� �ִ� ���� ������ Ȯ�� ����

-- ������ ������� �ִ�(on) users���̺� ����������� �� �ְ� ������ �ִ� ��
ALTER USER user01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS; 
-- ��� : User USER01��(��) ����Ǿ����ϴ�.
-- ���Ŀ� insert �����Ѱ� Ȯ���� �� �ִ�.

-- ���̺� �����̽��� ���� ����� ���
ALTER USER user01 DEFAULT TABLESPACE my_data QUOTA UNLIMITED ON my_data;
--��� ; User USER01��(��) ����Ǿ����ϴ�.


-- ���� �̿��� ���� ������ ���� �ο�
CREATE USER user02 IDENTIFIED BY user02;
GRANT CONNECT, RESOURCE TO user02;
ALTER USER user02 DEFAULT TABLESPACE my_data QUOTA UNLIMITED ON my_data;

drop user "user02";


