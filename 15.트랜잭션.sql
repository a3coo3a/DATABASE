-- Ʈ�����
-- : ������ �۾����� ������ ������ ���̽��� ������ġ

-- Ʈ����� ������ Ȯ��
show autocommit;  
-- ��� > autocommit OFF

-- �ڵ� Ŀ�ԵǴ� ���·� ����
set autocommit on;
-- ��� > autocommit IMMEDIATE

-- �ڵ� Ŀ�� ����
set autocommit off;
-- ���� ������� ������ �ʰ� show�� ���� �����¸� Ȯ���� ���ƾ� ��.

-- savepoint���� �� �ѹ�
select * from depts;

delete from depts where department_id = 10;
-- savepoint ���� : savepoint ����Ʈ��(����)
savepoint delete_10;   

delete from depts where department_id = 20;
savepoint delete_20;

delete from depts; -- ��ü ������
select * from depts;  -- �ڷᰡ �ϳ��� �ȳ��Ե�.

rollback;  -- ����Ŀ�� ���ı��� �ǵ���
select * from depts; 

-- ���� �ѹ�
-- ���� Ŀ�� ���ķ� ���ư��� savepoint�� ���� ���¶� �ٽ� �ѹ� ����
delete from depts where department_id = 10;
savepoint delete_10;   

delete from depts where department_id = 20;
savepoint delete_20;

delete from depts;
rollback to delete_20;

select * from depts;

rollback to delete_10;
select * from depts;

commit; -- Ŀ�� ���Ŀ��� � ������ε� �ǵ��� �� ����