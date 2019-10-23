<template>
  <q-page class="flex ">
<div class="q-pa-md" style="width:100%">
    <q-table
      class="my-sticky-virtscroll-table"
       :dense="$q.screen.lt.md"
      virtual-scroll
      :table-style="style"
      :pagination.sync="pagination"
      :rows-per-page-options="[10,20,50]"
      :virtual-scroll-sticky-start="48"
      row-key="id"
       selection="multiple"
     :selected.sync="selecteds"
      title="Treats"
      :data="rows"
      :columns="columns"
      ref="grid"
       :selected-rows-label="getSelectedString"
       @request="getData"
    >
    <template v-slot:top="props">
      <div class="col-2 q-table__title">Formularios</div>

        <q-space />
         <q-btn
          flat round dense
          :icon="props.inFullscreen ? 'fullscreen_exit' : 'fullscreen'"
          @click="props.toggleFullscreen"
          class="q-ml-md"
        />
    </template>
    </q-table>
  </div>
 <q-btn round color="primary" icon="add" size="lg" style="position:absolute;right:20px;bottom:40px;z-index:999"  @click="add"/>
   <q-dialog v-model="form_dialog" persistent >
      <q-card style="width: 700px; max-width: 80vw;">
        <q-form
      @submit="onSubmit"
      ref="form"
    >
      <q-card>
        <q-card-section >
          <div class="text-h6">Nuevo formulario</div>
        </q-card-section>

        <q-separator />

        <q-card-section class="scroll">
        <div class="row">
  <div class="col-xs-12 col-sm-6 col-md-4">
    <q-input
        filled
        v-model="form.title"
        label="Nombre *"
        lazy-rules
        :rules="[ val => val && val.length > 0 || 'Ingrese el nombre']"
      />

  </div>

</div>

        </q-card-section>

        <q-separator />

        <q-card-actions align="right">
          <q-btn flat label="Cerrar" color="primary" v-close-popup />
          <q-btn flat label="Guardar" color="primary" v-close-popup type="submit" />
        </q-card-actions>
      </q-card>
      </q-form>
      </q-card>
    </q-dialog>
  </q-page>
</template>

<script>

export default {
  name:'Form_manager',
  data () {
    return {
      selecteds:[],
      form_dialog:false,
      style:{
       'max-height':'600px'
      },
      form:{},
      pagination: {
        rowsPerPage: 5
      },
       rows:[],
      columns: [
        {
          name: 'id',
          label: '#',
          field: 'id'
        },
        {
          name: 'title',
          required: true,
          label: 'Título',
          align: 'left',
          field: row => row.title,
          format: val => `${val}`,
          sortable: true
        },
        { name: 'creation_date', align: 'center', label: 'Fecha', field: 'creation_date', sortable: true },
       
      ]
    }
  },
  created(){
   this.getData();
  },
  mounted(){
 // this.$refs.grid.requestServerInteraction();
  this.$set(this.style,'max-height',(window.innerHeight-76)+'px');

  },
  methods:{
    getSelectedString () {
      var s=this.selecteds.length > 1 ? 's' : '';
      return this.selecteds.length === 0 ? '' : this.selecteds.length+' fila'+s+' seleccionada'+s+' de '+this.rows.length;
    },
    getData(args){
      console.log(args);
      this.$axios.get('service/form/getAll').then(response=>{
          if(response.data.state){
            this.rows=response.data.result;
          }
      });
       
    },
    add(){
  this.form_dialog=true;
    },
    onSubmit(){
      this.$refs.form.validate().then(ok=>{
          this.$axios.post('service/form/create',this.form).then(response=>{
            if(response.data.state){
              this.getData();
            }
          });
      });
    }
  }
}
</script>
<style lang="sass">
.my-sticky-virtscroll-table
  /* max height is important */
  .q-table__middle
    max-height: 200px

  .q-table__top,
  .q-table__bottom,
  thead tr:first-child th /* bg color is important for th; just specify one */
    background-color: #fff

  thead tr:first-child th
    position: sticky
    top: 0
    opacity: 1
    z-index: 1
</style>