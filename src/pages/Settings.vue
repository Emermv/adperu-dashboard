<template>
  <q-page class="flex flex-start">
    <q-stepper v-model="step" vertical color="primary"  header-nav animated style="width:100%">
      <q-step :name="1" title="Medios" icon="settings" :done="step > 1">
        <q-list bordered separator>
          <q-item v-for="(s,index) in scopes" :key="s.id">
            <q-item-section top>
              <q-item-label lines="1">
                <span class="text-weight-medium">{{s.name}}</span>
              </q-item-label>
              <q-item-label caption lines="1">
                <q-badge :color="s.state?'blue':'red'">{{s.state?'Activo':'Inactivo'}}</q-badge>
              </q-item-label>
            </q-item-section>

            <q-item-section top side>
              <div class="text-grey-8 q-gutter-xs">
                
                <q-btn
           
                  size="12px"
                  flat
                  dense
                  round
                  icon="delete"
                  @click="deleteScope(s)"
                />
                <q-btn size="12px" flat dense round icon="more_vert" />
              </div>
            </q-item-section>
          </q-item>
        </q-list>

        <q-stepper-navigation>
          <q-btn
                  color="primary"
                  label="Nuevo"
                  size="md"
                  @click="scope_dialog=true"
                />
                 <q-btn @click="step = 2" color="primary" flat label="Siguiente" />
        </q-stepper-navigation>
      </q-step>

      <q-step
        :name="2"
        title="Create an ad group"
        caption="Optional"
        icon="create_new_folder"
        :done="step > 2"
      >
        An ad group contains one or more ads which target a shared set of keywords.
        <q-stepper-navigation>
          <q-btn @click="step = 4" color="primary" label="Continue" />
          <q-btn flat @click="step = 1" color="primary" label="Back" class="q-ml-sm" />
        </q-stepper-navigation>
      </q-step>

      <q-step
        :name="3"
        title="Ad template"
        icon="assignment"
        disable
      >This step won't show up because it is disabled.</q-step>

      <q-step :name="4" title="Create an ad" icon="add_comment">
        Try out different ad text to see what brings in the most customers, and learn how to
        enhance your ads using features like ad extensions. If you run into any problems with
        your ads, find out how to tell if they're running and how to resolve approval issues.
        <q-stepper-navigation>
          <q-btn color="primary" label="Finish" />
          <q-btn flat @click="step = 2" color="primary" label="Back" class="q-ml-sm" />
        </q-stepper-navigation>
      </q-step>
    </q-stepper>
    <q-dialog v-model="scope_dialog" persistent>
      <q-card style="width: 400px">
        <q-card-section>
          <div class="text-h6">Descripción</div>
        </q-card-section>

        <q-card-section>
          <q-form @submit="save_scope" ref="scope_form">
            <div class="row">
              <div class="col-xs-12 q-pa-sm">
                <q-input
                  dense
                  v-model="scope.name"
                  autofocus
                  :rules="[ val => val && val.length > 0 || 'Ingrese una descripción!']"
                />
              </div>
              <div class="col-xs-12 q-pa-sm">
                <q-btn-toggle
                  v-model="scope.state"
                  no-caps
                  rounded
                  unelevated
                  toggle-color="primary"
                  color="white"
                  text-color="primary"
                  :options="[
          {label: 'Activo', value: '1'},
          {label: 'Inactivo', value: '0'}
        ]"
                />
              </div>
            </div>
          </q-form>
        </q-card-section>

        <q-card-actions align="right" class="text-primary">
          <q-btn flat label="Cerrar" v-close-popup />
          <q-btn flat label="Guardar" type="submit" @click="save_scope" />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </q-page>
</template>

<script>
export default {
  name: "Settings",
  data() {
    // <img alt="Quasar logo" src="~assets/quasar-logo-full.svg">
    return {
      step: 1,
      scope: { state: "1" },
      scope_dialog: false,
      scopes: []
    };
  },
  created() {
    this.getAllScope();
  },
  methods: {
    save_scope() {
      this.$refs.scope_form.validate().then(ok => {
        if (ok) {
          this.$axios
            .post("service/scope/create", this.scope)
            .then(response => {
              if (response.data.state) {
                this.getAllScope();
              }
            })
            .finally(() => {
              this.scope_dialog = false;
            });
        }
      });
    },
    getAllScope() {
      this.$axios.get("service/scope/getAll").then(response => {
        if (response.data.state) {
          this.scopes = response.data.result;
        }
      });
    },
    deleteScope(row) {
      this.$q
        .dialog({
          dark: true,
          title: "¡Alerta!",
          message: "¿Está seguro(a) que desea eliminar " + row.name + "?",
          cancel: true,
          persistent: true
        })
        .onOk(() => {
          this.$axios.delete("service/scope/" + row.id).then(response => {
            if (response.data.state) {
              this.getAllScope();
            }
          });
        });
    }
  }
};
</script>
