require("dotenv").config();
const db = require("./src/db/database");
const express = require("express");
const ejs = require("ejs");
const bodyParser = require("body-parser");
const path = require("path");
const cookieParser = require("cookie-parser");
const flash = require("express-flash");
const multer = require("multer");
const session = require("express-session");
const UserRouter = require("./src/routes/UserRouter");


const app = express();

app.use(cookieParser("123"));
app.use(session({ cookie: { maxAge: 3600000 } }));
app.use(flash());
app.use("/user", UserRouter);


//

// parse requests of content-type - application/json
app.use(bodyParser.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

//static files
const publicPath = path.join(__dirname, "./public");
app.use(express.static(publicPath));
//set views
const viewsPath = path.join(__dirname, "./src/views");
app.set("views", viewsPath);
app.set("view engine", "ejs");
//set routes
const productRouter = require("./src/routes/product");
const pakageRouter = require("./src/routes/package");
const customerRouter = require("./src/routes/customer");
app.use(cookieParser("hungvuong"));
app.use(session({ cookie: { maxAge: 3600000 } }));
app.use(flash());

app.use("/product", productRouter);
app.use("/package", pakageRouter);
app.use("/customer", customerRouter);

app.get("/", (req, res) => {
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
      res.render("index", {package_exp, count , user })
    } else {
      console.log('Whoops! We hit an error')
    }
  });
});

const port = process.env.PORT || 9000;
app.listen(port, () => {
  console.log("Listening on port: " + port);
});
