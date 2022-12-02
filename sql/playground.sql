-- joins ---------------------------------------------------------------------------------------------------
-- INNER AND LEFT JOIN : get posts and upvotes
select p.id, u.username, count(upvote.user_id) as upvotes
from post as p
join user as u on p.user_id = u.id
left join upvote on p.id = upvote.post_id
where 
(
    p.user_id in (
        select to_id from follow where from_id=4
    )
    or
    p.user_id = 4
)
group by p.id
order by p.id desc;

-- LEFT JOIN : get comment count for post
select p.id, count(pc.parent_id) as comment_count
from post p 
left join post pc on p.id = pc.parent_id
group by p.id
order by p.id desc;

-- LEFT JOIN : get tag of post
select p.id, t.tag
from post p 
left join post_tag t on p.id = t.post_id
order by p.id desc;

-- INNER JOIN : get post by tag
select p.id, t.tag
from post p
inner join post_tag t on p.id = t.post_id
where t.tag = "go";

-- RIGHT JOIN : all posts with no upvotes
select p.*, count(u.post_id) as no_of_upvotes
from upvote u
right join post p on u.post_id = p.id
group by p.id
having no_of_upvotes=0;


-- NATURAL JOIN : username, post and date difference since post was made
select u.username, p.title, DATEDIFF(CURRENT_TIMESTAMP(), p.created_at) as date_since_post from user u, post p
where u.id = p.user_id;


-- aggregate ---------------------------------------------------------------------------------------------------

-- MAX and COUNT : Post with max number of upvotes
select id as post_id, max(cnt_upvotes) as max_upvotes from (
    select p.id, count(u.post_id) as cnt_upvotes
    from upvote u
    right join post p on u.post_id = p.id
    group by p.id
) as COUNT_UPVOTES;

-- MIN : Post with minimum number of saves

select id as post_id, min(cnt_saves) as min_saves from (
    select p.id, count(sp.post_id) as cnt_saves
    from saved_post sp
    right join post p on sp.post_id = p.id
    group by p.id
) as COUNT_SAVES;

-- COUNT : Ratio of upvotes per tag
select pt.tag, count(*)/upvote_cnts as ratio, count(*) as upvotes, upvote_cnts 
from upvote u, post_tag pt, (select count(*) as upvote_cnts from upvote) as cnt_sum 
where pt.post_id = u.post_id 
group by pt.tag;

-- SUM : Total length of content posted by users
 select user_id, sum(length(content)) as total_content_length from post group by user_id;



-- set operations (UNION, INTERSECT, SET DIFFERENCE, UNIONALL) -----------------------------------------------------------

-- -- UNION : 

-- -- INTERSECT : posts that are saved

select id from post where id in (
    select post_id from saved_post
);

select id from post
INTERSECT
select post_id from saved_post;


-- -- MINUS : hashtags that havent been used in posts
select tag from hashtag
MINUS
select tag from post_tag;

select tag from hashtag
where tag not in (
    select tag from post_tag
);

-- -- UNIONALL : count of all the hashtags in user_interest and post_tags
select interest, count(interest) from (
    select interest from user_interest
    UNION ALL
    select tag from post_tag
) as UNION_TAGS
group by interest;

-- -- COMPARISON TO UNION
select interest, count(interest) from (
    select interest from user_interest
    UNION
    select tag from post_tag
) as UNION_TAGS
group by interest;


-- function ---------------------------------------------------------------------------------------------------

drop function if exists get_post_age;

delimiter $$ 

create function get_post_age(
    post_created_at datetime
)
returns varchar(300)
deterministic
begin
    DECLARE currentDate DATE;
    DECLARE age varchar(200);
    select current_date() into currentDate;
    select concat(
        "Date diff : ",
        DATEDIFF(current_date(), post_created_at), 
        " days || ",
        "Time diff : ",
        TIMEDIFF(TIME(post_created_at), TIME(current_date()))
    ) into age;
    RETURN age;
end $$

delimiter ;

select get_post_age(created_at) as post_age from post;

-- select 
-- concat(YEAR(current_date()) - YEAR(created_at), " years ", MONTH(current_date()) - MONTH(created_at), " months ", day(current_date()) - day(created_at)," days")
-- from post;


-- procedure ---------------------------------------------------------------------------------------------------

drop procedure if exists user_details;
delimiter $$
create procedure user_details(
    IN userID integer
)
begin
    select concat("User Details") as ___;
    select * from user where id=userID;
    select concat("Upvotes") as ___;
    select * from upvote where user_id=userID;
    select concat("Posts/Comments") as ___;
    select * from post where user_id=userID;
end $$
delimiter ;
call user_details(1);

drop procedure if exists delete_user;
delimiter $$
create procedure delete_user(
    IN userID integer
)
begin
    delete from user where id=userID;
end $$
delimiter ;



-- trigger ---------------------------------------------------------------------------------------------------


-- TRIGGER :  user can only upvote once
drop trigger if exists user_upvote_once;
delimiter $$
create trigger user_upvote_once
before insert
on upvote for each row
begin
    declare count_upvote int(10);
    declare error_message varchar(200);

    set error_message = "Cannot upvote twice!";

    select count(*) into count_upvote from upvote where (user_id=new.user_id and post_id=new.post_id) group by user_id, post_id;

    if count_upvote = 1 then
        signal SQLSTATE "45000"
        set message_text=error_message;
    end if;
end $$

delimiter ;


-- TRIGGER : user cannot upvote a post which is from a user they dont follow

drop trigger if exists user_upvote_post_check;

delimiter $$
create trigger user_upvote_post_check
before insert
on upvote for each row
begin
    declare count int(10);
    declare error_message varchar(400);

    set error_message = "Cannot upvote the post as the post has been made by a user you dont follow!";

    -- get count of posts which are posted
    -- by users that current user follows
    -- or is a self post
    select count(*) into count from post
    where (
        (
            user_id in (
            select to_id from follow where (from_id=new.user_id and is_accepted=1)
            )
            or user_id=new.user_id
        )
        and id = new.post_id
    );
    if count = 0 then
        signal SQLSTATE "45000"
        set message_text=error_message;
    end if;
end $$

delimiter ;

insert into upvote (user_id, post_id) values (1,9);


select * from post 
where (
    (
        user_id in (
        select to_id from follow where from_id=1
        )
        or user_id=1
    )
    and id = 9
);

-- cursor ---------------------------------------------------------------------------------------------------

-- CURSOR : get a list of all usernames
drop procedure if exists usernameList;
delimiter $$
create procedure usernameList (
    INOUT usernameList varchar(5000)
)
begin
    declare var_username varchar(200);
    declare var_check_row integer default 0;

    declare curUser cursor for select username from user;

    declare continue handler for not found set var_check_row = 1;

    open curUser;

    loopOverUsers: loop
        fetch curUser into var_username;
        -- select var_username;
        if var_check_row=1 THEN
            leave loopOverUsers;
        end if;
        select concat(usernameList, " ; ", var_username) into usernameList;
    end loop loopOverUsers;
    close curUser;
end $$

delimiter ;

set @ulist = "";
call usernameList(@ulist);
select @ulist;

-- ---------------------------------------------------------------------------------------------------

update post
set title = "new post 1234", content="print('this is a new posrt 1231413431')"
where id=12 and user_id=4;