package controllers

import (
	"bee-go-vue/models"
	"encoding/json"
	"log"

	"github.com/astaxie/beego"
)

type H map[string]interface{}

type UserController struct {
	beego.Controller
}

func (u *UserController) URLMapping() {
	u.Mapping("Get", u.GetUsers)
	u.Mapping("Get", u.GetUsersRecent)
	u.Mapping("Post", u.PostUser)
	u.Mapping("Put", u.PutUser)
	u.Mapping("Delete", u.DeleteUser)
}

func (u *UserController) ShowIndex() {
	u.TplName = "index.tpl"
}

func (u *UserController) GetUsers() {
	keyword := u.Ctx.Input.Param(":keyword")
	datas := models.GetUsers(keyword)
	u.Data["json"] = datas
	u.ServeJSON()
}

func (u *UserController) GetUsersRecent() {
	datas := models.GetUsersRecent()
	u.Data["json"] = datas
	u.ServeJSON()
}

func (u *UserController) PostUser() {

	user := u.bind()
	id := models.PostUser(user)

	u.Data["json"] = H{
		"created": id,
	}
	u.ServeJSON()
}

func (u *UserController) PutUser() {
	user := u.bind()

	id := models.PutUser(user)

	u.Data["json"] = H{
		"updated": id,
	}

	u.ServeJSON()
}

func (u *UserController) DeleteUser() {
	id := u.Ctx.Input.Param(":id")
	models.DeleteUser(id)

	u.Data["json"] = H{
		"deleted": id,
	}
	u.ServeJSON()
}

func (u *UserController) bind() (us models.User) {
	err := json.NewDecoder(u.Ctx.Request.Body).Decode(&us)
	if err != nil {
		log.Fatalln(err)
	}
	return
}
