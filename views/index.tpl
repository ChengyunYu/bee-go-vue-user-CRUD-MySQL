<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="context-type" content="text/html" ; charset="utf-8">
    <title>User CRUD Demo</title>

    <link rel="stylesheet" type="text/css"
        href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css"
        href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">

    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js">
    </script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js">
    </script>
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/vue/1.0.24/vue.min.js">
    </script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/vue-resource/0.7.0/vue-resource.min.js">
    </script>
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h1>User CRUD Demo</h1>

                <div class="input-group">
                    <input
                        style="border-top-right-radius: 3px;
                               border-top-left-radius: 3px;
                               border-bottom-right-radius:3px;
                               border-bottom-left-radius:3px;"
                        type="text" class="form-control"
                        placeholder="Search by name..."
                        v-model.trim="keyword"
                        @input="getUsers"
                        autofocus>
                    <span class="input-group-btn">
                        <button
                            style="border-top-right-radius: 3px;
                                   border-top-left-radius: 3px;
                                   border-bottom-right-radius:3px;
                                   border-bottom-left-radius:3px;"
                            class="btn btn-primary"
                            type="button"
                            v-on:click="clearInput">
                            Clear
                        </button>
                    </span>
                    <span class="input-group-btn">
                        <button
                            style="border-top-right-radius: 3px;
                                   border-top-left-radius: 3px;
                                   border-bottom-right-radius:3px;
                                   border-bottom-left-radius:3px;"
                            class="btn btn-primary"
                            data-toggle="modal"
                            data-target="#createUser"
                            v-on:click="clearNewUser()">
                            Create
                        </button>
                    </span>
                </div>

                <div
                    class="modal fade"
                    id="createUser"
                    tabindex="-1"
                    role="dialog"
                    aria-labelledby="myModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button
                                    type="button"
                                    class="close"
                                    data-dismiss="modal"
                                    aria-hidden="true"
                                    v-on:click="clearCreateForm();">
                                    &times;
                                </button>
                                <h4 class="modal-title" id="myModalLabel">Create a New User</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form-horizontal" id="createForm">
                                    <fieldset>
                                    <div class="control-group">
                                        <!-- Text input-->
                                        <label class="control-label" for="input01">Name</label>
                                        <div class="controls">
                                            <input
                                                type="text"
                                                v-model="newUser.name"
                                                placeholder="Your full name..."
                                                class="input-xlarge"
                                                v-on:click="clearEmptyName()"
                                            >
                                            <label class="text-danger" v-if="emptyName">
                                                Name cannot be empty.
                                            </label>
                                            <p class="help-block">Please enter your legal full name. </p>
                                        </div>
                                    </div>

                                    <div class="control-group">
                                        <!-- Select Basic -->
                                        <label class="control-label">Gender</label>
                                        <div class="controls">
                                            <select
                                                class="input-xlarge"
                                                v-model="newUser.gender"
                                                v-on:click="clearEmptyGender()">
                                                <option selected>Select Gender</option>
                                                <option>Male</option>
                                                <option>Female</option>
                                                <option>Others</option>
                                            </select>
                                            <label class="text-danger" v-if="emptyGender">
                                                Gender cannot be empty.
                                            </label>
                                        </div>

                                    </div><div class="control-group">
                                        <!-- Text input-->
                                        <label class="control-label" for="input01">Hometown</label>
                                        <div class="controls">
                                            <input
                                                type="text"
                                                v-model="newUser.hometown"
                                                placeholder="Your hometown..."
                                                class="input-xlarge"
                                                v-on:click="clearEmptyHometown()"
                                            >
                                            <label class="text-danger" v-if="emptyHometown">
                                                Hometown cannot be empty.
                                            </label>
                                            <p class="help-block">Please enter the city your were born in. </p>
                                        </div>
                                    </div>

                                    <div class="control-group">
                                        <label class="checkbox inline font-size" style="padding-left：10px">
                                            I am a project owner.
                                        </label>
                                        <input
                                            style="width:12px;height:12px;"
                                            type="checkbox"
                                            class="form-control"
                                            v-model="user.owner">
                                    </div>
                                    </fieldset>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button
                                    type="button"
                                    class="btn btn-default"
                                    data-dismiss="modal"
                                    v-on:click="clearCreateForm();"
                                >Close</button>
                                <button type="button" class="btn btn-primary" v-on:click="createUser()">Submit</button>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal -->
                </div>

                <br>
                <h2 style="color: red">Search Results</h2>
                <div v-if="searchUsers.length===0">No users match the keyword...</div>
                <div class="panel panel-primary" v-for="user in searchUsers"
                    style="margin-bottom: 5px margin-right: 5px">
                    <div class="input-group" style="margin-bottom: 0px">
                        <table class="table-responsive" style="margin-bottom: 0px">
                            <th>Id</th>
                            <th>Name</th>
                            <th>Gender</th>
                            <th>Hometown</th>
                            <th>Owner?</th>
                            <tbody>
                                <tr>
                                    <td>
                                        <input class="form-control" type="text" v-model="user.id" readonly></input>
                                    </td>
                                    <td>
                                        <input
                                            type="text"
                                            class="form-control"
                                            v-model="user.name">
                                    </td>
                                    <td>
                                        <select v-model="user.gender" style="height:34px;">
                                            <option>Select Gender</option>
                                            <option>Male</option>
                                            <option>Female</option>
                                            <option>Others</option>
                                        </select>
                                    </td>
                                    <td>
                                        <input
                                            type="text"
                                            class="form-control"
                                            v-model="user.hometown">
                                    </td>
                                    <td>
                                        <input
                                            style="width:34px;height:34px;vertical-align:text-top; margin-top:0;"
                                            type="checkbox"
                                            class="form-control"
                                            v-model="user.owner">
                                    </td>
                                    <td>
                                        <span class="input-group-btn">
                                            <button
                                                style="border-top-right-radius: 3px;
                                                       border-top-left-radius: 3px;
                                                       border-bottom-right-radius:3px;
                                                       border-bottom-left-radius:3px;"
                                                class="btn btn-info"
                                                type="button" v-on:click="updateUser(user)">
                                                <i class="fa fa-edit" aria-hidden="true"></i>
                                            </button>
                                            <button
                                                style="border-top-right-radius: 3px;
                                                       border-top-left-radius: 3px;
                                                       border-bottom-right-radius:3px;
                                                       border-bottom-left-radius:3px;"
                                                class="btn btn-info"
                                                type="button" :disable="task.done===true"
                                                v-on:click="updateTask(task,true)">
                                                <i class="fa fa-reply" aria-hidden="true"></i>
                                            </button>
                                            <button
                                                style="border-top-right-radius: 3px;
                                                       border-top-left-radius: 3px;
                                                       border-bottom-right-radius:3px;
                                                       border-bottom-left-radius:3px;"
                                                class="btn btn-danger"
                                                type="button" v-on:click="deleteUser(user.id)">
                                                <i class="fa fa-trash-o" aria-hidden="true"></i>
                                            </button>
                                        </span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                    </div>
                </div>

                <br>
                <h2 style="color: green">Recently Added</h2>
                <div v-if="recentUsers.length===0">No users were recently added...</div>
                <div class="panel panel-primary" v-for="user in recentUsers"
                    style="margin-bottom: 5px">
                    <div class="input-group" style="margin-bottom: 0px">
                        <table class="table-responsive" style="margin-bottom: 0px">
                            <th>Id</th>
                            <th>Name</th>
                            <th>Gender</th>
                            <th>Hometown</th>
                            <th>Owner?</th>
                            <tbody>
                                <tr>
                                    <td>
                                        <input class="form-control" type="text" v-model="user.id" readonly></input>
                                    </td>
                                    <td>
                                        <input
                                            type="text"
                                            class="form-control"
                                            v-model="user.name">
                                    </td>
                                    <td>
                                        <select v-model="user.gender" style="height:34px;">
                                            <option>Select Gender</option>
                                            <option>Male</option>
                                            <option>Female</option>
                                            <option>Others</option>
                                        </select>
                                    </td>
                                    <td>
                                        <input
                                            type="text"
                                            class="form-control"
                                            v-model="user.hometown">
                                    </td>
                                    <td>
                                        <input
                                            style="width:34px;height:34px;vertical-align:text-top; margin-top:0;"
                                            type="checkbox"
                                            class="form-control"
                                            v-model="user.owner">
                                    </td>
                                    <td>
                                        <span class="input-group-btn">
                                            <button
                                                style="border-top-right-radius: 3px;
                                                       border-top-left-radius: 3px;
                                                       border-bottom-right-radius:3px;
                                                       border-bottom-left-radius:3px;"
                                                class="btn btn-info"
                                                type="button" v-on:click="updateUser(user)">
                                                <i class="fa fa-edit" aria-hidden="true"></i>
                                            </button>
                                            <button
                                                style="border-top-right-radius: 3px;
                                                       border-top-left-radius: 3px;
                                                       border-bottom-right-radius:3px;
                                                       border-bottom-left-radius:3px;"
                                                class="btn btn-info"
                                                type="button" :disable="task.done===true"
                                                v-on:click="updateTask(task,true)">
                                                <i class="fa fa-reply" aria-hidden="true"></i>
                                            </button>
                                            <button
                                                style="border-top-right-radius: 3px;
                                                       border-top-left-radius: 3px;
                                                       border-bottom-right-radius:3px;
                                                       border-bottom-left-radius:3px;"
                                                class="btn btn-danger"
                                                type="button" v-on:click="deleteUser(user.id)">
                                                <i class="fa fa-trash-o" aria-hidden="true"></i>
                                            </button>
                                        </span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                    </div>
                </div>

            </div>
        </div>
    </div>
    <script type="text/javascript" src="static/js/app.js"></script>
</body>

</html>