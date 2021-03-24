const express = require("express");
const db = require("../db/database");
const { nanoid } = require("nanoid");
const multer = require("multer");
const { check, validationResult } = require("express-validator");
const fs = require("fs");
const e = require("express");
const customerRouter = express.Router();




customerRouter.get("/", (req, res) => {
  if (!req.session.user) {
    return res.redirect("/user/login");
  }
  const success = req.flash("success") || "";
  const error = req.flash("error") || "";
 
  const user = req.session.user;
  let customerList = new Array();
  const sql =
    "SELECT  * FROM customer";
  db.query(sql, (err, result, fields) => {
    if (err) {
      req.flash("error", err);
    } else if (result) {
      result.forEach((row) => {
        customerList.push(row);
      });
      res.render("customer", { success, customerList, error, user });
    } else {
      res.render("customer");
    }
  });
});


customerRouter.delete("/delete/:id", (req, res) => {
    const id = req.params.id;
    console.log(id)
    let sql = `DELETE FROM customer WHERE id = ?`;
    const params = [id];
    db.query(sql, params, (err, result, fields) => {
      if (err) {
        req.flash("error", err);
        res.send("Xu ly");
      } else if (result.affectedRows > 0) {
        req.flash("success", "Xóa khách hàng thành công");
        console.log(result);
        return res.send("success");
      } else {
        req.flash("error", "Xóa khách hàng thất bại");
        return res.send("error");
      }
    });
  });
    

  
  const LoginValidator = [
    check("email")
      .exists()
      .withMessage("Vui lòng nhập email người dùng")
      .notEmpty()
      .withMessage("Không được để trống email người dùng")
      .isEmail()
      .withMessage("Đây không phải là email hợp lệ"),
  
    check("password")
      .exists()
      .withMessage("Vui lòng nhập mật khẩu ")
      .notEmpty()
      .withMessage("Không được để trống mật khẩu")
      .isLength({ min: 6 })
      .withMessage("Mật khẩu phải từ 6 ký tự"),
  ];
  
 
  
  customerRouter.get("/edit/:id", (req, res) => {
    const id = req.params.id;
    const user = req.session.user;
    let sql = `SELECT * FROM customer WHERE id = ?`;
    const params = [id];
    db.query(sql, params, (err, result, fields) => {
      if (err) {
        req.flash("error", err);
        console.log("Lỗi: ", err);
      }
      //nếu không lỗi
      const edit_customer = result[0];
      res.render("editCustomer", { edit_customer, user });
    });
  });
  customerRouter.post("/edit", (req, res) => {
    const {
      name,
      email,
      phone_number,
      id
    } = req.body;
    console.log(req.body);
    const sql =
      "UPDATE customer SET name = ?, email = ?, phone_number = ?  WHERE id = ? ";
    const params = [
      name,
      email,
      phone_number,
      id
    ];
    db.query(sql, params, (err, result, fields) => {
      if (err) {
        console.log(err);
      }
      console.log(result);
      return res.redirect("/customer");
    });
  });
  
  
  const add_validator = [
      check("name")
      .exists()
      .withMessage("Vui lòng nhập tên của khách hàng ")
      .notEmpty()
      .withMessage("Không được để trống tên của khách hàng "),
    check("phone_number")
      .exists()
      .withMessage("Vui lòng nhập số điện thoại của khách hàng ")
      .notEmpty()
      .withMessage("Không được để trống số điện thoại của khách hàng "),
      
    check("email")
      .exists()
      .withMessage("Vui lòng nhập email khách hàng ")
      .notEmpty()
      .withMessage("Không được để trống email khách hàng "),
    
  ];
  customerRouter.get('/add' ,(req, res) => {
    if (!req.session.user) {
      return res.redirect("/user/login");
    }
    const error = req.flash("error") || "";
    const id = req.flash("id") || "";
    const name = req.flash("name") || "";
    const phone_number = req.flash("phone_number") || "";
    const email = req.flash("email") || "";
    const user = req.session.user;
    res.render('addCustomer', { 
      error,
      id,
      name,
      phone_number,
      email,
      user,
    })
})

customerRouter.post("/add" ,add_validator,(req, res) => {
    let result_validation = validationResult(req);
    if(result_validation.errors.length === 0){
        const {name,phone_number,email} = req.body;
        console.log(name,phone_number,email)

    
        const sql =
        "insert into customer(`name`,`phone_number`,`email`) values (?,?,?)";
        const params = [name,phone_number,email]
        
        db.query(sql, params, (err, result, fields) => {
            if (err) {
              req.flash("error", err.message);
              return res.redirect("/customer/add");
            } else if (result.affectedRows === 1) {
              req.flash("success", "Thêm khách hàng thành công");
              return res.redirect("/customer");
            }
          });    

        //update số lượng cho bảng product_attr
        
    }
    else{
        let message;
        result_validation = result_validation.mapped();
        for (var fields in result_validation) {
          message = result_validation[fields].msg;
          break;
        }
        const {id,name,phone_number,email} = req.body;
        req.flash("error", message);
        req.flash("id", id);
        req.flash("name", name);
        req.flash("phone_number", phone_number);
        req.flash("email", email);
        return res.redirect("/customer/add");
    }
    
    
})
  

  
  module.exports = customerRouter;
  