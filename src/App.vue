<template>
  <div id="q-app">
    <router-view />
  </div>
</template>

<script>
export default {
  name: 'App',
  created(){
    this.$socket.on('connect', ()=>{
    console.log("connected");
    });
  }
}
</script>
