# Generic Parallel Task Distributor
## Running the project 
1. Navigate to both the worker and distributor directories and run `npm install`
2. Install and Start RabbitMQ server (`rabbitmq-server`)
3. Run `node worker.js` in the worker folder for each instance of a worker you want.
4. Finally start the webserver by running `npm start` in the distributor folder.