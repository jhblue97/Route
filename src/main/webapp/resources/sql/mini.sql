
CREATE TABLE BoardBit (
	num number primary key,
	id varchar2(10) not null references Users(id) 
							on delete cascade,
	subject varchar2(100) not null,
	content varchar2(4000) not null,
	regDate DATE default sysdate , --작성일을 기본값으로 설정 
	hit number default 0,
	ip VARCHAR2(20),
	recommend number
);

CREATE SEQUENCE BOARDBIT_SEQ nocache;

create table Users (
	id varchar2(10) primary key ,
	snsFlag varchar2(2) not null,
	snsID varchar2(40) not null,
	name varchar2(10) not null,
	mail varchar2(30),
	phone varchar2(20),
	regDate date
);

      
create table data (
num number primary key,
sort varchar2(2),
moneykind varchar2(5),
url varchar2(100)
);

CREATE SEQUENCE DATA_SEQ nocache;
      