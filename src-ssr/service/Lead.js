var Service=require('../core/Service');

class Lead extends Service{
    constructor(c=true,l=null){
     super(c,l);
    }
    create(args,session,req){
        var useragent = require('express-useragent');
     return new Promise((resolve,reject)=>{
        var form=JSON.parse(Buffer.from(args.form, 'base64').toString('ascii'));
        var ua=useragent.parse(req.headers['user-agent']);
        this.insert("lead",{
          bell_scope_id:form.id,
          os:encodeURIComponent(ua.os),
          browser:encodeURIComponent(ua.browser),
         ip:req.header('x-forwarded-for') || req.connection.remoteAddress,
          creation_date:new Date().toISOString().substr(0,10)+" "+new Date().toTimeString().substr(0,8)
       }).then(lead=>{
        var values=[];
           for(var key in args.data){
             values.push({
              lead_id:lead.insertId,
              label:key,
              description:encodeURIComponent(args.data[key]),
              creation_date:new Date().toISOString().substr(0,10)+" "+new Date().toTimeString().substr(0,8)
          });
           }
           this.multi_insert('lead_data',values).then(result=>{
             lead.data=result;
            resolve(lead);
           }).catch(reject);
           
       }).catch(reject);


     });
    }
}

module.exports=Lead;