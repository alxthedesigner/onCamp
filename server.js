const MongoClient = require('mongodb').MongoClient;
const assert = require('assert').strict;
const app = require('express');
const mongoose = require('mongoose');

const url = 'mongodb://localhost/kentuckyState';
const dbName = 'kentuckyState';

mongoose.connect(url,{ useNewUrlParser: true },function(err, db){


        if(err){
                throw err
        }else{
                console.log("Connection to server successfull!!");
        }


/*var userSchema = new mongoose.Schema({
        name: String,
        birthday: String,
        email: String,
        password: String,
        school: String

});



db.collection('users').insertOne({
        name: "¨forest green",
        birthday: "",
        email: "",
        password: "",
        school: ""
})*/

db.close();
});
