<template>
  <div id="nav">
    <Navigation />
  <router-view/>
  </div>
  
</template>
<script>
import Navigation from "@/components/Navigation";
export default {
  name: "App",
  component:{
    Navigation
  }
};
</script>
<style>
@import'~bootstrap/dist/css/bootstrap.css';
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #fff;
}

#nav a.router-link-exact-active {
  color: #42b983;
}

</style>
