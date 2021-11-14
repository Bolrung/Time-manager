<template>
<Navigation />
    <div class="form">
        <h2 style="
    background-color: #e7e9eb;
    padding: 15px;">Create A New User</h2>
        <br>
        <form action="post">
            <input type="email" style="margin:5px" v-model="user.email" placeholder="Email">
            <input type="text" style="margin:5px" v-model="user.username" placeholder="Username">
            <input type="button" value="Submit" v-on:click="getcreate()">
        </form>
        <br>
    <div>
      <h2>List of All Users</h2>
        <input type="button" value="Show User" v-on:click="getUser()">
        <table class="table">
            <thead>
                <tr>
                <th>Email</th>
                <th>Username</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                <td>{{user.email}}</td>
                <td>{{user.username}}</td>
                </tr>
            </tbody>
        </table>
        <h2>Edit or delete a user</h2>
          <br>
          <form action="post">
            <div class="form-group">
                <input type="email" v-model="user.email" placeholder="Email">
            </div> 
            <div class="form-group">
                <input type="text" v-model="user.username" placeholder="Username">
            </div>
            <input type="button" value="Edit" v-on:click="updateUser()" class="button1">
            <input type="button" value="Delete" v-on:click="deleteUser()" class="button2">
          </form>
        </div>
       </div>
</template>
<script>
import Navigation from "@/components/Navigation";

import axios from 'axios'
export default {
      name: 'createUser',
      components: {
       Navigation
    },
      data(){
      return {
          user :{
              email : null ,
              id: null, 
              username : null
          }
       }      
  },
      methods: {
           getcreate(){
                console.log(this.user.email);
                let url = "http://localhost:4000/api/users"
                
                axios.post(url,{user:this.user}).then((a) => {
                    a
                }).catch(e => {console.log(e);
              });
            },
            getUser(){
                console.log(this.user.email);
                let url = "http://localhost:4000/api/users?email=den@gmail.co&username=qsdfg"

                axios.get(url,{user:this.user}).then((a) => {
                    this.user = a.data.data
                }).catch(e => {console.log(e);
              });
            },
            deleteUser() {
               console.log(this.user.email);
               let url = "http://localhost:4000/api/users/"+this.user.id

               axios.delete(url,{user:this.user}).then((a) => {
                   a
               }).catch(e => {console.log(e);
               });
            },
            updateUser() {
                console.log(this.user.email);
                let url = "http://localhost:4000/api/users/:userID"

                axios.put(url,{user:this.user}).then((a) => {
                    a
                }).catch(e => {console.log(e);
               });
            }
      },
    
}
</script>

<style>
.form {
   padding-top: 120px; 
   }
.button1 {
  background-color: #42b983;
  margin:5px;
  color: white;
  padding: 12px 20px;
  cursor: pointer;
  border-radius: 30px;
}
.button2 {
  background-color: #FF0000;
  margin:5px;
  color: white;
  padding: 12px 20px;
  cursor: pointer;
  border-radius: 30px;
}
</style>