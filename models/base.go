package models

import (
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
)

func init() {
	err := orm.RegisterDriver("mysql", orm.DRMySQL)
	print(err)
	err = orm.RegisterDataBase("default", "mysql", "root:Y941118u@/my_db?charset=utf8")
	print(err)
}
