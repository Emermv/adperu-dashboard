let mysql = require('mysql');
var pool = mysql.createPool({
    connectionLimit: 5,
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'adperu'
  });
  var $results=[];
  pool.getConnection((err, connection)=>{
    if(err){

      return;
    }
   
    connection.query("select * from form",[],(error,results,fields)=>{
      if(error){

      }else{
       $results=results
      }
    });
  });

export default {
  rows:$results
}