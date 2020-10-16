/*
오라클의 최고 관리자 계정으로 실행을 시킵니다.
PDB로 접속
*/

-- 계정 생성명령
CREATE USER user01 IDENTIFIED BY user01;
--결과 : User USER01이(가) 생성되었습니다.

-- 생성된 계정에 권한 부여
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW to user01;
-- 결과 : Grant을(를) 성공했습니다.

-- 테이블스페이스
-- 데이터가 물리적으로 저장되는 공간
-- 물리적 공간이 지정 되어야 insert 문을 사용할 수 있다.

-- 테이블스페이스 확인
-- 보기 -> DBA -> +눌러 계정 선택 -> 저장영역 -> 테이블스페이스 선택 
-- 만들어져 있는 테이블스페이스를 사용해도 되고 만들어서 사용해도 됨.
-- 위에서 파일로 들어가 보면 저장되어 있는 파일 공간도 확인 가능

-- 기존에 만들어져 있는(on) users테이블에 무한정사용할 수 있게 권한을 주는 것
ALTER USER user01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS; 
-- 결과 : User USER01이(가) 변경되었습니다.
-- 이후에 insert 가능한걸 확인할 수 있다.

-- 테이블 스페이스를 직접 만들어 사용
ALTER USER user01 DEFAULT TABLESPACE my_data QUOTA UNLIMITED ON my_data;
--결과 ; User USER01이(가) 변경되었습니다.


-- 롤을 이용한 계정 생성과 권한 부여
CREATE USER user02 IDENTIFIED BY user02;
GRANT CONNECT, RESOURCE TO user02;
ALTER USER user02 DEFAULT TABLESPACE my_data QUOTA UNLIMITED ON my_data;

drop user "user02";


