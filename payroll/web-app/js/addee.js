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

var addEmployeeFromForm = function() {
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
