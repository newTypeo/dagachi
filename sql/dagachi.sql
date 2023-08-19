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
--DROP TABLE "ACTIVITY_AREA" CASCADE CONSTR AINTS;
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
	password	varchar2(30)	not null,
	name	varchar2(20)	not null,
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
	status char(1) default 'Y'
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
	comment_ref	number	not null,
	content	varchar2(1000)	not null,
	created_at	date default sysdate,
	status char(1) default 'Y'
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


------------------------------------------------- 쿼리문 -------------------------------------------------

-- 1
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (1, '스포츠 열정 클럽', '강남구', '스포츠', TO_DATE('2023-08-01', 'YYYY-MM-DD'), 0, '우리는 다양한 종목의 스포츠를 즐기고 관찰하는 스포츠 애호가들의 모임입니다.', '가장 좋아하는 스포츠는 무엇인가요?', 'sportsclub.com');

-- 2
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (2, '예술 창작 모임', '홍대', '예술', TO_DATE('2023-07-15', 'YYYY-MM-DD'), 0, '회화, 드로잉, 조각 등을 통해 창의력을 표현하는 공간입니다.', '어떤 종류의 예술 활동을 좋아하시나요?', 'artisticcreations.com');

-- 3
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (3, '테크 이노베이터스', '서초구', '기술', TO_DATE('2023-08-10', 'YYYY-MM-DD'), 0, '기술의 최신 동향을 탐구하고 흥미로운 프로젝트에 참여하는 곳입니다.', '어떤 프로그래밍 언어를 다룰 수 있나요?', 'techinnovators.com');

-- 4
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (4, '책벌레 모임', '종로구', '문학', TO_DATE('2023-07-30', 'YYYY-MM-DD'), 0, '책의 세계에 몰입하고 생각을 나누는 문학 토론의 장소입니다.', '최근에 읽은 좋은 책은 무엇인가요?', 'bookwormssociety.com');

-- 5
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (5, '음악 감상 클럽', '이태원', '음악', TO_DATE('2023-08-05', 'YYYY-MM-DD'), 0, '음악 애호가들이 좋아하는 노래, 악기, 작곡을 나누는 공간입니다.', '가장 좋아하는 음악 장르는 무엇인가요?', 'musicvibesclub.com');

-- 6
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (6, '그린 어스 소사이어티', '강서구', '환경', TO_DATE('2023-08-12', 'YYYY-MM-DD'), 0, '환경 인식을 높이고 지구를 보호하기 위한 활동을 공유하는 모임입니다.', '환경을 위해 실천하는 습관이 있나요?', 'greenearthsociety.com');

-- 7
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (7, '요리 열풍 클럽', '마포구', '음식', TO_DATE('2023-08-08', 'YYYY-MM-DD'), 0, '음식을 좋아하고 요리하는 열정을 공유하며 미식 토론을 즐기는 곳입니다.', '당신의 대표 요리는 무엇인가요?', 'culinarydelights.com');

-- 8
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (8, '모험을 찾아서', '용산구', '여행', TO_DATE('2023-07-20', 'YYYY-MM-DD'), 0, '짜릿한 모험을 떠나고 새로운 여행지를 탐험하며 여행 이야기를 공유하는 곳입니다.', '지금까지 다녀온 여행 중 가장 기억에 남는 곳은 어디인가요?', 'adventureseekers.com');

-- 9
INSERT INTO club (club_id, club_name, activity_area, category, last_activity_date, report_count, introduce, enroll_question, domain)
VALUES (9, '건강과 웰빙 컬렉티브', '성동구', '건강', TO_DATE('2023-08-03', 'YYYY-MM-DD'), 0, '운동 활동, 명상, 건강한 생활에 대한 토론을 통해 신체와 마음의 웰빙을 촉진하는 공간입니다.', '건강을 어떻게 관리하고 계시나요?', 'healthwellnesscollective.com');








