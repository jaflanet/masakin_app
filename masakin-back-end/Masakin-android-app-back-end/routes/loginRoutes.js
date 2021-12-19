const router = require("express").Router();
const controller = require("../controllers/loginController");

router.route("/").get(controller.getAllLogin).post(controller.addLogin);

module.exports = router;
