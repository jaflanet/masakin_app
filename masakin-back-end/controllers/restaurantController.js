const bodyParser = require("body-parser");
const express = require("express");
const { pool } = require("../config/db");
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

exports.getAllRestaurant = async (req, res) => {
  const query = "SELECT * FROM restaurant";
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log(result);
    res.send(result);
  });
};

exports.getRestaurantById = async (req, res) => {
  const query = `SELECT * FROM restaurant WHERE restaurantId = '${req.params.restaurantId}'`;
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log(result);
    res.send(result);
  });
};

exports.addRestaurant = async (req, res, next) => {
  const query = `INSERT INTO restaurant(restaurantName, rating, address, resPhoneNumber) VALUES ('${req.body.restaurantName}', '${req.body.rating}', '${req.body.address}', '${req.body.resPhoneNumber}')`;
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log("berhasil");
    res.send("berhasil");
  });
};

exports.deleteRestaurant = async (req, res) => {
  const query = `DELETE FROM restaurant WHERE restaurantId = '${req.params.restaurantId}'`;
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log("berhasil");
    res.send("berhasil");
  });
};

exports.updateRestaurant = async (req, res) => {
  const query = `UPDATE restaurant SET restaurantName = '${req.body.restaurantName}', rating = ${req.body.rating}, address = '${req.body.address}', resPhoneNumber = '${req.body.resPhoneNumber}' WHERE restaurantId = ${req.params.restaurantId}`;
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log("berhasil");
    res.send("berhasil");
  });
};
