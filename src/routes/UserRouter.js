const express = require("express");
const { check, validationResult } = require("express-validator");
const db = require("../db/database");
const { nanoid } = require("nanoid");
const multer = require("multer");
const bcrypt = require("bcrypt");
const bodyParser = require("body-parser");
const fs = require("fs");
const e = require("express");
const Router = express.Router();


Router.use(bodyParser.json());

// parse requests of content-type - application/x-www-form-urlencoded
Router.use(bodyParser.urlencoded({ extended: true }));

Router.get("/", (req,res) => {
  const success = req.flash("success") || "";
  const error = req.flash("error") || "";
  const user = req.session.user;
  let userList = new Array();
  const sql =
    "SELECT * FROM account";
  db.query(sql, (err, result, fields) => {
    if (err) {
      req.flash("error", err);
    }
     else if (result) {
      result.forEach((row) => {
        userList.push(row);
      });
      res.render("users", {success, userList, error, user });
    } else {
      res.render("users");
    }
  });
})

Router.delete("/delete/:id", (req, res) => {
  const id = req.params.id;
  console.log(id)
  let sql = `DELETE FROM account WHERE id = ?`;
  const params = [id];
  db.query(sql, params, (err, result, fields) => {
    if (err) {
      req.flash("error", err);
      res.send("Xu ly");
    } else if (result.affectedRows > 0) {
      req.flash("success", "Xóa người dùng thành công");
      console.log(result);
      return res.send("success");
    } else {
      req.flash("error", "Xóa người dùng thất bại");
      return res.send("error");
    }
  });
});

Router.get("/login", (req, res) => {
  if (req.session.user) {
    return res.redirect("/user/");
  }

  const error = req.flash("error") || "";
  const password = req.flash("password") || "";
  const email = req.flash("email") || "";

  res.render("login", { error, password, email });
});

Router.get("/logout", (req, res) => {
  req.session.destroy();
  res.redirect("/user/login");
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

Router.post("/login", LoginValidator, (req, res) => {
  let result = validationResult(req);
  if (result.errors.length === 0) {
    const { email, password } = req.body;
    const sql = "SELECT * FROM account WHERE email = ?";
    const params = [email];

    db.query(sql, params, (err, results, fields) => {
      if (err) {
        req.flash("error", err.message);
        req.flash("password", password);
        req.flash("email", email);
        return res.redirect("/user/login");
      } else if (results.length === 0) {
        req.flash("error", "Email không tồn tại");
        req.flash("password", password);
        req.flash("email", email);
        return res.redirect("/user/login");
      } else {
        const hashed = results[0].password;
        const match = bcrypt.compareSync(password, hashed);
        if (!match) {
          req.flash("error", "Mật khẩu không chính xác");
          req.flash("password", password);
          req.flash("email", email);
          return res.redirect("/user/login");
        } else {
          req.session.user = results[0];
          console.log(results[0])
          return res.redirect("/");
        }
      }
    });
  } else {
    result = result.mapped();

    let message;
    for (var fields in result) {
      message = result[fields].msg;
      break;
    }
    const { email, password } = req.body;

    req.flash("error", message);
    req.flash("password", password);
    req.flash("email", email);

    res.redirect("/user/login");
  }
});

Router.get("/edit/:id", (req, res) => {
  const id = req.params.id;
  const user = req.session.user;
  let sql = `SELECT * FROM account WHERE id = ?`;
  const params = [id];
  db.query(sql, params, (err, result, fields) => {
    if (err) {
      req.flash("error", err);
      console.log("Lỗi: ", err);
    }
    //nếu không lỗi
    const edit_user = result[0];
    res.render("editUser", { edit_user, user });
  });
});
Router.post("/edit", (req, res) => {
  const {
    name,
    email,
    role,
    phone,
    id
  } = req.body;
  console.log(req.body);
  const sql =
    "UPDATE account SET name = ?, email = ?, role = ? ,phone = ? WHERE id = ? ";
  const params = [
    name,
    email,
    role,
    phone,
    id
  ];
  db.query(sql, params, (err, result, fields) => {
    if (err) {
      console.log(err);
    }
    console.log(result);
    return res.redirect("/user");
  });
});


Router.get("/register", (req, res) => {
  const error = req.flash("error") || "";
  const name = req.flash("name") || "";
  const email = req.flash("email") || "";
  const phone = req.flash("phone") || "";

  res.render("register", { error, name, email, phone });
});

const validator = [
  check("name")
    .exists()
    .withMessage("Vui lòng nhập tên người dùng")
    .notEmpty()
    .withMessage("Không được để trống tên người dùng")
    .isLength({ min: 6 })
    .withMessage("Tên người dùng phải từ 6 ký tự"),

  check("email")
    .exists()
    .withMessage("Vui lòng nhập email người dùng")
    .notEmpty()
    .withMessage("Không được để trống email người dùng")
    .isEmail()
    .withMessage("Đây không phải là email hợp lệ"),

  check("phone")
    .exists()
    .withMessage("Vui lòng nhập sđt người dùng")
    .notEmpty()
    .withMessage("Không được để trống sđt người dùng")
    .isLength({ min: 10 })
    .withMessage("Tên người dùng phải 10 ký tự"),

  check("password")
    .exists()
    .withMessage("Vui lòng nhập mật khẩu ")
    .notEmpty()
    .withMessage("Không được để trống mật khẩu")
    .isLength({ min: 6 })
    .withMessage("Mật khẩu phải từ 6 ký tự"),

  check("rePassword")
    .exists()
    .withMessage("Vui lòng nhập xác nhận mật khẩu ")
    .notEmpty()
    .withMessage("Không được để trống xác nhận mật khẩu")
    .custom((value, { req }) => {
      if (value != req.body.password) {
        throw new Error("Mật khẩu không khớp");
      }
      return true;
    }),
];

Router.post("/register", validator, (req, res) => {
  let result = validationResult(req);

  if (result.errors.length === 0) {
    const { name, email, phone, password } = req.body;
    const hashed = bcrypt.hashSync(password, 10);

    const sql =
      "insert into account(name, email, phone, password) values(?,?,?,?)";
    const params = [name, email, phone, hashed];

    db.query(sql, params, (err, result, fields) => {
      if (err) {
        req.flash("error", err.message);
        req.flash("name", name);
        req.flash("email", email);
        req.flash("phone", phone);

        return res.redirect("/user/register");
      } else if (result.affectedRows === 1) {
        return res.redirect("/user/login");
      }

      req.flash("error", "Đăng kí thất bại");
      req.flash("name", name);
      req.flash("email", email);
      req.flash("phone", phone);

      return res.redirect("/user/register");
    });
  } else {
    result = result.mapped();

    let message;
    for (var fields in result) {
      message = result[fields].msg;
      break;
    }

    const { name, email, phone, password } = req.body;
    req.flash("error", message);
    req.flash("name", name);
    req.flash("email", email);
    req.flash("phone", phone);

    res.redirect("/user/register");
  }
});

Router.get("/users", (req, res) => {
  res.redirect("/user/login");
  res.send("OK");
});

module.exports = Router;
