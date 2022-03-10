DROP TABLE  IF EXISTS video_view;
DROP TABLE  IF EXISTS video_like;
DROP TABLE  IF EXISTS video_comment_like;
DROP TABLE  IF EXISTS video_comment;
DROP TABLE  IF EXISTS video;
DROP TABLE  IF EXISTS channel_subscriber;
DROP TABLE  IF EXISTS youtube_channel;
DROP TABLE  IF EXISTS youtube_account;
DROP TABLE  IF EXISTS user_profile;

CREATE TABLE IF NOT EXISTS user_profile (
   id BIGSERIAL PRIMARY KEY,
   first_name TEXT NOT NULL,
   last_name TEXT NOT NULL,
   email TEXT UNIQUE NOT NULL,
   gender TEXT CHECK(gender IN ('MALE', 'FEMALE')) NOT NULL,
   created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS youtube_account (
   id BIGINT PRIMARY KEY REFERENCES user_profile(id),
   created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS youtube_channel (
   id BIGSERIAL PRIMARY KEY,
   youtube_account_id BIGINT NOT NULL REFERENCES youtube_account(id),
   channel_name TEXT NOT NULL UNIQUE,
   created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS channel_subscriber (
   youtube_account_id BIGINT REFERENCES youtube_account(id),
   youtube_channel_id BIGINT REFERENCES youtube_channel(id),
   created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
   PRIMARY KEY (youtube_account_id, youtube_channel_id)
);


CREATE TABLE IF NOT EXISTS video (
    id BIGSERIAL PRIMARY KEY,
    youtube_channel_id BIGINT REFERENCES youtube_channel(id),
    title TEXT NOT NULL,
    url TEXT NOT NULL,
    description TEXT NOT NULL,
    category TEXT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS video_comment (
    id BIGSERIAL PRIMARY KEY,
    youtube_account_id BIGINT REFERENCES youtube_account(id),
    video_id BIGINT REFERENCES video(id),
    comment TEXT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL

);

CREATE TABLE IF NOT EXISTS video_comment_like (
    youtube_account_id BIGINT REFERENCES youtube_account(id),
    video_comment_id BIGINT REFERENCES video_comment(id),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
   PRIMARY KEY (youtube_account_id, video_comment_id)
);

CREATE TABLE IF NOT EXISTS video_like (
    youtube_account_id BIGINT REFERENCES youtube_account(id),
    video_id BIGINT REFERENCES video(id),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
   PRIMARY KEY (youtube_account_id, video_id)
);

CREATE TABLE IF NOT EXISTS video_view (
    id BIGSERIAL PRIMARY KEY,
    youtube_account_id BIGINT REFERENCES youtube_account(id),
    video_id BIGINT REFERENCES video(id),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);



-- users
INSERT INTO public.user_profile (id, first_name, last_name, email, gender, created_at)
VALUES (1, 'Kush', 'Trivedi', 'kxt@gmail.com', 'FEMALE', '2020-11-24 23:42:47.000000');

INSERT INTO public.user_profile (id, first_name, last_name, email, gender, created_at)
VALUES (2, 'Sandeep', 'Paul', 'sxp@gmail.com', 'MALE', '2020-11-24 23:42:47.000000');

INSERT INTO public.user_profile (id, first_name, last_name, email, gender, created_at)
VALUES (3, 'Kaushik', 'Jugalkar', 'kxj@gmail.com', 'FEMALE', '2020-11-24 23:42:47.000000');

INSERT INTO public.user_profile (id, first_name, last_name, email, gender, created_at)
VALUES (4, 'David', 'Ademilua', 'dxa2000@gmail.com', 'MALE', '2020-11-24 23:42:47.000000');

INSERT INTO public.user_profile (id, first_name, last_name, email, gender, created_at)
VALUES (5, 'Harsh', 'Patel', 'hxp@gmail.com', 'MALE', '2020-11-24 23:42:47.000000');

-- accounts
INSERT INTO public.youtube_account (id, created_at)
VALUES (1, '2022-03-05 23:44:36.000000');

INSERT INTO public.youtube_account (id, created_at)
VALUES (2, '2022-03-05 23:00:36.000000');

INSERT INTO public.youtube_account (id, created_at)
VALUES (4, '2022-03-05 10:44:36.000000');

-- youtube channels
INSERT INTO public.youtube_channel (id, youtube_account_id, channel_name, created_at)
VALUES (1, 1, 'Data Science & Engineer Tutorials', '2022-03-06 23:47:05.385073');

INSERT INTO public.youtube_channel (id, youtube_account_id, channel_name, created_at)
VALUES (4, 1, 'Solution Architect & Dev Ops Tutorial', '2022-03-06 23:47:05.385073');

INSERT INTO public.youtube_channel (id, youtube_account_id, channel_name, created_at)
VALUES (2, 2, 'Database Administration Tutorials', '2022-03-06 23:47:50.904706');
INSERT INTO public.youtube_channel (id, youtube_account_id, channel_name, created_at)
VALUES (3, 4, 'Business Intelegence', '2022-03-06 23:47:50.904706');

-- subscribers
INSERT INTO public.channel_subscriber (youtube_account_id, youtube_channel_id, created_at)
VALUES (1, 2, '2022-09-07 22:19:41.000000');
INSERT INTO public.channel_subscriber (youtube_account_id, youtube_channel_id, created_at)
VALUES (1, 3, '2022-09-07 22:19:58.000000');
INSERT INTO public.channel_subscriber (youtube_account_id, youtube_channel_id, created_at)
VALUES (4, 1, '2022-09-07 22:19:58.000000');
INSERT INTO public.channel_subscriber (youtube_account_id, youtube_channel_id, created_at)
VALUES (2, 1, '2022-09-07 22:19:58.000000');

-- video
INSERT INTO public.video (id, youtube_channel_id, title, url, description, category, created_at) VALUES (1, 1, 'A/B Testing with ML Models', 'https://youtube.com/9328982', 'You will learn the best way to take care of your skin', 'People & Vlogs', '2022-03-08 22:30:28.000000');
INSERT INTO public.video (id, youtube_channel_id, title, url, description, category, created_at) VALUES (2, 4, 'AWS EC2 on premises', 'https://youtube.com/932898233', 'Master db design', 'Education', '2022-03-08 22:41:08.000000');
INSERT INTO public.video (id, youtube_channel_id, title, url, description, category, created_at) VALUES (3, 4, 'Advanced Database Normalization', 'https://youtube.com/423432', 'Advanced DB Course', 'Education', '2022-03-08 22:41:10.000000');
INSERT INTO public.video (id, youtube_channel_id, title, url, description, category, created_at) VALUES (4, 2, 'Kanban and Scrum', 'https://youtube.com/432423k', 'Unboxing', 'Tech', '2022-03-08 22:41:10.000000');

-- comments
INSERT INTO public.video_comment (id, youtube_account_id, video_id, comment, created_at) VALUES (1, 4, 1, 'Nice video', '2022-03-09 22:35:08.000000');
INSERT INTO public.video_comment (id, youtube_account_id, video_id, comment, created_at) VALUES (2, 4, 2, 'I loved it.', '2022-03-09 22:35:08.000000');
INSERT INTO public.video_comment (id, youtube_account_id, video_id, comment, created_at) VALUES (3, 4, 3, 'Keep Going', '2022-03-09 22:35:08.000000');
INSERT INTO public.video_comment (id, youtube_account_id, video_id, comment, created_at) VALUES (4, 1, 1, 'Best course', '2022-03-09 22:35:08.000000');
INSERT INTO public.video_comment (id, youtube_account_id, video_id, comment, created_at) VALUES (5, 1, 1, 'Had to comment again. Best course', '2022-03-09 22:35:08.000000');
INSERT INTO public.video_comment (id, youtube_account_id, video_id, comment, created_at) VALUES (6, 2, 1, 'Good stuff', '2022-03-09 22:35:08.000000');
INSERT INTO public.video_comment (id, youtube_account_id, video_id, comment, created_at) VALUES (7, 2, 3, 'I have a question about joins', '2022-03-09 22:35:08.000000');

-- likes to comments
INSERT INTO public.video_comment_like (youtube_account_id, video_comment_id, created_at) VALUES (4, 4, '2022-03-09 22:51:00.000000');
INSERT INTO public.video_comment_like (youtube_account_id, video_comment_id, created_at) VALUES (1, 4, '2022-03-09 22:51:00.000000');
INSERT INTO public.video_comment_like (youtube_account_id, video_comment_id, created_at) VALUES (2, 3, '2022-03-09 22:51:00.000000');
INSERT INTO public.video_comment_like (youtube_account_id, video_comment_id, created_at) VALUES (1, 1, '2022-03-09 22:51:00.000000');
INSERT INTO public.video_comment_like (youtube_account_id, video_comment_id, created_at) VALUES (1, 2, '2022-03-09 22:51:00.000000');

-- likes to videos
INSERT INTO public.video_like (youtube_account_id, video_id, created_at) VALUES (4, 1, '2022-03-09 22:35:38.000000');
INSERT INTO public.video_like (youtube_account_id, video_id, created_at) VALUES (1, 2, '2022-03-09 22:35:38.000000');
INSERT INTO public.video_like (youtube_account_id, video_id, created_at) VALUES (4, 2, '2022-03-09 22:35:38.000000');
INSERT INTO public.video_like (youtube_account_id, video_id, created_at) VALUES (2, 2, '2022-03-09 22:35:38.000000');
INSERT INTO public.video_like (youtube_account_id, video_id, created_at) VALUES (2, 3, '2022-03-09 22:35:38.000000');

-- views
INSERT INTO public.video_view (id, youtube_account_id, video_id, created_at) VALUES (1, 4, 1, '2022-03-09 22:36:07.000000');
INSERT INTO public.video_view (id, youtube_account_id, video_id, created_at) VALUES (2, 4, 3, '2022-03-09 22:36:07.000000');
INSERT INTO public.video_view (id, youtube_account_id, video_id, created_at) VALUES (3, 4, 2, '2022-03-09 22:36:07.000000');
INSERT INTO public.video_view (id, youtube_account_id, video_id, created_at) VALUES (4, 4, 1, '2022-03-09 22:36:07.000000');
INSERT INTO public.video_view (id, youtube_account_id, video_id, created_at) VALUES (5, 4, 1, '2022-03-09 22:36:07.000000');
INSERT INTO public.video_view (id, youtube_account_id, video_id, created_at) VALUES (6, 4, 3, '2022-03-09 22:36:07.000000');
INSERT INTO public.video_view (id, youtube_account_id, video_id, created_at) VALUES (7, null, 1, '2022-03-09 22:36:07.000000');
INSERT INTO public.video_view (id, youtube_account_id, video_id, created_at) VALUES (8, null, 1, '2022-03-09 22:36:07.000000');
INSERT INTO public.video_view (id, youtube_account_id, video_id, created_at) VALUES (9, null, 1, '2022-03-09 22:36:07.000000');
INSERT INTO public.video_view (id, youtube_account_id, video_id, created_at) VALUES (10, null, 1, '2022-03-09 22:36:07.000000');