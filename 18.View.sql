-- view (뷰)
-- 빠르게 정보를 확인하기 위해 사용하는 테이블
select * from EMP_DETAILS_VIEW where FIRST_NAME = 'Steven';

/*
view는 제한적인 자료만 보기위해서 사용할 수 있는 가상 테이블의 개념
view는 가상테이블이기 때문에 필요한 컬럼만 저장해 두면 데이터 조회가 용이
뷰는 실제로 데이터가 물리적으로 저장된 형태가 아닌 원본테이블을 참조하는 기반으로 사용
뷰에서 DML작업을 하게 되면 실제 테이블에 적용됩니다,(다만, 제약사항이 많이 따름)
*/

select * from user_role_privs;
-- 현재 사용자 권한 확인
select * from user_sys_privs;


-- view 생성
-- 단순뷰
-- 하나의 테이블을 기반으로 한 뷰
create view view_emp
as(select employee_id,
          first_name,
          last_name,
          job_id,
          salary from employees
    );
    
select * from view_emp;


-- 복합뷰
-- 여러테이블을 조인하여 필요한 데이터를 저장한 
CREATE view view_emp_dept_job
as (select employee_id,
           first_name || ' ' || last_name as name,
           department_name,
           job_title
    from EMPLOYEES e
    left outer join DEPARTMENTS d
    on e.department_id = d.department_id
    left outer join jobs j
    on e.job_id = j.job_id
    );
    
select * from VIEW_EMP_DEPT_JOB;


-- view 의 수정
-- create or replace view 동일이름
create or replace view view_emp_dept_job
as (select E.EMPLOYEE_ID,
        first_name || ' ' || last_name as name,
        department_name,
        job_title,
        salary,
        street_address
    from EMPLOYEES e
    left outer join DEPARTMENTS d
    on E.DEPARTMENT_ID = D.DEPARTMENT_ID
    left outer join jobs j
    on e.job_id = j.job_id
    left outer join locations l
    on D.LOCATION_ID = L.LOCATION_ID
    );
    
select * from VIEW_EMP_DEPT_JOB;

-- 복합뷰로 필요한 데이터 생성을 햇다면 데이터의 조회가 간편
-- 예
select 
    job_title, 
    avg(salary), 
    sum(salary), 
    count(salary), 
    count(*)
from VIEW_EMP_DEPT_JOB
GROUP by job_title;


-- 뷰삭제
drop view view_emp;
drop view view_emp_dept_job;

-- 뷰의 DML연산
-- view는 insert, update, delete가 일어나는 경우에 실제테이블에 반영
-- 그리고 많은 제약사항이 있음.
-- 원본테이블에 Dml명령 사용 추천
select * from VIEW_EMP_DEPT_JOB;
select * from view_emp;
desc EMPLOYEES;

-- 복합뷰 DML연산
insert into VIEW_EMP_DEPT_JOB VALUES(300,'test','test','test');
-- 결과 : SQL 오류: ORA-01733: 가상 열은 사용할 수 없습니다
--       01733. 00000 -  "virtual column not allowed here"
-->> name은 뷰 생성당시 원본의 형태를 변형하여 만든 가상열이기 때문에 insert 적용이 되지 않는다.
insert into VIEW_EMP_DEPT_JOB(employee_id, department_name, job_title) 
VALUES(300,'test','test');
-- 결과 : SQL 오류: ORA-01776: 조인 뷰에 의하여 하나 이상의 기본 테이블을 수정할 수 없습니다.
--        01776. 00000 -  "cannot modify more than one base table through a join view"
-->> 조인 테이블의경우에도 update, insert가 안됩니다.

-- 단순뷰 DML
desc EMPLOYEES;
insert into VIEW_EMP(employee_id, first_name, salary) 
VALUES(300,'test',10000);
-- 결과 : ORA-01400: NULL을 ("HR"."EMPLOYEES"."LAST_NAME") 안에 삽입할 수 없습니다
-- last_name이 not null 제약조건이 있기때문에 insert 되지 않음.

-- 뷰의 제약사항
-- 옵션
-- with check option :  조건 컬럼 값을 변경하지 못하게 하는 옵션
CREATE view view_emp_test
as (select employee_id,
           first_name,
           last_name,
           email,
           hire_date,
           job_id,
           department_id
    from EMPLOYEES 
    where department_id = 60)
with check option;
update VIEW_EMP_TEST set DEPARTMENT_ID = 100;
-- 결과 :ORA-01402: 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다
-- department_id 수정 불가



-- with read only : 오직 select만 허용하는 옵션
CREATE OR REPLACE VIEW view_emp_test
as (select employee_id,
           first_name,
           last_name,
           email,
           hire_date,
           job_id,
           department_id
    from EMPLOYEES 
    where department_id = 60)
with read only;

update view_emp_test set DEPARTMENT_ID = 100;
-- 결과 :  ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
-- 오직 select만 할수 있기 때문에 수정 삭제 생성 불가

