-- 테이블 생성 : create
create table dept2(
    dept_no number(2, 0),    -- 두자리 숫자를 저장하는데 실수는 저장하지 않는 숫자타입    
    dept_name VARCHAR2(14),  -- byte기반 가변 문자열
    loca VARCHAR2(13),
    dept_date date,
    depf_bouns number(10)
);

insert into dept2 values(99,'영업','서울',sysdate, 2000000000);

select * from dept2;

-- 테이블 수정 : alter
-- 컬럼에 관한 명령어 : add, modify, rename column, drop
-- add : 컬럼 추가
alter table dept2
add dept_count number(3);

desc dept2;

-- modify : 수정
alter table dept2
modify dept_count number(10);

desc dept2;

-- rename column : 컬럼 이름 변경
alter table dept2
rename column dept_count to emp_count;

desc dept2;

-- drop  : 컬럼 삭제
alter table dept2
drop column emp_count;

desc dept2;


-- 테이블 삭제
drop table dept2;
-- 제약조건이 있는 테이블 삭제
-- 해당 테이블에 걸려있는 FK(참조제한조건)도 지운다
-- drop table dept2 cascade constraints(제약조건명)

-- 테이블 전체 삭제
truncate table dept2;