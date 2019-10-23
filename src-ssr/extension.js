/*
 * This file runs in a Node context (it's NOT transpiled by Babel), so use only
 * the ES6 features that are supported by your Node version. https://node.green/
 *
 * All content of this folder will be copied as is to the output folder. So only import:
 *  1. node_modules (and yarn/npm install dependencies -- NOT to devDependecies though)
 *  2. create files in this folder and import only those with the relative path
 *
 * Note: This file is used for both PRODUCTION & DEVELOPMENT.
 * Note: Changes to this file (but not any file it imports!) are picked up by the
 * development server, but such updates are costly since the dev-server needs a reboot.
 */

var session=require('express-session');
var bodyParser = require('body-parser');
module.exports.extendApp = function ({ app, ssr }) {
  /*
     Extend the parts of the express app that you
     want to use with development server too.

     Example: app.use(), app.get() etc
  */
 app.use(session({ secret: 'your secret here' }));
 app.use(bodyParser.urlencoded({ extended: false }));
 app.use(bodyParser.json());
 app.get('/',(req,res,next)=>{
    if(req.session.user){
      res.redirect('/dashboard')
    }else{
      next();
    }
 });
 app.get('/dashboard',(req,res,next)=>{
  if(req.session.user){
    next();
    
  }else{
    res.redirect('/')
  }
});

 app.route('/service/:service/:action').get((req,res)=>{
   var service=req.params.service;
  var cls= require("./service/"+ service.charAt(0).toUpperCase() + service.slice(1));
   var $service=new cls();
     $service[req.params.action]().then(response=>{
      $service.set('result',response);
      $service.set('state',response?true:false);
     res.json($service.toJSON());
    });
}).post((req,res)=>{
  var service=req.params.service;
  var cls= require("./service/"+ service.charAt(0).toUpperCase() + service.slice(1));
   var $service=new cls();
     $service[req.params.action](req.body).then(response=>{
       $service.set('result',response);
       $service.set('state',response?true:false);
      res.json($service.toJSON());
     });
}).delete((req,res)=>{
  var service=req.params.service;
  var cls= require("./service/"+ service.charAt(0).toUpperCase() + service.slice(1));
   var $service=new cls();
     $service.destroy(req.params.action).then(response=>{
       $service.set('result',response);
       $service.set('state',response?true:false);
      res.json($service.toJSON());
     });
});
/*
app.get('/service/:service/:action/:id',(req,res)=>{
  var service=req.params.service;
  var cls= require("./service/"+ service.charAt(0).toUpperCase() + service.slice(1));
   var $service=new cls();
     $service[req.params.action](req.params.id).then(response=>{
      $service.set('result',response);
      $service.set('state',response?true:false);
     res.json($service.toJSON());
    });
});
*/


app.get('/session',(req,res)=>{
   res.json({
       session:req.session
   });
});
app.post('/service/authentication',(req,res)=>{
var Authentication=require('./service/Authentication');
var auth=new Authentication();
auth.run(req.body).then(response=>{
req.session.user=response[0];
auth.set('state',true);
res.json(auth.toJSON());
}).catch(error=>{
  res.json(auth.toJSON());
});
});

app.get('/exit',(req,res)=>{
     req.session.destroy();
     res.redirect('/');
});

}
