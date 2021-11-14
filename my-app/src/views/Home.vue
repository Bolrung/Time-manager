<template>
  <div class="home">
    <div>
    <Navigation />
    </div>
    <div class="body">
    <HelloWorld msg="Welcome to Your Time Manager "/>
    </div>
  </div>
</template>
<script>
// @ is an alias to /src
import HelloWorld from '@/components/HelloWorld.vue'
import Navigation from "@/components/Navigation";


export default {
  name: 'Home',
  components: {
    HelloWorld,
    Navigation
  }
}
</script>

<style>
.body {
   padding-top: 180px; 
   }
</style>