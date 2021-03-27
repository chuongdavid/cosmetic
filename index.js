require("dotenv").config();

const db = require("./src/db/database");
const express = require("express");
const { nanoid } = require("nanoid");
const ejs = require("ejs");
const path = require("path");
const cookieParser = require("cookie-parser");
const flash = require("express-flash");
const multer = require("multer");
const session = require("express-session");
const UserRouter = require("./src/routes/UserRouter");
const exportReportToExcel = require('./src/excelSetup/exportExcelService');


const app = express();

app.use(cookieParser("123"));
app.use(session({ cookie: { maxAge: 3600000 } }));
app.use(flash());
app.use("/user", UserRouter);


//

// parse requests of content-type - application/json
app.use(express.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(express.urlencoded({ extended: true }));

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
const paymentRouter = require("./src/routes/payment");
const customerRouter = require("./src/routes/customer");
app.use(cookieParser("hungvuong"));
app.use(session({ cookie: { maxAge: 3600000 } }));
app.use(flash());

app.use("/product", productRouter);
app.use("/package", pakageRouter);
app.use("/payment", paymentRouter);
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

  //thống kê doanh thu

});
app.get('/report', (req, res) => {
  if (!req.session.user) {
    return res.redirect("/user/login");
  }
  const user = req.session.user;
  let revenue = new Array()
  let totalAmount = 0;
  db.query("SELECT orders.*,transaction.amount,transaction.user_id FROM orders INNER JOIN transaction ON orders.transaction_id = transaction.id", (err1, result1,fields1) => {
        
    result1.forEach((row) => {
      revenue.push(row);
    });
    db.query("SELECT * from transaction", (errTrans, resultTrans) => {
      resultTrans.forEach(row => {
        totalAmount+=row.amount;
      })
      res.render("report", { revenue, user, totalAmount })
    })
   
  })
})
app.post('/report', (req, res) => {

  const data = req.body
  let revenue = []
  let totalAmount = 0;
  db.query(`SELECT orders.*,transaction.amount,transaction.user_id FROM orders INNER JOIN transaction ON orders.transaction_id = transaction.id WHERE orders.created_at BETWEEN  "${data.dateStart}"  AND "${data.dateEnd}" `, (err1, result1,fields1) => {
    if(err1) {
      throw err;
    }
    else if(result1.length===0){
      //if not found any transaction or order
      res.send(JSON.stringify({code: 1, message:`Không có giao dịch nào trong thời gian từ ${data.dateStart} đến ${data.dateEnd} `}))
    }
    else{
      result1.forEach((row) => {
        revenue.push(row);
      });
      db.query(`SELECT * from transaction WHERE created_at BETWEEN  "${data.dateStart}"  AND "${data.dateEnd}"`, (errTrans, resultTrans) => {
        resultTrans.forEach(row => {
          totalAmount+=row.amount;
        })
        res.send(JSON.stringify({code: 2,revenue,totalAmount}));
      })
    }
  })
})

app.post('/excel', (req, res) => {
  const data = req.body;
  const dateStart = data.dateStart;
  const dateEnd = data.dateEnd
  let revenue = []
  let totalAmount = 0;
  db.query(`SELECT orders.*,transaction.amount,transaction.user_id FROM orders INNER JOIN transaction ON orders.transaction_id = transaction.id WHERE orders.created_at BETWEEN  "${data.dateStart}"  AND "${data.dateEnd}" `, (err1, result1,fields1) => {
    if(err1) {
      throw err;
    }
    else if(result1.length===0){
      //if not found any transaction or order
      res.send(JSON.stringify({code: 1, message:`Không có giao dịch nào trong thời gian từ ${data.dateStart} đến ${data.dateEnd} `}))
    }
    else{
      result1.forEach((row) => {
        revenue.push(row);
      });
      db.query(`SELECT * from transaction WHERE created_at BETWEEN  "${data.dateStart}"  AND "${data.dateEnd}"`, (errTrans, resultTrans) => {
        resultTrans.forEach(row => {
          totalAmount+=row.amount;
        })
        //set up excel exports
          const workSheetColumnName = [
            "Mã hóa đơn",
            "Mã khách hàng",
            "Mã sản phẩm",
            "Số lượng",
            "Giá bán",
            "Ngày bán"
        ]
        let dataReport = revenue;
        dataReport.push({totalAmount,dateStart,dateEnd})
        const workSheetName = 'Reports';
        const filePath = `./public/outputFiles/report_${dateStart}_${dateEnd}_${nanoid(6)}.xlsx` ;
        const fileView = path.join(__dirname, filePath)
        exportReportToExcel(dataReport, workSheetColumnName, workSheetName, filePath);
        res.send(JSON.stringify({code: 2,revenue,totalAmount,fileView}));
      })
    }
  })
  


})

const port = process.env.PORT || 9000;
app.listen(port, () => {
  console.log("Listening on port: " + port);
});
