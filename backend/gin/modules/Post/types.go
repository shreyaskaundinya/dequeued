package post

type Post struct {
	ID          int    `json:"id"`
	Title       string `json:"title"`
	Content     string `json:"content"`
	User_ID     int    `json:"user_id"`
	Parent_Post int    `json:"parent_id"`
}

var posts = []Post{
	{
		ID:    1,
		Title: "HELLO WORLD HELLO WORLD HELLO WORLD HELLO WORLD HELLO WORLD HELLO WORLD HELLO WORLD HELLO WORLD",
		Content: `
		func getPosts(c *gin.Context) {
			println("GET POSTS")
			c.IndentedJSON(http.StatusOK, posts)
		}
		`,
		User_ID:     1,
		Parent_Post: -1,
	},
	{
		ID:    2,
		Title: "In Search of Lost Time",
		Content: `
		func getPosts(c *gin.Context) {
			println("GET POSTS")
			c.IndentedJSON(http.StatusOK, posts)
		}
		`,
		User_ID:     1,
		Parent_Post: -1,
	},
	{
		ID:    3,
		Title: "IDK IDK IDK IDK IDK",
		Content: `
		func getPosts(c *gin.Context) {
			println("GET POSTS")
			c.IndentedJSON(http.StatusOK, posts)
		}
		`,
		User_ID:     1,
		Parent_Post: -1,
	},
}