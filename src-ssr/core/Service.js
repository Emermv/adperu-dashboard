let mysql = require('mysql');
class Service{
    
    constructor(connect=true,link=null){
     if(connect){
         this.pool = mysql.createPool({
            connectionLimit: 5,
            host: 'localhost',
            user: 'developer',
            password: 'dashboard2019',
            database: 'adperu'
          });
     }else{
     this.pool=link;
     }
     this.response={state:false,message:''};
    }
    getLink(){
      return this.pool;
    }
    insert(table,args){
 return new Promise((resolve,reject)=>{
    this.pool.getConnection((err, connection)=>{
        if(err){
         reject(err);
          return;
        }
        var values=[],cols=[];
        for(var key in args){
            values.push(args[key]);
            cols.push(key);
        }
        var str_cols=cols.join("`,`");
        var str_values=values.join("','");

       var sql="insert into `"+table+"` (`"+str_cols+"`) values('"+str_values+"');";
        connection.query(sql,(error,results,fields)=>{
          if(error){
         reject(error);
          }else{
            resolve(results,fields);
          }
        });
      });
 });
        
    }
    multi_insert(table,args){
      return new Promise((resolve,reject)=>{
         this.pool.getConnection((err, connection)=>{
             if(err){
              reject(err);
               return;
             }
             var values=[],cols=[];
             for(var arg of args){
                 
               
                  var row=[];
                  for(var col in arg){
                    row.push(arg[col]);
                    if(cols.length==0){
                    cols=Object.keys(arg);
                     }
                   }
                   values.push(row);
                 
             }
             var str_cols=cols.join("`,`");
            var sql="insert into `"+table+"` (`"+str_cols+"`) values ?";
             connection.query(sql,[values],(error,results,fields)=>{
               if(error){
              reject(error);
               }else{
                 resolve(results,fields);
               }
             });
           });
      });
             
         }
    execute(sql,args=[],helper=null){
        return new Promise((resolve,reject)=>{
            this.pool.getConnection((err, connection)=>{
                if(err){
                 reject(err);
                  return;
                }
               
                connection.query(sql,args,(error,results,fields)=>{
                  if(error){
                 reject(error);
                  }else{
                    if(typeof helper=="function"){
                     for(var row in results){
                       helper(results[row]);
                     }
                    }
                    resolve(results,fields);
                  }
                });
              });
         }); 
    }
    toJSON(){
        return this.response;
    }
    set(key,val){
        this.response[key]=val;
    }
}

module.exports=Service;