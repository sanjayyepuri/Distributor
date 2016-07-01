var jackrabbit = require('jackrabbit');
var http = require('http');

var rabbit = jackrabbit('amqp://localhost');
var exchange = rabbit.default();
var tasks = exchange.queue({ name: 'task_queue', durable : true});

tasks.consume(run);

function run(data, ack){
    console.log(JSON.stringify(data));
    data.data.forEach(function(file){
            var req = http.request({
            host: 'localhost',
            path: '/shellscripts/'+escape(file.originalname),
            port: '3000',
            method: 'GET'
        }, function(res){
            console.log('data');
            var data = '';
            res.on('data', function(chunk){
                data += chunk;
            });

            res.on('end', function(){
                console.log(file.originalname +'<>>>>>>>>>>>>>')
                console.log(data);
                
            });
        });
        req.end();
    });
    ack();
    /*var req = http.request({
        host: 'localhost',
        path: '/shellscripts/'+data.filename,
        port: '3000',
        method: 'GET'
    }, function(res){
        console.log('data');
        var file = '';
        res.on('data', function(chunk){
            file += chunk;
        });

        res.on('end', function(){
            console.log(file);
            ack();
        });
    });
    req.end();*/
}
