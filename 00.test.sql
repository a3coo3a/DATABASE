create table member(
    id VARCHAR2(30) PRIMARY key,
    pw VARCHAR2(30),
    name VARCHAR2(30),
    email VARCHAR2(30)
);

insert into member values('test01', '1234', 'ȫ�浿', 'naver');    
insert into member values('test02', '1234', '�̼���', 'ever');
insert into member values('test03', '1234', 'ȫ����', 'google');

commit;   -- insert�� delete�� �� commit !!!    ]


select * from member;

