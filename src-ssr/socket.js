var app = require('express')();
var http = require('http').createServer(app);
var io = require('socket.io')(http);


io.on('connection', function(socket){
  console.log('a user connected');
  socket.on('getData',()=>{
var Bell=require('./service/Bell');
console.log("getData");
var bell=new Bell();
bell.getData().then(results=>{
    io.emit("data",results);
});
});
socket.on("getDrilldown",(id)=>{
    var Bell=require('./service/Bell');
    var bell=new Bell();
    bell.getDrilldown(id).then(results=>{
        socket.emit("drilldown",results);
    });

});

});
http.listen(4000, function(){
  console.log('listening on *:3000');
});