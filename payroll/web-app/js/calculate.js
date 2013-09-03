var AC_URL =  'http://pocketpayroll-lb-QA-ssl-1602432401.us-east-1.elb.amazonaws.com/v1/usa/ca';
var AC_API_KEY = '44F0DCC0-6D52-4BDC-95E1-9784496A177A';

var formatPayDate = function(payDateStr) {
    var dateObj, payMonth, payDay;
    dateObj = payDateStr ? new Date(payDateStr) : new Date();
    payMonth = dateObj.getMonth() + 1;
    payMonth = (payMonth < 10) ? '0' + payMonth : '' + payMonth;
    payDay = dateObj.getDate();
    payDay = (payDay < 10) ? '0' + payDay : '' + payDay;
    return dateObj.getFullYear() + payMonth + payDay;
}
var unformatPayDate = function(dateStr) {
    var year, month, day;
    year = dateStr.substring(0, 4);
    month = dateStr.substring(4, 6);
    day = dateStr.substring(6);
    return month + '/' + day + '/' + year;
}
var formatPeriodsInYear = function(payDateStr) {
    return (payDateStr.toLowerCase() == 'weekly') ? 52 : 26;
}
var clearCheckDisplay = function() {
    $('#recipient').html('Employee 1');
    $('#displayGrossHourly').html('$0.00');
    $('#displayGrossOvertime').html('$0.00');
    $('#displayAdditionalSalary').html('$0.00');
    $('#displayAdditionalBonus').html('$0.00');
    $('#displayAdditionalCommission').html('$0.00');
    $('#SocSecurity').html('-$0.00');
    $('#CA_SDI').html('-$0.00');
    $('#Medicare').html('-$0.00');
    $('#FedIncome').html('-$0.00');
    $('#CA_Income').html('-$0.00');
    $('#amount').html('$0.00');
    $('#netPay').html('$0.00');
}
var updateCheckDisplay = function(obj) {
    var netPay = parseFloat(obj.parsedInput.grossPay);
    for (var i = 0; i < obj.employeeTaxes.length; i++) {
        var val = parseFloat(obj.employeeTaxes[i].amount);
        netPay += val;
        $('#' + obj.employeeTaxes[i].name).html('-$' + (val * -1));
    }
    // net
    $('#amount').html('$' + netPay.toFixed(2));
    $('#netPay').html('$' + netPay.toFixed(2));
}
var calculate = function() {
    var payType, grossHourly, hoursWorked, payRate, grossPay, payAmount, commission, bonus, salary;
    var overtimeHoursWorked, payDate, grossOvertime;
    payType = $('#payType').val();
    if (payType.toLowerCase() == 'hourly') {
        hoursWorked = $('#hoursWorked').val();
        payRate = $('#payRate').val();
        if (!hoursWorked || !payRate) return;
        hoursWorked = parseInt(hoursWorked);
        payRate = parseFloat(payRate);
        grossHourly = hoursWorked * payRate;
        overtimeHoursWorked = $('#overtimeHoursWorked').val();
        overtimeHoursWorked = overtimeHoursWorked ? parseInt(overtimeHoursWorked) : 0;
        grossOvertime = (payRate * 1.5) * overtimeHoursWorked;
        salary = $('#salary').val();
        salary = salary ? parseFloat(salary) : 0;
        commission = $('#commission').val();
        commission = commission ? parseFloat(commission) : 0;
        bonus = $('#bonus').val();
        bonus = bonus ? parseFloat(bonus) : 0;
        $('#displayGrossHourly').html('$' + grossHourly.toFixed(2));
        $('#displayGrossOvertime').html('$' + grossOvertime.toFixed(2));
        $('#displayAdditionalSalary').html('$' + salary.toFixed(2));
        $('#displayAdditionalBonus').html('$' + bonus.toFixed(2));
        $('#displayAdditionalCommission').html('$' + commission.toFixed(2));
        grossPay = hoursWorked * payRate + overtimeHoursWorked * (payRate * 1.5) + commission + bonus + salary;
    } else {
        payAmount = $('#payAmount').val();
        if (!payAmount) return;
        payAmount = parseFloat(payAmount);
    }
    var obj = {
        "grossPay": grossPay,
        "grossQTD": 0.0,
        "grossMTD": 0.0,
        "grossYTD": 0.0,
        "periodsInYear": formatPeriodsInYear($('#payPeriod').val()),
        "payDate": formatPayDate($('#payDate').val()),
        "federalFilingStatus": $('#fedFilingStatus').val(),
        "federalAdditionalWithholding":$('#fedAdditionalWithheld').val(),
        "federalExemptions": $('#fedAllowances').val(),
        "stateFilingStatus": $('#stateFilingStatus').val(),
        "stateExemptions": $('#stateAllowances').val(),
        "stateAdditionalWithholding": $('#stateAdditionalWithheld').val()
    };
    $.ajax({
        url: AC_URL,
        contentType: 'application/json',
        beforeSend: function (request) {
            request.setRequestHeader('X-Intuit-ApiKey', AC_API_KEY);
        },
        type: 'POST',
        dataType: 'json',
        data: JSON.stringify(obj),
        success: function(data, status, jqXHR) {
            latestCalculatedData = data;
            updateCheckDisplay(data);
        },
        error: function(jqXHR, status, errorThrown) {
            console.log(errorThrown);
        }
    });
};

// EVENTS FOR THE FORM
$('#inputEmployee').keyup(function() {
    $('#recipient').html($('#inputEmployee').val());
});
$('#inputState').change(function() {
    console.log('inputState change');
});
$('#payDate').blur(function() {
    calculate();
});
$('#payPeriod').change(function() {
    calculate();
});
$('#payType').change(function() {
    calculate();
});
$('#hoursWorked').blur(function() {
    calculate();
});
$('#payRate').blur(function() {
    calculate();
});
$('#overtimeHoursWorked').blur(function() {
    calculate();
});
$('#salary').blur(function() {
    calculate();
});
$('#bonus').blur(function() {
    calculate();
});
$('#commission').blur(function() {
    calculate();
});
$('#fedFilingStatus').change(function() {
    calculate();
});
$('#fedAllowances').blur(function() {
    calculate();
});
$('#fedAdditionalWithheld').blur(function() {
    calculate();
});
$('#stateFilingStatus').change(function() {
    calculate();
});
$('#stateAllowances').blur(function() {
    calculate();
});
$('#stateAdditionalWithheld').blur(function() {
    calculate();
});

