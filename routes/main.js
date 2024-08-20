var express = require('express');
var router = express.Router();
/* GET users listing. */
// const express=require('express');
// const app=express()
var conn = require('../database');

router.get('/form', function (req, res, next) {
  // res.render('voter-registration.ejs');
  if (req.session.loggedinUser) {
    res.render('voter-registration.ejs')
  } else {
    res.redirect('/login');
  }
});



var account_address;
var data;

// app.use(express.static('public'));
// //app.use('/css',express.static(__dirname+'public/css'));
// //app.use(express.json());
// app.use(express.urlencoded());

router.post('/registerdata', function (req, res) {
  var dob = [];
  data = req.body.aadharno;    //data stores aadhar no
  // console.log(data);
  account_address = req.body.account_address;     //stores metamask acc address
  //console.log(data);
  voter_name = req.body.voter_name;
  let sql = "SELECT * FROM aadhar_info WHERE Aadharno = ?";
  conn.query(sql, data, (error, results, fields) => {
    console.log(results);
    if (error || results.length===0) {
      console.log("IN");
      var msg = "Enter valid Aadhar number.";
      res.render('voter-registration.ejs', { alertMsg: msg });

    }
    else if (voter_name != results[0].Name) {
      var msg = "Enter proper details";
      res.render('voter-registration.ejs', { alertMsg: msg });
    }
    else {
      console.log(results)
      console.log(results[0].dob)
      dob = results[0].dob;
      console.log(dob);
      var email = results[0].Email;
      age = dob;
      is_registerd = results[0].Is_registered;
      if (is_registerd != 'YES') {
        if (age >= 18) {

          var record = { Account_address: account_address, Is_registered: 'Yes' };
          var sql = "INSERT INTO registered_users SET ?";
          conn.query(sql, record, function (err2, res2) {
            if (err2) {
              throw err2;
            }
            else {
              var record1 = ['YES', data];
              var sql1 = "Update aadhar_info set Is_registered=? Where Aadharno=?";
              conn.query(sql1, record1, function (err1, res1) {
                if (err1) {
                  res.render('voter-registration.ejs');
                }
                else {
                  console.log("1 record updated");
                  var msg = "You are successfully registered";
                  var vadd = account_address;
                  // res.send('You are successfully registered');
                  res.render('voter-registration.ejs', { alertMsg: msg, voterAdd: vadd });
                }
              });

            }
          });
        }
        else {
          res.send('You cannot vote as your age is less than 18');
        }
      }
      else    //IF USER ALREADY REGISTERED
      {
        res.render('voter-registration.ejs', { alertMsg: "You are already registered. You cannot register again" });
      }
    }


  });

  
})

// router.get('/register',function(req,res){
//     res.sendFile(__dirname+'/views/index.html')
// });

/*app.get('/signin_signup',function(req,res){
    res.sendFile(__dirname+'/views/signup.html')
});

app.get('/signup',function(req,res){
    console.log(req.body);
    res.sendFile(__dirname+'/views/signup.html')
});*/

module.exports = router;