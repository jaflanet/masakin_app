const bodyParser = require("body-parser");
const express = require("express");
const { pool } = require("../config/db");
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

exports.getAllTestOrder = async (req, res) => {
  const query = "SELECT * FROM testOrder";
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log(result);
    res.send(result);
  });
};

exports.getTestOrderById = async (req, res) => {
  const query = `SELECT * FROM testOrder WHERE id = '${req.body.id}'`;
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log(result);
    res.send(result);
  });
};

exports.addTestOrder = async (req, res, next) => {
  const query = `INSERT INTO testOrder(orderMenu) VALUES ('${req.body.orderMenu}')`;
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log("berhasil");
    res.send("berhasil");
  });
};
