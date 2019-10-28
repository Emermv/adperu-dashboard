<template>
  <q-page class="flex ">
<div class="q-pa-md" style="width:100%">
    <q-table
      class="my-sticky-virtscroll-table"
       :dense="$q.screen.lt.md"
      virtual-scroll
      :table-style="style"
      :pagination.sync="pagination"
      :rows-per-page-options="[15,20,50]"
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
      <div class="col-2 q-table__title">Campañas</div>

        <q-space />
         <q-btn
          flat round dense
          :icon="props.inFullscreen ? 'fullscreen_exit' : 'fullscreen'"
          @click="props.toggleFullscreen"
          class="q-ml-md"
        />
    </template>
    <template v-slot:body-cell-action="props">
        <q-td :props="props">
           <q-btn size="12px" color="negative" flat dense round icon="delete" />
            <q-btn  size="12px"  color="primary" flat dense round icon="remove_red_eye" @click="show_detail(props.row.id)"/>
           <q-btn size="12px" color="green" flat dense round icon="cloud_download" @click="donwload(props.row.id)" />
        </q-td>
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
          <div class="text-h6">Nueva campaña</div>
        </q-card-section>

        <q-separator />

        <q-card-section class="scroll">
        <div class="fit row wrap justify-between   ">
  <div class="col-xs-12 col-sm-6 col-md-6 q-gutter-md">
     <q-select filled v-model="form.form_id" :options="forms" label="Formulario" option-value="id"
        option-label="title" emit-value :map-options="true" dense/>

  </div>
  <div class="col-xs-12 col-sm-6 col-md-6 q-gutter-md">
    <q-input
        filled
        v-model="form.code"
        label="Código"
        lazy-rules
        dense
        :rules="[ val => val && val.length > 0 || 'Por favor ingrese un código']"
      />

  </div>
  <div class="col-xs-12 col-sm-6 col-md-6 q-gutter-md">
    <q-input
        filled
        v-model="form.title"
        label="Título"
        dense
        lazy-rules
        :rules="[ val => val && val.length > 0 || 'Por favor ingrese un título']"
      />

  </div>
    <div class="col-xs-12 col-sm-6 col-md-6 q-gutter-md">
    <q-input
        filled
        v-model="form.investment"
        label="Inversión"
        lazy-rules
        dense
        type="number"
        :rules="[ val => val!=''  || 'Por favor ingrese este campo']"
      />

  </div>
      <div class="col-xs-12 col-sm-6 col-md-6 q-gutter-md">
       <q-checkbox v-model="form.state" :label="form.state?'Activo':'Inactivo'" />
      </div>
</div>
<div class="col-xs-12 col-sm-12 col-md-12 q-gutter-md">
  
<q-input dense filled v-model="search" label="Público" >
          <template v-slot:append>
            <q-icon v-if="search === ''" name="search" />
            <q-icon v-else name="clear" class="cursor-pointer" @click="search = ''" />
          </template>
<q-menu  fit>
          <q-list style="min-width: 100px">
            <q-item v-show="scopes.length==0 && search.length>0" >
              <q-item-section>Sin resultados para {{search}}</q-item-section>
            </q-item>
          <q-item  clickable v-for="s in scopes" :key="s.id" @click="pushItem(s)" v-close-popup>
              <q-item-section>{{s.name}}</q-item-section>
            </q-item>
          </q-list>
        </q-menu>
        </q-input>

</div>
<div class="col-xs-12 col-sm-12 col-md-12 q-gutter-md">
   <q-list bordered>
      <q-item clickable v-ripple v-for="s in form.scopes" :key="s.id">
        <q-item-section>{{s.name}}</q-item-section>
              <q-item-section top side>
          <div class="text-grey-8 q-gutter-xs">
            <q-btn size="12px" color="negative" flat dense round icon="delete" />
            <q-btn v-if="s.url" size="12px"  color="primary" flat dense round icon="public" @click="open_url(s.url)"/>
          </div>
        </q-item-section>
      </q-item>



   </q-list>
</div>

        </q-card-section>
        <q-separator />

        <q-card-actions align="right">
          <q-btn flat label="Cerrar" color="default" v-close-popup />
          <q-btn flat label="Guardar" color="primary" type="submit" />
        </q-card-actions>
      </q-card>
      </q-form>
      </q-card>
    </q-dialog>
              

  </q-page>
</template>
<script>
export default {
  name:'Bell',
  data () {
    return {
      selecteds:[],
      rows:[],
      search:'',
      form_dialog:false,
      style:{
       'max-height':'600px'
      },
      form:{state:true,scopes:[]},
      forms:[],
      show_scope_menu:false,
      scopes:[],
      pagination: {
        rowsPerPage: 5
      },

      columns: [
        {
          label: '#',
          field: 'id'
        },
        {
          field:'code',
          required: true,
          label: 'Código',
          align: 'left',
        
          sortable: true
        },
        {  align: 'left', label: 'Título', field: 'title', sortable: true },
        {  label: 'Inversión', field: 'investment', sortable: true },
        { align:'left',label: 'Formulario', field: 'form_title', sortable: true },
        {  label: 'Fecha', field: 'creation_date' },
        {label:'Acción',name:'action'}
      ]
    }
  },
  created(){
  this.getData();
  this.getResources();
  },
  mounted(){
  //this.$refs.grid.requestServerInteraction();
  this.$set(this.style,'max-height',(window.innerHeight-76)+'px');
  },
  methods:{
  pushItem(item){
    var exist=false;
   this.show_scope_menu=false;
      for(var s of this.form.scopes){
        if(s.id==item.id){
          exist=true;
          break;
        }
      }
      if(!exist){
         this.form.scopes.push(item);
      }else{
        this.$q.notify({
                    color:'red-5',
                     textColor:'white',
                     position:'center',
                     message:item.name+' ya fue seleccionado!',
                     actions:[ { label: 'Ok', color: 'white'} ]
        });
      }
  },
    getSelectedString () {
      var s=this.selecteds.length > 1 ? 's' : '';
      return this.selecteds.length === 0 ? '' : this.selecteds.length+' fila'+s+' seleccionada'+s+' de '+this.rows.length;
    },
    getResources(){
      this.$axios.get('service/bell/getResources').then(response=>{
          if(response.data.state){
           this.forms=response.data.result.forms;
         // this.scopes=response.data.result.scopes;
          }
      });
    },
    getData(args){
      this.$axios.get('service/bell/getAll').then(response=>{
      if(response.data.state){
          this.rows=response.data.result;
      }
      });
    },
    add(){

      this.form={state:true,form_id:this.forms[0].id,scopes:[]};
       this.form_dialog=true;
    },
    notify(sms){
      this.$q.notify({
                    color:'red-5',
                     textColor:'white',
                     position:'center',
                     message:sms,
                     actions:[ { label: 'Ok', color: 'white'} ]
          });
    },
    onSubmit(){
      this.$refs.form.validate().then(ok=>{
      if(ok){
        if(this.form.scopes.length>0){
            this.$axios.post('service/bell/create',this.form).then(response=>{
        if(response.data.state){
          this.getData();
          this.form_dialog=false;
        }else{
        this.notify('Lo sentimos, pero ocurrió un error inesperado!');
        }
        });
        }else{
          this.notify('Por favor añada por lo menos un público!');
        }
      }
      });
    },
    show_detail(id){
      this.$axios.post('service/bell/getById',{id:id}).then(response=>{
         if(response.data.state){
           this.form=response.data.result;
           this.form_dialog=true;
         }
      });
    },
    open_url(url){
      window.open(url,'_blank');
    },
    donwload(id){
      window.open('donwload/'+id,'_blank');
    }
  },
  watch:{
    search(val){
       if(val.length>1){
          this.$axios.post('service/scope/find',{q:val}).then(response=>{
             if(response.data.state){
                     this.$set(this,'scopes',response.data.result);
                 }else{
                   this.scopes=[];
                 }
          }).finally(()=>{
            this.show_scope_menu=true;
          });
       }
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