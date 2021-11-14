<template>
<Navigation />
   <div class="form">
      <h2 style="
    background-color: #e7e9eb;
    padding: 15px;">Working Time</h2>
      <p>displaying, creating, modifying and deleting a working time
      </p>
      <br>
      <form action="post">
          <input type="text" style="margin:5px" placeholder="Username">
          <input type="text" style="margin:5px" placeholder="starting time">
          <input type="text" style="margin:5px"  placeholder="ending time">
          <input type="button" value="Create" v-on:click="createWorkingTime()">
      </form>
      <br>
      <h2>List of Working Times</h2>
      <input type="button" value="Display" v-on:click="getWorkingTime()">
      <br>
      <div>
      <table class="table">
              <thead>
                 <tr>
                    <th>Username</th>
                    <th>Working Time</th>
                </tr>
                </thead>
                <tbody>
                    <tr>
                    <td>{{user.username}}</td>
                    <td>{{workingtime.workingtimeid}}</td>
                    </tr>
              </tbody>
          </table>
          </div>
        <div>
            <form action="post">
            <div class="form-group">
                <input type="text" placeholder="Username">
            </div> 
            <div class="form-group">
                <input type="text" placeholder="startTime">
            </div>
            <div class="form-group">
                <input type="text" placeholder="endTime">
            </div>
            <input type="button" value="Edit" v-on:click="updateWorkingTime()" class="button1">
            <input type="button" value="Delete" v-on:click="deleteWorkingTime()" class="button2">
             </form>
        </div>
   </div>
</template>

<script>
import Navigation from "@/components/Navigation";

import axios from 'axios'
export default {
    name: 'workingtime',
    components: {
       Navigation
    },
    data() {
        return {
            start: null,
            end: null,
            user: {username : null},
            workingtime : {workingtimeid: null}
        }
    },
    methods: {
        getWorkingTime() {
            console.log(this.workingtime);
            let url = "http://localhost:4000/api/workingtimes/:userid/:id"

            axios.get(url, {workingtime: this.workingtime}).then((a) => {
                a
            }).catch((e) => {console.log(e);
            })
        },
        createWorkingTime(){
            console.log(this.workingtime);
            let url = "http://localhost:4000/api/workingtimes/:userID"

            axios.post(url,{workingtime: this.workingtime}).then((a) => {
                a
            }).catch((e) => {console.log(e);
            });
        },
        updateWorkingTime() {
            console.log(this.workingtime);
            let url = "http://localhost:4000/api//workingTime/:userid/"+this.workingtimeid

            axios.put(url,{workingtime: this.workingtime}).then((a) => {
                a
            }).catch((e) => {console.log(e);
            });
        },
        deleteWorkingTime() {
            console.log(this.workingtime);
            let url = "http://localhost:4000/api//workingTime/:userid/"+this.workingtimeid

            axios.delete(url,{workingtime: this.workingtime}).then((a) => {
                a
            }).catch((e) => {console.log(e);
            });
        }
    }

}
</script>

<style>
.form {
   padding-top: 120px;
   margin: 0 auto; 
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