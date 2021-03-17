const express = require("express");
const db = require("../db/database");
const { nanoid } = require("nanoid");
const multer = require("multer");
const fs = require("fs");
const { resolveInclude } = require("ejs");
const productRouter = express.Router();

//middleware upload
const upload = multer({
  dest: "./public/img",
  limits: {
    fileSize: 1000000,
  },
  fileFilter(req, file, cb) {
    if (file.mimetype.startsWith("image/")) {
      console.log(file);
      cb(null, true);
    } else {
      cb(null, false);
    }
  },
});

productRouter.get("/", (req, res) => {
  res.render("product");
});
productRouter.get("/add", (req, res) => {
  res.render("addProduct");
});
productRouter.post("/add", upload.single("img"), (req, res) => {
  const { name, desc, ingredient, brand, category, volume } = req.body;
  //console.log(img);
  let img = req.file;
  if (!img) {
    console.log("File ảnh không đúng định dạng");
  } else {
    fs.renameSync(img.path, `./public/img/${img.originalname}`);
  }
  const product_id = nanoid(11);
  const sql =
    "insert into product(`id`,`name`,`desc`,`ingredient`,`brand`,`category`) values (?,?,?,?,?,?)";
  const params = [product_id, name, desc, ingredient, brand, category];
  // db.query(sql, params, (err, result, fields) => {
  //   if (err) {
  //     console.error(err.message);
  //     return res.redirect("/product/add");
  //   } else if (result.affectedRows === 1) {
  //     console.log(result);
  //     return res.redirect("/product");
  //   }
  // });
  // if (volume.isArray()) {
  //   volume.forEach((element) => {
  //     const sql_insert =
  //       "insert into product_attr(`product_id`,`volume`) values (?,?)";
  //     const params_insert = [product_id, element];
  //     db.query(sql_insert, params_insert, (err, result, fields) => {
  //       if (err) {
  //         console.error(err.message);
  //         return res.redirect("/product/add");
  //       } else if (result.affectedRows === 1) {
  //         console.log(result);
  //       }
  //     });
  //   });
  // } else {
  //   const sql_insert =
  //     "insert into product_attr(`product_id`,`volume`) values (?,?)";
  //   const params_insert = [product_id, volume];
  //   db.query(sql_insert, params_insert, (err, result, fields) => {
  //     if (err) {
  //       console.error(err.message);
  //       return res.redirect("/product/add");
  //     } else if (result.affectedRows === 1) {
  //       console.log(result);
  //     }
  //   });
  // }
  res.send("Xu ly....");
});

module.exports = productRouter;
