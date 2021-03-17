const express = require("express");
const ejs = require("ejs");
const bodyParser = require("body-parser");
const path = require("path");
const multer = require("multer");

const app = express();
const port = process.env.PORT || 9000;
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
app.use("/product", productRouter);

app.get("/", (req, res) => {
  res.render("index");
});

app.listen(port, () => {
  console.log("Listening on port: " + port);
});
