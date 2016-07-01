var jackrabbit = require('jackrabbit');
var http = require('http');

var rabbit = jackrabbit('amqp://localhost');
var exchange = rabbit.default();
var tasks = exchange.queue({ name: 'task_queue', durable : true});

// Watches for incoming tasks and passes it the callback
tasks.consume(run); 

// The callback called when a task is assigned
// Logs the raw data and requests for each of the files sent
function run(data, ack){
    console.log(JSON.stringify(data));
    data.data.forEach(function(file){
            var req = http.request({
            host: 'localhost', // This must be changed to be dynamic so it can run from multiple locations
            path: '/shellscripts/'+escape(file.originalname),
            port: '3000', // This also is not a constant value that must be changed to be dynamic 
            method: 'GET'
        }, function(res){
            console.log('data');
            var data = '';
            res.on('data', function(chunk){
                data += chunk;
            });

            res.on('end', function(){
                console.log( '<<<<<<<<<<<<<==='+ file.originalname + '===>>>>>>>>>>>>>');
                console.log(data);
                // Here you would do logic to write the file to storage and create a Promise or Observable that 
                // is triggered when all the files are written. 
            });
        });
        req.end();
    });
    ack();
    // After all the data is written and processed this is called to acknowlege with the RabbitMQ server that 
    // the operation is a success
}
