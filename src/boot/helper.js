// import something here

// "async" is optional
export default async ({ app,router,Vue }) => {
  Vue.prototype.$helper={
        toFormData(data){
          var form=new FormData();
            for(var key in data){
              form.append(key,data[key]);
            }
            return form;
        }
  };
}
