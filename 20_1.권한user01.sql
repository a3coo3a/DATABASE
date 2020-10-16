-- user01 
create table test01(
    id VARCHAR2(20),
    name varchar2(20)
);

INSERT into test01 values('1', 'test');
--결과 : ORA-01950: 테이블스페이스 'USERS'에 대한 권한이 없습니다.

-- 저장 -> 물리적 저장 공간
-- 테이블을 통째로 저장하는것이 아니라 값들을 나누어 잘 저장하는데 >> 요것이 테이블스페이스 즉, 실제 저장공간
-- C:\app\user\product\18.0.0\oradata\XE\XEPDB1 에 .dbf라는 파일로 저장됨.

-- 테이블스페이스권한 생성 후 
INSERT into test01 values('1', 'test');
-- 결과 : 1 행 이(가) 삽입되었습니다.
-- 확인
select * from test01;

drop table test01;