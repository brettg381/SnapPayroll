var getAbbreviation = function(name) {
    var n = $.trim(name);
    if ('' == n) {
        return '';
    }
    var parts = n.split(' ');
    if (parts.length == 1) {
        if (parts[0].length == 1) {
            return parts[0] + ' ';
        }
        return parts[0].substring(0, 2);
    }
    return parts[0].substring(0, 1) + parts[parts.length - 1].substring(0, 1);
}

var clearBadge = function() {
    $('#badgeImage').attr('src', 'images/mock-gravatar.png');
    $('#badgeNameAbbreviation span').html('E1');
    $('#badgeName span').html('Employee 1');
}
var validateEmailField = function(field) {
    var val = field.val();
    if (val == '') {
        return true;
    }
    var isValid = true;
    var emailPattern = /.+@.+\..+/;
    if (!emailPattern.test(val)) {
        field.addClass('error');
        isValid = false;
    } else {
        field.removeClass('error');
    }
    return isValid;
}
var validateEmployeeForm = function() {
    var isValid = true;
    if (!validateEmailField($('#eeInputEmail'))) isValid = false;
    if (!validateNumberField($('#eeInputPayRate'))) isValid = false;
    if (!validateNumberField($('#eeInputFedAllowances'))) isValid = false;
    if (!validateNumberField($('#eeInputStateAllowances'))) isValid = false;
    if (!validateNumberField($('#eeInputFedAdditionalWithheld'))) isValid = false;
    if (!validateNumberField($('#eeInputStateAdditionalWithheld'))) isValid = false;
    return isValid;
}
var updateEmployeesInPaychecks = function() {
    app.paychecks.forEach(function(paycheck) {
        var ee = findEmployeeByName(paycheck.get('employee'));
        if (ee != null) {
            paycheck.set('eeEmail', ee.get('email'));
        }
    });
}
var saveEmployeeFromEmployeeForm = function() {
    if (!validateEmployeeForm()) return false;
    var name = $('#eeInputName').val();
    var ee = findEmployeeByName(name);
    if (ee == null) {
        ee = new app.Employee();
        app.employees.add(ee);
    }
    ee.set({
        name: name,
        abbr: getAbbreviation(name),
        email: $('#eeInputEmail').val(),
        state: $('#eeInputState').val(),
        payRate: toFloat($('#eeInputPayRate').val()),
        payPeriod: $('#eeInputPayPeriod').val(),
        payType: $('#eeInputPayType').val(),
        previousPay: $('#eeInputPreviousPayYes').is(':checked'),
        fedFilingStatus: $('#eeInputFedFilingStatus').val(),
        fedAllowances: toInt($('#eeInputFedAllowances').val()),
        fedAdditionalWithheld: toFloat($('#eeInputFedAdditionalWithheld').val()),
        stateFilingStatus: $('#eeInputStateFilingStatus').val(),
        stateAllowances: toInt($('#eeInputStateAllowances').val()),
        stateAdditionalWithheld: toFloat($('#eeInputStateAdditionalWithheld').val()),
        numChecks: 0
    });
    updateEmployeesInPaychecks();
    app.employeesView.render();
    app.paychecksView.render();
    return true;
}
var findEmployeeByName = function(name) {
    var ee = null;
    if (name == '') {
        name = 'Employee 1';
    }
    app.employees.forEach(function(model) {
        if (model.get('name') == name) {
            ee = model;
        }
    });
    return ee;
}
var populatePaycheckFormWithEmployee = function(ee) {
    $('#inputEmployee').val(ee.get('name'));
    $('#payRate').val(ee.get('payRate'));
    $('#fedFilingStatus').val(ee.get('fedFilingStatus'));
    $('#fedAllowances').val(ee.get('fedAllowances'));
    $('#fedAdditionalWithheld').val(ee.get('fedAdditionalWithheld'));
    $('#stateFilingStatus').val(ee.get('stateFilingStatus'));
    $('#stateAllowances').val(ee.get('stateAllowances'));
    $('#stateAdditionalWithheld').val(ee.get('stateAdditionalWithheld'));
}
var populateEmployeeFormWithEmployee = function(ee) {
    $('#eeInputName').val(ee.get('name'));
    $('#eeInputEmail').val(ee.get('email'));
    $('#eeInputPayRate').val(ee.get('payRate'));
    $('#eeInputPayPeriod').val(ee.get('payPeriod'));
    $('#eeInputFedFilingStatus').val(ee.get('fedFilingStatus'));
    $('#eeInputFedAllowances').val(ee.get('fedAllowances'));
    $('#eeInputFedAdditionalWithheld').val(ee.get('fedAdditionalWithheld'));
    $('#eeInputStateFilingStatus').val(ee.get('stateFilingStatus'));
    $('#eeInputStateAllowances').val(ee.get('stateAllowances'));
    $('#eeInputStateAdditionalWithheld').val(ee.get('stateAdditionalWithheld'));
}

var saveEmployeeFromPaycheckForm = function() {
    var name = $('#inputEmployee').val();
    name = (name == '') ? 'Employee 1' : name;
    var ee = findEmployeeByName(name);
    if (ee == null) {
        ee = new app.Employee();
        app.employees.add(ee);
    }
    ee.set({
        name: name,
        abbr: getAbbreviation(name),
        state: $('#inputState').val(),
        payRate: toFloat($('#payRate').val()),
        payPeriod: $('#payPeriod').val(),
        payType: $('#payType').val(),
        fedFilingStatus: $('#fedFilingStatus').val(),
        fedAllowances: toInt($('#fedAllowances').val()),
        fedAdditionalWithheld: toFloat($('#fedAdditionalWithheld').val()),
        stateFilingStatus: $('#stateFilingStatus').val(),
        stateAllowances: toInt($('#stateAllowances').val()),
        stateAdditionalWithheld: toFloat($('#stateAdditionalWithheld').val()),
        numChecks: 1,
        netPay: toFloat($('#netPay').html().substring(1))
    });
    app.employeesView.render();
    return true;
}

var activateEmployeeDisplay = function(header, slugline, buttonText) {
    $('#action-layout header.employeeInput div.title').html(header);
    $('#left div.employeeInput h1').html(slugline);
    $('#finishAddEmployeeButton').html(buttonText);

    $('#action-layout .paycheckInput').each(function() {
        if (!$(this).hasClass('inactive')) {
            $(this).addClass('inactive');
        }
    });
    $('#action-layout .employeeInput').each(function() {
        if ($(this).hasClass('inactive')) {
            $(this).removeClass('inactive');
        }
    });
    $('#eeInputName').trigger('paste');
    $('#action-layout').show('slide', {'direction': 'right'}, 400);
}

// EVENTS FOR THE FORM
$('#eeInputName').bind('change paste keyup blur',function() {
    var name = $('#eeInputName').val();
    $('#badgeName span').html(name);
    $('#badgeNameAbbreviation span').html(getAbbreviation(name));
});
$('#eeInputEmail').bind('change paste keyup blur', function() {
    var email = $('#eeInputEmail').val().toLowerCase();
    var hash = md5($.trim(email));
    var srcStr = 'http://www.gravatar.com/avatar/' + hash + '?s=142&d=blank';
    $('#badgeImage').attr('src', srcStr);
    validateEmployeeForm();
});
$('#eeInputPayRate').bind('change paste keyup blur', function() {validateEmployeeForm();});
$('#eeInputFedAllowances').bind('change paste keyup blur', function() {validateEmployeeForm();});
$('#eeInputStateAllowances').bind('change paste keyup blur', function() {validateEmployeeForm();});
$('#eeInputFedAdditionalWithholdings').bind('change paste keyup blur', function() {validateEmployeeForm();});
$('#eeInputStateAdditionalWithholdings').bind('change paste keyup blur', function() {validateEmployeeForm();});