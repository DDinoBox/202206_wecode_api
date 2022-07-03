const express = require("express");
const router = express.Router();
const app = express();

const adminRoute = require("./adminRoute");

router.use("/admin", adminRoute);

module.exports = router;
