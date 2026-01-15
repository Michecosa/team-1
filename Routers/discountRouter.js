const express = require("express");
const router = express.Router();
const { validateDiscount } = require("../Controllers/discountController");

router.post("/validate", validateDiscount);

module.exports = router;
