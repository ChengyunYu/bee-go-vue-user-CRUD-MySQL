package models

import (
	"github.com/astaxie/beego/orm"
	"log"
	"strconv"
)

type User struct {
	Id   int    `orm:"pk" json:"id"`
	Name string `orm:"size(255)" json:"name"`
	Gender string `orm:"size(255)" json:"gender"`
	Hometown string `orm:"size(255)" json:"hometown"`
	Owner bool `json:"owner"`
}

type UserCollection struct {
	Users []User `json:"iterms"`
}

func init() {
	orm.RegisterModel(new(User))
}

func GetUsers(keyword string) UserCollection {
	sql := `SELECT * ` +
			`FROM user ` +
			`WHERE name ` +
			`LIKE '%` + keyword + `%' ` +
			`ORDER BY name ASC`

	o := orm.NewOrm()

	var maps []orm.Params
	if _, err := o.Raw(sql).Values(&maps); err != nil {
		log.Fatalf("query user by keyword failed that error was: %s", err.Error())
		return UserCollection{}
	}

	result := UserCollection{}
	for _, user := range maps {

		id, _ := strconv.Atoi(user["id"].(string))
		owner, _ := strconv.ParseBool(user["owner"].(string))
		data := User{
			Id:   id,
			Name: user["name"].(string),
			Gender: user["gender"].(string),
			Hometown: user["hometown"].(string),
			Owner: owner,
		}
		result.Users = append(result.Users, data)
	}

	return result
}

func GetUsersRecent () UserCollection {
	sql := `SELECT * FROM user ORDER BY id DESC LIMIT 5`
	o := orm.NewOrm()

	var maps []orm.Params
	if _, err := o.Raw(sql).Values(&maps); err != nil {
		log.Fatalf("query recent user failed that error was: %s", err.Error())
	}

	result := UserCollection{}
	for _, user := range maps {

		id, _ := strconv.Atoi(user["id"].(string))
		owner, _ := strconv.ParseBool(user["owner"].(string))
		data := User{
			Id:   id,
			Name: user["name"].(string),
			Gender: user["gender"].(string),
			Hometown: user["hometown"].(string),
			Owner: owner,
		}
		result.Users = append(result.Users, data)
	}
	return result
}

func PostUser(user User) int64 {
	var owner = "0"

	if user.Owner {
		owner = "1"
	}

	sql := `INSERT INTO user(name, gender, hometown, owner) 
			VALUES('` + user.Name + `','` + user.Gender + `','` + user.Hometown + `','` + owner + `')`

	o := orm.NewOrm()

	result, err := o.Raw(sql).Exec()

	if err != nil {
		log.Fatalf("insert user into table failed that error was: %s", err.Error())
	}

	id, err := result.LastInsertId()

	if err != nil {
		log.Fatal(err)
	}
	return id
}

func PutUser(user User) int64 {
	var owner = "0"

	if user.Owner {
		owner = "1"
	}

	sql := `UPDATE user 
			SET 
				name="` + user.Name + `", 
				gender="` + user.Gender + `", 
				hometown="` + user.Hometown + `", 
				owner=` + owner + ` 
			WHERE id = ` + strconv.FormatInt(int64(user.Id), 10) + ``

	o := orm.NewOrm()

	result, err := o.Raw(sql).Exec()
	if err != nil {
		log.Fatalf("update user table failed that error was: %s", err.Error())
	}

	id, err := result.LastInsertId()

	if err != nil {
		log.Fatalln(err)
	}
	return id
}

func DeleteUser(id string) {
	sql := `DELETE FROM user 
			WHERE id=` + id

	o := orm.NewOrm()

	if _, err := o.Raw(sql).Exec(); err != nil {
		log.Fatalf("delete user from table failed that error was: %s", err.Error())
	}
}
