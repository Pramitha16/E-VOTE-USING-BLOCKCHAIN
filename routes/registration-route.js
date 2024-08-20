var express = require('express');
var router = express.Router();
var db=require('../database');
var app = express();
app.use(express.urlencoded());
app.set('view engine', 'ejs');
app.use(express.static('public'))
app.use('/css',express.static(__dirname + 'public/css'))

// to display registration form 
router.get('/register', function(req, res, next) {
  res.render('registration-form.ejs');
});


// to store user input detail on post request
router.post('/register', function(req, res, next) {
    
    inputData ={
        first_name: req.body.first_name,
        last_name: req.body.last_name,
        email_address: req.body.email_address,
        gender: req.body.gender,
        password: req.body.password,
        confirm_password:req.body.confirm_password
    }
    
// check unique email address

var sql = 'SELECT * FROM registration WHERE email_address = ?';
    db.query(sql, [inputData.email_address], function (err, data, fields) {
        if (err) throw err;
        if (data.length > 0) {
            var msg = inputData.email_address + " already exists";
            res.render('registration-form.ejs', { alertMsg: msg });
        } else if (inputData.confirm_password !== inputData.password) {
            var msg = "Password and Confirm Password do not match";
            res.render('registration-form.ejs', { alertMsg: msg });
        } else {
            // Save user data into database
            var insertSql = 'INSERT INTO registration SET ?';
            db.query(insertSql, inputData, function (err, data) {
                if (err) throw err;
                var msg = "You are successfully registered";
                res.render('registration-form.ejs', { alertMsg: msg });
            });
        }
    });
});
module.exports = router;

