<template>
  <q-layout view="hHh LpR fFf" class="bg-grey-3">
    <q-page-container>
      <q-page class=" row fit wrap justify-center items-center content-center">
        <div class="col-xs-11 col-sm-11 col-md-5 col-lg-5">
          <q-card bordered>
            <q-card-section class="flex flex-center">
              <strong>COTIZA TU CAMIÓN</strong>
            </q-card-section>
            <q-separator inset />
            <q-card-section>
              <q-form @submit="onSubmit" class="q-gutter-md" ref="form">
                <div class="row justify-between">
                  <div class="col-xs-12 col-sm-6 col-md-6 q-gutter-md">
                    <q-input
                      filled
                      dense
                      v-model="form.name"
                      label="Nombre(*)"
                      lazy-rules
                      :rules="[ val => val && val.length > 0 || 'Por favor ingrese tu  nombre']"
                    />
                  </div>
                  <div class="col-xs-12 col-sm-6 col-md-6 q-gutter-md">
                    <q-input
                      filled
                      dense
                      v-model="form.surnames"
                      label="Apellidos(*)"
                      lazy-rules
                      :rules="[
          val => val && val.length>0 || 'Por favor ingrese tu apellido',
      
        ]"
                    />
                  </div>
                  <div class="col-xs-12 col-sm-6 col-md-6 q-gutter-md">
                    <q-select
                      filled
                      dense
                      :options="documents_type"
                      v-model="form.document_type"
                      label="Tipo de documento de identidad(*)"/>
                  </div>
      <div class="col-xs-12 col-sm-6 col-md-6 q-gutter-md">
                    <q-input
                      filled
                      dense
                      v-model="form.document_number"
                      label="Número de documento de identidad(*)"
                      lazy-rules
                      :rules="[
          val => val && val.length>0 || 'Por favor ingrese tu número de documento',
      
        ]"
                    />
                  </div>
                       <div class="col-xs-12 col-sm-6 col-md-6 q-gutter-md">
                    <q-select
                      filled
                      dense
                      :options="departaments"
                      v-model="form.departament"
                      label="Departamento(*)"/>
                  </div>
      <div class="col-xs-12 col-sm-6 col-md-6 q-gutter-md">
                    <q-input
                      filled
                      v-model="form.phone"
                      label="Teléfono móvil(*)"
                      lazy-rules
                      dense
                      :rules="[
          val => val && val.length>0 || 'Por favor ingrese completa este campo',
      
        ]"
                    />
                  </div>
      <div class="col-xs-12 col-sm-6 col-md-6 q-gutter-md">
                    <q-input
                      filled
                      type="email"
                      v-model="form.email"
                      label="Correo(*)"
                      dense
                      lazy-rules
                      :rules="[
          val => val && val.length>0 || 'Por favor ingrese tu email',
      
        ]"
                    />
                  </div>
                        <div class="col-xs-12 col-sm-6 col-md-6 q-gutter-md">
                    <q-select
                      filled
                      :options="brands"
                         dense
                      v-model="form.brand"
                      label="Marca a cotizar(*)"/>
                  </div>
                  <div class="col-xs-12 col-sm-6 col-md-6 q-gutter-md  ">
                    <q-select
                      filled
                      dense
                      :options="models[form.brand]"
                      v-model="form.model"
                      label="Modelo a cotizar(*)"/>
                  </div>
         <div class="col-xs-12 col-sm-6 col-md-6 q-gutter-md ">
                    <q-select
                      filled
                      :options="interests"
                      dense
                      v-model="form.interest"
                      label="Interés de compra(*)"/>
                  </div>

<div class="col-xs-12 col-sm-12 col-md-12 ">
    <q-input
                      filled
                         autogrow
                      v-model="form.message"
                      style="margin-top:20px"
                      label="Mensaje"
                      dense
                     
                    />
    </div>

                  <div class="col-xs-12 col-sm-12 col-md-12  " style="margin-top:20px">
                      Politicas de privacidad
                  </div>
                  <div class="col-xs-12 col-sm-12 col-md-12 ">
                    <div class="flex justify-end">
                      <q-btn label="ENVIAR" type="submit" color="primary" />
                    </div>
                  </div>
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
  name: "Form",
  data() {
    return {
      form: {document_type:'DNI',departament:'Lima',brand:'Volkswagen',interest:'Inmediato'},
      documents_type:[
          'DNI','RUC','CE','Pasaporte'
      ],
      brands:['Volkswagen','MAN'],
      interests:['Inmediato',		
'Menos de 1 mes',		
'Entre 1 mes y 3 meses',		
'Entre 3 meses y 6 meses',	
'Más de 6 meses',		
],
      models:{
        Volkswagen:['Hasta 4 toneladas',		
'De 4  a 6  toneladas',		
'De 6 a 8 toneladas',		
'De 8 a 10 toneladas',		
'De 10 a 12 toneladas',		
'De 12 a 17 toneladas',		
'De 17 a 19 toneladas',		
'De 19 a 22 toneladas',		
'Más de 22 toneladas',],
MAN:['Hasta 30 toneladas',
'Hasta 65 toneladas',
]
      },
      departaments:[
'Amazonas',
'Ancash',
'Apurimac',
'Arequipa',
'Ayacucho',
'Cajamarca',
'Callao',
'Cusco',
'Huancavelica',
'Huánuco',
'Ica',
'Junin',
'La Libertad',
'Lambayeque',
'Lima',
'Loreto',
'Madre De Dios',
'Moquegua',
'Pasco',
'Piura',
'Puno',
'San Martin',
'Tacna',
'Tumbes',
'Ucayali',]
    };
  },

  methods: {
    onSubmit() {
        
      this.$refs.form.validate().then(ok => {

        this.$axios
          .post("service/lead/create", {form:this.$route.params.form,data:this.form})
          .then(response => {
             if(response.data.state){
               this.$socket.emit("getData");
                 this.$q.notify({
                color: "primary",
                textColor: "white",
                position: "center",
                message: "Gracias por completar este formulario!",
                actions: [{ label: "Ok", color: "white" }]
              });
              
             }else{
               this.$q.notify({
                color: "negative",
                textColor: "white",
                position: "center",
                message: "Ocurrió un error inesperado!",
                actions: [{ label: "Ok", color: "white" }]
              });
             }
          });
      });
    }
  },
  computed:{
      watch_brand(){
          return this.form.brand;
      }
  },
  watch:{
      watch_brand(val){
          this.form.model=this.models[val][0];
      }
  }
};
</script>
