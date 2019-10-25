var Service=require('../core/Service');
class Scope extends Service{
    constructor(c=true,l=null){
     super(c,l);
    }
    create(args){
      return this.insert("scope",{
         name:args.name,
         state:args.state,
         creation_date:new Date().toISOString()
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

module.exports=Scope;