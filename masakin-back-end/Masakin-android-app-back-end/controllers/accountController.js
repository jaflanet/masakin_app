const bodyParser = require("body-parser");
const express = require("express");
const { pool } = require("../config/db");
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
const { cloudinary } = require("../config/cloudinaryConfig");

exports.getAllAccount = async (req, res) => {
  const query = "SELECT * FROM account";
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log(result);
    res.send(result);
  });
};

exports.getAccountByEmail = async (req, res) => {
  const query = `SELECT * FROM account WHERE email = '${req.query.email}'`;
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log(result);
    res.send(result);
  });
};

exports.deleteAccount = async (req, res) => {
  const query = `DELETE FROM account WHERE accountId = '${req.params.accountId}'`;
  pool.execute(query, function (err, result) {
    if (err) {
      res.send("error");
      throw err;
    }
    console.log("berhasil");
    res.send("berhasil");
  });
};

exports.updateAccount = async (req, res) => {
  await cloudinary.uploader.upload(
    req.file.path,
    { dpr: "auto", responsive: true, width: "auto", crop: "scale" },
    (error, result) => {
      const query = `UPDATE account SET username = '${req.body.username}', password = '${req.body.password}', email = '${req.body.email}', name = '${req.body.name}', accPhoneNumber = '${req.body.accPhoneNumber}', profilePicture = '${result.secure_url}', accountType = '${req.body.accountType}' WHERE accountId = ${req.params.accountId}`;
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

exports.addAccount = async (req, res) => {
  await cloudinary.uploader.upload(
    req.file.path,
    { dpr: "auto", responsive: true, width: "auto", crop: "scale" },
    (error, result) => {
      const query = `INSERT INTO account(email, password, name, accPhoneNumber, address, profilePicture, accountType) VALUES ('${req.body.email}', '${req.body.password}', '${req.body.name}', '${req.body.accPhoneNumber}', '${req.body.address}', '${result.secure_url}', '${req.body.accountType}')`;
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
