package user

import (
	"crypto/sha256"
	"database/sql"
	res_error "dequeued-backend/modules/Error"
	"net/http"

	"github.com/gin-gonic/gin"
)

type LoginBody struct {
	Name string `json:"name"`
	Password string `json:"password"`
}

func Login(c *gin.Context) {
	var body LoginBody

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

	result , err := db.Query(`
		select * from user where username=? and password=?
	`, body.Name, body.Password)

	// handle error
    if err != nil {
        c.IndentedJSON(http.StatusInternalServerError, res_error.ResponseError{Message: "Cant query"})
		return
    }

	for result.Next() {
		var (
			id int
			name string
			username string
			password string
			created_at string
		)
		if err:= result.Scan(&id, &name, &username, &password, &created_at); err != nil {
			c.IndentedJSON(http.StatusBadRequest, res_error.ResponseError{Message: "Cant find user"})
			return
		} else {
			c.IndentedJSON(http.StatusAccepted, res_error.ResponseError{Message: ""})
			return
		}
	}
    
    defer db.Close()
}