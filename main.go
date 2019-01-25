package main

import (
	_ "bee-go-vue/routers"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
)

func init() {
	err := orm.RegisterDriver("mysql", orm.DRMySQL)
	print(err)
	err = orm.RegisterDataBase("default", "mysql", "root:Y941118u@/my_db?charset=utf8")
	print(err)
}

func main() {
	beego.Run()
}
