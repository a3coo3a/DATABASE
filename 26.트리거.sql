-- 트리거 (Trigger)

-- 테이블에 부착시켜 놓은 프로시저
-- 테이블이 동작할때 동시에 동작하는  ex) 테이블에 인서트가 들어오면 다른테이블에 업데이트가 들어가야한다.

-- trigger는 테이블에 부착된 형태로써, insert, update, delete 작업이 수행될때, 특정 코드가 동작되도록 하는 구문

CREATE TABLE tbl_test(
    id NUMBER(10),
    text VARCHAR2(50)
);

CREATE OR REPLACE TRIGGER trg_test
    AFTER DELETE OR UPDATE  -- delete나 update 이후에
    ON tbl_test         -- 부착할 테이블
    FOR EACH ROW        -- 각행에 적용한다는 뜻으로 무조건 부착
BEGIN               -- 실행될 내용 작성
    DBMS_OUTPUT.PUT_LINE('트리거 실행');
END;

-- 결과 : Trigger TRG_TEST이(가) 컴파일되었습니다.

-- 확인
INSERT INTO tbl_test VALUES(10,'홍길동');  -- 트리거실행 x
INSERT INTO tbl_test VALUES(20,'홍길자');  -- 트리거실행 x
/*결과
1 행 이(가) 삽입되었습니다.
*/
UPDATE tbl_test SET text = '이순신' WHERE ID = 20;   -- 트리거 실행 o
/* 결과 
트리거 실행


1 행 이(가) 업데이트되었습니다.
*/
delete from tbl_test where id = 20;   -- 트리거 실행 o
/*결과
트리거 실행


1 행 이(가) 삭제되었습니다.
*/



-- after 트리거  : insert, update, delete 작업 이후에 동작하는 트리거
-- before 트리거 : insert, update, delete 작업 이전에 동작하는 트리거
-- instead of 트리거 : insert, update, delete 작업 이전에 view에만 부착되서 실행되는 트리거

-- 예를 들어, 회원에 테이블 update, delete 작업에 수행되면 이력을 남겨둔다.
CREATE TABLE tbl_user(
    id VARCHAR2(50) PRIMARY KEY,
    name VARCHAR2(50),
    address VARCHAR2(50)
);
CREATE TABLE tbl_user_backup(
    id VARCHAR2(50),   -- FK역할
    name VARCHAR2(50),
    address VARCHAR2(50),
    update_date DATE DEFAULT sysdate,
    m_type CHAR(1),   -- 변경된 타입
    m_user VARCHAR2(50) -- 변경한 사용자
);

-- after 트리거
CREATE OR REPLACE TRIGGER trg_user_backup
    AFTER UPDATE OR DELETE
    ON tbl_user
    FOR EACH ROW
DECLARE  -- 사용할 변수가 있다면 익명블록 활용
    v_type CHAR(1);
BEGIN
    -- update면 u, delete면 d를 변수에 입력
    IF updating THEN   -- update되었다는 시스템 변수
        v_type := 'U';
    ELSIF deleting then  -- delete되었다는 시스템 변수
        v_type := 'D';
    END IF;
    
    -- :old  update,delete가 수행되기 전에 남아있는 데이터
    -- :new  update,delete가 수행된 후 데이터 , 복사 데이터라고도함.
    -- user() : 현재 접속된 유저를 나타내는 시스템 함수
    INSERT INTO tbl_user_backup 
    VALUES(:OLD.id, :OLD.name, :OLD.address, sysdate, v_type, USER());
END;

-- 확인
INSERT INTO tbl_user 
VALUES('test01', '홍길동', '서울');
INSERT INTO tbl_user 
VALUES('test02', '홍길자', '부산');
INSERT INTO tbl_user 
VALUES('test03', '이순신', '경기');

SELECT * FROM tbl_user;
SELECT * FROM tbl_user_backup;
-- 현재 백업테이블은 비어 있음

UPDATE tbl_user SET address = '제주' WHERE ID = 'test01';

SELECT * FROM tbl_user;
SELECT * FROM tbl_user_backup;

DELETE FROM tbl_user WHERE ID = 'test01';
SELECT * FROM tbl_user_backup;


-- before 트리거
-- 테이블에 DML구문 실행전
-- insert되기 전에 데이터를 변경
-- 주민번호를 입력하는데 자료가 들어가기 전에 가려라
CREATE OR REPLACE TRIGGER trg_user_insert
    BEFORE INSERT
    ON tbl_user
    FOR EACH ROW
DECLARE
    
BEGIN
    -- :new.컬럼 ->  insert구문에서는 전달되는 데이터
    :NEW.name := substr(:NEW.NAME,1,1) || '**';  -- 성만 가져와서 데이터 변경
END;

select * from tbl_user;

INSERT INTO tbl_user VALUES('test04','이방원','부산');
INSERT INTO tbl_user VALUES('test05','이성계','경기');
SELECT * FROM tbl_user;

----------------------------------------트리거 활용 ------------------------------------------
-- 주문상세 테이블에 insert(주문상세 after trigger) -> 상품 테이블을 update 시킴 : 수량 변동

-- 주문상세 테이블
CREATE SEQUENCE order_history_seq NOCACHE;  -- 주문상세 시퀀스
CREATE TABLE order_history(
    history_no NUMBER(5) PRIMARY KEY,
    order_no NUMBER(5), -- 주문이력에 대한 fk역할
    product_no NUMBER(5), --물품에 대한 fk역할
    total NUMBER(10),   -- 수량
    price NUMBER(10)    -- 가격
);

-- 상품 테이블
CREATE SEQUENCE product_seq NOCACHE;
CREATE TABLE product (
    product_no NUMBER(5) PRIMARY KEY,
    product_name VARCHAR2(30),
    total NUMBER(10),
    price NUMBER(10)
);

INSERT INTO product VALUES (product_seq.NEXTVAL,'피자',100,10000);
INSERT INTO product VALUES (product_seq.NEXTVAL,'치킨',100,15000);
INSERT INTO product VALUES (product_seq.NEXTVAL,'햄버거',100,5000);
SELECT * FROM product;

-- 주문상세에 insert가 들어오면 실행 trigger
CREATE OR REPLACE TRIGGER trg_order_history_insert
    AFTER INSERT
    ON order_history
    FOR EACH ROW
DECLARE
    v_total NUMBER;  -- 개수
    v_product_no NUMBER;  -- 상품번호
BEGIN
    SELECT :NEW.product_no, :NEW.total
    INTO v_product_no, v_total
    FROM dual; -- 가상테이블에서
    
    -- 상품에서 업데이트 진행
    UPDATE product SET total = total - v_total   -- (현재 상품 수량 - 들어오는 수량)을 현재 수량으로 변경
    WHERE product_no = v_product_no;
    
END;

-- 확인
INSERT INTO ORDER_HISTORY
VALUES(ORDER_HISTORY_SEQ.NEXTVAL, 50000,1,10,10000);  -- 피자 19개 주문
INSERT INTO ORDER_HISTORY
VALUES(ORDER_HISTORY_SEQ.NEXTVAL, 50000,2,5,15000);  -- 치킨 5개 주문
INSERT INTO ORDER_HISTORY
VALUES(ORDER_HISTORY_SEQ.NEXTVAL, 50000,3,1,5000); -- 햄버거 1개주문
SELECT * FROM product;