---- 시험
--SELECT 
--    JOB_ID, 
--    COUNT(*) AS 직무별사원수,
--    SUM(SALARY) AS 직무별급여합,
--    AVG(SALARY) AS 직무별급여평균
--FROM EMPLOYEES
--GROUP BY JOB_ID;
--
--UPDATE BOARD SET TITLE = '바꿔', CONTENT = '다바꿔', UPDATEDATE = SYSDATE WHERE BNO = 2;
--
--SELECT * FROM BOARD WHERE TITLE LIKE '%질문%' ORDER BY TITLE ASC;
--
----1) board게시판의 테이블 생성 쿼리문을 작성하세요 
----조건- bno는 시퀀스를 이용한 자동증가 값을 갖는다. 
----조건 - writer는 회원의 id를 FK로 갖는다. 
----조건- regdate와, updatedate는 기본값으로 현재시간을 저장한다. 
--CREATE SEQUENCE board_bno_seq NOCACHE;
--CREATE TABLE board(
--    bno NUMBER(5) PRIMARY KEY,
--    writer VARCHAR2(20) REFERENCES USER1(ID),
--    title VARCHAR2(100),
--    content VARCHAR2(200),
--    regdate DATE DEFAULT sysdate,
--    updatedate DATE DEFAULT sysdate
--);
--select * from board;
--insert into board(bno, writer, title, content) VALUES(BOARD_BNO_SEQ.NEXTVAL,'ccc','우와~','~~');
----2) 댓글 테이블의 테이블 생성 쿼리문을 작성하세요 
----조건- rno는 시퀀스를 이용한 자동증가값을 갖는다. 
----조건- bno는 board의 bno를 FK로 갖는다. 
----조건 - regdate는 기본값으로 현재시간을 갖는다.
--CREATE SEQUENCE 댓글_rno_seq NOCACHE;
--CREATE TABLE  댓글(
--    rno NUMBER(5) PRIMARY KEY,
--    bno NUMBER(5) REFERENCES board(bno),
--    writer VARCHAR2(20),
--    content VARCHAR2(200),
--    regdate DATE DEFAULT sysdate
--);
--select * from 댓글;
--insert into 댓글 VALUES("댓글_RNO_SEQ".NEXTVAL, 5, 'aaa', '~~', sysdate);
--
--create table user1(
--    id VARCHAR2(20) PRIMARY key,
--    pw VARCHAR2(20),
--    name VARCHAR2(20),
--    address VARCHAR2(50)
--);
--select * from user1;
--insert into user1 VALUES('kkk123','*****','홍길동','서울');
--insert into user1 VALUES('aaa','****','홍길자','경기');
--insert into user1 VALUES('bbb','***','이순신','서울');
--insert into user1 VALUES('ccc','****','강감찬','서울');
--insert into user1 VALUES('ddd','*****','박찬호','부산');
--
--
--SELECT b.*
--FROM board b
--INNER JOIN user1 u
--ON b.writer = u.id
--WHERE b.writer = 'kkk123';
--
--SELECT 댓글.*
--FROM 댓글
--LEFT OUTER JOIN user 
--ON 댓글.writer = user.id
--WHERE 댓글.writer = 'aaa';
--
--SELECT 
--    BOARD.BNO AS 게시글번호,
--    BOARD.WRITER AS 게시판작성자,
--    BOARD.TITLE AS 제목,
--    BOARD.CONTENT AS 내용,
--    BOARD.REGDATE AS 작성일,
--    BOARD.UPDATEDATE AS 수정일,
--    RNO AS 댓글번호,
--    댓글.WRITER AS 댓글작성자,
--    댓글.CONTENT AS 댓글내용,
--    댓글.REGDATE AS 댓글작성일
--FROM BOARD
--LEFT OUTER JOIN 댓글
--ON BOARD.BNO = 댓글.BNO;
--
--select * from board;
--update board set regdate = '20200415' where bno = 5;
----board테이블의 가장최신글 순서대로 ROWNUM을 부여하여 1-10개의 게시글만 조회하는 페이징 서브쿼리문을 작성하세요.
--SELECT *
--FROM(
--    SELECT 
--        ROWNUM AS rn, 
--        board.*
--    FROM board
--    ORDER BY regdate
--)
--WHERE rn BETWEEN 1 AND 10;
--
--
--
select bno, count(*)
from 댓글
GROUP by bno;

SELECT board.*,
    nvl((SELECT COUNT(*)
    FROM 댓글
    WHERE board.bno = 댓글.bno
    GROUP BY bno),0) AS 댓글수
FROM board;

SELECT board.*,
    (SELECT COUNT(*)
    FROM 댓글
    WHERE board.bno = 댓글.bno
    GROUP BY bno) AS 댓글수
FROM board;
----------------------------------------------------------------------------
--
--CREATE OR REPLACE PROCEDURE GOGOPROC(
--    P_DAN IN NUMBER    
--)
--IS
--BEGIN
--    FOR I IN 1..9
--    LOOP
--        DBMS_OUTPUT.PUT_LINE(P_DAN || ' x ' || I || ' = ' || P_DAN * I);
--    END LOOP;
--END;
--
--EXECUTE gogoProc(3);
--
--
----1. 복사테이블생성
--CREATE TABLE depts AS (SELECT * FROM departments WHERE 1=1);
--
--select * from depts;
--
--ALTER TABLE depts ADD CONSTRAINT depts_department_id_pk PRIMARY KEY (department_id);
--
----3. 부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
----DEPTS 테이블에 각각 INSERT, UPDATE, DELETE 하는 
----deptsProc 란 이름의 프로시저를 생성하는 구문을 작성하세요 
----4. 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
--
--CREATE OR REPLACE PROCEDURE deptsproc(
--    p_depts_id IN depts.department_id%TYPE,
--    p_depts_name IN depts.department_name%TYPE,
--    p_flag IN VARCHAR2
--)
--IS
--BEGIN
--    IF p_flag = 'I' THEN
--        INSERT INTO depts(department_id, department_name) VALUES(p_depts_id, p_depts_name);
--    ELSIF p_flag = 'U' THEN
--        UPDATE depts SET department_name = p_depts_name WHERE department_id = p_depts_id;
--    ELSIF p_flag = 'D' THEN
--        DELETE FROM depts WHERE department_id = p_depts_id;
--    END IF;
--        
--    EXCEPTION WHEN OTHERS THEN
--        ROLLBACK;
--    
--    COMMIT;
--END;
--
--desc depts;
--
--
--
----[문항5]  프로시저명 - emp_hiredate_proc 
---- employee_id를 입력받아 
---- employees에 존재하면, 
---- 근속년수를 out하는 프로시저를 작성하세요. 
---- 없다면 exception처리하세요 (IN, OUT)변수를 사용합니다
--CREATE OR REPLACE PROCEDURE emp_hiredate_proc(
--    p_emp_id IN employees.employee_id%TYPE,
--    p_emp_date OUT number
--)IS
--    v_count NUMBER := 0;
--    v_date DATE;
--    v_long number := 0;
--BEGIN
--    SELECT COUNT(*)
--    INTO v_count
--    FROM employees
--    WHERE employee_id = p_emp_id;
--   
--    
--    IF v_count > 0 THEN
--        SELECT hire_date
--        INTO v_date
--        FROM employees
--        WHERE employee_id = p_emp_id;
--        v_long := TRUNC((sysdate - v_date)/365);
--    END IF;
--    
--    EXCEPTION WHEN OTHERS THEN
--        dbms_output.put_line(p_emp_id || '은 존재하지 않습니다');
--   
--   p_emp_date := v_long;
--END;
--set SERVEROUTPUT ON;
--DECLARE
--    v_num number;
--begin
--    emp_hiredate_proc(100,v_num);
--    DBMS_OUTPUT.put_line(v_num);
--end;
--
--
--SELECT TRUNC((sysdate - hire_date)/365)
--        
--        FROM employees
--        WHERE employee_id = 100;
--        
--desc employees;
--
----프로시저명 - emp_merge_proc 
---- employees 테이블의 복사 테이블 emps를 생성합니다. 
----employee_id, last_name, email, hire_date, job_id를 입력받아 
--
----존재하면 이름, 이메일, 입사일, 직업을 update, 
----없다면 insert하는 merge문을 작성하세요
drop table emps;
CREATE TABLE emps AS(SELECT * FROM employees WHERE 1=1);
select * from emps;

CREATE OR REPLACE PROCEDURE emp_merge_proc(
    p_emp_id IN emps.employee_id%TYPE,
    p_emp_last_name IN emps.last_name%TYPE,
    p_emp_email IN emps.email%TYPE,
    p_emp_hire_date IN emps.hire_date%TYPE,
    p_emp_job_id IN emps.job_id%TYPE
)
IS
BEGIN
    MERGE INTO emps A
        USING (SELECT * FROM emps WHERE employee_id = p_emp_id) b
        ON (A.employee_id = b.employee_id)
    WHEN MATCHED THEN
        UPDATE SET A.last_name = p_emp_last_name,
                   A.email = p_emp_email,
                   A.hire_date = p_emp_hire_date,
                   A.job_id = p_emp_job_id
    WHEN NOT MATCHED THEN
        INSERT (employee_id, last_name, email, hire_date, job_id) 
        VALUES(p_emp_id,
               p_emp_last_name,
               p_emp_email,
               p_emp_hire_date,
               p_emp_job_id);
    
END;

EXECUTE emp_merge_proc(101,'hi','test',sysdate,'test_te');


--[문항7]  프로시저명 - salesProc 
-- sales테이블은 오늘의 판매내역이다. 
-- day_of_sales테이블은 판매내역 마감시 오늘 일자의 총매출을 기록하는 테이블이다. 
-- 조건) day_of_sales의 마감내역이 이미 존재하면 업데이트 처리

create table sales(  -- 판매내역
    sno number(5), -- 번호
    name varchar2(30), -- 상품명
    total number(10), --수량
    price number(10), --가격
    regdate date default sysdate --날짜
);
insert into sales VALUES(2 ,'aa',10,1000,sysdate);

create table day_of_sales(   -- 마감시 오늘일자 총매출 기록
    regdate date,
    final_total number(10)
);

create or REPLACE PROCEDURE salesProc(
    p_date in date
)
is
    v_total number;
begin
    select sum(price)
    into v_total
    from sales
    where to_char(regdate,'YY-MM-DD') = to_char(p_date,'YY-MM-DD');
    
    MERGE INTO day_of_sales A
        USING sales b
        ON (to_char(A.regdate,'YY-MM-DD') = to_char(b.regdate,'YY-MM-DD'))
    WHEN MATCHED THEN
        UPDATE SET a.final_total = v_total
    WHEN NOT MATCHED THEN
        INSERT VALUES(to_char(p_date,'YY-MM-DD'), V_TOTAL);
end;

select * from sales;
select * from day_of_sales;
delete from day_of_sales where to_char(regdate,'YY-MM-DD') = '20-10-22';
EXECUTE salesProc('20-10-22');

select count(*), sum(price)
from sales
group by to_char(regdate,'YY-MM-DD');

select sum(price)
    from sales
    where regdate = sysdate;
    
    
    
    
    
--    
--    
--CREATE OR REPLACE PROCEDURE deptsproc(
--    p_depts_id IN depts.department_id%TYPE,
--    p_depts_name IN depts.department_name%TYPE,
--    p_flag IN VARCHAR2
--)
--IS
--BEGIN
--    IF p_flag = 'I' THEN
--        INSERT INTO depts(department_id, department_name) VALUES(p_depts_id, p_depts_name);
--    ELSIF p_flag = 'U' THEN
--        UPDATE depts SET department_name = p_depts_name WHERE department_id = p_depts_id;
--    ELSIF p_flag = 'D' THEN
--        DELETE FROM depts WHERE department_id = p_depts_id;
--    END IF;
--        
--    EXCEPTION WHEN OTHERS THEN
--        ROLLBACK;
--    
--    COMMIT;
--END;


select board.*,
    nvl((select count(*) from 댓글 where board.bno = 댓글.bno group by bno),0) as 댓글수
from board;