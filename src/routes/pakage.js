const express = require("express");
const db = require("../db/database");
const { nanoid } = require("nanoid");
const multer = require("multer");
const { check, validationResult } = require("express-validator");
const fs = require("fs");
const e = require("express");
const packageRouter = express.Router();

packageRouter.get('/', (req, res) => {
    res.send("package page")
})



module.exports = packageRouter;
