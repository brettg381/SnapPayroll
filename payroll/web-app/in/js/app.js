// ======================
// GLOBAL SETUP
var today = new Date();
var app = app || {};

var formatDate = function(date) {
    var todayMonthStr = (today.getMonth() < 10) ? '0' + (today.getMonth() + 1) : '' + (today.getMonth() + 1);
    var todayDayStr = (today.getDate() < 10) ? '0' + today.getDate() : '' + today.getDate();
    return todayMonthStr + '/' + todayDayStr + '/' + date.getFullYear();
};
var toFloat = function(str) {
    if (str == null || str == '') {
        return 0.0;
    }
    return parseFloat(str);
}
var toInt = function(str) {
    if (str == null || str == '') {
        return 0;
    }
    return parseInt(str);
}

// [norio] UNFINISHED!
app.eeIopToSimple = function(ee) {
    var name = ee.fistName + ' ' + ee.lastName;
    var abbr = getAbbreviation(name);
    var state = ee.workLocation.state;
    var payType = ee.payRatetype;
    var payRate = toFloat(ee.salaryRate);
    var payPeriod = ee.salaryFrequency;   // [norio] I think this is 'Week' rather than 'Weekly'
    var fedFilingStatus = ee.federalTaxSetup.filingStatus;  // [norio] this is an integer that needs to be remapped
    var fedAllowances = toInt(ee.federalTaxSetup.allowances);
    var fedAdditionalWithheld = toFloat(ee.federalTaxSetup.additionalWithholding);
    var stateFilingStatus
    var stateAllowances
    var stateAdditionalWithheld
}

// [norio] UNFINISHED!
app.eeSimpleToIop = function(simpleEmployeeModel) {
}

// =====================
// TEMPLATE HELPERS
Handlebars.registerHelper('fmtDollars', function(val) {
    if (val > 0) {
        return '$' + val.toFixed(2);
    } else if (val < 0) {
        return '-$' + val.toFixed(2);
    }
    return '$0.00';
});
Handlebars.registerHelper('fmtDate', function(val) {
    return formatDate(val);
});
Handlebars.registerHelper('md5', function(val) {
    if (val == undefined || val == '') return 0;
    return md5(val);
});

// =======================
// CHART DRAWING
function drawChart(totalNet, totalTaxes) {
    var data = google.visualization.arrayToDataTable([
        ['Source', 'Amount'],
        ['Net Pay', totalNet],
        ['Taxes Withheld', totalTaxes]
    ]);
    var options = {
        backgroundColor: '#f7fafc',
        colors: ['#50b8d4','#c1589f'],
        height: 200,
        width: 280,
        chartArea: {
            left: 0,
            top: 10,
            height: 180,
            width: '100%'
        },
        tooltip: {
            testStyle: {
                color: '#ffffff',
                backgroundColor: '#000000'
            }
        },
        legend: 'none',
        pieSliceText: 'none',
        pieHole: 0.5
    };
    var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
    chart.draw(data, options);
}

// =====================
// APP FUNCTIONS

// Deferred -- please use done and fail listeners
app.signIn = function(username, password) {
    return iop.signIn(username, password);
}

// Deferred -- please use done and fail listeners
app.signUp = function(email, password) {
    return iop.signUp(email, password);
}
app.logOut = function() {
    return iop.logOut();
}

// =====================
// MODELS

// User
app.User = Backbone.Model.extend({
    defaults: {
        isLoggedIn: false,
        email: '',
        totalNet: 0.0,
        totalGross: 0.0,
        totalTaxes: 0.0
    }
});
// Paycheck
app.Paycheck = Backbone.Model.extend({
    defaults: {
        "user": 'Unknown',
        "employee": 'Employee 1',
        "grossPay": 0.0,
        "netPay": 0.0,
        "grossQTD": 0.0,
        "grossMTD": 0.0,
        "grossYTD": 0.0,
        "periodsInYear": 52,
        "payDate": new Date(),
        "federalFilingStatus": 'Single',
        "federalAdditionalWithholding": 0.0,
        "federalExemptions": 0,
        "stateFilingStatus": 'Single',
        "stateExemptions": 0,
        "stateAdditionalWithholding": 0.0
    }
});
// Employee
app.Employee = Backbone.Model.extend({
    defaults: {
        name: 'Employee 1',
        payType: 'Hourly',
        payRate: 0.00,
        numChecks: 0,
        netPay: 0.00
    }
});

// =====================
// COLLECTIONS

// Paychecks
app.PaycheckCollection = Backbone.Collection.extend({
    model: app.Paycheck
});
// Employees
app.EmployeesCollection = Backbone.Collection.extend({
    model: app.Employee
});

// =====================
// VIEWS

// UserView
app.UserView = Backbone.View.extend({
    el: '#mainMenu .userid',
    initialize: function() {
        var source = $('#userTemplate').html();
        this.template = Handlebars.compile(source);
    },
    render: function() {
        if (app.currentUser.get('isLoggedIn')) {
            var html = this.template(app.currentUser.toJSON());
            this.$el.html(html);
        }
    }
});

// PaycheckInsightView
app.PaycheckInsightView = Backbone.View.extend({
    el: '#paycheckInsight',
    initialize: function() {
        var source = $('#paycheckInsightTemplate').html();
        this.template = Handlebars.compile(source);
        this.model.on('change', this.render, this);
    },
    render: function() {
        if (app.currentUser.get('isLoggedIn')) {
            var html = this.template(app.currentUser.toJSON());
            this.$el.html(html);
            $('#calculateCheckButton').on('click', function() {
                $('#action-layout .paycheckInput').each(function() {
                    if ($(this).hasClass('inactive')) {
                        $(this).removeClass('inactive');
                    }
                });
                $('#action-layout .employeeInput').each(function() {
                    if (!$(this).hasClass('inactive')) {
                        $(this).addClass('inactive');
                    }
                });
                var ee = findEmployeeByName($('#inputEmployee').val());
                if (ee != null) {
                    populatePaycheckFormWithEmployee(ee);
                }
                $('#action-layout').show('slide', {'direction': 'right'}, 400);
            });
            drawChart(app.currentUser.get('totalNet'), app.currentUser.get('totalTaxes'));
        }
    }
});

// PaychecksView
app.PaychecksView = Backbone.View.extend({
    el: '#paychecks',
    initialize: function() {
        var source = $('#paychecksTemplate').html();
        this.template = Handlebars.compile(source);
        this.collection.on('add', this.render, this);
    },
    render: function() {
        var html = this.template(this.collection.toJSON());
        this.$el.html(html);
    }
});

// EmployeesView
app.EmployeesView = Backbone.View.extend({
    el: '#employees',
    initialize: function() {
        var source = $('#employeesTemplate').html();
        this.template = Handlebars.compile(source);
        this.collection.on('add', this.render, this);
    },
    render: function() {
        var html = this.template(this.collection.toJSON());
        this.$el.html(html);
        $('#employees tr').on('click', function() {
            var ee = findEmployeeByName($(this).find('.name').html());
            populateEmployeeFormWithEmployee(ee);
            activateEmployeeDisplay("Update Employee", "Update your employee.", "Update");
        });
    }
});

// =====================
// APP INITIALIZATION
app.paychecks = new app.PaycheckCollection();
app.paychecksView = new app.PaychecksView({collection: app.paychecks});
app.employees = new app.EmployeesCollection();
app.employeesView = new app.EmployeesView({collection: app.employees});
app.currentUser = new app.User();
app.userView = new app.UserView();
app.paycheckInsightView = new app.PaycheckInsightView({model: app.currentUser});
app.currentCompany = null;  // set by login or sign up

