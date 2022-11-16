package post

import (
	res_error "dequeued-backend/modules/Error"
	"net/http"

	"github.com/gin-gonic/gin"
)

func GetPosts(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, posts)
}

func CreatePost(c *gin.Context) {
	var newBook Post

	if err := c.BindJSON(&newBook); err != nil {
		// println(err.Error())
		c.IndentedJSON(http.StatusConflict, res_error.ResponseError{Message: "Cannot bind json"})
		return
	}

	if (newBook.ID == -1){
		newBook.ID = len(posts) + 1
	}

	found := false

	for _, b := range posts {
		if b.ID == newBook.ID {
			found = true
		}
	}

	if found {
		c.Status(http.StatusConflict)
		return
	}

	// create new post
	posts = append(posts, newBook)
	c.IndentedJSON(http.StatusCreated, newBook)
}
