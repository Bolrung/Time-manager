<template>
  <div class="hello">
    <div>
    <img src="@/assets/hourglass.png" alt="clock"/>
    </div>
    <br>
    <h1>{{ msg }}</h1>
    <button id="gettingStarted" @click="click">Get Started</button>
  </div>
</template>

<script>
import { useRouter } from 'vue-router'

export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  setup() {
        const router = useRouter()
        const click = () => {
            router.push({
                path: '../views/Login'
            })
        }
        return {
            click
        }
    }
}
</script>

<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
img {
  width: 200px;
  transition: 0.5s ease all;
}
#gettingStarted {
  background-color: #42b983;
  color: #fff;
  padding: 10px;
  border-radius: 5px;
  border: none;
  font-size: 16px;
  cursor: pointer;
  transition: 0.5s ease all;
}
</style>
