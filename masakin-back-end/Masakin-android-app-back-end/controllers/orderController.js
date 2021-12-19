const bodyParser = require("body-parser");
const express = require("express");
const { pool } = require("../config/db");
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

exports.getAllOrder = async (req, res) => {
  const query = "SELECT * FROM orderMenu";
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log(result);
    res.send(result);
  });
};

exports.getOrderByEmail = async (req, res) => {
  const query = `SELECT * FROM orderMenu WHERE email = '${req.query.email}'`;
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log(result);
    res.send(result);
  });
};

exports.addOrder = async (req, res, next) => {
  const query = `INSERT INTO orderMenu(email, orderFood, totalPrice) VALUES ('${req.body.email}', '${req.body.orderFood}', '${req.body.totalPrice}')`;
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log("berhasil");
    res.send("berhasil");
  });
};
