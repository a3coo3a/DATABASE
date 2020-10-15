-- 트랜잭션
-- : 논리적인 작업수행 단위로 데이터 베이스의 안전장치

-- 트랜잭션 현상태 확인
show autocommit;  
-- 결과 > autocommit OFF

-- 자동 커밋되는 상태로 변경
set autocommit on;
-- 결과 > autocommit IMMEDIATE

-- 자동 커밋 해제
set autocommit off;
-- 따로 결과문은 나오지 않고 show를 통해 현상태를 확인해 보아야 함.

-- savepoint생성 및 롤백
select * from depts;

delete from depts where department_id = 10;
-- savepoint 생성 : savepoint 포인트명(지정)
savepoint delete_10;   

delete from depts where department_id = 20;
savepoint delete_20;

delete from depts; -- 전체 삭제됨
select * from depts;  -- 자료가 하나도 안남게됨.

rollback;  -- 최종커밋 이후까지 되돌림
select * from depts; 

-- 지점 롤백
-- 최종 커밋 이후로 돌아가서 savepoint는 없던 상태라 다시 한번 적용
delete from depts where department_id = 10;
savepoint delete_10;   

delete from depts where department_id = 20;
savepoint delete_20;

delete from depts;
rollback to delete_20;

select * from depts;

rollback to delete_10;
select * from depts;

commit; -- 커밋 이후에는 어떤 방법으로도 되돌릴 수 없음