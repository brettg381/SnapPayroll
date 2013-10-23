$('#landingInputState').on('change', function() {
    var state = $('#landingInputState option:selected').val();
    var itm = $('#landing-state-' + state);
    itm.show();
    itm.children('.accordion-body').collapse();
});
$('#payDate').datepicker();
$('#landingPayDate').datepicker();
$('#inputEmployee').typeahead({
    source: function(query, process) {
        var eeNames = [];
        app.employees.forEach(function(model) {
            eeNames.push(model.get('name'));
        });
        return eeNames;
    }
});
$('#landingSignUp').on('click', function() {
    $('#modalLayout').show();
    $('#signupModal').fadeIn(200);
});
$('#landingSignIn').on('click', function() {
    $('#modalLayout').toggle();
    $('#signinModal').fadeIn(200);
});
$('#loginGoButton').on('click', function() {
    var signInEmailField = $('#loginEmail');
    var signInEmail = signInEmailField.val();
    var signInPasswordField = $('#loginPassword');
    var signInPassword = signInPasswordField.val();
    var p = app.signIn(signInEmail, signInPassword);
    p.done(function() {
        app.currentUser.set('email', signInEmail);
        app.currentUser.set('isLoggedIn', true);
        $('#signinModal').fadeOut(200, function() {
            $('#modalLayout').toggle();
        });
        $('#overviewLayout').css('display', 'inline');
        var actionLayout = $('#action-layout');
        if (actionLayout.css('display') != 'none') {
            actionLayout.hide('slide', {'direction': 'right'}, 400);
        }
        $('#landingLayout').hide('slide', {'direction': 'right'}, 400);
        clearForms();
        $('#cancelSaveCheckButton').show();
        app.userView.render();
    });
    p.fail(function() {
        $('#loginEmail').addClass('error');
        $('#loginPassword').addClass('error');
    });
});
$('#loginCancelButton').on('click', function() {
    $('#signinModal').fadeOut(200, function() {
        $('#modalLayout').toggle();
    });
});
var clearForms = function() {
    $('form').each(function() {$(this).find('input[type=text]').val('')});
    clearCheckDisplay();
    clearBadge();
}
$('#landingCalculateButton').on('click', function() {
    transferLandingData();
    calculate();
    $('#action-layout').show();
    $('#landingLayout').hide('slide', {'direction': 'right'}, 400);
});
$('.accordion').on('show hide', function (evt) {
    $(evt.target).siblings('.accordion-heading').find('.accordion-toggle h4').toggleClass('arrow-right arrow-down');
});
$('#saveCheckButton').on('click', function () {
    if (app.currentUser.get('isLoggedIn')) {
        savePaycheckFromPaycheckForm();
        saveEmployeeFromPaycheckForm();
        $('#paycheckOverviewLayout').css('display', 'inline');
        $('#action-layout').hide('slide', {'direction': 'right'}, 400);
        clearForms();
    } else {
        $('#modalLayout').toggle();
        $('#signupModal').fadeIn(200);
    }
});
$('#cancelSaveCheckButton').on('click', function() {
    $('#paycheckOverviewLayout').css('display', 'inline');
    $('#action-layout').hide('slide', {'direction': 'right'}, 400);
    clearForms();
});
$('#signupCancelButton').on('click', function () {
    $('#signupModal').fadeOut(200, function() {
        $('#modalLayout').toggle();
    });
});
$('#signupGoButton').on('click', function () {
    var valid = true;
    var emailPattern = /.+@.+\..+/;
    var signUpEmailField = $('#signupEmail');
    var signUpEmail = signUpEmailField.val();
    var signUpPasswordField = $('#signupPassword');
    var signUpPassword = signUpPasswordField.val();
    if (!emailPattern.test(signUpEmail)) {
        signUpEmailField.css('border-color', 'red');
        valid = false;
    } else {
        signUpEmailField.css('border-color', '#cccccc');
    }
    if (signUpPassword == '') {
        signUpPasswordField.css('border-color', 'red');
        valid = false;
    } else {
        signUpPasswordField.css('border-color', '#cccccc');
    }
    if (!valid) return;
    var p = app.signUp(signUpEmail, signUpPassword);
    p.done(function() {
        app.currentUser.set('email', signUpEmail);
        app.currentUser.set('isLoggedIn', true);
        savePaycheckFromPaycheckForm();
        saveEmployeeFromPaycheckForm();
        $('#signupModal').fadeOut(200, function() {
            $('#modalLayout').toggle();
        });
        $('#overviewLayout').css('display', 'inline');
        var actionLayout = $('#action-layout');
        if (actionLayout.css('display') != 'none') {
            actionLayout.hide('slide', {'direction': 'right'}, 400);
        }
        if (!actionLayout.is(":visible")) {
            $('#landingLayout').hide('slide', {'direction': 'right'}, 400);
        }
        clearForms();
        $('#cancelSaveCheckButton').show();
        app.userView.render();
    });
    p.fail(function(data) {
        console.error(data);  // [norio] need a spot for display
    });
});
$('#addEmployeeButton').on('click', function() {
    activateEmployeeDisplay("Add Employee", "Let's add a new employee!", "Add");
});
$('#cancelAddEmployeeButton').on('click', function() {
    $('#action-layout').hide('slide', {'direction': 'right'}, 400);
    clearForms();
});
$('#finishAddEmployeeButton').on('click', function() {
    if (saveEmployeeFromEmployeeForm()) {
        $('#action-layout').hide('slide', {'direction': 'right'}, 400);
        clearForms();
    }
});
$('.nav li').on('click', function() {
    if ($(this).hasClass('selected')) {
        return;
    }
    $('.nav li').each(function() {
        $(this).toggleClass('selected');
    });
    switch ($(this).html()) {
        case 'Paychecks':
            $('#paychecksOverview').toggle();
            $('#employeesOverview').toggle();
            break;
        case 'Employees':
            $('#employeesOverview').toggle();
            $('#paychecksOverview').toggle();
            break;
    }
});
$('#logout').on('mouseup', function() {
    app.logOut();
});
$(document).ready(function() {
    var dateStr = formatDate(today);
    $('#payDate').attr('placeholder', dateStr);
    $('#landingPayDate').attr('placeholder', dateStr);
});
