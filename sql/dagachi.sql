--================================
-- 관리자계정 - dagachi 계정 생성
--================================
--alter session set "_oracle_script" = true;
--
--create user dagachi
--identified  by dagachi
--default tablespace users;
--
--alter user dagachi quota unlimited on users;
--
--grant connect, resource to dagachi;


------------------------------------------- 전체 테이블 조회 -------------------------------------------

--SELECT 'DROP TABLE "' ||  TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;

---------------------------------------------- 테이블 삭제 ----------------------------------------------

--DROP TABLE "MEMBER" CASCADE CONSTRAINTS;
--DROP TABLE "CLUB" CASCADE CONSTRAINTS;
--DROP TABLE "CLUB_MEMBER" CASCADE CONSTRAINTS;
--DROP TABLE "ACTIVITY_AREA" CASCADE CONSTRAINTS;
--DROP TABLE "MEMBER_INTEREST" CASCADE CONSTRAINTS;
--DROP TABLE "MEMBER_PROFILE" CASCADE CONSTRAINTS;
--DROP TABLE "CLUB_GALLERY_ATTACHMENT" CASCADE CONSTRAINTS;
--DROP TABLE "CLUB_BOARD_ATTACHMENT" CASCADE CONSTRAINTS;
--DROP TABLE "CLUB_SCHEDULE" CASCADE CONSTRAINTS;
--DROP TABLE "CLUB_SCHEDULE_PLACE" CASCADE CONSTRAINTS;
--DROP TABLE "CLUB_SCHEDULE_ENROLL_MEMBER" CASCADE CONSTRAINTS;
--DROP TABLE "BOARD_COMMENT" CASCADE CONSTRAINTS;
--DROP TABLE "MEMBER_REPORT" CASCADE CONSTRAINTS;
--DROP TABLE "CLUB_REPORT" CASCADE CONSTRAINTS;
--DROP TABLE "CHAT_LOG" CASCADE CONSTRAINTS;
--DROP TABLE "CLUB_PROFILE" CASCADE CONSTRAINTS;
--DROP TABLE "CLUB_APPLY" CASCADE CONSTRAINTS;
--DROP TABLE "CLUB_LAYOUT" CASCADE CONSTRAINTS;
--DROP TABLE "MEMBER_LIKE" CASCADE CONSTRAINTS;
--DROP TABLE "CLUB_TAG" CASCADE CONSTRAINTS;
--DROP TABLE "MAIN_PAGE" CASCADE CONSTRAINTS;
--DROP TABLE "ADMIN_NOTICE" CASCADE CONSTRAINTS;
--DROP TABLE "CLUB_BOARD" CASCADE CONSTRAINTS;
--DROP TABLE "CLUB_GALLERY" CASCADE CONSTRAINTS;
--DROP TABLE "AUTHORITY" CASCADE CONSTRAINTS;

------------------------------------------------- 시퀀스 -------------------------------------------------
create sequence seq_club_id;
create sequence seq_club_report_id;
create sequence seq_chat_log_id;

create sequence seq_member_id;
create sequence seq_member_report_id;
create sequence seq_member_like_id;

create sequence seq_club_gallery_id;
create sequence seq_club_board_id;
create sequence seq_club_gallery_attachment_id;
create sequence seq_club_board_attachment_id;
create sequence seq_board_comment_id;

create sequence seq_club_schedule_id;
create sequence seq_club_schedule_place_id;

create sequence seq_main_page_id;
create sequence seq_admin_notice_id;

create sequence seq_alarm_id;

---------------------------------------------- 시퀀스 삭제 ----------------------------------------------
--drop sequence seq_club_id;
--drop sequence seq_club_report_id;
--drop sequence seq_chat_log_id;
--
--drop sequence seq_member_id;
--drop sequence seq_member_report_id;
--drop sequence seq_member_like_id;
--
--drop sequence seq_club_gallery_id;
--drop sequence seq_club_board_id;
--drop sequence seq_club_gallery_attachment_id;
--drop sequence seq_club_board_attachment_id;
--drop sequence seq_board_comment_id;
--
--drop sequence seq_club_schedule_id;
--drop sequence seq_club_schedule_place_id;
--
--drop sequence seq_main_page_id;
--drop sequence seq_admin_notice_id;
--
--drop sequence seq_alarm_id;

------------------------------------------------- 테이블 -------------------------------------------------
create table member (
	member_id	varchar2(30)	not null,
	password	varchar2(150)	not null,
	name	 varchar2(20)	not null,
    nickname varchar2(30) not null,
	phone_no	varchar2(20)	not null,
	email	varchar2(50)	not null,
	birthday	date	not null,
	gender	char(1)	not null, -- 	COMMENT 'M, F'
	mbti	varchar(10)	,
	address	varchar2(200)	not null,
	report_count	number	default 0,
	enroll_date	date default sysdate,
	withdrawal_date	date, --  COMMENT 'null 이면 회원'
	password_change_date	date default sysdate,
	last_login_date date,
	status char(1) default 'Y',
    member_role char(1) default 'M' not null
);

create table club (
	club_id	number	not null,
	club_name	varchar2(50)	not null,
	activity_area	varchar2(100)	not null,
	category	varchar2(20)	not null, -- COMMENT 'enum으로 만들까?'
	created_at	date default sysdate,
	last_activity_date	date,
	status char(1) default 'Y', -- COMMENT '활성화 : Y 비활성화 : N'
	report_count	number,
	introduce	varchar2(1000) not null,
	enroll_question	varchar2(1000) not null,
    domain varchar2(100) not null
);

create table club_member (
	member_id	varchar2(30)	not null,
	club_id	number	not null,
	enroll_at	 date	default sysdate,
	last_activity_date	date,
	club_member_roll number	 default 0, -- 	COMMENT '0 : 일반회원 (default) 1: 임원 (최대 5명) null가능 2: 서브리더 (1명) null가능 3: 리더 (1명) notnull',
	enroll_count	number default 0
);

create table club_board (
	board_id number	 not null,
	club_id number not null,
	writer varchar2(30) not null,
	title varchar2(200) not null,
	content	varchar2(4000) not null,
	created_at date default sysdate,
	type	number	not null,
	status char(1) default 'Y',
	like_count number default 0
);  -- 	COMMENT '0 : 자유글 1 : 정보글 2 : 정모후기 3 : 가입인사 4 : 공지사항'

create table activity_area (
	member_id	varchar2(30)	not null,
	main_area_id	number	not null,
	sub1_area_id	number default 0,
	sub2_area_id	number default 0
);

create table member_interest (
	member_id	varchar2(30)	not null,
	interest	varchar2(50)	not null
);

create table member_profile (
	member_id	varchar2(30)	not null,
	original_filename	varchar2(200),
	renamed_filename	varchar2(200),
	created_at	date default sysdate
);

create table club_gallery (
	gallery_id	number	not null,
	club_id	number	not null,
	like_count number default 0,
	status char(1) default 'Y'
);

create table club_gallery_attachment (
	id	number	not null,
	gallery_id	number	not null,
	original_filename	varchar2(200)	not null,
	renamed_filename	varchar2(200)	not null,
	created_at	date default sysdate,
	thumbnail	char(1) default 'N'
);

create table club_board_attachment (
	id	number	not null,
	board_id	number	not null,
	original_filename	varchar2(200)	not null,
	renamed_filename varchar2(200)	not null,
	created_at	date default sysdate,
	thumbnail	char(1) default 'N'
);

create table club_schedule (
	schedule_id	number	not null,
	club_id	number	not null,
	title	varchar2(200)	not null,
	start_date date	not null,
	end_date date,
	expence	number	default 0,
	capacity	number	default 0,
	alarm_date	date,
	status char(1) default 'Y'
);

create table club_schedule_place (
	id	number	not null,
	schedule_id	number	not null,
	name	varchar2(100)	not null,
	address	varchar2(200),
	sequence	number default 0,
	start_time	date	not null
);

create table club_schedule_enroll_member (
	member_id	varchar2(30)	not null,
	club_id	number	not null,
	schedule_id	number	not null,
	created_at	date default sysdate
);

create table board_comment (
	comment_id	number	not null,
	board_id	number	not null,
	writer	varchar2(30)	not null,
	comment_ref	number, -- null 댓글인경우 | board_comment.no 대댓글인 경우
	content	varchar2(1000)	not null,
	created_at	date default sysdate,
	status char(1) default 'Y',
    comment_level number default 1  -- 1. 댓글, 2. 대댓글
);

create table member_report (
	id	number	not null,
	member_id	varchar2(30)	not null,
	reporter	varchar2(30),
	reason	varchar2(500)	not null,
	created_at	date	default sysdate,
	board_id	 number default 0,
	comment_id number default 0
);

create table club_report (
	id	number	not null,
	club_id	number	not null,
	reason	varchar2(500)	not null,
	reporter	varchar2(30)	not null,
	created_at	date default sysdate
);

create table chat_log (
	id	number	not null,
	club_id	number	not null,
	writer	varchar2(30)	not null,
	content	varchar2(2000)	not null,
	created_at	date default sysdate
);

create table club_profile (
	club_id	number	not null,
	original_filename	varchar2(200)	not null,
	renamed_filename varchar2(200) not null,
	created_at date default sysdate
);

create table club_apply (
	club_id	number	not null,
	member_id	varchar2(30) not null,
	answer	varchar2(1000) not null
);

create table club_layout (
	club_id	number	not null,
	type	number default 0,
	font	varchar2(200),
	background_color	varchar2(50),
	font_color	varchar2(50),
	point_color	varchar2(50),
	title	varchar2(200),
	main_image	varchar2(200),
	main_content	varchar2(1000)
);

create table member_like (
	like_id	number	not null,
	member_id	varchar2(30)	not null,
	like_sender	varchar(255)	not null,
	created_at	date default sysdate
);

create table club_tag (
	club_id	number	not null,
	tag	varchar2(200)
);

create table main_page (
	id	number	not null,
	original_filename	varchar2(200),
	renamed_filename	varchar2(200),
	created_at	date default sysdate
);

create table admin_notice (
	id	number	not null,
	writer	varchar2(30)	not null,
	title	varchar2(200)	not null,
	content	varchar2(4000)	not null,
	created_at	date default sysdate,
	status	char(1) default 'Y'
);

create table authority (
    member_id varchar2(30),
    auth varchar2(20)   not null
);

alter table member add constraint pk_member primary key (
	member_id
);

alter table club add constraint pk_club primary key (
	club_id
);

alter table club_member add constraint pk_club_member primary key (
	member_id,
	club_id
);

alter table club_board add constraint pk_club_board primary key (
	board_id
);

alter table activity_area add constraint pk_activity_area primary key (
	member_id
);

alter table member_profile add constraint pk_member_profile primary key (
	member_id
);

alter table club_gallery add constraint pk_club_gallery primary key (
	gallery_id
);

alter table club_gallery_attachment add constraint pk_club_gallery_attachment primary key (
	id
);

alter table club_board_attachment add constraint pk_club_board_attachment primary key (
	id
);

alter table club_schedule add constraint pk_club_schedule primary key (
	schedule_id
);

alter table club_schedule_place add constraint pk_club_schedule_place primary key (
	id
);

alter table club_schedule_enroll_member add constraint pk_club_schedule_enroll_member primary key (
	member_id,
	club_id,
	schedule_id
);

alter table board_comment add constraint pk_board_comment primary key (
	comment_id
);

alter table member_report add constraint pk_member_report primary key (
	id
);

alter table club_report add constraint pk_club_report primary key (
	id
);

alter table chat_log add constraint pk_chat_log primary key (
	id
);

alter table club_profile add constraint pk_club_profile primary key (
	club_id
);

alter table club_layout add constraint pk_club_layout primary key (
	club_id
);

alter table member_like add constraint pk_member_like primary key (
	like_id
);

alter table main_page add constraint pk_main_page primary key (
	id
);

alter table admin_notice add constraint pk_admin_notice primary key (
	id
);

alter table club_member add constraint fk_member_to_club_member_1 foreign key (
	member_id
)
references member (
	member_id
);

alter table club_member add constraint fk_club_to_club_member_1 foreign key (
	club_id
)
references club (
	club_id
);

alter table club_board add constraint fk_club_to_club_board_1 foreign key (
	club_id
)
references club (
	club_id
);

alter table club_board add constraint fk_member_to_club_board_1 foreign key (
	writer
)
references member (
	member_id
);

alter table activity_area add constraint fk_member_to_activity_area_1 foreign key (
	member_id
)
references member (
	member_id
);

alter table member_interest add constraint fk_member_to_member_interest_1 foreign key (
	member_id
)
references member (
	member_id
);

alter table member_profile add constraint fk_member_to_member_profile_1 foreign key (
	member_id
)
references member (
	member_id
);

alter table club_gallery add constraint fk_club_to_club_gallery_1 foreign key (
	club_id
)
references club (
	club_id
);

alter table club_gallery_attachment add constraint fk_club_gallery_to_club_gallery_attachment_1 foreign key (
	gallery_id
)
references club_gallery (
	gallery_id
);

alter table club_board_attachment add constraint fk_club_board_to_club_board_attachment_1 foreign key (
	board_id
)
references club_board (
	board_id
);

alter table club_schedule add constraint fk_club_to_club_schedule_1 foreign key (
	club_id
)
references club (
	club_id
);

alter table club_schedule_place add constraint fk_club_schedule_to_club_schedule_place_1 foreign key (
	schedule_id
)
references club_schedule (
	schedule_id
);

--alter table club_schedule_enroll_member add constraint fk_club_member_to_club_schedule_enroll_member_1 foreign key (
--	member_id
--)
--references club_member (
--	member_id
--);
--
--alter table club_schedule_enroll_member add constraint fk_club_member_to_club_schedule_enroll_member_2 foreign key (
--	club_id
--)
--references club_member (
--	club_id
--);

alter table club_schedule_enroll_member add constraint fk_club_schedule_to_club_schedule_enroll_member_1 foreign key (
	schedule_id
)
references club_schedule (
	schedule_id
);

alter table board_comment add constraint fk_club_board_to_board_comment_1 foreign key (
	board_id
)
references club_board (
	board_id
);

alter table board_comment add constraint fk_member_to_board_comment_1 foreign key (
	writer
)
references member (
	member_id
);

alter table board_comment add constraint fk_board_comment_to_board_comment_1 foreign key (
	comment_ref
)
references board_comment (
	comment_id
);

alter table member_report add constraint fk_member_to_member_report_1 foreign key (
	member_id
)
references member (
	member_id
);

alter table club_report add constraint fk_club_to_club_report_1 foreign key (
	club_id
)
references club (
	club_id
);

alter table chat_log add constraint fk_club_to_chat_log_1 foreign key (
	club_id
)
references club (
	club_id
);

alter table club_profile add constraint fk_club_to_club_profile_1 foreign key (
	club_id
)
references club (
	club_id
);

alter table club_apply add constraint fk_club_to_club_apply_1 foreign key (
	club_id
)
references club (
	club_id
);

alter table club_layout add constraint fk_club_to_club_layout_1 foreign key (
	club_id
)
references club (
	club_id
);

alter table member_like add constraint fk_member_to_member_like_1 foreign key (
	member_id
)
references member (
	member_id
);

alter table club_tag add constraint fk_club_to_club_tag_1 foreign key (
	club_id
)
references club (
	club_id
);

alter table admin_notice add constraint fk_member_to_admin_notice_1 foreign key (
	writer
)
references member (
	member_id
);

alter table member add constraint uq_member_nickname unique (
    nickname
);


alter table member add constraint uq_member_email unique (
    email
);

alter table club add constraint uq_club_name unique (
    club_name
);

alter table authority add constraint fk_member_to_authorithy foreign key (
	member_id
)
references member (
	member_id
);

-- 소모임샘플
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (seq_club_id.nextval, '스포츠 열정 클럽', '강남구', '운동/스포츠', TO_DATE('2023-08-01', 'YYYY-MM-DD'), 0, '우리는 다양한 종목의 스포츠를 즐기고 관찰하는 스포츠 애호가들의 모임입니다.', '가장 좋아하는 스포츠는 무엇인가요?', 'sportsclub');
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (seq_club_id.nextval, '예술 창작 모임', '홍대', '공연/축제', TO_DATE('2023-07-15', 'YYYY-MM-DD'), 0, '회화, 드로잉, 조각 등을 통해 창의력을 표현하는 공간입니다.', '어떤 종류의 예술 활동을 좋아하시나요?', 'artisticcreations');
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (seq_club_id.nextval, '테크 이노베이터스', '서초구', '자유주제', TO_DATE('2023-08-10', 'YYYY-MM-DD'), 0, '기술의 최신 동향을 탐구하고 흥미로운 프로젝트에 참여하는 곳입니다.', '어떤 프로그래밍 언어를 다룰 수 있나요?', 'techinnovators');
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (seq_club_id.nextval, '책벌레 모임', '종로구', '인문학/독서', TO_DATE('2023-07-30', 'YYYY-MM-DD'), 0, '책의 세계에 몰입하고 생각을 나누는 문학 토론의 장소입니다.', '최근에 읽은 좋은 책은 무엇인가요?', 'bookwormssociety');
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (seq_club_id.nextval, '음악 감상 클럽', '이태원', '음악/악기', TO_DATE('2023-08-05', 'YYYY-MM-DD'), 0, '음악 애호가들이 좋아하는 노래, 악기, 작곡을 나누는 공간입니다.', '가장 좋아하는 음악 장르는 무엇인가요?', 'musicvibesclub');
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (seq_club_id.nextval, '그린 어스 소사이어티', '강서구', '봉사활동', TO_DATE('2023-08-12', 'YYYY-MM-DD'), 0, '환경 인식을 높이고 지구를 보호하기 위한 활동을 공유하는 모임입니다.', '환경을 위해 실천하는 습관이 있나요?', 'greenearthsociety');
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (seq_club_id.nextval, '요리 열풍 클럽', '마포구', '요리/제조', TO_DATE('2023-08-08', 'YYYY-MM-DD'), 0, '음식을 좋아하고 요리하는 열정을 공유하며 미식 토론을 즐기는 곳입니다.', '당신의 대표 요리는 무엇인가요?', 'culinarydelights');
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (seq_club_id.nextval, '모험을 찾아서', '용산구', '여행', TO_DATE('2023-07-20', 'YYYY-MM-DD'), 0, '짜릿한 모험을 떠나고 새로운 여행지를 탐험하며 여행 이야기를 공유하는 곳입니다.', '지금까지 다녀온 여행 중 가장 기억에 남는 곳은 어디인가요?', 'adventureseekers');
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (seq_club_id.nextval, '건강과 웰빙 컬렉티브', '성동구', '사교/인맥', TO_DATE('2023-08-03', 'YYYY-MM-DD'), 0, '운동 활동, 명상, 건강한 생활에 대한 토론을 통해 신체와 마음의 웰빙을 촉진하는 공간입니다.', '건강을 어떻게 관리하고 계시나요?', 'healthwellnesscollective');



-- 소모임사진 샘플
insert into club_profile values(1,'asd','1.png',sysdate);
insert into club_profile values(2,'asd','2.png',sysdate);
insert into club_profile values(3,'asd','3.png',sysdate);
insert into club_profile values(4,'asd','4.png',sysdate);
insert into club_profile values(5,'asd','5.png',sysdate);
insert into club_profile values(6,'asd','6.png',sysdate);
insert into club_profile values(7,'asd','7.png',sysdate);
insert into club_profile values(8,'asd','8.png',sysdate);
insert into club_profile values(9,'asd','9.png',sysdate);


-- 소모임 태그 샘플 데이터
insert into club_tag (club_id, tag)
values(1, '스포츠');
insert into club_tag (club_id, tag)
values(1, '축구');
insert into club_tag (club_id, tag)
values(1, '농구');
insert into club_tag (club_id, tag)
values(1, '야구');
insert into club_tag (club_id, tag)
values(1, '족구');
insert into club_tag (club_id, tag)
values(1, '배드민턴');

insert into club_tag (club_id, tag)
values(2, '음악');
insert into club_tag (club_id, tag)
values(2, '미술');
insert into club_tag (club_id, tag)
values(2, '무용');
insert into club_tag (club_id, tag)
values(2, '연극');
insert into club_tag (club_id, tag)
values(2, '영화');
insert into club_tag (club_id, tag)
values(2, '오페라');


insert into club_tag (club_id, tag)
values(3, 'JAVA');
insert into club_tag (club_id, tag)
values(3, '인공지능');
insert into club_tag (club_id, tag)
values(3, 'C');
insert into club_tag (club_id, tag)
values(3, '빅데이터');
insert into club_tag (club_id, tag)
values(3, 'AR');
insert into club_tag (club_id, tag)
values(3, 'VR');
insert into club_tag (club_id, tag)
values(3, 'IoT');

insert into club_tag (club_id, tag)
values(4, '책');
insert into club_tag (club_id, tag)
values(4, '독서');
insert into club_tag (club_id, tag)
values(4, '추리 소설');
insert into club_tag (club_id, tag)
values(4, '공포 소설');
insert into club_tag (club_id, tag)
values(4, '판타지 소설');

insert into club_tag (club_id, tag)
values(5, '클래식');
insert into club_tag (club_id, tag)
values(5, '재즈');
insert into club_tag (club_id, tag)
values(5, 'CCM');
insert into club_tag (club_id, tag)
values(5, '팝송');
insert into club_tag (club_id, tag)
values(5, '발라드');

insert into club_tag (club_id, tag)
values(6, '친환경');
insert into club_tag (club_id, tag)
values(6, '재활용');
insert into club_tag (club_id, tag)
values(6, '녹색 에너지');
insert into club_tag (club_id, tag)
values(6, '환경보호');
insert into club_tag (club_id, tag)
values(6, '지속가능성');
insert into club_tag (club_id, tag)
values(6, '자연보전');

insert into club_tag (club_id, tag)
values(7, '요리');
insert into club_tag (club_id, tag)
values(7, '한식');
insert into club_tag (club_id, tag)
values(7, '양식');
insert into club_tag (club_id, tag)
values(7, '일식');

insert into club_tag (club_id, tag)
values(8, '여행');
insert into club_tag (club_id, tag)
values(8, '관광지');
insert into club_tag (club_id, tag)
values(8, '배낭여행');
insert into club_tag (club_id, tag)
values(8, '해외여행');
insert into club_tag (club_id, tag)
values(8, '국내여행');
insert into club_tag (club_id, tag)
values(8, '문화체험');
insert into club_tag (club_id, tag)
values(8, '자연소풍');

insert into club_tag (club_id, tag)
values(9, '건강');
insert into club_tag (club_id, tag)
values(9, '운동');
insert into club_tag (club_id, tag)
values(9, '식단');
insert into club_tag (club_id, tag)
values(9, '스트레스 관리');
insert into club_tag (club_id, tag)
values(9, '건강정보');

-- 멤버샘플
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
values ('admin', '1234', '관리자','관리자', '956-456-7890', 'admin@naver.com', TO_DATE('1990-01-15', 'YYYY-MM-DD'), 'M', 'ISTJ', '서울시 강남구 123번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y', default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
values ('honggd', '1234', '홍길동','길동길동', '123-456-7890', 'honggd@naver.com', TO_DATE('1990-01-15', 'YYYY-MM-DD'), 'M', 'ISTJ', '서울시 강남구 123번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
values ('user1', 'password1', '김영희','영희얌', '987-654-3210', 'user1@example.com', TO_DATE('1992-03-20', 'YYYY-MM-DD'), 'F', 'ENFP', '서울시 종로구 456번지', 1, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
values ('user2', 'password2', '이철수','흔한이름철쑤', '555-123-4567', 'user2@example.com', TO_DATE('1985-08-05', 'YYYY-MM-DD'), 'M', 'INTP', '부산시 해운대구 789번지', 2, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
values ('user3', 'password3', '박미영','박미영팀장', '111-222-3333', 'user3@example.com', TO_DATE('1995-12-10', 'YYYY-MM-DD'), 'F', 'ISFJ', '대구시 수성구 101번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
values ('user4', 'password4', '정민준','정민준짱', '444-555-6666', 'user4@example.com', TO_DATE('1988-06-25', 'YYYY-MM-DD'), 'M', 'ENTJ', '인천시 남구 202번지', 1, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
values ('user5', 'password5', '강서연','이쁘니서연', '777-888-9999', 'user5@example.com', TO_DATE('1999-04-08', 'YYYY-MM-DD'), 'F', 'INFJ', '광주시 동구 303번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
values ('user6', 'password6', '윤동휘','나두동휘야', '222-333-4444', 'user6@example.com', TO_DATE('1994-09-30', 'YYYY-MM-DD'), 'M', 'ESTP', '대전시 서구 404번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
values ('user7', 'password7', '서지원','지1', '999-888-7777', 'user7@example.com', TO_DATE('1987-11-02', 'YYYY-MM-DD'), 'F', 'ENTP', '울산시 중구 505번지', 3, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
values ('user8', 'password8', '김동하','김동하짱짱맨', '555-444-3333', 'user8@example.com', TO_DATE('1991-07-12', 'YYYY-MM-DD'), 'M', 'ISFP', '세종시 606번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
values('user9', 'password9', '임소현','소혀니', '777-666-5555', 'user9@example.com', TO_DATE('1993-02-28', 'YYYY-MM-DD'), 'F', 'ENFJ', '제주시 707번지', 1, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user10', 'password10', '박재현','재현짱짱우', '555-666-7777', 'user10@example.com', TO_DATE('1993-11-18', 'YYYY-MM-DD'), 'M', 'ISTJ', '서울시 중구 1010번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user11', 'password11', '김민수','나도민수야', '888-777-6666', 'user11@example.com', TO_DATE('1990-05-08', 'YYYY-MM-DD'), 'F', 'ENFP', '인천시 동구 1111번지', 1, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user12', 'password12', '정현우','혀어누', '111-222-3333', 'user12@example.com', TO_DATE('1995-10-03', 'YYYY-MM-DD'), 'M', 'ISTJ', '부산시 사하구 1212번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user13', 'password13', '이서영','이서영', '777-888-9999', 'user13@example.com', TO_DATE('1988-08-28', 'YYYY-MM-DD'), 'F', 'INFP', '서울시 송파구 1313번지', 1, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user14', 'password14', '이준호','주노주노', '222-333-4444', 'user14@example.com', TO_DATE('1995-09-05', 'YYYY-MM-DD'), 'M', 'INTP', '경기도 수원시 1414번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user15', 'password15', '장지훈','jihun', '444-555-6666', 'user15@example.com', TO_DATE('1992-06-28', 'YYYY-MM-DD'), 'M', 'ESTJ', '대전시 유성구 1515번지', 2, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user16', 'password16', '김은지','금지', '555-666-7777', 'user16@example.com', TO_DATE('1987-07-20', 'YYYY-MM-DD'), 'F', 'ESFJ', '경북 포항시 1616번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user17', 'password17', '박민재','민쟈', '888-777-6666', 'user17@example.com', TO_DATE('1989-12-15', 'YYYY-MM-DD'), 'M', 'ENTP', '광주시 서구 1717번지', 1, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user18', 'password18', '송민준','보낼송', '111-222-3333', 'user18@example.com', TO_DATE('1995-10-03', 'YYYY-MM-DD'), 'M', 'ISTJ', '서울시 중랑구 1818번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user19', 'password19', '김하영','하영공주', '555-444-3333', 'user19@example.com', TO_DATE('1992-04-12', 'YYYY-MM-DD'), 'F', 'ENFJ', '경기도 고양시 1919번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user20', 'password20', '이준서','준쏘', '777-888-9999', 'user20@example.com', TO_DATE('1988-10-15', 'YYYY-MM-DD'), 'M', 'ISFJ', '인천시 연수구 2020번지', 1, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user21', 'password21', '박지윤','지유니맨', '888-777-6666', 'user21@example.com', TO_DATE('1991-07-22', 'YYYY-MM-DD'), 'F', 'ISTP', '서울시 강서구 2121번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user22', 'password22', '이민우','미누미누', '111-222-3333', 'user22@example.com', TO_DATE('1993-09-05', 'YYYY-MM-DD'), 'M', 'ESFP', '경기도 수원시 2222번지', 1, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user23', 'password23', '김하진','하지니', '555-666-7777', 'user23@example.com', TO_DATE('1990-12-28', 'YYYY-MM-DD'), 'F', 'INTJ', '대전시 서구 2323번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user24', 'password24', '정승우','승우얌', '888-777-6666', 'user24@example.com', TO_DATE('1991-03-10', 'YYYY-MM-DD'), 'M', 'ENFP', '서울시 동작구 2424번지', 1, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user25', 'password25', '이아름','아르미', '111-222-3333', 'user25@example.com', TO_DATE('1996-02-18', 'YYYY-MM-DD'), 'F', 'ISFP', '경기도 용인시 2525번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user26', 'password26', '김재희','재히', '555-666-7777', 'user26@example.com', TO_DATE('1988-07-20', 'YYYY-MM-DD'), 'M', 'ENTJ', '대구시 북구 2626번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user27', 'password27', '신민지','신민지이', '888-777-6666', 'user27@example.com', TO_DATE('1989-11-15', 'YYYY-MM-DD'), 'F', 'INFJ', '서울시 양천구 2727번지', 1, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user28', 'password28', '장태준','장태준회사', '111-222-3333', 'user28@example.com', TO_DATE('1994-10-03', 'YYYY-MM-DD'), 'M', 'ISTP', '경기도 부천시 2828번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user29', 'password29', '한승민','스응미니', '555-666-7777', 'user29@example.com', TO_DATE('1993-09-05', 'YYYY-MM-DD'), 'M', 'ESFJ', '대전시 중구 2929번지', 1, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);
insert into member (member_id, password, name, nickname, phone_no, email, birthday, gender, mbti, address, report_count, enroll_date, withdrawal_date, password_change_date, last_login_date, status, member_role)
VALUES ('user30', 'password30', '이민재','2민재', '888-777-6666', 'user30@example.com', TO_DATE('1988-12-10', 'YYYY-MM-DD'), 'M', 'ENTP', '서울시 마포구 3030번지', 0, SYSDATE, NULL, SYSDATE, NULL, 'Y',default);

-- 소모임에 가입한 멤버테이블 샘플
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('honggd', 1, SYSDATE, 3, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user1', 2, SYSDATE, 3, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user2', 3, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user3', 4, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user4', 5, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user5', 6, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user6', 7, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user7', 8, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user8', 9, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user9', 1, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user10', 2, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user11', 3, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user12', 4, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user13', 5, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user14', 6, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user15', 7, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user16', 8, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user17', 9, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user18', 1, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user19', 2, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user20', 3, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user21', 4, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user22', 5, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user23', 6, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user24', 7, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user25', 8, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user26', 1, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user27', 2, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user28', 3, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user29', 4, SYSDATE, 0, 1);
INSERT INTO club_member (member_id, club_id, enroll_at, club_member_roll, enroll_count)
VALUES ('user30', 4, SYSDATE, 0, 1);

-- 회원권한 샘플
insert into authority values('admin', 'ADMIN');
insert into authority values('honggd', 'MEMBER');
insert into authority values('user1', 'MEMBER');
insert into authority values('user2', 'MEMBER');
insert into authority values('user3', 'MEMBER');
insert into authority values('user4', 'MEMBER');
insert into authority values('user5', 'MEMBER');
insert into authority values('user6', 'MEMBER');
insert into authority values('user7', 'MEMBER');
insert into authority values('user8', 'MEMBER');
insert into authority values('user9', 'MEMBER');
insert into authority values('user10', 'MEMBER');
insert into authority values('user11', 'MEMBER');
insert into authority values('user12', 'MEMBER');
insert into authority values('user13', 'MEMBER');
insert into authority values('user14', 'MEMBER');
insert into authority values('user15', 'MEMBER');
insert into authority values('user16', 'MEMBER');
insert into authority values('user17', 'MEMBER');
insert into authority values('user18', 'MEMBER');
insert into authority values('user19', 'MEMBER');
insert into authority values('user20', 'MEMBER');
insert into authority values('user21', 'MEMBER');
insert into authority values('user22', 'MEMBER');
insert into authority values('user23', 'MEMBER');
insert into authority values('user24', 'MEMBER');
insert into authority values('user25', 'MEMBER');
insert into authority values('user26', 'MEMBER');
insert into authority values('user27', 'MEMBER');
insert into authority values('user28', 'MEMBER');
insert into authority values('user29', 'MEMBER');
insert into authority values('user30', 'MEMBER');

-- 소모임 신고 샘플데이터
insert into club_report (id, club_id, reason, reporter, created_at)
values(seq_club_report_id.nextval, 2, '예술예술 예술이', 'user1', default);
insert into club_report (id, club_id, reason, reporter, created_at)
values(seq_club_report_id.nextval, 3, '저희 비밀정보를 빼갔습니다', 'honggd', default);
insert into club_report (id, club_id, reason, reporter, created_at)
values(seq_club_report_id.nextval, 3, '저작권 표시도 없이 공유 하고 있네요', 'user2', default);
insert into club_report (id, club_id, reason, reporter, created_at)
values(seq_club_report_id.nextval, 6, '환경오염 발생시킴', 'user3', default);

--회원 관심사 샘플
insert into Member_interest values('honggd','운동/스포츠');
insert into Member_interest values('honggd','차/오토바이');
insert into Member_interest values('user1','공연/축제');
insert into Member_interest values('user1','게임/오락');
insert into Member_interest values('user2','자유주제');
insert into Member_interest values('user2','사진/영상');
insert into Member_interest values('user3','인문학/독서');
insert into Member_interest values('user3','업종/직무');
insert into Member_interest values('user3','야구관람');
insert into Member_interest values('user4','음악/악기');
insert into Member_interest values('user4','업종/직무');
insert into Member_interest values('user5','봉사활동');
insert into Member_interest values('user5','언어/회화');
insert into Member_interest values('user5','공연/축제');
insert into Member_interest values('user6','요리/제조');
insert into Member_interest values('user6','음악/악기');
insert into Member_interest values('user7','여행');
insert into Member_interest values('user7','자유주제');
insert into Member_interest values('user8','사교/인맥');
insert into Member_interest values('user8','애완동물');
insert into Member_interest values('user9','운동/스포츠');
insert into Member_interest values('user9','공예/만들기');
insert into Member_interest values('user10','공연/축제');
insert into Member_interest values('user10','댄스/무용');
insert into Member_interest values('user11','자유주제');
insert into Member_interest values('user12','인문학/독서');
insert into Member_interest values('user13','음악/악기');
insert into Member_interest values('user14','봉사활동');
insert into Member_interest values('user15','요리/제조');
insert into Member_interest values('user16','여행');
insert into Member_interest values('user16','야구관람');
insert into Member_interest values('user17','사교/인맥');
insert into Member_interest values('user18','운동/스포츠');
insert into Member_interest values('user19','공연/축제');
insert into Member_interest values('user20','자유주제');
insert into Member_interest values('user21','인문학/독서');
insert into Member_interest values('user21','애완동물');
insert into Member_interest values('user22','음악/악기');
insert into Member_interest values('user23','봉사활동');
insert into Member_interest values('user24','요리/제조');
insert into Member_interest values('user24','애완동물');
insert into Member_interest values('user25','여행');
insert into Member_interest values('user26','운동/스포츠');
insert into Member_interest values('user27','공연/죽제');
insert into Member_interest values('user28','자유주제');
insert into Member_interest values('user29','인문학/독서');
insert into Member_interest values('user30','인문학/독서');
insert into Member_interest values('user30','요리/제조');

-- 활동지역 샘플
insert into activity_area values('honggd',1,2,3);
insert into activity_area values('user1',6,5,3);
insert into activity_area values('user2',11,12,13);
insert into activity_area values('user3',3,0,0);
insert into activity_area values('user4',14,default,default);
insert into activity_area values('user5',19,default,default);
insert into activity_area values('user6',17,default,default);
insert into activity_area values('user7',22,23,default);
insert into activity_area values('user8',31,32,default);
insert into activity_area values('user9',41,42,default);
insert into activity_area values('user10',11,12,default);
insert into activity_area values('user11',11,22,33);
insert into activity_area values('user12',1,default,default);
insert into activity_area values('user13',33,32,default);
insert into activity_area values('user14',11,default,default);
insert into activity_area values('user15',10,20,30);
insert into activity_area values('user16',11,default,default);
insert into activity_area values('user17',45,default,default);
insert into activity_area values('user18',77,default,default);
insert into activity_area values('user19',81,82,default);
insert into activity_area values('user20',91,92,default);
insert into activity_area values('user21',65,66,default);
insert into activity_area values('user22',1,default,default);
insert into activity_area values('user23',15,default,default);
insert into activity_area values('user24',71,72,default);
insert into activity_area values('user25',74,75,default);
insert into activity_area values('user26',69,70,default);
insert into activity_area values('user27',56,52,default);
insert into activity_area values('user28',41,42,default);
insert into activity_area values('user29',31,52,default);
insert into activity_area values('user30',56,58,60);

-- 소모임 가입신청 샘플데이터
insert into club_apply (club_id, member_id, answer)
values(1, 'user1', '축구, 농구, 배구 좋아합니다');
insert into club_apply (club_id, member_id, answer)
values(1, 'user2', '전 축구 좋아합니다!');
insert into club_apply (club_id, member_id, answer)
values(2, 'user3', '예술이라고 하면 다 좋죠');
insert into club_apply (club_id, member_id, answer)
values(3, 'user4', '저 자바 조금 다룰 줄 압니다');
insert into club_apply (club_id, member_id, answer)
values(4, 'user5', '사랑은 어디로 가는가');
insert into club_apply (club_id, member_id, answer)
values(5, 'user6', '제가 좋아하는 음악의 장르는 힙합입니다.');
insert into club_apply (club_id, member_id, answer)
values(5, 'user7', '전 발라드 좋아해요');
insert into club_apply (club_id, member_id, answer)
values(6, 'user8', '카페에서 플라스틱이 아닌 개인 텀블러를 이용하고 있습니다');
insert into club_apply (club_id, member_id, answer)
values(7, 'user9', '된장찌개를 좋아해~~ 김치찌개를 좋아해~~');
insert into club_apply (club_id, member_id, answer)
values(8, 'user10', '홍콩이 야경이 진짜 멋있더라구요 기억에 남아요!');

-- 회원신고 샘플
insert into Member_report values(1,'honggd','user1','너무이상한 말을 합니다.',sysdate,default,default);
insert into Member_report values(2,'honggd','user4','그냥짜증나요.',sysdate,default,default);

-- 회원 좋아요 샘플
insert into member_like values(1,'honggd','user1',sysdate);
insert into member_like values(2,'honggd','user2',sysdate);

-- 소모임 일정 샘플
INSERT INTO club_schedule (schedule_id, club_id, title, start_date, end_date, expence, capacity, alarm_date, status)
VALUES (1, 1, '두근두근 축구데이트', TO_DATE('2023-08-20', 'YYYY-MM-DD'), TO_DATE('2023-08-20', 'YYYY-MM-DD'), 5000, 10, TO_DATE('2023-08-18', 'YYYY-MM-DD'), 'Y');
INSERT INTO club_schedule (schedule_id, club_id, title, start_date, end_date, expence, capacity, alarm_date, status)
VALUES (2, 1, '두근두근 농구데이트', TO_DATE('2023-09-05', 'YYYY-MM-DD'), TO_DATE('2023-09-05', 'YYYY-MM-DD'), 3000, 15, TO_DATE('2023-09-02', 'YYYY-MM-DD'), 'Y');
INSERT INTO club_schedule (schedule_id, club_id, title, start_date, end_date, expence, capacity, alarm_date, status)
VALUES (3, 1, '신나는 볼링데이트', TO_DATE('2023-09-15', 'YYYY-MM-DD'), TO_DATE('2023-09-17', 'YYYY-MM-DD'), 0, 10, TO_DATE('2023-09-10', 'YYYY-MM-DD'), 'Y');

-- 소모임 일정 참가회원 샘플
INSERT INTO club_schedule_enroll_member (member_id, club_id, schedule_id)
VALUES ('honggd', 1, 1);
INSERT INTO club_schedule_enroll_member (member_id, club_id, schedule_id)
VALUES ('user9', 1, 1);
INSERT INTO club_schedule_enroll_member (member_id, club_id, schedule_id)
VALUES ('user9', 1, 2);
INSERT INTO club_schedule_enroll_member (member_id, club_id, schedule_id)
VALUES ('user18', 1, 3);

-- 소모임 일정 장소 샘플
INSERT INTO club_schedule_place (id, schedule_id, name, address, sequence, start_time)
VALUES (1, 1, '강남 축구장', '서울시 강남구', 1, TO_DATE('2023-08-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO club_schedule_place (id, schedule_id, name, address, sequence, start_time)
VALUES (2, 2, '마포 농구장 B', '서울시 마포구', 2, TO_DATE('2023-09-05 19:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO club_schedule_place (id, schedule_id, name, address, sequence, start_time)
VALUES (3, 3, '관악 볼링장', '서울시 관악구', 3, TO_DATE('2023-09-15 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- 소모임 게시판 샘플
INSERT INTO club_board (board_id, club_id, writer, title, content, type, like_count)
VALUES (1, 1, 'honggd', '동아리 가입 안내', '안녕하세요! 우리 동아리에 가입하신 여러분을 환영합니다. 첫 모임은 다음 주 토요일에 있을 예정입니다. 함께 즐거운 시간 보내요!', 4, 15);
INSERT INTO club_board (board_id, club_id, writer, title, content, type, like_count)
VALUES (2, 1, 'user9', '음악 동호회 공연 안내', '안녕하세요, 음악 동호회입니다. 다음 달에 예정된 공연에 대한 정보를 공유합니다. 많은 관심 부탁드립니다!', 1, 8);
INSERT INTO club_board (board_id, club_id, writer, title, content, type, like_count)
VALUES (3, 1, 'user9', '오늘의 운동 대회', '모두들 오늘 운동 대회에서 최선을 다해주셔서 감사합니다. 정말 즐거운 시간이었습니다!', 2, 23);
INSERT INTO club_board (board_id, club_id, writer, title, content, type, like_count)
VALUES (4, 1, 'user18', '가입 인사드립니다', '안녕하세요! 이번에 가입한 신규 회원입니다. 모두 잘 부탁드립니다~', 3, 5);
INSERT INTO club_board (board_id, club_id, writer, title, content, type, like_count)
VALUES (5, 1, 'user26', '자유롭게 이야기 나눠요', '어떤 주제든 자유롭게 이야기 나누는 공간입니다. 새로운 음악 추천해주세요!', 0, 10);
INSERT INTO club_board (board_id, club_id, writer, title, content, type, like_count)
VALUES (6, 2, 'user1', '공지사항: 동아리 활동 일정 변경', '안녕하세요, 동아리 활동 일정이 변경되었습니다. 확인 부탁드립니다.', 4, 32);
INSERT INTO club_board (board_id, club_id, writer, title, content, type, like_count)
VALUES (7, 2, 'user10', '오늘의 모임 후기', '오늘의 모임이 정말 재미있었어요! 같이 참여한 분들 감사합니다~', 2, 18);
INSERT INTO club_board (board_id, club_id, writer, title, content, type, like_count)
VALUES (8, 2, 'user27', '자유롭게 토론해요', '새로운 주제에 대한 토론을 자유롭게 나누는 공간입니다. 의견을 나눠주세요!', 0, 7);
INSERT INTO club_board (board_id, club_id, writer, title, content, type, like_count)
VALUES (9, 2, 'user19', '회원들과 함께하는 캠프', '다음 주 캠프에 참가하실 분들은 미리 연락 부탁드립니다. 준비물 안내 드립니다!', 1, 11);
INSERT INTO club_board (board_id, club_id, writer, title, content, type, like_count)
VALUES (10, 2, 'user27', '안녕하세요!', '안녕하세요! 모든 회원분들께 즐거운 하루 되세요~', 3, 3);

-- 댓글 샘플
INSERT INTO board_comment (comment_id, board_id, writer, comment_ref, content, comment_level)
VALUES (1, 1, 'user9', NULL, '가입하려면 어떻게 해야하나요?', 1);
INSERT INTO board_comment (comment_id, board_id, writer, comment_ref, content, comment_level)
VALUES (2, 1, 'user18', NULL, '음악 공연 날짜가 궁금합니다.', 1);
INSERT INTO board_comment (comment_id, board_id, writer, comment_ref, content, comment_level)
VALUES (3, 1, 'user26', NULL, '오늘 운동 대회 재밌었어요!', 1);
INSERT INTO board_comment (comment_id, board_id, writer, comment_ref, content, comment_level)
VALUES (4, 1, 'user26', 1, '가입 방법은 홈페이지에서 신청하면 됩니다.', 2);
INSERT INTO board_comment (comment_id, board_id, writer, comment_ref, content, comment_level)
VALUES (5, 1, 'user26', 2, '음악 공연은 다음 달 10일에 있을 예정입니다.', 2);
INSERT INTO board_comment (comment_id, board_id, writer, comment_ref, content, comment_level)
VALUES (6, 1, 'user26', 3, '운동 대회에서 여러분과 함께해서 기뻤습니다!', 2);
INSERT INTO board_comment (comment_id, board_id, writer, comment_ref, content, comment_level)
VALUES (7, 2, 'user19', NULL, '환영합니다! 함께 즐거운 시간 보내요~', 1);
INSERT INTO board_comment (comment_id, board_id, writer, comment_ref, content, comment_level)
VALUES (8, 2, 'user27', NULL, '오늘의 주제는 뭐에요?', 1);
INSERT INTO board_comment (comment_id, board_id, writer, comment_ref, content, comment_level)
VALUES (9, 2, 'user10', NULL, '일정 변경에 대해 추가 정보 부탁드립니다.', 1);
INSERT INTO board_comment (comment_id, board_id, writer, comment_ref, content, comment_level)
VALUES (10, 2, 'user1', NULL, '오늘 모임 정말 즐거웠어요!', 1);


commit;

select 
	  	c.*,
        cp.club_id profile_club_id,
        original_filename,
        renamed_filename,
        cp.created_at profile_created_at
from 
	  	club c left join club_profile cp
            on c.club_id = cp.club_id
where 
	  	club_name like '%클럽%';


select * from club_apply;








