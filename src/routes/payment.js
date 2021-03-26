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

paymentRouter.post('/add', (req, res) => {
  if (!req.session.user) {
      return res.redirect("/user/login");
    }
    const {customer_id,product_id,price,quantity} = req.body
    let product_list = new Array()
    let amount = 0;
    if(Array.isArray(product_id)){
      
      //nhieu hon 1 san pham
      for (var i in product_id) {
        product_list.push({product_id: product_id[i],price: price[i],quantity: quantity[i]})
        amount += parseInt(quantity[i])*parseInt(price[i])
      }
    }
    else{
      product_list.push(product_id,price,quantity,parseInt(quantity)*parseInt(price))
      amount += parseInt(quantity)*parseInt(price)
    }
    //insert transaction
    db.query("insert into transaction(amount,user_id) values(?,?)",[amount,customer_id],(err,result, fields) => {
      console.log(result)
    })
    db.query("SELECT LAST_INSERT_ID() AS id",(err1,result1, fields1) => {
      product_list.forEach(product => {
        db.query("insert into orders(transaction_id,product_id,quantity,price) values(?,?,?,?)",[result1[0].id,product.product_id,product.quantity,product.price],(err2, result2, fields2) =>{
          //cap nhat so luong
          db.query(`UPDATE product_attr, product_detailed SET quantity = quantity - ? WHERE product_detailed.id = ? AND product_detailed.attr_id = product_attr.id`,
            [product.quantity,product.product_id])
        })
      })
       
    })
    
    res.redirect("/payment")
})


module.exports = paymentRouter;