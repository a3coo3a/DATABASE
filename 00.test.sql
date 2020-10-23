create table member(
    id VARCHAR2(30) PRIMARY key,
    pw VARCHAR2(30),
    name VARCHAR2(30),
    email VARCHAR2(30)
);

insert into member values('test01', '1234', '홍길동', 'naver');    
insert into member values('test02', '1234', '이순신', 'ever');
insert into member values('test03', '1234', '홍길자', 'google');

commit;   -- insert와 delete는 꼭 commit !!!    ]


select * from member;

