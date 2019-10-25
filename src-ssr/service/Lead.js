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
          os:ua.os,
          browser:ua.browser,
         ip:req.header('x-forwarded-for') || req.connection.remoteAddress,
          creation_date:new Date().toISOString()
       }).then(lead=>{
           var size=Object.keys(args.data);
           for(var key in args.data){
            this.insert('lead_data',{
                lead_id:lead.insertId,
                label:key,
                description:encodeURIComponent(args.data[key]),
                creation_date:new Date().toISOString()
            });
           }
           resolve(lead);
       }).catch(reject);


     });
    }
    getAll(){
      return this.execute('select id,name,state from scope order by id desc');
    }
    destroy(id){
      return this.execute('delete from scope where id=?',[id]);
    }
    find(args){
      let q=encodeURIComponent(args.q);
 let sql="select id,name from scope where name like '%"+q+"%' order by id desc limit 10";
 //console.log(sql);
      return this.execute(sql,[],(row)=>{
        row.name=decodeURIComponent(row.name);
      });
    }
}

module.exports=Lead;