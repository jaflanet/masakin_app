const bodyParser = require("body-parser");
const express = require("express");
const { pool } = require("../config/db");
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

exports.signupAccount = async (req, res) => {
  const query = `INSERT INTO account(email, password, name, accPhoneNumber, address) VALUES ('${req.body.email}', '${req.body.password}', '${req.body.name}', '${req.body.accPhoneNumber}', '${req.body.address}')`;
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log("berhasil");
    res.send("berhasil");
  });
};
