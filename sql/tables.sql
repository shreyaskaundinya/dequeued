-- cleanup
drop database if exists dequeued_409;

-- create
create database dequeued_409;

-- use
use dequeued_409;


-- user
create table user (
    id int primary key AUTO_INCREMENT,
    name varchar(200) not null,
    username varchar(200) not null unique,
    password varchar(200) not null,
    created_at timestamp default CURRENT_TIMESTAMP()
);

-- follow
create table follow (
    from_id int,
    to_id int,
    is_accepted boolean,
    created_at timestamp default CURRENT_TIMESTAMP(),
    foreign key (from_id) references user(id) on delete CASCADE,
    foreign key (to_id) references user(id) on delete CASCADE
);

-- post
create table post (
    id int primary key AUTO_INCREMENT,
    title varchar(200) not null,
    content varchar(500) not null,
    user_id int,
    parent_id int,
    created_at timestamp default CURRENT_TIMESTAMP(),
    foreign key (user_id) references user(id) on delete CASCADE
);

-- alter post to add recursive relation
alter table post add foreign key(parent_id) references post(id);

-- hashtag
create table hashtag (
    tag varchar(100) primary key,
    created_at timestamp default CURRENT_TIMESTAMP()
);

-- saved_post
create table saved_post (
    user_id int,
    post_id int,
    created_at timestamp default CURRENT_TIMESTAMP(),
    foreign key (user_id) references user(id) on delete CASCADE,
    foreign key (post_id) references post(id) on delete CASCADE
);

-- user_interest
create table user_interest (
    interest varchar(100),
    user_id int,
    foreign key (user_id) references user(id) on delete CASCADE,
    foreign key (interest) references hashtag(tag) on delete CASCADE
);

-- post_tag
create table post_tag (
    tag varchar(100),
    post_id int,
    foreign key (post_id) references post(id) on delete CASCADE,
    foreign key (tag) references hashtag(tag) on delete CASCADE
);

-- upvote
create table upvote (
    user_id int,
    post_id int,
    created_at timestamp default CURRENT_TIMESTAMP(),
    foreign key (user_id) references user(id) on delete CASCADE,
    foreign key (post_id) references post(id) on delete CASCADE
);