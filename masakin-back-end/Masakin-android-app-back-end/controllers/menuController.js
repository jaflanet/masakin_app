const bodyParser = require("body-parser");
const express = require("express");
const { pool } = require("../config/db");
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
const { cloudinary } = require("../config/cloudinaryConfig");

exports.getAllMenu = async (req, res) => {
  const query = "SELECT * FROM menu";
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log(result);
    res.send(result);
  });
};

exports.getMenuByRestaurantId = async (req, res) => {
  const query = `SELECT * FROM menu WHERE restaurantId = '${req.params.restaurantId}'`;
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log(result);
    res.send(result);
  });
};

exports.getMenuByMenuId = async (req, res) => {
  const query = `SELECT * FROM menu WHERE restaurantId = '${req.params.restaurantId}' AND menuId = '${req.params.menuId}'`;
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log(result);
    res.send(result);
  });
};

exports.deleteMenu = async (req, res) => {
  const query = `DELETE FROM menu WHERE menuId = '${req.params.menuId}' AND restaurantId = '${req.params.restaurantId}'`;
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log("berhasil");
    res.send("berhasil");
  });
};

exports.updateMenu = async (req, res) => {
  await cloudinary.uploader.upload(
    req.file.path,
    { dpr: "auto", responsive: true, width: "auto", crop: "scale" },
    (error, result) => {
      const query = `UPDATE menu SET restaurantId = '${req.body.restaurantId}', menuTitle = '${req.body.menuTitle}',type = '${req.body.type}', price = '${req.body.price}', description = '${req.body.description}', photo = '${result.secure_url}' WHERE menuId = ${req.params.menuId} AND restaurantId = '${req.params.restaurantId}'`;
      pool.execute(query, function (err, result) {
        if (err) {
          res.send("error");
          throw err;
        }
        console.log("berhasil");
        res.send("berhasil");
      });
    }
  );
};

exports.addMenu = async (req, res) => {
  await cloudinary.uploader.upload(
    req.file.path,
    { dpr: "auto", responsive: true, width: "auto", crop: "scale" },
    (error, result) => {
      const query = `INSERT INTO menu(restaurantId, menuTitle, type, price, description, photo) VALUES ('${req.body.restaurantId}', '${req.body.menuTitle}', '${req.body.type}', '${req.body.price}', '${req.body.description}', '${result.secure_url}')`;
      pool.execute(query, function (err, result) {
        if (err) {
          res.send("error");
          throw err;
        }
        console.log("berhasil");
        res.send("berhasil");
      });
    }
  );
};
