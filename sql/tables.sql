drop database if exists dequeued_409;
create database dequeued_409;

use dequeued_409;

create table user (
    id int primary key,
    name varchar(200) not null,
    username varchar(200) not null unique,
    password varchar(200) not null,
    created_at timestamp default CURRENT_TIMESTAMP()
);

create table follow (
    from_id int,
    to_id int,
    is_accepted boolean,
    created_at timestamp default CURRENT_TIMESTAMP(),
    foreign key (from_id) references user(id),
    foreign key (to_id) references user(id)
);

create table post (
    id int primary key,
    title varchar(200) not null,
    content varchar(500) not null,
    user_id int,
    parent_id int,
    foreign key (user_id) references user(id)
);

alter table post add foreign key(parent_id) references post(id);

create table hashtag (
    tag varchar(100) primary key,
    created_at timestamp default CURRENT_TIMESTAMP()
);

create table saved_post (
    user_id int,
    post_id int,
    created_at timestamp default CURRENT_TIMESTAMP(),
    foreign key (user_id) references user(id),
    foreign key (post_id) references post(id)
);

create table user_interest (
    interest varchar(100),
    user_id int,
    foreign key (user_id) references user(id),
    foreign key (interest) references hashtag(tag)
);

create table post_tag (
    tag varchar(100),
    post_id int,
    foreign key (post_id) references post(id),
    foreign key (tag) references hashtag(tag)
);

create table upvote (
    user_id int,
    post_id int,
    created_at timestamp default CURRENT_TIMESTAMP(),
    foreign key (user_id) references user(id),
    foreign key (post_id) references post(id)
);