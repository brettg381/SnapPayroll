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

var saveEmployeeFromEmployeeForm = function() {
    var name = $('#eeInputName').val();
    var ee = new app.Employee({
        name: name,
        abbr: getAbbreviation(name),
        email: $('eeInputEmail').val(),
        state: $('#eeInputState').val(),
        payRate: parseFloat($('#eeInputPayRate').val()),
        payPeriod: $('#eeInputPayPeriod').val(),
        payType: $('#eeInputPayType').val(),
        previousPay: $('#eeInputPreviousPayYes').is(':checked'),
        fedFilingStatus: $('#eeInputFedFilingStatus').val(),
        fedAllowances: parseInt($('#eeInputFedAllowances').val()),
        fedAdditionalWithheld: parseFloat($('#eeInputFedAdditionalWithheld').val()),
        stateFilingStatus: $('#eeInputStateFilingStatus').val(),
        stateAllowances: parseInt($('#eeInputStateAllowances').val()),
        stateAdditionalWithheld: parseFloat($('#eeInputStateAdditionalWithheld').val()),
        numChecks: 0
    });
    app.employees.add(ee);
}

var saveEmployeeFromPaycheckForm = function() {
    var name = $('#inputEmployee').val();
    name = (name == '') ? 'Employee 1' : name;
    var ee = new app.Employee({
        name: name,
        abbr: getAbbreviation(name),
        state: $('#inputState').val(),
        payRate: parseFloat($('#payRate').val()),
        payPeriod: $('#payPeriod').val(),
        payType: $('#payType').val(),
        fedFilingStatus: $('#fedFilingStatus').val(),
        fedAllowances: parseInt($('#fedAllowances').val()),
        fedAdditionalWithheld: parseFloat($('#fedAdditionalWithheld').val()),
        stateFilingStatus: $('#stateFilingStatus').val(),
        stateAllowances: parseInt($('#stateAllowances').val()),
        stateAdditionalWithheld: parseFloat($('#stateAdditionalWithheld').val()),
        numChecks: 1,
        netPay: parseFloat($('#netPay').html().substring(1))
    });
    app.employees.add(ee);
}

// EVENTS FOR THE FORM
$('#eeInputName').keyup(function() {
    var name = $('#eeInputName').val();
    $('#badgeName span').html(name);
    $('#badgeNameAbbreviation span').html(getAbbreviation(name));
});
$('#eeInputEmail').blur(function() {
    var email = $('#eeInputEmail').val().toLowerCase();
    var hash = md5($.trim(email));
    var srcStr = 'http://www.gravatar.com/avatar/' + hash + '?s=142&d=blank';
    $('#badgeImage').attr('src', srcStr);
});
