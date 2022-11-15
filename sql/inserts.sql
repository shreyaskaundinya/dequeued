-- tables
-- user

insert into user (id, name, username, password) values 
(1, "User One", "username_cool", ""),
(2, "User Two", "username_username_username_1", ""),
(3, "User Three", "username_1", "");

-- follow
-- post

insert into post (id, title, content, user_id, parent_id) values 
(1, "TITLE 1 | by user 1", "func getPosts(c *gin.Context) { println('GET POSTS') c.IndentedJSON(http.StatusOK, posts)}", 1, null),
(2, "TITLE 2 | by user 2", "func getPosts(c *gin.Context) { println('GET POSTS') c.IndentedJSON(http.StatusOK, posts)}", 2, null),
(3, "TITLE 3 | by user 3", "func getPosts(c *gin.Context) { println('GET POSTS') c.IndentedJSON(http.StatusOK, posts)}", 3, null);

-- hashtag
insert into hashtag (tag) values
("c"),
("c++"),
("go"),
("postgres"),
("mysql"),
("firebase"),
("js"),
("rust");

-- saved_post

-- user_interest
insert into user_interest (interest, user_id) values
("c", 1),
("c++", 1),
("go", 2),
("rust", 2),
("postgres", 3),
("mysql", 3);

-- post_tag
insert into post_tag (tag, post_id) values
("go", 1),
("go", 2),
("go", 3);

-- upvote
