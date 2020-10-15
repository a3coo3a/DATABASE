-- insert

-- 테이블의 컬럼 구조, 정보를 보여주는 것
desc DEPARTMENTS;
--이름              널?       유형           
----------------- -------- ------------ 
--DEPARTMENT_ID   NOT NULL NUMBER(4)        -> number형태의 4자리
--DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
--MANAGER_ID               NUMBER(6)    
--LOCATION_ID              NUMBER(4)

-- 사용방법
-- 1. 모든 컬럼 데이터를 한번에 지정
INSERT INTO DEPARTMENTS
VALUES (280,'developer', null, 1700);
-- 결과 : 1 행 이(가) 삽입되었습니다.     --> 아직 데이터의 반영이 된건 아님.
-- 확인
SELECT * FROM DEPARTMENTS;
-- 실행지점 뒤로 되돌리는 것
ROLLBACK;
-- 결과 : 롤백 완료.
-- 확인
SELECT * FROM DEPARTMENTS;

-- 2. 직접 컬럼을 지정하고 저장
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID) VALUES(280,'developer', 1700);
-- 결과 : 1 행 이(가) 삽입되었습니다.
-- 확인
SELECT * FROM DEPARTMENTS;
-- 실행지점 뒤로 되돌리는 것
ROLLBACK;
-- 결과 : 롤백 완료.
-- 확인
SELECT * FROM DEPARTMENTS;

-- 실습
INSERT INTO DEPARTMENTS 
VALUES(280,'직업1',NULL,1700);
INSERT INTO DEPARTMENTS
VALUES(290, '직업2',NULL,1700);
INSERT INTO DEPARTMENTS
VALUES(300, '직업3', NULL, 1700);
SELECT * FROM DEPARTMENTS;
ROLLBACK;  -- 직업1을 넣기 전인 처음과 결과가 값음을 확인

-- 3. 서브쿼리 구문으로 INSERT
-- 사본테이블 만들기
DESC EMPLOYEES;
-- 1 = 2 는 맞지 않는 조건이므로 데이터가 안들어감
-- 1 = 1 이면 데이터가 들어감
CREATE TABLE MANAGERS 
AS 
(
    SELECT 
        EMPLOYEE_ID, FIRST_NAME, 
        JOB_ID, SALARY, HIRE_DATE 
    FROM EMPLOYEES 
    WHERE 1 = 2
);
-- 결과 : Table MANAGERS이(가) 생성되었습니다.

-- 확인
SELECT * FROM MANAGERS;
-- 결과 : 값은 없고 컬럼만 가져온 모습

INSERT 
INTO MANAGERS(EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, HIRE_DATE)
(
    SELECT 
        EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, HIRE_DATE
    FROM EMPLOYEES 
    WHERE DEPARTMENT_ID = 60
);
-- 결과 : 5개 행 이(가) 삽입되었습니다.

-- 확인
SELECT * FROM MANAGERS;
ROLLBACK;

-- UPDATE --------------------------------
-- 사본테이블 : 통째로 복사
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES);
SELECT * FROM EMPS;

UPDATE EMPS 
SET SALARY = 100000;
-- 결과 : 107개 행 이(가) 업데이트되었습니다.

-- 확인
SELECT * FROM EMPS;
-- 결과 : SALARY의 모든 행의 값이 100000이 되어 있음.

ROLLBACK;
-- 결과 : SALARY의 값이 원래의 모습으로 돌아감

UPDATE EMPS 
SET SALARY = 100000 
WHERE EMPLOYEE_ID = 100;  --> 100번만 수정

-- 확인
SELECT * FROM EMPS;
-- EMPLOYEE_ID가 100번인 사람의 SALARY값만 변경

ROLLBACK;

-- 연산의 형태로 값 변경도 가능
UPDATE EMPS
SET SALARY = SALARY *0.1 + SALARY 
WHERE EMPLOYEE_ID = 100;
-- 확인
SELECT * FROM EMPS;
-- EMPLOYEE_ID가 100번인 사람의 SALARY값만 24000->26400으로 변경

ROLLBACK;

UPDATE EMPS
SET MANAGER_ID = 100
WHERE EMPLOYEE_ID = 100;
-- 결과 : 1 행 이(가) 업데이트되었습니다.

SELECT * FROM EMPS;
-- EMPLOYEE_ID가 100번인 MANAGER_ID사람의 값만 NULL->100으로 변경

ROLLBACK;

-- 여러개의 데이터를 수정
UPDATE EMPS
SET 
    PHONE_NUMBER = '031.123.1234',
    MANAGER_ID = 102
WHERE EMPLOYEE_ID = 100;
-- 결과 : 1 행 이(가) 업데이트되었습니다.

-- 확인
SELECT * FROM EMPS;
-- EMPLOYEE_ID가 100번인 사람의 PHONE_NUMBER, MANAGER_ID가 변경됨

ROLLBACK;

-- 서브쿼리 형식으로 수정, 변경 가능
-- 여러개의 컬럼을 수정, 변경할때 용이함.
UPDATE EMPS 
SET
    SALARY = (SELECT 1000 FROM DUAL)
WHERE EMPLOYEE_ID = 100;
-- 확인
SELECT * FROM EMPS;
-- EMPLOYEE_ID가 100번인 사람의 SALARY값만 24000->1000으로 변경
ROLLBACK;

UPDATE EMPS
SET
    (SALARY, PHONE_NUMBER) = (SELECT SALARY, PHONE_NUMBER FROM EMPS WHERE EMPLOYEE_ID = 101)
WHERE EMPLOYEE_ID = 100;
-- 확인
SELECT * FROM EMPS;
-- EMPLOYEE_ID가 100번인 사람의 SALARY, PHONE_NUMBER가 EMPLOYEE_ID가 101번인 사람과 동일한 값을 가지게됨.
ROLLBACK;

-- DELETE -------------------------------------------------------------------
-- 삭제시 항상 확인 하는 습관을 가져야 함.
-- 삭제시에 반드시 조건절 사용!
-- 다른 테이블에서 데이터를 참조하고 있으면 삭제가 불가능합니다.
-- EMPS 테이블의 프라이머리키 지정
ALTER TABLE EMPS
ADD CONSTRAINT EMPS_EMP_ID_PK PRIMARY KEY (EMPLOYEE_ID);
--결과 : Table EMPS이(가) 변경되었습니다.

-- EMPS 테이블의 FOREIGN KEY 지정
ALTER TABLE EMPS
ADD CONSTRAINT EMPS_MANAGER_FK FOREIGN KEY (MANAGER_ID) REFERENCES EMPS(EMPLOYEE_ID);
-- 결과 : Table EMPS이(가) 변경되었습니다.

-- 참조 무결성 제약조건
-- 다른 테이블에서 데이터를 참조하고 있으면 삭제가 불가능합니다.
DELETE FROM EMPS
WHERE EMPLOYEE_ID = 100;
-- 결과 : 
-- 오류 보고 -
-- ORA-02292: 무결성 제약조건(HR.EMPS_MANAGER_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다

-- 사본테이블 생성
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS);
SELECT * FROM DEPTS;   --> 복사테이블은 제약 조건이 걸려있지 않음.

DELETE FROM DEPTS;  --> 큰일나요!

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 10;
-- 결과 : 1 행 이(가) 삭제되었습니다.

-- 확인
SELECT * FROM DEPTS;
-- DEPARTMENT_ID가 10번인 사람의모든 정보가 지워짐.

ROLLBACK;

-- 서브쿼리
-- 조건절의 서브쿼리는 단일 행이 와야함
DELETE FROM DEPTS 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPS WHERE EMPLOYEE_ID = 100); -- 90
-- 결과 : 1 행 이(가) 삭제되었습니다.
-- 확인
SELECT * FROM DEPTS;

ROLLBACK;

-- MERGE -------------------------------------------------------------------
-- 있으면, 수정(UPDATE)하고 없으면 추가(INSERT)하는
-- 테이블 수정, 추가가 빈번한 경우 자주 사용
-- 사본테이블 생성 
CREATE TABLE EMPS_IT
AS (SELECT * FROM EMPLOYEES WHERE 1=2);
SELECT * FROM EMPS_IT;

INSERT INTO EMPS_IT(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (105, '데이비드', '김', 'davidkim','06/06/06', 'IT_PROG');

SELECT * FROM EMPS_IT;  --> 원본이라고 생각 여기에 다른 걸 붙이는 거야

-- A테이블에 B테이블의 정보를 추출해서 넣을거야
-- B에서 JOB_ID가 ~~인 정보를 A테이블에 넣는것
MERGE INTO EMPS_IT A  --> A는 별칭
    USING(SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG') B --> B는 별칭
    ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID)  -- A테이블과 B테이블의 조인 조건
WHEN MATCHED THEN      -- 맞으면 이곳을 실행
    UPDATE SET A.PHONE_NUMBER = B.PHONE_NUMBER,
               A.SALARY = B.SALARY,
               A.COMMISSION_PCT = B.COMMISSION_PCT,
               A.MANAGER_ID = B.MANAGER_ID,
               A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHEN NOT MATCHED THEN  -- 맞지 않으면 이곳을 실행
    INSERT VALUES(
            B.EMPLOYEE_ID, 
            B.FIRST_NAME, 
            B.LAST_NAME, 
            B.EMAIL, 
            B.PHONE_NUMBER, 
            B.HIRE_DATE, 
            B.JOB_ID, 
            B.SALARY, 
            B.COMMISSION_PCT, 
            B.MANAGER_ID, 
            B.DEPARTMENT_ID);
-- 결과 ; 5개 행 이(가) 병합되었습니다.

--확인
SELECT * FROM EMPS_IT;
-- 4개는 INSERT가 들어가고 1개는 UPDATE가 진행된 모습

-- 실습
INSERT INTO EMPS_IT(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (102, '렉스', '킴', 'LEX','01/04/06', 'AD_VP');
INSERT INTO EMPS_IT(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (102, '니나', '커', 'nian','20/04/06', 'AD_VP');
SELECT * FROM EMPS_IT;
ROLLBACK;

-- EMPLOYEES 테이블을 매번 수정되는 테이블이라고 가정하고.
-- 기존데이터는 EMAIL, PHONE, SALARY, MANAGER_ID, DEPARTMENT_ID는 업데이트 되도록 처리
-- 새로 유입된 데이터는 그냥 그대로 전부 추가

MERGE INTO EMPS_IT A
    USING EMPLOYEES B
    ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID)
WHEN MATCHED THEN
    UPDATE SET 
        A.EMAIL = B.EMAIL,
        A.PHONE_NUMBER = B.PHONE_NUMBER,
        A.SALARY = B.SALARY,
        A.MANAGER_ID = B.MANAGER_ID,
        A.DEPARTMENT_ID = B.DEPARTMENT_ID
   
WHEN NOT MATCHED THEN
    INSERT VALUES(
        B.EMPLOYEE_ID, 
        B.FIRST_NAME, 
        B.LAST_NAME,
        B.EMAIL,
        B.PHONE_NUMBER,
        B.HIRE_DATE,
        B.JOB_ID,
        B.SALARY,
        B.COMMISSION_PCT,
        B.MANAGER_ID,
        B.DEPARTMENT_ID);
        
SELECT * FROM EMPS_IT;


-- 삭제도 가능
MERGE INTO EMPS_IT A
    USING EMPLOYEES B
    ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID)
WHEN MATCHED THEN
    UPDATE SET 
        A.EMAIL = B.EMAIL,
        A.PHONE_NUMBER = B.PHONE_NUMBER,
        A.SALARY = B.SALARY,
        A.MANAGER_ID = B.MANAGER_ID,
        A.DEPARTMENT_ID = B.DEPARTMENT_ID
     DELETE WHERE B.EMPLOYEE_ID = 105
WHEN NOT MATCHED THEN
    INSERT VALUES(
        B.EMPLOYEE_ID, 
        B.FIRST_NAME, 
        B.LAST_NAME,
        B.EMAIL,
        B.PHONE_NUMBER,
        B.HIRE_DATE,
        B.JOB_ID,
        B.SALARY,
        B.COMMISSION_PCT,
        B.MANAGER_ID,
        B.DEPARTMENT_ID);
        
SELECT * FROM EMPS_IT;  -- 105번 행이 지워짐

-- 연습문제 -------------------------------------------------------------------
--문제 1.
--DEPTS테이블의 다음을 추가하세요
--DEPARTMENT_ID DEPARTMENT_NAME MANAGER_ID LOCATION_ID
--280           개발            null          1800
--290           회계부           null          1800
--300           재정            301           1800
--310           인사            302           1800
--320           영업            303           1700
SELECT * FROM DEPTS; 
desc depts;

INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (280, '개발', null, 1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (290, '회계부', null, 1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (300, '재정', 301, 1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (310, '인사', 302, 1800);
-- 전체 컬럼에 적용할때는 순서대로 적어주어, 아래와 같이 작성해도 됨
INSERT INTO DEPTS
VALUES (320, '영업', 303, 1700);

--문제 2.
--DEPTS테이블의 데이터를 수정합니다
SELECT * FROM DEPTS;
--1. department_name 이 IT Support 인 데이터의 department_name을 IT bank로 변경
UPDATE DEPTS SET DEPARTMENT_NAME = 'IT bank' WHERE DEPARTMENT_NAME = 'IT Support'; -- 210번 수정됨
--2. department_id가 290인 데이터의 manager_id를 301로 변경]
UPDATE DEPTS SET MANAGER_ID = 301 WHERE DEPARTMENT_ID = 290;
--3. department_name이 IT Helpdesk인 데이터의 부서명을 IT Help로 , 매니저아이디를 303으로, 지역아이디를
--1800으로 변경하세요
UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT Help', MANAGER_ID = 303, location_id = 1800 WHERE DEPARTMENT_NAME = 'IT Helpdesk';
--4. 개발, 회계부, 재정, 인사, 영업의 매니저아이디를 301로 한번에 변경하세요.
SELECT * FROM DEPTS;
UPDATE DEPTS SET MANAGER_ID = 301 WHERE DEPARTMENT_ID BETWEEN 280 AND 320;


--문제 3.
--삭제의 조건은 항상 primary key로 합니다, 여기서 primary key는 department_id라고 가정합니다.
--1. 부서명 영업부를 삭제 하세요
DELETE FROM DEPTS WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPTS WHERE DEPARTMENT_NAME = '영업');
--2. 부서명 NOC를 삭제하세요
DELETE FROM DEPTS WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC');
SELECT * FROM DEPTS;

--문제4
--1. Depts 사본테이블에서 department_id 가 200보다 큰 데이터를 삭제하세요.
DELETE FROM DEPTS WHERE DEPARTMENT_ID > 200;
--2. Depts 사본테이블의 manager_id가 null이 아닌 데이터의 manager_id를 전부 100으로 변경하세요.
UPDATE DEPTS SET MANAGER_ID = 100 WHERE MANAGER_ID IS NOT NULL;
--3. Depts 테이블은 타겟 테이블 입니다.
--4. Departments테이블은 매번 수정이 일어나는 테이블이라고 가정하고 Depts와 비교하여
--일치하는 경우 Depts의 부서명, 매니저ID, 지역ID를 업데이트 하고
--새로유입된 데이터는 그대로 추가해주는 merge문을 작성하세요.
MERGE INTO DEPTS A
    USING DEPARTMENTS B
    ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
WHEN MATCHED THEN
    UPDATE SET 
        A.DEPARTMENT_NAME = B.DEPARTMENT_NAME,
        A.MANAGER_ID = B.MANAGER_ID,
        A.LOCATION_ID = B.LOCATION_ID
WHEN NOT MATCHED THEN
    INSERT VALUES(
        B.DEPARTMENT_ID,
        B.DEPARTMENT_NAME,
        B.MANAGER_ID,
        B.LOCATION_ID);
SELECT * FROM DEPTS;

--문제 5
SELECT * FROM JOBS;   -- JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY
--1. jobs_it 사본 테이블을 생성하세요 (조건은 min_salary가 6000보다 큰 데이터만 복사합니다)
CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE MIN_SALARY >= 6000); 
SELECT * FROM JOBS_IT;
--2. jobs_it 테이블에 다음 데이터를 추가하세요
--JOB_ID   JOB_TITLE     MIN_SALARY MAX_SALARY
--IT_DEV   아이티개발팀   6000        20000
--NET_DEV  네트워크개발팀  5000        20000
--SEC_DEV  보안개발팀     6000        19000
INSERT INTO JOBS_IT(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
VALUES ('IT_DEV', '아이티개발팀', 6000, 20000);
INSERT INTO JOBS_IT(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
VALUES ('NET_DEV', '네트워크개발팀', 5000, 20000);
INSERT INTO JOBS_IT(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
VALUES ('SEC_DEV', '보안개발팀', 6000, 19000);

--3. jobs_it은 타겟 테이블 입니다
--4. jobs테이블은 매번 수정이 일어나는 테이블이라고 가정하고 jobs_it과 비교하여
--min_salary컬럼이 0보다 큰 경우 기존의 데이터는 min_salary, max_salary를 업데이트 하고 새로 유입된
--데이터는 그대로 추가해주는 merge문을 작성하세요
SELECT * FROM JOBS;
MERGE INTO JOBS_IT A
    USING (SELECT * FROM JOBS WHERE MIN_SALARY > 0) B
    ON (A.JOB_ID = B.JOB_ID)
WHEN MATCHED THEN
    UPDATE SET 
        A.MIN_SALARY = B.MIN_SALARY,
        A.MAX_SALARY = B.MIN_SALARY
WHEN NOT MATCHED THEN
    INSERT VALUES(
        B.JOB_ID,
        B.JOB_TITLE,
        B.MIN_SALARY,
        B.MAX_SALARY);
        
SELECT * FROM JOBS_IT;
commit;   --> 마지막 지점