const router = require("express").Router();
const controller = require("../controllers/orderController");

router.route("/").get(controller.getAllOrder).post(controller.addOrder);

router.route("/byemail").get(controller.getOrderByEmail);

module.exports = router;
