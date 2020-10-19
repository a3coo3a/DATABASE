

/* Create Sequences */

CREATE SEQUENCE SEQ_board_bno INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_lecture_lno INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_reply_rno INCREMENT BY 1 START WITH 1;



/* Create Tables */

CREATE TABLE admins
(
	id varchar2(50) NOT NULL,
	regdate date DEFAULT SYSDATE,
	PRIMARY KEY (id)
);


CREATE TABLE board
(
	bno number(10,0) NOT NULL,
	id varchar2(50) NOT NULL,
	title varchar2(50),
	content varchar2(100),
	regdate date DEFAULT SYSDATE,
	PRIMARY KEY (bno)
);


CREATE TABLE lecture
(
	lno number(10,0) NOT NULL,
	teacher varchar2(50) NOT NULL,
	l_list varchar2(50) NOT NULL,
	PRIMARY KEY (lno)
);


CREATE TABLE lecture_list
(
	id varchar2(50) NOT NULL,
	lno number(10,0) NOT NULL,
	PRIMARY KEY (id, lno)
);


CREATE TABLE members
(
	id varchar2(50) NOT NULL,
	info varchar2(50),
	regdate date DEFAULT sysdate,
	PRIMARY KEY (id)
);


CREATE TABLE reply
(
	rno number(10,0) NOT NULL,
	content varchar2(100),
	regdate date DEFAULT SYSDATE,
	bno number(10,0) NOT NULL,
	id varchar2(50) NOT NULL,
	PRIMARY KEY (rno)
);



/* Create Foreign Keys */
-- 논리적 데이터 모델링까지는 FK를 지정하지만, 
-- 실제 물리적 데이터 모델링에서는 하지 않는 경우가 많다.
-- 왜냐하면, 데이터 삭제시 묶여있는 종속의 관계가 복잡해서 잦은 변화시 번거로움이 있음.

ALTER TABLE reply
	ADD FOREIGN KEY (bno)
	REFERENCES board (bno)
;


ALTER TABLE lecture_list
	ADD FOREIGN KEY (lno)
	REFERENCES lecture (lno)
;


ALTER TABLE admins
	ADD FOREIGN KEY (id)
	REFERENCES members (id)
;


ALTER TABLE board
	ADD FOREIGN KEY (id)
	REFERENCES members (id)
;


ALTER TABLE lecture_list
	ADD FOREIGN KEY (id)
	REFERENCES members (id)
;


ALTER TABLE reply
	ADD FOREIGN KEY (id)
	REFERENCES members (id)
;
