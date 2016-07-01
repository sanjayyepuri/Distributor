var express = require('express');
var router = express.Router();
var jackrabbit = require('jackrabbit');

var rabbit = jackrabbit ('amqp://localhost');
var exchange = rabbit.default();
var tasks = exchange.queue({name: 'task_queue', durable: true});

//set up filestorage
var multer = require('multer');
var storage = multer.diskStorage({
  destination:function(req, file, cb){
    cb(null, './public/shellscripts/');
  },
  filename: function(req, file, cb){
    cb(null, file.originalname);
  }
});
var upload = multer({storage: storage});

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

//File Uploads
router.post('/', upload.any(), function(req, res, next){
  console.log(req.files);
  exchange.publish({ data: req.files }, {key: 'task_queue'});
  res.status(204).end();
});

module.exports = router;
