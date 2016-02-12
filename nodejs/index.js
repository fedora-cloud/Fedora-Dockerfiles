'use strict';

var
  express = require('express'),
  app = express(),
  port = process.env.PORT || 3000; //load port number from application environment

app.get('/', function (req, res) {
  res.send('Hello from Docker container!\n');
});

app.listen(port, function(error){
  if(error) {
    throw error; //error binding to port
  }
  console.log('ExpressJS application is running on http://localhost:%d', port);
});
