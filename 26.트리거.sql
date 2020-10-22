-- Ʈ���� (Trigger)

-- ���̺� �������� ���� ���ν���
-- ���̺��� �����Ҷ� ���ÿ� �����ϴ�  ex) ���̺� �μ�Ʈ�� ������ �ٸ����̺� ������Ʈ�� �����Ѵ�.

-- trigger�� ���̺� ������ ���·ν�, insert, update, delete �۾��� ����ɶ�, Ư�� �ڵ尡 ���۵ǵ��� �ϴ� ����

CREATE TABLE tbl_test(
    id NUMBER(10),
    text VARCHAR2(50)
);

CREATE OR REPLACE TRIGGER trg_test
    AFTER DELETE OR UPDATE  -- delete�� update ���Ŀ�
    ON tbl_test         -- ������ ���̺�
    FOR EACH ROW        -- ���࿡ �����Ѵٴ� ������ ������ ����
BEGIN               -- ����� ���� �ۼ�
    DBMS_OUTPUT.PUT_LINE('Ʈ���� ����');
END;

-- ��� : Trigger TRG_TEST��(��) �����ϵǾ����ϴ�.

-- Ȯ��
INSERT INTO tbl_test VALUES(10,'ȫ�浿');  -- Ʈ���Ž��� x
INSERT INTO tbl_test VALUES(20,'ȫ����');  -- Ʈ���Ž��� x
/*���
1 �� ��(��) ���ԵǾ����ϴ�.
*/
UPDATE tbl_test SET text = '�̼���' WHERE ID = 20;   -- Ʈ���� ���� o
/* ��� 
Ʈ���� ����


1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
*/
delete from tbl_test where id = 20;   -- Ʈ���� ���� o
/*���
Ʈ���� ����


1 �� ��(��) �����Ǿ����ϴ�.
*/



-- after Ʈ����  : insert, update, delete �۾� ���Ŀ� �����ϴ� Ʈ����
-- before Ʈ���� : insert, update, delete �۾� ������ �����ϴ� Ʈ����
-- instead of Ʈ���� : insert, update, delete �۾� ������ view���� �����Ǽ� ����Ǵ� Ʈ����

-- ���� ���, ȸ���� ���̺� update, delete �۾��� ����Ǹ� �̷��� ���ܵд�.
CREATE TABLE tbl_user(
    id VARCHAR2(50) PRIMARY KEY,
    name VARCHAR2(50),
    address VARCHAR2(50)
);
CREATE TABLE tbl_user_backup(
    id VARCHAR2(50),   -- FK����
    name VARCHAR2(50),
    address VARCHAR2(50),
    update_date DATE DEFAULT sysdate,
    m_type CHAR(1),   -- ����� Ÿ��
    m_user VARCHAR2(50) -- ������ �����
);

-- after Ʈ����
CREATE OR REPLACE TRIGGER trg_user_backup
    AFTER UPDATE OR DELETE
    ON tbl_user
    FOR EACH ROW
DECLARE  -- ����� ������ �ִٸ� �͸��� Ȱ��
    v_type CHAR(1);
BEGIN
    -- update�� u, delete�� d�� ������ �Է�
    IF updating THEN   -- update�Ǿ��ٴ� �ý��� ����
        v_type := 'U';
    ELSIF deleting then  -- delete�Ǿ��ٴ� �ý��� ����
        v_type := 'D';
    END IF;
    
    -- :old  update,delete�� ����Ǳ� ���� �����ִ� ������
    -- :new  update,delete�� ����� �� ������ , ���� �����Ͷ����.
    -- user() : ���� ���ӵ� ������ ��Ÿ���� �ý��� �Լ�
    INSERT INTO tbl_user_backup 
    VALUES(:OLD.id, :OLD.name, :OLD.address, sysdate, v_type, USER());
END;

-- Ȯ��
INSERT INTO tbl_user 
VALUES('test01', 'ȫ�浿', '����');
INSERT INTO tbl_user 
VALUES('test02', 'ȫ����', '�λ�');
INSERT INTO tbl_user 
VALUES('test03', '�̼���', '���');

SELECT * FROM tbl_user;
SELECT * FROM tbl_user_backup;
-- ���� ������̺��� ��� ����

UPDATE tbl_user SET address = '����' WHERE ID = 'test01';

SELECT * FROM tbl_user;
SELECT * FROM tbl_user_backup;

DELETE FROM tbl_user WHERE ID = 'test01';
SELECT * FROM tbl_user_backup;


-- before Ʈ����
-- ���̺� DML���� ������
-- insert�Ǳ� ���� �����͸� ����
-- �ֹι�ȣ�� �Է��ϴµ� �ڷᰡ ���� ���� ������
CREATE OR REPLACE TRIGGER trg_user_insert
    BEFORE INSERT
    ON tbl_user
    FOR EACH ROW
DECLARE
    
BEGIN
    -- :new.�÷� ->  insert���������� ���޵Ǵ� ������
    :NEW.name := substr(:NEW.NAME,1,1) || '**';  -- ���� �����ͼ� ������ ����
END;

select * from tbl_user;

INSERT INTO tbl_user VALUES('test04','�̹��','�λ�');
INSERT INTO tbl_user VALUES('test05','�̼���','���');
SELECT * FROM tbl_user;

----------------------------------------Ʈ���� Ȱ�� ------------------------------------------
-- �ֹ��� ���̺� insert(�ֹ��� after trigger) -> ��ǰ ���̺��� update ��Ŵ : ���� ����

-- �ֹ��� ���̺�
CREATE SEQUENCE order_history_seq NOCACHE;  -- �ֹ��� ������
CREATE TABLE order_history(
    history_no NUMBER(5) PRIMARY KEY,
    order_no NUMBER(5), -- �ֹ��̷¿� ���� fk����
    product_no NUMBER(5), --��ǰ�� ���� fk����
    total NUMBER(10),   -- ����
    price NUMBER(10)    -- ����
);

-- ��ǰ ���̺�
CREATE SEQUENCE product_seq NOCACHE;
CREATE TABLE product (
    product_no NUMBER(5) PRIMARY KEY,
    product_name VARCHAR2(30),
    total NUMBER(10),
    price NUMBER(10)
);

INSERT INTO product VALUES (product_seq.NEXTVAL,'����',100,10000);
INSERT INTO product VALUES (product_seq.NEXTVAL,'ġŲ',100,15000);
INSERT INTO product VALUES (product_seq.NEXTVAL,'�ܹ���',100,5000);
SELECT * FROM product;

-- �ֹ��󼼿� insert�� ������ ���� trigger
CREATE OR REPLACE TRIGGER trg_order_history_insert
    AFTER INSERT
    ON order_history
    FOR EACH ROW
DECLARE
    v_total NUMBER;  -- ����
    v_product_no NUMBER;  -- ��ǰ��ȣ
BEGIN
    SELECT :NEW.product_no, :NEW.total
    INTO v_product_no, v_total
    FROM dual; -- �������̺���
    
    -- ��ǰ���� ������Ʈ ����
    UPDATE product SET total = total - v_total   -- (���� ��ǰ ���� - ������ ����)�� ���� �������� ����
    WHERE product_no = v_product_no;
    
END;

-- Ȯ��
INSERT INTO ORDER_HISTORY
VALUES(ORDER_HISTORY_SEQ.NEXTVAL, 50000,1,10,10000);  -- ���� 19�� �ֹ�
INSERT INTO ORDER_HISTORY
VALUES(ORDER_HISTORY_SEQ.NEXTVAL, 50000,2,5,15000);  -- ġŲ 5�� �ֹ�
INSERT INTO ORDER_HISTORY
VALUES(ORDER_HISTORY_SEQ.NEXTVAL, 50000,3,1,5000); -- �ܹ��� 1���ֹ�
SELECT * FROM product;