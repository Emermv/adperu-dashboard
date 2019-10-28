var Service=require('../core/Service');
class Bell extends Service{
    constructor(c=true,l=null){
     super(c,l);
    }
    create(args,session){
      return new Promise((resolve,reject)=>{
        this.insert("bell",{
          form_id:args.form_id,
          user_id:session.user.id,
          code:args.code,
          investment:args.investment,
         title:encodeURIComponent(args.title),
         state:args.state?1:0,
         creation_date:new Date().toISOString()
      }).then(bell=>{
       // console.log(args.scopes);
          for(var scope of args.scopes){
            this.insert('bell_scope',{
              bell_id:bell.insertId,
              scope_id:scope.id,
             // url:Buffer.from(JSON.stringify({})).toString('base64'),
              creation_date:new Date().toISOString()
           });
          }
          resolve(bell);
      }).catch(reject);

      });
    }
    getById(args){
   return new Promise((resolve,reject)=>{
    this.execute("select f.title as form_title,b.form_id,b.id,b.code,b.title,b.state,b.investment from bell as b join form as f on f.id=b.form_id and b.id=? order by b.id desc",[args.id],(row)=>{
      row.title=decodeURIComponent(row.title);
      row.form_title=decodeURIComponent(row.form_title);
      row.state=row.state?true:false;
      
  }).then(bell=>{
       this.execute("select bs.id,s.name  from bell_scope as bs join scope as s on s.id=bs.scope_id where bs.bell_id=?",[bell[0].id],(row)=>{
           row.name=decodeURIComponent(row.name);
           row.url="http://localhost:3000/form/"+Buffer.from(JSON.stringify({id:row.id})).toString('base64');
       }).then(bell_scope=>{
         bell[0].scopes=bell_scope;
           resolve(bell[0]);
       }).catch(err=>{
         reject(err);
       });
  }).catch(reject);

   });

    }
    getAll(){
      return this.execute("select f.title as form_title,b.id,b.code,b.title,b.state,b.investment,date_format(b.creation_date,'%d-%m-%Y') as creation_date from bell as b join form as f on f.id=b.form_id order by b.id desc",[],(row)=>{
          row.title=decodeURIComponent(row.title);
          row.form_title=decodeURIComponent(row.form_title);
      });
    }
    getResources(){
  return new Promise((resolve,reject)=>{
    var Form=require('./Form');
    var Scope=require('./Scope');
    var form=new Form(false,this.getLink());
    var scope=new Scope(false,this.getLink());
    form.getAll().then(forms=>{
         scope.getAll().then(scops=>{
              resolve({forms:forms,scopes:scops})
         }).catch(err=>{
           reject(err);
         });

    }).catch(err=>{
      reject(err);
    });
  });
      
    }
    destroy(id){
      return this.execute('delete from scope where id=?',[id]);
    }
    getData(){
      return this.execute("SELECT  b.id,b.title as name,count(l.id) as y FROM bell as b join bell_scope as bs on bs.bell_id=b.id join lead as l on l.bell_scope_id=bs.id group by b.id order by count(l.id) desc",[],(row)=>{
        row.name=decodeURIComponent(row.name);
        row.drilldown='drilldown-'+row.id;
      });
    }
    getDrilldown(id){
      return new Promise((resolve,reject)=>{
        var data=[];
          this.execute("select s.name,count(l.id) as y from bell_scope as bs join lead as l on l.bell_scope_id=bs.id join scope as s on s.id=bs.scope_id where bs.bell_id=? group by bs.id order by count(l.id) desc",[id],(row)=>{
          data.push([decodeURIComponent(row.name),row.y]);
          }).then(result=>{
              resolve(data);
          }).catch(reject);

      });
    }
    donwload(id){
      return this.execute("select s.name,count(l.id) as y from bell_scope as bs join lead as l on l.bell_scope_id=bs.id join scope as s on s.id=bs.scope_id where bs.bell_id=? group by bs.id order by count(l.id) desc",[id]);
    }
}

module.exports=Bell;