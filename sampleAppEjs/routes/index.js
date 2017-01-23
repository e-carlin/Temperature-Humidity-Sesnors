var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
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
      res.render('users', {users: row, title: 'Users'}, function(err, html) {
        res.send(200, html);
      });
    }
  });
});

module.exports = router;
