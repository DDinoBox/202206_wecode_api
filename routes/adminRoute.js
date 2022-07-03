const express = require("express");
const router = express.Router();

const adminController = require("../controllers/adminController");

// admin signup
router.post("/signup", adminController.adminSignup);

module.exports = router;
