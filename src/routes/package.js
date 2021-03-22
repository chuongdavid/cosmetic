const express = require("express");
const db = require("../db/database");
const { nanoid } = require("nanoid");
const multer = require("multer");
const { check, validationResult } = require("express-validator");
const fs = require("fs");
const e = require("express");
const packageRouter = express.Router();

packageRouter.get('/', (req, res) => {
    const user = req.session.user;
    res.render('package',{ user})
})

packageRouter.get('/add', (req, res) => {
    const user = req.session.user;
    res.render('addPackage',{ user})
})

packageRouter.post("/add", (req, res) => {
    const {price_import} = req.body;
    var newPrice = price_import.replace(",", "");
    console.log(newPrice)
    res.send('addPackage dang xu ly')
})
module.exports = packageRouter;
