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
      row-key="index"
       selection="multiple"
     :selected.sync="selecteds"
      title="Treats"
      :data="data"
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
      @reset="onReset"
      
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
        v-model="form.name"
        label="Nombre *"
        hint="Name and surname"
        lazy-rules
        :rules="[ val => val && val.length > 0 || 'Please type something']"
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
const data = [
  {
    name: 'Frozen Yogurt',
    calories: 159,
    fat: 6.0,
    carbs: 24,
    protein: 4.0,
    sodium: 87,
    calcium: '14%',
    iron: '1%',
    index:1
  },
  {
    name: 'Ice cream sandwich',
    calories: 237,
    fat: 9.0,
    carbs: 37,
    protein: 4.3,
    sodium: 129,
    calcium: '8%',
    iron: '1%',
    index:2
  },
  {
    name: 'Eclair',
    calories: 262,
    fat: 16.0,
    carbs: 23,
    protein: 6.0,
    sodium: 337,
    calcium: '6%',
    iron: '7%',
    index:3
  },
  {
    name: 'Cupcake',
    calories: 305,
    fat: 3.7,
    carbs: 67,
    protein: 4.3,
    sodium: 413,
    calcium: '3%',
    iron: '8%',
    index:4
  },
  {
    name: 'Gingerbread',
    calories: 356,
    fat: 16.0,
    carbs: 49,
    protein: 3.9,
    sodium: 327,
    calcium: '7%',
    iron: '16%',
    index:5
  },
  {
    name: 'Jelly bean',
    calories: 375,
    fat: 0.0,
    carbs: 94,
    protein: 0.0,
    sodium: 50,
    calcium: '0%',
    iron: '0%',
    index:6
  },
  {
    name: 'Lollipop',
    calories: 392,
    fat: 0.2,
    carbs: 98,
    protein: 0,
    sodium: 38,
    calcium: '0%',
    iron: '2%',
    index:7
  },
  {
    name: 'Honeycomb',
    calories: 408,
    fat: 3.2,
    carbs: 87,
    protein: 6.5,
    sodium: 562,
    calcium: '0%',
    iron: '45%',
    index:8
  },
  {
    name: 'Donut',
    calories: 452,
    fat: 25.0,
    carbs: 51,
    protein: 4.9,
    sodium: 326,
    calcium: '2%',
    iron: '22%',
    index:9
  },
  {
    name: 'KitKat',
    calories: 518,
    fat: 26.0,
    carbs: 65,
    protein: 7,
    sodium: 54,
    calcium: '12%',
    iron: '6%',
    index:10
  }
]
export default {
  name:'Leads',
  data () {
    return {
      selecteds:[],
      data,
      form_dialog:false,
      style:{
       'max-height':'600px'
      },
      form:{},
      pagination: {
        rowsPerPage: 5
      },

      columns: [
        {
          name: 'index',
          label: '#',
          field: 'index'
        },
        {
          name: 'name',
          required: true,
          label: 'Dessert (100g serving)',
          align: 'left',
          field: row => row.name,
          format: val => `${val}`,
          sortable: true
        },
        { name: 'calories', align: 'center', label: 'Calories', field: 'calories', sortable: true },
        { name: 'fat', label: 'Fat (g)', field: 'fat', sortable: true },
        { name: 'carbs', label: 'Carbs (g)', field: 'carbs' },
        { name: 'protein', label: 'Protein (g)', field: 'protein' },
        { name: 'sodium', label: 'Sodium (mg)', field: 'sodium' },
        { name: 'calcium', label: 'Calcium (%)', field: 'calcium', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) },
        { name: 'iron', label: 'Iron (%)', field: 'iron', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) }
      ]
    }
  },
  mounted(){
  this.$refs.grid.requestServerInteraction();
  this.$set(this.style,'max-height',(window.innerHeight-76)+'px');

  },
  methods:{
    getSelectedString () {
      var s=this.selecteds.length > 1 ? 's' : '';
      return this.selecteds.length === 0 ? '' : this.selecteds.length+' fila'+s+' seleccionada'+s+' de '+this.data.length;
    },
    getData(args){
      console.log(args);
       this.data.push({
    name: 'Server data',
    calories: 518,
    fat: 26.0,
    carbs: 65,
    protein: 7,
    sodium: 54,
    calcium: '12%',
    iron: '6%',
    index:11
  });
    },
    add(){
  this.form_dialog=true;
    },
    onSubmit(){
    
    },
    onReset(){

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