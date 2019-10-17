<template>
  <q-page class="flex flex-center">
         <q-page-sticky expand position="top">
        <q-toolbar class="GPLAY__sticky bg-white q-px-xl">
          <q-space />
          <q-btn icon="help" dense flat size="12px" class="GPLAY__sticky-help" />
          <q-btn icon="settings" dense flat class="GPLAY__sticky-settings q-ml-md" size="12px" />
        </q-toolbar>
      </q-page-sticky>
  </q-page>
</template>

<script>
export default {
  name: 'PageIndex',
  data(){
    // <img alt="Quasar logo" src="~assets/quasar-logo-full.svg">
    return {

    }
  },
  created(){
    console.log("this",this)
  }
}
</script>
