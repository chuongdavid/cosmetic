const express = require("express");
const db = require("../db/database");
const { nanoid } = require("nanoid");
const multer = require("multer");
const { check, validationResult } = require("express-validator");
const fs = require("fs");
const e = require("express");
const packageRouter = express.Router();

packageRouter.get('/', (req, res) => {
    if (!req.session.user) {
      return res.redirect("/user/login");
    }
    const success = req.flash("success") || "";
    const error = req.flash("error") || "";
    const user = req.session.user;
    let packageList = new Array();
    const sql =
        "SELECT * FROM product_package";
    db.query(sql, (err, result, fields) => {
        if (err) {
        req.flash("error", err);
        } else if (result) {
        result.forEach((row) => {
            packageList.push(row);
        });
        res.render("package", { success, packageList, error, user });
        } else {
        res.render("package");
        }
    });
})
const add_validator = [
    check("product_id")
      .exists()
      .withMessage("Vui lòng nhập mã sản phẩm")
      .notEmpty()
      .withMessage("Không được để trống mã sản phẩm"),
      check("mfg_date")
      .exists()
      .withMessage("Vui lòng nhập ngày sản xuất của sản phẩm ")
      .notEmpty()
      .withMessage("Không được để trống ngày sản xuất của sản phẩm "),
    check("exp_date")
      .exists()
      .withMessage("Vui lòng nhập ngày hết hạn của sản phẩm ")
      .notEmpty()
      .withMessage("Không được để trống ngày hết hạn của sản phẩm ")
      .custom((value,{req}) => {
        let d1 = new Date(req.body.mfg_date)
        console.log(value)
        let d2 = new Date(value)
        if(d1.getTime() > d2.getTime()){
            throw new Error("Ngày hết hạn phải sau ngày sản xuất")
        }
        return true
      }),

    check("quantity")
      .exists()
      .withMessage("Vui lòng nhập số lượng ")
      .notEmpty()
      .withMessage("Không được để trống số lượng sản phẩm "),
    check("price_import")
      .exists()
      .withMessage("Vui lòng nhập giá sản phẩm ")
      .notEmpty()
      .withMessage("Không được để trống giá sản phẩm "),
  ];

  packageRouter.delete("/delete/:id", (req, res) => {
    const id = req.params.id;
    console.log(id)
    let sql = `DELETE FROM product_package WHERE id = ?`;
    const params = [id];
    db.query(sql, params, (err, result, fields) => {
      if (err) {
        req.flash("error", err);
        res.send("Xu ly");
      } else if (result.affectedRows > 0) {
        req.flash("success", "Xóa lô thành công");
        console.log(result);
        return res.send("success");
      } else {
        req.flash("error", "Xóa lô thất bại");
        return res.send("error");
      }
    });
  });
  packageRouter.get("/edit/:id" ,(req, res) => {
    const id = req.params.id;
    const user = req.session.user;
    let sql = `SELECT * FROM product_package WHERE id = ?`;
    const params = [id];
    db.query(sql, params, (err, result, fields) => {
      if (err) {
        req.flash("error", err);
        console.log("Lỗi: ", err);
      }
     
      //nếu không lỗi
      const edit_package = result[0];
      res.render("editPackage", { edit_package, user });
    });
  });
  packageRouter.post("/edit", (req, res) => {
    const {

      quantity,
      price_import,
      product_id,
      
    } = req.body;
    //cap nhap so luong san pham 

    console.log(req.body);
    const sql =
      "UPDATE product_package SET quantity = ?, price_import = ? WHERE product_id = ? ";
    const params = [
      quantity,
      price_import,
      product_id,

    ];
    db.query(sql, params, (err, result, fields) => {
      if (err) {
        console.log(err);
      }
      console.log(result);
      req.flash("success", "Cập nhật sản phẩm thành công");
      return res.redirect("/package");
    });
  });

packageRouter.get('/add', (req, res) => {
    if (!req.session.user) {
      return res.redirect("/user/login");
    }
    const error = req.flash("error") || "";
    const product_id = req.flash("product_id") || "";
    const mfg_date = req.flash("mfg_date") || "";
    const exp_date = req.flash("exp_date") || "";
    const quantity = req.flash("quantity") || "";
    const price_import = req.flash("price_import") || "";
    const user = req.session.user;
    res.render('addPackage',{ user,error,product_id,mfg_date,exp_date,quantity,price_import})
})

packageRouter.post("/add", add_validator ,(req, res) => {

    let result_validation = validationResult(req);
    if(result_validation.errors.length === 0){
        const {product_id,mfg_date,exp_date,quantity,price_import} = req.body;
      
        var newPrice = price_import.replace(",", "");


    
        const sql =
        "insert into product_package(`product_id`,`exp_date`,`mfg_date`,`quantity`,`price_import`) values (?,?,?,?,?)";
        const params = [product_id,exp_date,mfg_date,quantity,newPrice]
        
        db.query(sql, params, (err, result, fields) => {
            if (err) {
              req.flash("error", err.message);
              return res.redirect("/package/add");
            } else if (result.affectedRows === 1) {
              console.log(result);
              req.flash("success", "Thêm lô sản phẩm thành công");
              return res.redirect("/package");
            }
          });    
    }
    else{
        let message;
        result_validation = result_validation.mapped();
        for (var fields in result_validation) {
          message = result_validation[fields].msg;
          console.log(result_validation)
          console.log(result_validation[fields])
          console.log(message);
          break;
        }
        const {product_id,mfg_date,exp_date,quantity,price_import} = req.body;
        req.flash("error", message);
        req.flash("product_id", product_id);
        req.flash("mfg_date", mfg_date);
        req.flash("exp_date", exp_date);
        req.flash("quantity", quantity);
        req.flash("price_import", price_import);
        return res.redirect("/package/add");
    }
    
    
})
packageRouter.get("/exp-date" , (req, res) => {
  if (!req.session.user) {
    return res.redirect("/user/login");
  }
  const user = req.session.user;
   //check exp_Date của lô sản phẩm
   let package_exp = new Array()
   let count = 0;
   const sql = "SELECT * FROM product_package WHERE exp_date BETWEEN curdate() AND curdate() + INTERVAL 6 MONTH"
   db.query(sql, (err, result, fields) => {
     if (err) {
     req.flash("error", err);
     } else if (result) {
       result.forEach((row) => {
         package_exp.push(row);
       });
       count = package_exp.length;
       res.render("package-exp", {package_exp, count , user })
     } else {
       console.log('Whoops! We hit an error')
     }
   });
})
module.exports = packageRouter;
