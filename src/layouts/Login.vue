<template>
  <q-layout view="hHh LpR fFf" class="bg-grey-3">
      <q-page-container>
    <q-page class="fit row wrap justify-center items-center content-center">

        <div class="col-xs-11 col-sm-11 col-md-2 col-lg-2 ">
                <q-card  bordered >
      <q-card-section class="flex flex-center">
      <img src="statics/icons/logo.png" style="height:50px">
      </q-card-section>
      <q-separator  inset />
      <q-card-section>
        <q-form
      @submit="onSubmit"
      class="q-gutter-md"
      ref="form"
    >
      <q-input
        filled
        v-model="user"
        label="Usuario"
        lazy-rules
        :rules="[ val => val && val.length > 0 || 'Por favor ingrese tu usuario']"
      />
      <q-input
        filled
        type="password"
        v-model="password"
        label="Contraseña"
        lazy-rules
        :rules="[
          val => val !== null && val !== '' || 'Por favor ingrese tu contraseña',
          val => val.length > 6  || 'La contraseña debe tener por lo menos 6 caracteres'
        ]"
      />
      <div class="flex flex-center">
        <q-btn label="AUTENTICAR" type="submit" color="primary" />
      </div>
    </q-form>
      </q-card-section>
    </q-card>
        </div>

    </q-page>
      </q-page-container>
  </q-layout>
</template>

<script>
export default {
    name:'Login',
  data () {
    return {
      user: null,
      password: null
    }
  },

  methods: {
    onSubmit () {
      this.$refs.form.validate().then(ok=>{
         this.$axios.post('service/authentication',{user:this.user,password:this.password}).then(response=>{
                if(response.data.state){
                  location.reload(true);
                }else{
                    this.$q.notify({
                     color:'red-5',
                     textColor:'white',
                     position:'center',
                     message:'Usuario y/o contraseña incorrecta!',
                     actions:[ { label: 'Ok', color: 'white'} ]
                   });
                   setTimeout(() => {
                     location.reload();
                   }, 3000);
                }
         });
      });
    },
  }
}
</script>
