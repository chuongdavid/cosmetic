const express = require("express");
const db = require("../db/database");
const { nanoid } = require("nanoid");
const multer = require("multer");
const { check, validationResult } = require("express-validator");
const fs = require("fs");
const e = require("express");
const productRouter = express.Router();

//middleware upload
const upload = multer({
  dest: "./public/img",
  limits: {
    fileSize: 5000000,
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
  const success = req.flash("success") || "";
  const error = req.flash("error") || "";
  //delete product in product table if not exist in product_detailed
  let sql_delete = `DELETE FROM product WHERE NOT EXISTS ( SELECT 1 FROM product_detailed WHERE product_detailed.product_id = product.id )`;
  db.query(sql_delete, (err, result, fields) => {
    if (err) {
      console.error(err);
    }
  });
  //xoa neu chi tiet san pham khong ton tai
  const user = req.session.user
  let productList = new Array();
  const sql =
    "SELECT  product_detailed.id,product.name,product.desc,product.ingredient,product.brand,product.category,product.image,product_attr.volume,product_attr.price,product_attr.volume_unit FROM product,product_detailed,product_attr WHERE product.id = product_detailed.product_id AND product_detailed.attr_id = product_attr.id";
  db.query(sql, (err, result, fields) => {
    if (err) {
      req.flash("error", err);
    } else if (result) {
      result.forEach((row) => {
        productList.push(row);
      });
      res.render("product", { success, productList, error , user });
    } else {
      res.render("product");
    }
  });
});
const add_validator = [
  check("name")
    .exists()
    .withMessage("Vui lòng nhập tên sản phẩm")
    .notEmpty()
    .withMessage("Không được để trống tên sản phẩm"),
  check("desc")
    .exists()
    .withMessage("Vui lòng nhập mô tả sản phẩm ")
    .notEmpty()
    .withMessage("Không được để trống mô tả sản phẩm "),
  check("ingredient")
    .exists()
    .withMessage("Vui lòng nhập thành phần sản phẩm ")
    .notEmpty()
    .withMessage("Không được để thành phần sản phẩm "),
  check("brand")
    .exists()
    .withMessage("Vui lòng nhập thương hiệu sản phẩm ")
    .notEmpty()
    .withMessage("Không được để trống thương hiệu sản phẩm "),
  check("category")
    .exists()
    .withMessage("Vui lòng nhập danh mục sản phẩm ")
    .notEmpty()
    .withMessage("Không được để trống danh mục sản phẩm "),
  check("volume")
    .exists()
    .withMessage("Vui lòng nhập dung tích sản phẩm ")
    .notEmpty()
    .withMessage("Không được để trống dung tích sản phẩm "),
  check("price")
    .exists()
    .withMessage("Vui lòng nhập giá sản phẩm ")
    .notEmpty()
    .withMessage("Không được để trống giá sản phẩm "),
];
productRouter.get("/add", (req, res) => {
  const user = req.session.user
  const error = req.flash("error") || "";
  const name = req.flash("name") || "";
  const desc = req.flash("desc") || "";
  const ingredient = req.flash("ingredient") || "";
  const brand = req.flash("brand") || "";
  const category = req.flash("category") || "";
  const volume = req.flash("volume") || "";
  const price = req.flash("price") || "";

  res.render("addProduct", {
    error,
    name,
    desc,
    ingredient,
    brand,
    category,
    volume,
    price,
    user
  });
});

productRouter.post("/add", upload.single("img"), add_validator, (req, res) => {
  let result_validation = validationResult(req);
  //if no errors
  if (result_validation.errors.length === 0) {
    const {
      name,
      desc,
      ingredient,
      brand,
      category,
      volume,
      price,
      volume_unit,
    } = req.body;
    let img = req.file;
    if (!img) {
      req.flash("name", name);
      req.flash("desc", desc);
      req.flash("ingredient", ingredient);
      req.flash("brand", brand);
      req.flash("category", category);
      req.flash("volume", volume);
      req.flash("price", price);
      req.flash("error", "File ảnh không đúng định dạng hoặc chưa chọn ảnh");
      return res.redirect("/product/add");
    } else {
      fs.renameSync(img.path, `./public/img/${img.originalname}`);
    }

    const product_id = nanoid(11);

    const sql =
      "insert into product(`id`,`name`,`desc`,`ingredient`,`brand`,`category`,`image`) values (?,?,?,?,?,?,?)";
    const params = [
      product_id,
      name,
      desc,
      ingredient,
      brand,
      category,
      img.originalname,
    ];
    db.query(sql, params, (err, result, fields) => {
      if (err) {
        req.flash("error", err);
        return res.redirect("/product/add");
      } else if (result.affectedRows === 1) {
        console.log(result);
      }
    });
    if (Array.isArray(volume)) {
      for (var i in volume) {
        let id_detailed_pro = nanoid(11);
        let id_attr = nanoid(11);
        // insert product_attr table
        const sql_insert =
          "insert into product_attr(`id`,`volume`,`price`,`volume_unit`) values (?,?,?,?)";
        const params_insert = [id_attr, volume[i], price[i], volume_unit[i]];
        db.query(sql_insert, params_insert, (err, result, fields) => {
          if (err) {
            console.error(err.message);
            return res.redirect("/product/add");
          } else if (result.affectedRows === 1) {
            console.log(result);
          }
        });

        //insert product_detailed
        const sql_insert2 =
          "insert into product_detailed(`id`,`product_id`,`attr_id`) values (?,?,?)";
        const params_insert2 = [id_detailed_pro, product_id, id_attr];
        db.query(sql_insert2, params_insert2, (err, result, fields) => {
          if (err) {
            console.error(err.message);
            return res.redirect("/product/add");
          } else if (result.affectedRows === 1) {
            console.log(result);
          }
        });
        console.log(product_id, id_detailed_pro, id_attr);
      }
    } else {
      let id_detailed_pro = nanoid(11);
      let id_attr = nanoid(11);
      //insert product_attr table
      const sql_insert =
        "insert into product_attr(`id`,`volume`,`price`,`volume_unit`) values (?,?,?,?)";
      const params_insert = [id_attr, volume, price, volume_unit];
      console.log(id_attr, volume, price, volume_unit);
      db.query(sql_insert, params_insert, (err, result, fields) => {
        console.log(product_id, id_detailed_pro, id_attr);
        if (err) {
          console.error(err.message);
          return res.send("SOmethingwrong");
        } else if (result.affectedRows === 1) {
          console.log("not array", result);
        }
      });

      //insert product_detailed
      const sql_insert2 =
        "insert into product_detailed(`id`,`product_id`,`attr_id`) values (?,?,?)";
      const params_insert2 = [id_detailed_pro, product_id, id_attr];
      db.query(sql_insert2, params_insert2, (err, result, fields) => {
        if (err) {
          console.error(err.message);
          return res.redirect("/product/add");
        } else if (result.affectedRows === 1) {
          console.log(result);
        }
      });
    }

    req.flash("success", "Thêm sản phẩm thành công");
    return res.redirect("/product");
    //endif no error
  } else {
    let message;
    result_validation = result_validation.mapped();
    for (var fields in result_validation) {
      message = result_validation[fields].msg;
      console.log(message);
      break;
    }
    const { name, desc, ingredient, brand, category, volume, price } = req.body;
    req.flash("error", message);
    req.flash("name", name);
    req.flash("desc", desc);
    req.flash("ingredient", ingredient);
    req.flash("brand", brand);
    req.flash("category", category);
    req.flash("volume", volume);
    req.flash("price", price);
    return res.redirect("/product/add");
  }
});

productRouter.delete("/delete/:id", (req, res) => {
  const id = req.params.id;
  let sql = `DELETE product_detailed, product_attr FROM product_detailed INNER JOIN product_attr ON product_detailed.attr_id = product_attr.id WHERE product_detailed.id = ?`;
  const params = [id];
  db.query(sql, params, (err, result, fields) => {
    if (err) {
      req.flash("error", err);
      res.send("Xu ly");
    } else if (result.affectedRows > 0) {
      req.flash("success", "Xóa sản phẩm thành công");

      console.log(result);
      return res.send("success");
    } else {
      req.flash("error", "Xóa sản phẩm thất bại");
      return res.send("error");
    }
  });
});
productRouter.get("/edit/:id", (req, res) => {
  const id = req.params.id;
  let sql = `SELECT p.*, d.id ,a.volume, a.price, a.volume_unit FROM product_detailed AS d, product AS p, product_attr AS a WHERE d.id = ? AND a.id = d.attr_id`;
  const params = [id];
  db.query(sql, params, (err, result, fields) => {
    if (err) {
      req.flash("error", err);
      console.log("Lỗi: ", err);
    }
    //nếu không lỗi
    const edit_product = result[0];
    console.log(edit_product);
    res.render("editProduct", { edit_product });
  });
});
productRouter.post("/edit", (req, res) => {
  const {
    id,
    name,
    desc,
    ingredient,
    brand,
    category,
    volume,
    price,
    volume_unit,
  } = req.body;
  console.log(req.body);
  const sql =
    "UPDATE product AS p,product_detailed AS d ,product_attr AS a SET p.name = ?,p.desc = ?,p.ingredient = ? ,p.brand = ?,p.category = ?,a.volume = ?,a.price = ?,a.volume_unit = ? WHERE d.id = ? AND d.product_id = p.id AND a.id = d.attr_id";
  const params = [
    name,
    desc,
    ingredient,
    brand,
    category,
    volume,
    price,
    volume_unit,
    id,
  ];
  db.query(sql, params, (err, result, fields) => {
    if (err) {
      console.log(err);
    }
    console.log(result);
    return res.redirect("/product");
  });
});

module.exports = productRouter;
