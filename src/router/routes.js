
const routes = [
  {
    path:'/',
    component:()=>import('layouts/Login.vue')
  },
  {
    path: '/dashboard',
    component: () => import('layouts/Dashboard.vue'),
    children: [
      {path: '', component: () => import('pages/Index.vue') },
      {path:'form_manager',component:()=>import('pages/Form_manager.vue')},
      {path:'report',component:()=>import('pages/Report.vue')},
      {path:'settings',component:()=>import('pages/Settings.vue')},
      {path:'bell',component:()=>import('pages/Bell.vue')},
    ]
  },
  {
    path:'/form/:form',
    component:()=>import('layouts/Form.vue')
  }
]

// Always leave this as last one
if (process.env.MODE !== 'ssr') {
  routes.push({
    path: '*',
    component: () => import('pages/Error404.vue')
  })
}

export default routes
