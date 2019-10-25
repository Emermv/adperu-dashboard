<template>
  <q-layout view="hHh LpR fFf" class="bg-grey-3">
    <q-header class="bg-grey-3 text-grey-9" reveal height-hint="60">
      <q-toolbar class="GPLAY__toolbar text-grey-6 ">
        <q-btn
          v-if="this.$q.platform.is.mobile || !leftDrawerOpen"
          flat
          dense
          round
          @click="leftDrawerOpen = !leftDrawerOpen"
          aria-label="Menu"
          icon="menu"
          class="q-mr-sm"
        />

        <div class="q-pr-lg" v-if="$q.screen.gt.xs">
          <img class="GPLAY__logo cursor-pointer" src="statics/icons/logo.png" @click="navigate('/')">
        </div>

        <q-space />

        <div class="GPLAY__toolbar-input-container row no-wrap">
          <q-input dense outlined square v-model="search" placeholder="Buscar" class="bg-white col" />
          <q-btn class="GPLAY__toolbar-input-btn" color="primary" icon="search" unelevated />
        </div>

        <q-space />

        <div class="q-pl-md q-gutter-sm row no-wrap items-center">
          <q-btn round dense flat color="grey-8" size="14px" icon="apps">
            <q-tooltip>Apps</q-tooltip>
          </q-btn>

          <q-btn round dense flat color="grey-8" icon="notifications">
            <q-badge color="red" text-color="white" floating>
              2
            </q-badge>
            <q-tooltip>Notificaciones</q-tooltip>
          </q-btn>


          <q-btn round flat>
            <q-avatar size="26px">
              <img src="https://cdn.quasar.dev/img/boy-avatar.png">
            </q-avatar>
            <q-menu auto-close>
          <q-list style="min-width: 100px">
            <q-item clickable>
              <q-item-section>New tab</q-item-section>
            </q-item>
            <q-item clickable>
              <q-item-section>New incognito tab</q-item-section>
            </q-item>
            <q-separator />
            <q-item clickable tag="a" href="/exit">
              <q-item-section>Cerar sesión</q-item-section>
            </q-item>

          </q-list>
        </q-menu>
          </q-btn>
        </div>
      </q-toolbar>
    </q-header>

    <q-drawer
      v-model="leftDrawerOpen"
      show-if-above
      bordered
      content-class="bg-grey-3 text-grey-7"
      :width="200"
    >
      <q-list>

        <q-item clickable class="GPLAY__drawer-link bg-grey-10 text-grey-3" @click="navigate('/')">
          <q-item-section avatar class="text-grey-1">
            <q-icon name="home" />
          </q-item-section>
          <q-item-section class="text-grey-3">
            <q-item-label>Inicio</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable class="GPLAY__drawer-link GPLAY__drawer-link--apps" @click="navigate('/form_manager')">
          <q-item-section avatar class="bg-green-7 text-grey-1 text-center">
            <q-icon name="code" />
          </q-item-section>
          <q-item-section class="apps-text">
            <q-item-label>Formularios</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable class="GPLAY__drawer-link GPLAY__drawer-link--movies" @click="navigate('/bell')">
          <q-item-section avatar class="movies-icon bg-red-7 text-grey-1 text-center">
            <q-icon name="local_movies" />
          </q-item-section>
          <q-item-section class="movies-text">
            <q-item-label>Campañas</q-item-label>
          </q-item-section>
        </q-item>
        <q-item clickable class="GPLAY__drawer-link GPLAY__drawer-link--books" @click="navigate('/report')">
          <q-item-section avatar class="books-icon bg-blue-7 text-grey-1 text-center">
            <q-icon name="report" />
          </q-item-section>
          <q-item-section class="books-text">
            <q-item-label>Reportes</q-item-label>
          </q-item-section>
        </q-item>

        <q-item clickable class="GPLAY__drawer-link GPLAY__drawer-link--devices" @click="navigate('/settings')">
          <q-item-section avatar class="devices-icon bg-blue-grey-7 text-grey-1 text-center">
            <q-icon name="devices" />
          </q-item-section>
          <q-item-section class="devices-text">
            <q-item-label>Configuración</q-item-label>
          </q-item-section>
        </q-item>

        <q-separator class="q-mb-md" />

        <q-item v-for="link in links1" :key="link.text" v-ripple dense clickable class="GPLAY__drawer-item">
          <q-item-section class="text-grey-8">
            <q-item-label>{{ link.text }}</q-item-label>
          </q-item-section>
        </q-item>
      </q-list>
    </q-drawer>

    <q-page-container>
      <router-view />


    </q-page-container>
  </q-layout>
</template>

<script>
export default {
  name: 'Dashboard',
  data () {
    return {
      leftDrawerOpen: false,
      search: '',
      storage: 0.26,
      links1: [
        { text: 'Mi cuenta' },
        { text: 'Créditos' },
 
      ]
    }
  },
  methods:{
      navigate(to="/"){
      this.$router.push("/dashboard"+to);
    }
  }
}
</script>

<style lang="sass">
.GPLAY
  &__toolbar
    height: 60px
  &__logo
    width: auto
    height: 39px
  &__toolbar-input-container
    min-width: 100px
    width: 55%
  &__toolbar-input-btn
    border-radius: 0
    max-width: 60px
    width: 100%
  &__drawer-link
    .q-item__section--avatar
      margin: -8px 0 -8px -16px
      padding: 8px 0 8px 16px
    .q-item__section--main
      margin: -8px -16px -8px 16px
      padding: 8px 16px 8px 2px
      font-size: 18px
      font-weight: 300
    &--apps, &--movies, &--music, &--books, &--devices
      background: #f5f5f5!important
      &:hover
        color: #eee !important
    &--apps:hover
      background: #43a047!important
    &--movies:hover
      background: #e53935!important
    &--music:hover
      background: #fb8c00!important
    &--books:hover
      background: #1e88e5!important
    &--devices:hover
      background: #546e7a!important
  &__drawer-item
    padding: 6px 12px 6px 23px
  &__sticky
    min-height: 49px
    border-bottom: 1px solid rgba(0,0,0,0.12)
  &__sticky-help
    border: 1px solid #ccc
    padding-left: 8px
    padding-right: 8px
  &__sticky-settings
    padding-left: 17px
    padding-right: 17px
    border: 1px solid #ccc
</style>