const router = require("express").Router();
const controller = require("../controllers/menuController");
const upload = require("../config/multerConfig");

router
  .route("/")
  .get(controller.getAllMenu)
  .post(upload.single("image"), controller.addMenu);

router.route("/:restaurantId").get(controller.getMenuByRestaurantId);

router
  .route("/:restaurantId/:menuId")
  .get(controller.getMenuByMenuId)
  .put(upload.single("image"), controller.updateMenu)
  .delete(controller.deleteMenu);

module.exports = router;
