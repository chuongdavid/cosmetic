require('dotenv').config()
const express = require("express");
const ejs = require("ejs");
const bodyParser = require("body-parser");
const path = require("path");
const cookieParser = require("cookie-parser");
const flash = require("express-flash");
const multer = require("multer");
const session = require('express-session')
const UserRouter = require('./src/routes/UserRouter')



const app = express();

app.use(cookieParser('123'));
app.use(session({ cookie:{maxAge: 3600000}}));
app.use(flash());
app.use('/user', UserRouter)
 

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

app.use(cookieParser("hungvuong"));
app.use(session({ cookie: { maxAge: 60000 } }));
app.use(flash());

app.use("/product", productRouter);

app.get("/", (req, res) => {
  if (!req.session.user){
    return res.redirect('/user/login')
  }
  const user = req.session.user
  res.render("index", {user})
})


const port = process.env.PORT || 9000;
app.listen(port, () => {
  console.log("Listening on port: " + port);
});
