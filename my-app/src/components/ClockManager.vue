<template>
<Navigation />
<div class="form">
    <h2 style="
    background-color: #e7e9eb;
    padding: 15px;">Clock Manager</h2>
    <div>
        <table class="table">
              <thead>
                 <tr>
                    <th>Username</th>
                    <th>Hours worked</th>
                </tr>
                </thead>
                <tbody>
                    <tr>
                    <td>{{user.username}}</td>
                    <td>{{workingtime.startDateTime}}</td>
                    </tr>
               </tbody>
        </table>
      <div>
        <input type="button" style="margin:5px" value="Clock In" v-on:click="clock()" class="button1">
      </div>
      <div>
        <input type="button" style="margin:5px" value="Refresh" v-on:click="refresh()" class="button2">
      </div>
    </div>
</div>
</template>

<script>
import axios from 'axios'
import Navigation from "@/components/Navigation";

export default {
    name: 'ClockManager',
    components: {
       Navigation
    },
    data() {
        return {
            workingtime: {startDateTime: null},
            clockIn: null,
            user: {username : null}

        }
    },
    methods: {
        refresh() {
            console.log(this.clock)
            let url = "http://localhost:4000/api/clocks/:userID"

            axios.get(url, {clock: this.clock}).then((a) => {
                a
            }).catch((e) => {console.log(e);
            })
        },
        clock() {
            console.log(this.clock)
            let url = "http://localhost:4000/api/clocks/:userID"

            axios.post(url, {clock: this.clock}).then((a) => {
                a
            }).catch((e) => {console.log(e);
            })
        }
    }
}
</script>

<style>
.form {
   padding-top: 120px; 
   }
.table {
    border-collapse: collapse;
    width: 100%;
    }
.table th, .table td {
    text-align: left;
    padding: 8px;
    }

    .table tr {
    border-bottom: 1px solid #ddd; 
    }
.table tr:hover {
    background-color: #f5f5f5;
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
  background-color: #89CFF0;
  margin:5px;
  color: white;
  padding: 12px 20px;
  cursor: pointer;
  border-radius: 30px;
}

</style>