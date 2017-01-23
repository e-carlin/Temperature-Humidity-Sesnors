var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

/* GET Hello World page. */
router.get('/hello', function(req, res) {
    res.render('hello', { title: 'Hello!' });
});

router.get('/users', function(req, res, next) {

  req.db.all('SELECT * FROM User', function(err, row) {
    if(err !== null) {
      // Express handles errors via its next function.
      // It will call the next operation layer (middleware),
      // which is by default one that handles errors.
      next(err);
    }
    else {
      console.log(row);
      res.render('users', {User: row}, function(err, html) {
        res.send(200, html);
      });
    }
  });
});

// /* GET User table */
// router.get('/users', function(req, res) {
//     var db = req.db;
//     var collection = db.all("SELECT * FROM User");
//     // console.log(collection);
//     collection.find({},{}, function(err, docs){
//       res.render('userlist', {
//         "userlist" : docs
//       });
//     });
//     // db.serialize(function() {

//     //   db.each("SELECT rowid AS id, userName FROM User", function(err, row) {
//     //       //document.write(row.id + ": " + row.info);
//     //       console.log(row.id + ": " + row.userName);
//     //   });
//     //  });
//     // res.render('users');
// });

module.exports = router;