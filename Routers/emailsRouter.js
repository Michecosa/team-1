const express = require("express");
const router = express.Router();
const { sendNewsletterEmail } = require("../Controllers/emailsController");

router.post("/newsletter", sendNewsletterEmail);

module.exports = router;
