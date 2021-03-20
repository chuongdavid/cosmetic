const express = require("express");
const ejs = require("ejs");
const bodyParser = require("body-parser");
const path = require("path");
const multer = require("multer");
const {check, validationResult} = require('express-validator')
const flash = require('express-flash')
const session = require('express-session')
const cookieParser = require('cookie-parser')
const db = require("./src/db/database")
const bcrypt = require('bcrypt')


const app = express();

app.use(cookieParser('123'));
app.use(session({ cookie:{maxAge: 6000}}));
app.use(flash());

 
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
const e = require("express");
app.use("/product", productRouter);

app.get("/", (req, res) => {
  if (!req.session.user){
    return res.redirect('/login')
  }
  const user = req.session.user
  res.render("index", {user})
})

app.get("/login", (req, res) => {
  if(req.session.user){
    return res.redirect('/')
  }

  const error = req.flash('error') || ''
  const password = req.flash('password') || ''
  const email = req.flash('email') || ''
  
  res.render("login", {error, password, email})
})

app.get('/logout', (req, res) => {
  req.session.destroy()
  res.redirect('/login')
})

const LoginValidator = [
  
  check('email').exists().withMessage('Vui lòng nhập email người dùng')
  .notEmpty().withMessage('Không được để trống email người dùng')
  .isEmail().withMessage('Đây không phải là email hợp lệ'),

  check('password').exists().withMessage('Vui lòng nhập mật khẩu ')
  .notEmpty().withMessage('Không được để trống mật khẩu')
  .isLength({min: 6}).withMessage('Mật khẩu phải từ 6 ký tự'),

]

app.post("/login", LoginValidator, (req, res) => { 
  let result = validationResult(req);
  if (result.errors.length === 0){
    const{email, password} = req.body
    const sql = 'SELECT * FROM account WHERE email = ?'
    const params = [email]

    db.query(sql, params , (err, results, fields) => {
      if (err){
        req.flash('error', err.message)
        req.flash('password', password)
        req.flash('email', email)
        return res.redirect('/login')
      }
      else if (results.length === 0) {
        req.flash('error', 'Email không tồn tại')
        req.flash('password', password)
        req.flash('email', email)
        return res.redirect('/login')

      }else{
        const hashed = results[0].password
        const match = bcrypt.compareSync(password, hashed)
        if(!match){
          req.flash('error', 'Mật khẩu không chính xác')
          req.flash('password', password)
          req.flash('email', email)
          return res.redirect('/login')
        }else{
          req.session.user = results[0]
          return res.redirect('/')
        }
        
      }
    })

    
  }
  else{
    result = result.mapped()

    let message;
    for (fields in result){
      message = result[fields].msg
      break;
    }
    const {email, password} = req.body
    
    req.flash('error', message)
    req.flash('password', password)
    req.flash('email', email)

    res.redirect('/login')
  }
});



app.get("/register", (req, res) => {
  const error = req.flash('error') || ''
  const name = req.flash('name') || ''
  const email = req.flash('email') || ''
  const phone = req.flash('phone') || ''

  res.render('register', {error, name, email, phone})
})

const validator = [
  check('name').exists().withMessage('Vui lòng nhập tên người dùng')
  .notEmpty().withMessage('Không được để trống tên người dùng')
  .isLength({min: 6}).withMessage('Tên người dùng phải từ 6 ký tự'),

  check('email').exists().withMessage('Vui lòng nhập email người dùng')
  .notEmpty().withMessage('Không được để trống email người dùng')
  .isEmail().withMessage('Đây không phải là email hợp lệ'),

  check('phone').exists().withMessage('Vui lòng nhập sđt người dùng')
  .notEmpty().withMessage('Không được để trống sđt người dùng')
  .isLength({min: 10}).withMessage('Tên người dùng phải 10 ký tự'),

  check('password').exists().withMessage('Vui lòng nhập mật khẩu ')
  .notEmpty().withMessage('Không được để trống mật khẩu')
  .isLength({min: 6}).withMessage('Mật khẩu phải từ 6 ký tự'),

  check('rePassword').exists().withMessage('Vui lòng nhập xác nhận mật khẩu ')
  .notEmpty().withMessage('Không được để trống xác nhận mật khẩu')
  .custom((value,{req}) => {
    if (value != req.body.password) {
      throw new Error("Mật khẩu không khớp")

    }
    return true;
  })  
]

app.post('/register', validator,(req, res) => {
  let result = validationResult(req);
  

  if (result.errors.length === 0){
    const {name, email, phone, password} = req.body
    const hashed = bcrypt.hashSync(password, 10)

    const sql = 'insert into account(name, email, phone, password) values(?,?,?,?)' 
    const params = [name, email, phone, hashed]

    db.query(sql, params, (err, result, fields) =>{
      if(err){
        req.flash('error', err.message)
        req.flash('name', name) 
        req.flash('email', email)
        req.flash('phone', phone)

        return res.redirect('/register')
      }
      else if(result.affectedRows === 1){
        return res.redirect('/login')
      }

      req.flash('error', 'Đăng kí thất bại')
      req.flash('name', name) 
      req.flash('email', email)
      req.flash('phone', phone)

      return res.redirect('/register')
    })

    
  }
  else{
    result = result.mapped()
    
    let message;
    for (fields in result){
      message = result[fields].msg
      break;
    }

    const {name, email,phone, password} = req.body
    req.flash('error', message)
    req.flash('name', name) 
    req.flash('email', email)
    req.flash('phone', phone)

    res.redirect('/register')

  }
})


app.listen(port, () => {
  console.log("Listening on port: " + port);
});
