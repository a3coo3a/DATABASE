create SEQUENCE movie_res_seq NOCACHE;
create table movie_reservation(
    res_no number(20) PRIMARY key,
    res_mem_no number(10) REFERENCES member1(member_no),
    res_movie_no number(10) REFERENCES movie(movie_no),
    res_name VARCHAR2(30) ,
    res_movie_name VARCHAR2(30),
    res_movietheater VARCHAR2(30),
    res_regdate date DEFAULT sysdate,
    res_seat VARCHAR2(30),
    res_paymentYN char(1) CHECK(res_paymentYN in('Y','N'))
);

create SEQUENCE member1_seq NOCACHE;
create table member1(
    member_no NUMBER(10) primary key,
    id varchar2(30),
    pw varchar2(30),
    name varchar2(30),    
    phone varchar2(30),
    email varchar2(30)
);
alter table member1
add birthday date;

create table movie(
    movie_no number(10) primary key,
    movie_name varchar2(30),
    movie_date date default sysdate,
    theater varchar2(30),
    playtime  varchar2(10),
    age_limit varchar2(10)
);
alter table movie
modify age_limit number(10);

select * from movie;
select * from MEMBER1;
select * from movie_reservation;

