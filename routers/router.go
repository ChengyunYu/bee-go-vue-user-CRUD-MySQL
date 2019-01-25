package routers

import (
	"bee-go-vue/controllers"
	"github.com/astaxie/beego"
)

func init() {
	beego.Router("/", &controllers.UserController{}, "Get:ShowIndex")
	beego.Router("/users/:keyword", &controllers.UserController{}, "Get:GetUsers")
	beego.Router("/users/recent", &controllers.UserController{}, "Get:GetUsersRecent")
	beego.Router("/user", &controllers.UserController{}, "Post:PostUser")
	beego.Router("/user", &controllers.UserController{}, "Put:PutUser")
	beego.Router("/user/:id", &controllers.UserController{}, "Delete:DeleteUser")

}
