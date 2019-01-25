(function(Vue){
	"use strict";

	new Vue({
		el:  'body',

		data:{
			keyword: "",
			searchUsers: [],
			recentUsers: [],
			newUser: {name: "", gender: "Please Select", hometown: "", owner: false},
			emptyName: false,
			emptyGender: false,
			emptyHometown: false,
			invalid: false,
		},

		created: function() {
            this.$http.get('/users/recent').then(function(res) {
                this.recentUsers = res.data.iterms ? res.data.iterms : [];
            });
            // this.clearNewUser();
        },
        
        // Functions we will be using
		methods: {
			clearCreateForm: function() {
				this.clearWarnings();
				this.clearNewUser();
				this.getUsers();
				this.$http.get('/users/recent').then(function(res) {
					this.recentUsers = res.data.iterms ? res.data.iterms : [];
				});
			},

			clearWarnings: function() {
				this.emptyName = false;
				this.emptyGender = false;
				this.emptyHometown = false;
			},

			clearEmptyName: function() {
				this.emptyName = false;
			},

			clearEmptyGender: function() {
				this.emptyGender = false;
			},

			clearEmptyHometown: function() {
				this.emptyHometown = false;
			},

			clearNewUser: function() {
				this.newUser.name="";
				this.newUser.gender="Select Gender";
				this.newUser.hometown="";
				this.newUser.owner=false;
				document.getElementById("createForm").reset();
			},

			clearInput: function() {
				this.keyword = "";
			},

			getUsers: (
				function() {
					if(this.keyword === '') {
						this.searchUsers = [];
						return;
					}
					this.$http.get('/users/' + this.keyword).success(function(res) {
						this.searchUsers = res.iterms ? res.iterms : [];
					})
				}
			),

			createUser: function() {
			    if (!this.newUser.name) {
			    	this.emptyName = true;
			    	this.invalid = true;
			    }
			    else {
					this.emptyName = false;
				}

			    if (this.newUser.gender === "Select Gender") {
					this.emptyGender = true;
					this.invalid = true;
				}
				else {
					this.emptyGender = false;
				}

			    if (!this.newUser.hometown) {
			    	this.emptyHometown = true;
			    	this.invalid = true;
				}
				else {
					this.emptyHometown = false;
				}

			    if (this.invalid) {
			    	this.invalid = false;
			    	return;
				}

				this.$http.post('/user',this.newUser).success(function(res) {
					this.newUser.id = res.created;
					this.tasks.push(this.newUser);
					this.clearNewUser();
				}).error(function(err) {
					console.log(err);
				});
			},

			deleteUser : function(index)	{
				this.$http.delete('/user/'+index).success(function(res) {
					this.$http.get('/users/recent').then(function(res) {
						this.recentUsers = res.data.iterms ? res.data.iterms : [];
					});
					this.getUsers();
				}).error(function(err) {
					console.log(err)
				});
			},	

			updateUser: function(user) {
				user.done = user.done==="true";

				this.$http.put('/user', user).success(function(res) {
					this.$http.get('/users/recent').then(function(res) {
						this.recentUsers = res.data.iterms ? res.data.iterms : [];
					});
					this.getUsers();
				}).error(function(err) {
					console.log(err)
				});
			}
		}
	});
})(Vue);