-- 제약 조건
-- PK : not null + unique key
-- check : 조건절처럼 이같은 조건에 맞아야만 테이블에 들어갈 수 있어 라고 하는 것.


-- 1. 열레벨 
-- 테이블 생성시에 제약조건을 걸어주는 것.
-- 제약조건이름은 생략가능
-- not null 은 그냥 not null만 쓰면됨.
-- constraint 제약조건이름 제약조건  -> 제약조건 거는 구문
-- check(조건) 으로 제약조건에 기재
-- fk 제약조건 기재: REFERENCES 참조할테이블명(참조할컬럼명(보통pk))
--   참조시 참조테이블의 타입과 동일해야 선언가능
-- UNIQUE :중복을 허용하지 않는

CREATE TABLE DEPT2(
    DEPT_NO NUMBER(2) PRIMARY KEY,
    DEPT_NAME VARCHAR2(14) NOT NULL UNIQUE,    --> NOT NULL 이면서 UNIQUE 키다 라고 두가지 조건을 준것
    LOCA NUMBER(4) REFERENCES LOCATIONS(LOCATION_ID),
    DEPT_DATE DATE DEFAULT SYSDATE,    --> 아무것도 지정하지 않으면 기본값으로 지정되는 것을 지정(아무것도 없으면 현재시간으로 지정한것임)
    DEPT_BONUS NUMBER(10),
    DEPT_GENDER CHAR(1) CHECK (DEPT_GENDER IN('F', 'M'))
);

DESC DEPT2;
drop table dept2;
-- 2. 테이블레벨
-- 일단 컬럼 만들어 놓고 아래쪽에 지정해주는것
-- 꼭, 풀네임을 기재해야함.
-- 모든 열을 기재한 후 아래쪽에 제약조건 추가
-- not null, default는 안됨.
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
-- 일단 다 만들어 놓고 alter로 지정해 주는것