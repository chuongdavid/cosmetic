const {HOST, USER, PASSWORD, DATABASE} = process.env

const mysql = require("mysql");
var connection = mysql.createConnection({
  host: HOST,
  user: USER,
  password: PASSWORD,
  database: DATABASE,
});
module.exports = connection;
