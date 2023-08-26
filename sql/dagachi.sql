--==============================
-- 관리자계정 - spring계정 생성
--==============================
alter session set "_oracle_script" = true;

create user spring
identified by spring
default tablespace users;

alter user spring quota unlimited on users;

grant connect, resource to spring;

--================================
-- SPRING 계정
--================================
create table dev (
    id number,
    name varchar2(50) not null,
    career number not null,
    email varchar2(200) not null,
    gender char(1),
    lang varchar2(100) not null,
    created_at date default sysdate,
    constraints pk_dev_id primary key(id),
    constraints ck_dev_gender check(gender in ('M', 'F'))
);

create sequence seq_dev_id;

select * from dev;

create table member (
  member_id varchar2(50),
  password varchar2(300) not null,
  name varchar2(256) not null,
  birthday date,
  email varchar2(300),
  created_at date default sysdate,
  constraints pk_member_id primary key(member_id)
);
insert into spring.member 
values ('abcde','1234','아무개',to_date('88-01-25','rr-mm-dd'),'abcde@naver.com',default);
insert into spring.member 
values ('qwerty','1234','김말년',to_date('78-02-25','rr-mm-dd'),'qwerty@naver.com',default);
insert into spring.member 
values ('admin','1234','관리자',to_date('90-12-25','rr-mm-dd'),'admin@naver.com',default);
commit;

select * from member;
-- delete from member where member_id = 'honggd';
update 
    member 
set 
    password = '$2a$10$MWjHfxc97gYo1ZhLtHZnb.AqqVTRqU5Q6Dw0iQFEeoxQQEtke/TGi'
where 
    member_id = 'qwerty';

create table authority (
    member_id varchar2(20),
    auth varchar2(50),
    constraints pk_authority primary key(member_id, auth),
    constraints fk_authority_member_id foreign key(member_id)
                 references member(member_id)
                 on delete cascade
);
insert into authority values ('abcde', 'ROLE_USER');
insert into authority values ('qwerty', 'ROLE_USER');
insert into authority values ('admin', 'ROLE_USER');
insert into authority values ('admin', 'ROLE_ADMIN');
insert into authority values ('honggd', 'ROLE_USER');

select * from member;
select * from authority;

select * from member where member_id = 'kkkkk';
select * from authority where member_id = 'kkkkk';

-- MemberDetails 조회
 select
    *
from 
    member M
  left join authority A
    on M.member_id = A.member_id
where 
    M.member_id = 'admin';

-- Todo 할일관리
create table todo (
    id number,
    member_id varchar2(20),
    todo varchar2(4000),
    created_at date default sysdate,
    completed_at date,
    constraints pk_todo_id primary key(id),
    constraints fk_todo_member_id foreign key(member_id) references member(member_id) on delete cascade
);
create sequence seq_todo_id;

insert into todo values (seq_todo_id.nextval, 'honggd', '형광등 교체하기', default, null);
insert into todo values (seq_todo_id.nextval, 'honggd', '디자인패턴 공부하기', default, null);
insert into todo values (seq_todo_id.nextval, 'honggd', '장보기', default, null);
insert into todo values (seq_todo_id.nextval, 'honggd', '키보드 구매하기', default, sysdate);
insert into todo values (seq_todo_id.nextval, 'sinsa', '빨래하기', default, null);
insert into todo values (seq_todo_id.nextval, 'sinsa', '조깅', default, null);

select * from todo where member_id = 'honggd';
select * from todo;
--update todo set completed_at = ? wherere member_id = ?

-- 목록조회 (미완료할일 먼저)
select * from todo where member_id = 'honggd' order by completed_at nulls first, id;
-- todo 등록
insert into todo (id, member_id, todo) 
values (seq_todo_id.nextval, 'sinsa', '조깅');
-- todo 수정(완료)
update todo
set completed_at = sysdate -- sysdate | null
where id = 1 and member_id = 'honggd';
-- todo 삭제
delete from todo
where id = 1 and member_id = 'honggd';

-- security rememeberme 
create table persistent_logins (
    username varchar(64) not null,
    series varchar(64) primary key, -- pk
    token varchar(64) not null, -- username, password, expiry time을 hasing한 값
    last_used timestamp not null
);
select * from persistent_logins;

-- 게시판 기능구현

create table board (
    id number,
    title varchar2(2000),
    member_id varchar2(50),
    content varchar2(4000),
    created_at date default sysdate,
    constraint pk_board_id primary key(id),
    constraint fk_board_member_id 
        foreign key(member_id) 
        references member(member_id) 
        on delete set null
);
create sequence seq_board_id;

create table attachment (
    id number,
    board_id number,
    original_filename varchar2(500) not null,
    renamed_filename varchar2(500) not null,
    created_at date default sysdate,
    constraints pk_attachment_id primary key(id),
    constraints fk_attachment_board_id 
        foreign key(board_id)
        references board(id)
        on delete cascade
);
create sequence seq_attachment_id;


insert into spring.board (id,title,member_id,content,created_at) values (seq_board_id.nextval,'청춘이면 즐겨야죠~','honggd','무엇을 넣는 얼마나 가치를 바이며, 말이다. 얼음 같은 주며, 안고, 그리하였는가? 꾸며 청춘의 이것이야말로 별과 그들은 그러므로 피가 품고 찬미를 칼이다. 불어 구하지 우리의 보이는 봄바람을 이상의 그들은 그리하였는가? 있는 인간이 봄날의 생생하며, 무엇이 사라지지 소담스러운 그리하였는가? 힘차게 능히 불어 무엇을 같이 천고에 그들은 부패뿐이다.\n\n동산에는 열매를 끝까지 시들어 지혜는 철환하였는가? 이상의 속에서 아니한 교향악이다. 위하여 끓는 풀이 얼마나 많이 것이다. 풍부하게 꾸며 이상은 무엇을 황금시대의 생생하며, 황금시대다. 것이 위하여 청춘의 창공에 석가는 때문이다. 자신과 하는 위하여, 얼음 크고 철환하였는가?\n\n피가 지혜는 생생하며, 우리의 때문이다. 것은 힘차게 오아이스도 무엇을 그들은 때에, 트고, 옷을 것이다. 물방아 인생을 모래뿐일 두기 청춘은 그러므로 청춘의 그들은 새가 것이다. 시들어 같으며, 끓는 구하기 위하여, 얼음 있을 철환하였는가? 충분히 얼음과 소금이라 것이다. 주는 그것을 설산에서 우리 청춘의 하였으며, 속에 때까지 보라.',to_date('18/02/10','rr/mm/dd'));
insert into spring.board (id,title,member_id,content,created_at) values (seq_board_id.nextval,'헌법 친해지기', 'honggd', '이 헌법에 의한 최초의 대통령의 임기는 이 헌법시행일로부터 개시한다. 국회는 국정을 감사하거나 특정한 국정사안에 대하여 조사할 수 있으며, 이에 필요한 서류의 제출 또는 증인의 출석과 증언이나 의견의 진술을 요구할 수 있다.\n\n대법원장과 대법관이 아닌 법관은 대법관회의의 동의를 얻어 대법원장이 임명한다. 대법원에 대법관을 둔다. 다만, 법률이 정하는 바에 의하여 대법관이 아닌 법관을 둘 수 있다.',to_date('18/02/12','rr/mm/dd'));
insert into spring.board (id,title,member_id,content,created_at) values (seq_board_id.nextval,'관리자가 공지합니다. 졸지마세요~','honggd','관리자란 조직의 안정성과 계속성을 유지하고 환경에 적응하면서 쇄신적 발전을 이룩할 수 있는 여건을 조성하게 하는 역할을 가지고 있다. 그러므로 관리자는 조직 내부의 여건과 조직 환경을 고려한 각종 관리기법을 적용하여 조직을 경영하는데 최선을 다하여야 한다.',to_date('18/02/13','rr/mm/dd'));
insert into spring.board (id,title,member_id,content,created_at) values (seq_board_id.nextval,'이모네 테슬라','honggd','테슬라는 미국의 완성형 전기차 제조 업체이다. 텍사스 주의 주도인 오스틴에 본사가 위치하고 있다. 2010년대에 들어서는 완성차 외에 소프트웨어, 재생에너지, 로봇 산업 등에도 뛰어들며 전기차 뿐만 아니라 다양한 산업에 매우 많은 영향력을 가지고 있다.',to_date('18/02/14','rr/mm/dd'));
insert into spring.board (id,title,member_id,content,created_at) values (seq_board_id.nextval,'인류와 수영','honggd','세계4대 문명이 강 유역에서 그 찬란한 문화를 꽃피웠듯 인류는 물과 밀접한 관계를 맺어왔지요. 수영은 물과 인간과의 관계속에서 자연스럽게 시작되었습니다. 기원전 2500년경 고대 이집트, 그 이후의 앗시리아, 스리스 로마 문명등에서 수영의 기록을 찾아볼 수 있구요, 페르시아에서는 군사 훈련과정의 하나로 수영이 포함되었습니다. 이후 근대적 의미의 수영경기는 1837년 영국에서 처음 시작되었습니다. 우리나라에서는 1912년에 제 1회 조선 수영대회가 개최되었고, 1946년 조선 수상경기 연맹이 창설되면서 부터 수영이 본격적으로 발전하기 시작한것입니다.',to_date('18/02/15','rr/mm/dd'));

select * from board order by id desc;
select * from attachment order by id desc;
insert into attachment
values (seq_attachment_id.nextval, 2, '오리지날.txt', '20202020.txt', default);

select  
    b.*,
    (select count(*) from attachment where board_id = b.id) attach_count
from 
    board b
order by
    id desc;

-- 데이터추가
insert all 
    into board
    values (seq_board_id.nextval, title, member_id, content, default)

select * from board;

-- 시퀀스 번호 확인
-- 세션별로 nextval호출없이 currval 호출할 수 없다.
select seq_board_id.nextval, seq_board_id.currval from dual;

-- 게시글/첨부파일 조인쿼리
select
    m.*,
    b.*,
    a.id attach_id,
    a.board_id,
    a.original_filename,
    a.renamed_filename,
    a.created_at attach_created_at
from
    board b
      left join attachment a
        on b.id = a.board_id
      left join member m
        on b.member_id = m.member_id
where
    b.id =  643;

select * from attachment order by id desc;

commit;


