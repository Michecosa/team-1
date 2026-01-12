const express = require("express");
const router = express.Router();
const ordersController = require("../Controllers/ordersController");

//post
router.post("/", ordersController.createOrder);

module.exports = router;
