
-- tables
-- user

-- delete from user;
insert into user (name, username, password) values 
("John Doe", "select_username", "03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4"),
("Hopkin Ganger", "programmer_pro_max", "03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4"),
("Sudeep", "hello_world", "03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4"),
("Reddy", "reddy_anna", "03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4"),
("Ram Murthy", "gg_01", "03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4");

-- follow
-- -- 1 => 2
-- -- 1 => 3
-- -- 1 => 4

-- -- 2 => 1
-- -- 2 => 3

-- -- 3 => 1
-- -- 3 => 2
-- -- 3 => 5

-- -- 4 => 1

-- -- 5 => 1
-- -- 5 => 2
-- -- 5 => 3
-- -- 5 => 4
-- delete from follow;
insert into follow (from_id, to_id, is_accepted) values 
(1,2,1),
(1,3,0),
(1,4,0),
(2,1,1),
(2,3,1),
(3,1,1),
(3,2,1),
(3,5,1),
(4,1,1),
(5,1,1),
(5,2,1),
(5,3,1),
(5,4,0);

-- post
-- delete from post;
insert into post (title, content, user_id, parent_id) values 
("Function get posts in go", "func getPosts(c *gin.Context) { println('GET POSTS') c.IndentedJSON(http.StatusOK, posts)}", 1, null),
("Function in go", "func getPosts(c *gin.Context) { println('GET POSTS') c.IndentedJSON(http.StatusOK, posts)}", 1, null),
("Help with the error", "Error: Index out of range", 1, null),
("Hello world in python", "print('Hello world')", 2, null),
("Hello world in js", "console.log('Hello world')", 2, null),
("Query to get users", "select * from user;", 2, null),
("Hello world in go", "func main() { println('Hello world') }", 3, null);

-- post::comments
insert into post (title, content, user_id, parent_id) values 
("Re: Help with the error", "Please check the index you're accessing in the array!", 3, 3),
("Re: Hello world in go", "you could also use the fmt package as > fmt.PrintLn('Hello World')", 5, 7);

-- hashtag
-- delete from hashtag;
insert into hashtag (tag) values
("c"),
("c++"),
("go"),
("postgres"),
("mysql"),
("python"),
("firebase"),
("js"),
("rust");

-- saved_post
-- -- posts => (post_id, usr) => (1, 1)  (2, 1) (3, 1) (4, 2) (5, 2) (6, 2) (7, 3);
-- -- 1 => 2
-- -- 1 => 3 0
-- -- 1 => 4 0

-- -- 2 => 1
-- -- 2 => 3

-- -- 3 => 1
-- -- 3 => 2
-- -- 3 => 5

-- -- 4 => 1

-- -- 5 => 1
-- -- 5 => 2
-- -- 5 => 3
-- -- 5 => 4 0
insert into saved_post (user_id, post_id) values
(5, 1),
(5, 3),
(1, 4),
(3, 4),
(3, 5);

-- user_interest
-- delete from user_interest;
insert into user_interest (interest, user_id) values
("c", 1),
("c++", 1),
("go", 2),
("rust", 2),
("postgres", 3),
("mysql", 3),
("go", 4),
("python", 4),
("js", 4),
("rust", 5),
("firebase", 5),
("mysql", 5),
("postgres", 5);

-- post_tag
insert into post_tag (tag, post_id) values
("go", 1),
("go", 2),
("python", 3),
("python", 4),
("js", 5),
("mysql", 6),
("go", 7);

-- upvote
-- -- posts => (post_id, usr) => (1, 1)  (2, 1) (3, 1) (4, 2) (5, 2) (6, 2) (7, 3);
-- -- 1 => 2
-- -- 1 => 3 0
-- -- 1 => 4 0

-- -- 2 => 1
-- -- 2 => 3

-- -- 3 => 1
-- -- 3 => 2
-- -- 3 => 5

-- -- 4 => 1

-- -- 5 => 1
-- -- 5 => 2
-- -- 5 => 3
-- -- 5 => 4 0
insert into upvote (user_id, post_id) values
(1, 1),
(2, 1),
(5, 1),
(5, 2),
(5, 3),
(3, 3),
(1, 4),
(1, 5),
(2, 7);

 