package user

import (
	"crypto/sha256"
	"database/sql"
	res_error "dequeued-backend/modules/Error"
	"net/http"

	"github.com/gin-gonic/gin"
)

type SignUpBody struct {
	Username     string `json:"username"`
	Name     string `json:"name"`
	Password string `json:"password"`
}

func SignUp(c *gin.Context) {
	var body SignUpBody

	if err := c.BindJSON(&body); err != nil {
		// println(err.Error())
		c.IndentedJSON(http.StatusConflict, res_error.ResponseError{Message: "Cannot bind json"})
		return
	}

	hashed_pass := sha256.Sum256([]byte(body.Password))
	body.Password = string(hashed_pass[:])

	db, err := sql.Open("mysql", "root:K03n1g53gg008@tcp(127.0.0.1:3306)/dequeued_409")

	// handle error, if any.
    if err != nil {
        c.IndentedJSON(http.StatusInternalServerError, res_error.ResponseError{Message: "Cant connect to the database"})
		return
    }

	err = db.Ping()

	// handle error
    if err != nil {
        c.IndentedJSON(http.StatusInternalServerError, res_error.ResponseError{Message: "Cant connect to the database"})
		return
    }

	_, err = db.Query(`
		select * from user where username=?
	`, body.Name, body.Password)

	// handle error
    if err != nil {
        c.IndentedJSON(http.StatusInternalServerError, res_error.ResponseError{Message: "Cant query"})
		return
    }
     
    defer db.Close()
}