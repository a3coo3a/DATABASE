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
-- 제약조건은 추가, 삭제가 가능 -> 수정이라는 것은 없음

drop table dept2;
create table dept2(
    dept_no number(2),
    dept_name VARCHAR2(14),
    loca number(4),
    dept_date date default sysdate,
    dept_bonus number(10),
    dept_gender char(1)
);
-- pk 추가
alter table dept2 
add CONSTRAINT dept_no_pk PRIMARY KEY (dept_no);
-- fk 추가
alter table dept2
add CONSTRAINT dept_loca_fk FOREIGN key (loca) REFERENCES locations(location_id);
-- check 추가
alter table dept2 
add CONSTRAINT dept_gender_check CHECK(dept_gender in ('Y','N'));
-- unique 추가
alter table dept2
add CONSTRAINT dept_name_uk unique (dept_name);
-- not null은 열수정 형태로 수정
alter table dept2
MODIFY dept_name VARCHAR2(14) not null;


-- 제약조건의 삭제
-- 제약조건의 이름으로 삭제
alter table dept2
drop CONSTRAINT dept_no_pk;    --> pk삭제

-- fk는 부모테이블의 값이 없다면 삽입 불가능
select * from locations;
select * from dept2;
insert into dept2 values(10,'test',100,sysdate,5000,'Y');
-- 결과 : ORA-02291: 무결성 제약조건(HR.DEPT_LOCA_FK)이 위배되었습니다- 부모 키가 없습니다
-- > locations의 location_id의 100이 없는 값이라 들어가지 못함

-- 연습문제 --------------------------------------------------------------------
--문제 1.
--다음과 같은 테이블을 생성하고 데이터를 insert하세요 (커밋)
--M_NAME M_NUM REG_DATE     GENDER  LOCA
--AAA    1      2018-07-01  M       1800
--BBB    2      2018-07-02  F       1900
--CCC    3      2018-07-03  M       2000
--DDD    4      오늘날짜     M       2000
--조건) M_NAME 는 가변문자형, 널값을 허용하지 않음
--조건) M_NUM 은 숫자형, 이름(mem_memnum_pk) primary key
--조건) REG_DATE 는 날짜형, 널값을 허용하지 않음, 이름:(mem_regdate_uk) UNIQUE키
--조건) GENDER 가변문자형
--조건) LOCA 숫자형, 이름:(mem_loca_loc_locid_fk) foreign key ? 참조 locations테이블(location_id)
CREATE table members(
    m_name VARCHAR2(4) not null,
    m_num NUMBER(2) CONSTRAINT mem_memnum_pk PRIMARY key,
    reg_date DATE DEFAULT sysdate not null CONSTRAINT mem_regdate_uk unique,
    gender VARCHAR2(1),
    loca NUMBER(4) CONSTRAINT mem_loca_loc_locid_fk REFERENCES locations(location_id)
);
select * from members;
insert into members 
VALUES('AAA', 1, '2018-07-01', 'M', 1800);
insert into members 
VALUES('BBB', 2, '2018-07-02', 'F', 1900);
insert into members 
VALUES('CCC', 3, '2018-07-03', 'M', 2000);
insert into members(m_name, m_num, gender, loca) 
VALUES('DDD', 4, 'M', 2000);
commit;

alter table members
add CONSTRAINT gender_check CHECK(gender in('F','M'));
commit;
--문제 2.
--MEMBERS테이블과 LOCATIONS테이블을 INNER JOIN 하고 
--m_name, m_mum, street_address, location_id 컬럼만 조회
--m_num기준으로 오름차순 조회

select
    m_name, 
    m_num, 
    street_address, 
    l.location_id
from members m
join locations l
on m.loca = l.location_id
order by m_num ASC;
