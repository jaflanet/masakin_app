const router = require("express").Router();
const controller = require("../controllers/testOrderController");

router.route("/").get(controller.getAllTestOrder).post(controller.addTestOrder);

router.route("/:id").get(controller.getTestOrderById);

module.exports = router;
