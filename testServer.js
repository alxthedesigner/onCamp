const MongoClient = require('mongodb').MongoClient;
const assert = require('assert').strict;
const app = require('express');
const mongoose = require('mongoose');

const url = 'mongodb://localhost/kentuckyState';
const dbName = 'kentuckyState';

mongoose.connect(url, { useNewUrlParser: true });
var db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function() {
  console.log("WE ARE CONNECTED")

var userSchema = new mongoose.Schema({
        name: String,
        birthday: String,
        email: String,
        password: String,
        school: String

});

db.close();
});

