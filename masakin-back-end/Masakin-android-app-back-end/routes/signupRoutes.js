const router = require("express").Router();
const controller = require("../controllers/signupController");

router.route("/").post(controller.signupAccount);

module.exports = router;
