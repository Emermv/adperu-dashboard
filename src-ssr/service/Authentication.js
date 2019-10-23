var Service=require('../core/Service');

class Authentication extends Service{
    constructor(c=true,l=null){
        super(c,l);
    }
    run(args){
      return  this.execute('select u.id,u.company_id,u.name,u.email,u.user,u.avatar,u.level,c.code,c.ruc,c.name as company_name,c.database_name from app_db.users as u join app_db.company as c on c.id=u.company_id where u.user=? and u.password=? and u.state=1',[args.user,args.password]);
    }
}

module.exports=Authentication;