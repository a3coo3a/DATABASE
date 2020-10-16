-- 시퀀스
SELECT * FROM user_sequences;
SELECT * FROM user_views;
SELECT * FROM user_constraints;

-- 시퀀스 생성
CREATE SEQUENCE dept_seq;
DROP SEQUENCE dept_seq;
-- 옵션주어 생성
-- 쉼표 없이 쭉~~ 이어서 작성
CREATE SEQUENCE dept3_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 10
    NOCYCLE
    NOCACHE;

-- 시퀀스 삭제
DROP SEQUENCE dept_seq;

-- 시퀀스 사용방법
-- 테이블 생성
CREATE TABLE dept3(
    dept_no NUMBER(3) PRIMARY KEY,
    dept_name VARCHAR2(14),
    dept_date DATE DEFAULT sysdate
);
DESC dept3;

-- 시퀀스 번호 생성
INSERT INTO dept3(dept_no, dept_name) VALUES(dept3_seq.NEXTVAL, 'test');  --> 3번실행
SELECT * FROM dept3;
INSERT INTO dept3(dept_no, dept_name) VALUES(dept3_seq.NEXTVAL, 'test');  --> 최대치(10개)까지 실행시
-- 결과 : ORA-08004: 시퀀스 DEPT3_SEQ.NEXTVAL exceeds MAXVALUE은 사례로 될 수 없습니다
-- 현재 시퀀스 값 확인
SELECT dept3_seq.CURRVAL FROM dual;

-- 시퀀스의 수정
-- alter sequence dept3_seq 옵션
-- 최고값 변경
ALTER SEQUENCE dept3_seq MAXVALUE 9999;
-- 증가값 변경
ALTER SEQUENCE dept3_seq INCREMENT BY 10;
-- 최소값 변경
ALTER SEQUENCE dept3_seq MINVALUE 1;

-- 확인
SELECT dept3_seq.CURRVAL FROM dual;  -- 10
SELECT dept3_seq.NEXTVAL FROM dual;  -- 20
-- 한번 사용하고 나면 되돌릴 수 없다
SELECT dept3_seq.CURRVAL FROM dual;
ROLLBACK; -- 롤백을 해도 20인걸 볼 수 있다.

-- 시퀀스의 값을 다시 처음으로 돌리는 방법
-- 1. 현재 시퀀스 확인
-- 2. 증가값 수정(-가장높은값)  
-- 3. nextval 실행 : 처음 값으로 돌리는 거야
-- 4. 증가값 1로 변경
-- 5. 실행 
-- 순서로 진행
SELECT dept3_seq.CURRVAL FROM dual;  --20
ALTER SEQUENCE dept3_seq INCREMENT BY -19;
SELECT dept3_seq.NEXTVAL FROM dual;   --1
ALTER SEQUENCE dept3_seq INCREMENT BY 1;
SELECT dept3_seq.CURRVAL FROM dual;

SELECT * FROM dept3;

-- 시퀀스 활용
DROP SEQUENCE dept3_seq;
DROP TABLE dept3;

/*
1. dept3_seq생성
2. pk를 varchar2로 생성
3. insert시에 to_char(날짜) || - || tlznjstm rkqt 
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
VALUES(to_char(sysdate,'YYYYMMDD')||'-'||dept3_seq.NEXTVAL,'test');  -- 3번실행
SELECT * FROM dept3;

-- index
-- index는 primary key, unique 제약조건에서 자동으로 생성되고, 조회를 빠르게 해주는 hint역할
SELECT * FROM user_indexes;
select * from emps;

SELECT * FROM emps WHERE first_name = 'Lex';

-- 인덱스 수동 추가
CREATE INDEX emps_first_name_ix ON  emps(first_name);

-- 인덱스 삭제
DROP INDEX emps_first_name_ix;