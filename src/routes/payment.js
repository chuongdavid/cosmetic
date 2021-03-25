const express = require("express");
const db = require("../db/database");
const { nanoid } = require("nanoid");
const multer = require("multer");
const { check, validationResult } = require("express-validator");
const fs = require("fs");
const e = require("express");
const paymentRouter = express.Router();

paymentRouter.get('/', (req, res) => {
    if (!req.session.user) {
        return res.redirect("/user/login");
      }
      const user = req.session.user;
      res.render('payment', { user})
})

paymentRouter.post('/', (req, res) => {
  if (!req.session.user) {
      return res.redirect("/user/login");
    }
    const {customer_id,product_id,price,quantity} = req.body
    console.log(customer_id, product_id, price, quantity)
    const user = req.session.user;
    res.redirect("/payment", {user})
})


module.exports = paymentRouter;