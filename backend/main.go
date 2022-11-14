package main

import (
	"net/http"
	"time"

	// "errors"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)


type Post struct {
	ID int `json:"id"`
	Title string `json:"title"`
	Content string `json:"content"`
	User_ID int `json:"user_id"`
	Parent_Post int `json:"parent_id"`
}

var posts = []Post {
	{
		ID: 1, 
		Title: "HELLO WORLD HELLO WORLD HELLO WORLD HELLO WORLD HELLO WORLD HELLO WORLD HELLO WORLD HELLO WORLD", 
		Content: `
		func getPosts(c *gin.Context) {
			println("GET POSTS")
			c.IndentedJSON(http.StatusOK, posts)
		}
		`,
		User_ID: 1,
		Parent_Post: -1,
	},
	{
		ID: 2, 
		Title: "In Search of Lost Time", 
		Content: `
		func getPosts(c *gin.Context) {
			println("GET POSTS")
			c.IndentedJSON(http.StatusOK, posts)
		}
		`,
		User_ID: 1,
		Parent_Post: -1,
	},
	{
		ID: 3, 
		Title: "IDK IDK IDK IDK IDK", 
		Content: `
		func getPosts(c *gin.Context) {
			println("GET POSTS")
			c.IndentedJSON(http.StatusOK, posts)
		}
		`,
		User_ID: 1,
		Parent_Post: -1,
	},
}


func getPosts(c *gin.Context) {
	println("GET POSTS")
	c.IndentedJSON(http.StatusOK, posts)
}

func createPost(c *gin.Context) {
	println("POST TO POSTS")
	// println(c.)

	var newBook Post

	if err:= c.BindJSON(&newBook); err != nil {
		// println(err.Error())
		return
	}

	found := false

	for _, b := range posts {
		if (b.ID == newBook.ID) {
			found = true
		}
	}

	if (found) {
		c.Status(http.StatusConflict)
		return
	}

	// create new post
	posts = append(posts, newBook)
	c.IndentedJSON(http.StatusCreated, newBook)
}


func main() {
	router := gin.Default()
	router.Use(cors.New(cors.Config{
        AllowOrigins:     []string{"*"},
        AllowMethods:     []string{"*"},
        AllowHeaders:     []string{"Origin"},
        ExposeHeaders:    []string{"Content-Length"},
        AllowCredentials: true,
        AllowOriginFunc: func(origin string) bool {
            return origin == "https://github.com"
        },
        MaxAge: 12 * time.Hour,
    }))

	router.GET("/posts", getPosts)
	router.POST("/posts", createPost)
	router.Run("localhost:5000")
}