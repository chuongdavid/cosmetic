const xlsx = require('xlsx');
const path = require('path');

const exportExcel = (data, workSheetColumnNames, workSheetName, filePath) => {
    const workBook = xlsx.utils.book_new();
    const workSheetData = [
        workSheetColumnNames,
        ... data
    ];
    const workSheet = xlsx.utils.aoa_to_sheet(workSheetData);
    xlsx.utils.book_append_sheet(workBook, workSheet, workSheetName);
    xlsx.writeFile(workBook, path.resolve(filePath));
}

const exportUsersToExcel = (reports, workSheetColumnNames, workSheetName, filePath) => {
    const data = reports.map(report => {
        console.log(report)
        return [report.transaction_id, report.user_id, report.product_id, report.quantity, report.price, report.created_at];
    });
    let price = new Intl.NumberFormat('ja-JP', { style: 'currency', currency: 'VND' }).format(reports[reports.length - 1].totalAmount);
    data.push(["Tổng doanh thu "+" từ " + 
    reports[reports.length - 1].dateStart + " đến " +  reports[reports.length - 1].dateEnd + ": "+ price]);
    console.log("data", data)
    exportExcel(data, workSheetColumnNames, workSheetName, filePath);
}

module.exports = exportUsersToExcel;