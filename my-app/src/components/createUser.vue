<template>
    <div>
        <form action="post">
            <input type="email" v-model="user.email">
            <input type="text" v-model="user.username">
            <input type="button" value="Submit" v-on:click="getcreate()">
        </form>
       </div>
</template>
<script>
import axios from 'axios'
export default {
      name: 'createUser',
      data(){
      return {
          user :{
              email : null , 
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
                }).catch()
            },
      },
    
}
</script>
<style lang="">
    
</style>