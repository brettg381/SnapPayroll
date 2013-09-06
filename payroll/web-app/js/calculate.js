google.load("visualization", "1", {packages:["corechart"]});

var AC_URL =  'http://pocketpayroll-lb-QA-ssl-1602432401.us-east-1.elb.amazonaws.com/v1/usa/ca';
var AC_API_KEY = '44F0DCC0-6D52-4BDC-95E1-9784496A177A';

var formatPayDate = function(dateObj) {
    var payMonth, payDay;
    payMonth = dateObj.getMonth() + 1;
    payMonth = (payMonth < 10) ? '0' + payMonth : '' + payMonth;
    payDay = dateObj.getDate();
    payDay = (payDay < 10) ? '0' + payDay : '' + payDay;
    return dateObj.getFullYear() + payMonth + payDay;
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
        $('#' + obj.employeeTaxes[i].name).html('-$' + (val * -1).toFixed(2));
    }
    // net
    $('#amount').html('$' + netPay.toFixed(2));
    $('#netPay').html('$' + netPay.toFixed(2));
}

var validateNumberField = function(field) {
    if (isNaN(field.val())) {
        field.addClass('error');
        return false;
    } else {
        field.removeClass('error');
        return true;
    }
}
var validateDateField = function(field) {
    if (new Date(field.val()) instanceof Date) {
        field.removeClass('error');
        return true;
    } else {
        field.addClass('error');
        return false;
    }
}
var validateLandingForm = function() {
    var result = true;
    if (!validateNumberField($('#landingHoursWorked'))) result = false;
    if (!validateNumberField($('#landingPayRate'))) result = false;
    if (!validateDateField($('#landingPayDate'))) result = false;
    if (!validateNumberField($('#landingOvertimeHoursWorked'))) result = false;
    if (!validateNumberField($('#landingSalary'))) result = false;
    if (!validateNumberField($('#landingBonus'))) result = false;
    if (!validateNumberField($('#landingCommission'))) result = false;
    if (!validateNumberField($('#landingFedAllowances'))) result = false;
    if (!validateNumberField($('#landingFedAdditionalWithheld'))) result = false;
    if (!validateNumberField($('#landingStateAllowances'))) result = false;
    if (!validateNumberField($('#landingStateAdditionalWithheld'))) result = false;
    return result;
}

var validatePaycheckForm = function() {
    var result = true;
    if (!validateNumberField($('#hoursWorked'))) result = false;
    if (!validateNumberField($('#payRate'))) result = false;
    if (!validateDateField($('#payDate'))) result = false;
    if (!validateNumberField($('#overtimeHoursWorked'))) result = false;
    if (!validateNumberField($('#salary'))) result = false;
    if (!validateNumberField($('#bonus'))) result = false;
    if (!validateNumberField($('#commission'))) result = false;
    if (!validateNumberField($('#fedAllowances'))) result = false;
    if (!validateNumberField($('#fedAdditionalWithheld'))) result = false;
    if (!validateNumberField($('#stateAllowances'))) result = false;
    if (!validateNumberField($('#stateAdditionalWithheld'))) result = false;
    return result;
}

var savePaycheckFromPaycheckForm = function() {
    if (!validatePaycheckForm()) return;
    var ee = $('#inputEmployee').val();
    ee = (ee == '') ? 'Employee 1' : ee
    var payPeriod = $('#payPeriod').val();
    var hoursWorked = $('#hoursWorked').val();
    hoursWorked = (hoursWorked == '') ? 0 : parseFloat(hoursWorked);
    var payRate = $('#payRate').val();
    payRate = (payRate == '') ? 0 : parseFloat(payRate);
    var otHoursWorked = $('#overtimeHoursWorked').val();
    otHoursWorked = (otHoursWorked == '') ? 0 : parseFloat(otHoursWorked);
    var additionalSalary = $('#salary').val();
    additionalSalary = (additionalSalary == '') ? 0 : parseFloat(additionalSalary);
    var additionalBonus = $('#bonus').val();
    additionalBonus = (additionalBonus == '') ? 0 : parseFloat(additionalBonus);
    var additionalCommission = $('#commission').val();
    additionalCommission = (additionalCommission == '') ? 0 : parseFloat(additionalCommission);
    var grossPay = payRate * hoursWorked + payRate * 1.5 * otHoursWorked + additionalBonus + additionalSalary + additionalCommission;
    var payDateStr = $('#payDate').val();
    var netPay = parseFloat($('#netPay').html().substring(1));
    var paycheck = new app.Paycheck({
        "user": (app.currentUser.get('isLoggedIn')) ? app.currentUser.get('email') : 'Unknown',
        "employee": ee,
        "eeAbbr": getAbbreviation(ee),
        "state": $('#inputState').val(),
        "hoursWorked": hoursWorked,
        "payRate": payRate,
        "payDate": (payDateStr == '') ? new Date() : new Date(payDateStr),
        "payPeriod": payPeriod,
        "payPeriodsInYear": payPeriod == 'Weekly' ? 52 : 26,
        "otHoursWorked": otHoursWorked,
        "additionalSalary": additionalSalary,
        "additionalBonus": additionalBonus,
        "additionalCommission": additionalCommission,
        "grossPay": grossPay,
        "netPay": netPay,
        "federalFilingStatus": $('#fedFilingStatus'),
        "federalAdditionalWithholding": parseFloat($('#fedAdditionalWithheld')),
        "federalExemptions": parseInt($('#fedAllowances')),
        "stateFilingStatus": $('#stateFilingStatus'),
        "stateExemptions": parseInt($('#stateAllowances')),
        "stateAdditionalWithholding": parseFloat($('#stateAdditionalWithheld'))
    });
    app.paychecks.add(paycheck);
    app.currentUser.set('totalNet',app.currentUser.get('totalNet') + netPay);
    app.currentUser.set('totalGross', app.currentUser.get('totalGross') + grossPay);
    app.currentUser.set('totalTaxes', app.currentUser.get('totalTaxes') + (grossPay - netPay));
    app.paycheckInsightView.render();
}
var delayedCalculate = function() {
    if (app.calcTimeout != null) {
        clearTimeout(app.calcTimeout);
    }
    app.calcTimeout = setTimeout(calculate, 200);
}
var calculate = function() {
    var payType, grossHourly, hoursWorked, payRate, grossPay, payAmount, commission, bonus, salary;
    var overtimeHoursWorked, payDate, grossOvertime;
    if (!validatePaycheckForm()) return;
    payType = $('#payType').val();
    if (payType.toLowerCase() == 'hourly') {
        hoursWorked = $('#hoursWorked').val();
        payRate = $('#payRate').val();
        if (!hoursWorked || !payRate) return;
        hoursWorked = parseFloat(hoursWorked);
        payRate = parseFloat(payRate);
        grossHourly = hoursWorked * payRate;
        overtimeHoursWorked = $('#overtimeHoursWorked').val();
        overtimeHoursWorked = overtimeHoursWorked ? parseFloat(overtimeHoursWorked) : 0;
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
    payDate = $('#payDate').val();
    var obj = {
        "grossPay": grossPay,
        "grossQTD": 0.0,
        "grossMTD": 0.0,
        "grossYTD": 0.0,
        "periodsInYear": formatPeriodsInYear($('#payPeriod').val()),
        "payDate": formatPayDate((payDate == '') ? new Date() : new Date(payDate)),
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

// EVENTS FOR THE PAYCHECK FORM
$('#inputEmployee').bind('change paste keyup blur', function() {
    $('#recipient').html($('#inputEmployee').val());
});
$('#inputState').change(function() {
    console.log('inputState change');
});
$('#payDate').bind('change paste keyup blur', function() {
    delayedCalculate();
});
$('#payPeriod').bind('change paste keyup blur', function() {
    delayedCalculate();
});
$('#payType').bind('change paste keyup blur', function() {
    delayedCalculate();
});
$('#hoursWorked').bind('change paste keyup blur', function() {
    delayedCalculate();
});
$('#payRate').bind('change paste keyup blur', function() {
    delayedCalculate();
});
$('#overtimeHoursWorked').bind('change paste keyup blur', function() {
    delayedCalculate();
});
$('#salary').bind('change paste keyup blur', function() {
    delayedCalculate();
});
$('#bonus').bind('change paste keyup blur', function() {
    delayedCalculate();
});
$('#commission').bind('change paste keyup blur', function() {
    delayedCalculate();
});
$('#fedFilingStatus').bind('change paste keyup blur', function() {
    delayedCalculate();
});
$('#fedAllowances').bind('change paste keyup blur', function() {
    delayedCalculate();
});
$('#fedAdditionalWithheld').bind('change paste keyup blur', function() {
    delayedCalculate();
});
$('#stateFilingStatus').bind('change paste keyup blur', function() {
    delayedCalculate();
});
$('#stateAllowances').bind('change paste keyup blur', function() {
    delayedCalculate();
});
$('#stateAdditionalWithheld').bind('change paste keyup blur', function() {
    delayedCalculate();
});

// EVENTS FOR THE LANDING FORM
$('#landingHoursWorked').bind('change paste keyup blur', function() {validateLandingForm();});
$('#landingPayRate').bind('change paste keyup blur', function() {validateLandingForm();});
$('#landingPayDate').bind('change paste keyup blur', function() {validateLandingForm();});
$('#landingOvertimeHoursWorked').bind('change paste keyup blur', function() {validateLandingForm();});
$('#landingSalary').bind('change paste keyup blur', function() {validateLandingForm();});
$('#landingBonus').bind('change paste keyup blur', function() {validateLandingForm();});
$('#landingCommission').bind('change paste keyup blur', function() {validateLandingForm();});
$('#landingFedAllowances').bind('change paste keyup blur', function() {validateLandingForm();});
$('#landingFedAdditionalWithheld').bind('change paste keyup blur', function() {validateLandingForm();});
$('#landingStateAllowances').bind('change paste keyup blur', function() {validateLandingForm();});
$('#landingStateAdditionalWithheld').bind('change paste keyup blur', function() {validateLandingForm();});
