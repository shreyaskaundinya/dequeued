package user

type User struct {
	Id         int    `json:"id"`
	Name       string `json:"name"`
	Username   string `json:"username"`
	Password   string
	Created_at string
}