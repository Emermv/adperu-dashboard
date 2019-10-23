var Service=require('../core/Service');
class Form extends Service{
    constructor(c=true,l=null){
     super(c,l);
    }
    create(args){
      return this.insert("form",{
         title:encodeURIComponent(args.title),
         creation_date:new Date().toISOString()
      });
    }
    getAll(){
      return this.execute('select id,title,state,creation_date from form order by id desc',[],(row)=>{
          row.title=decodeURIComponent(row.title);
      });
    }
    destroy(id){
      return this.execute('delete from scope where id=?',[id]);
    }
}

module.exports=Form;