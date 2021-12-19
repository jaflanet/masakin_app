const bodyParser = require("body-parser");
const express = require("express");
const { pool } = require("../config/db");
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

exports.getAllLogin = async (req, res) => {
  const query = "SELECT * FROM login";
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log(result);
    res.send(result);
  });
};

exports.addLogin = async (req, res) => {
  const query = `SELECT * FROM account WHERE email = '${req.body.email}' AND password = '${req.body.password}'`;
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log(result);
    res.send(result);
  });
};
