// ======================
// GLOBAL SETUP
var today = new Date();
var latestCalculatedData = null;
var app = app || {};
var formatDate = function(date) {
    var todayYearStr = date.getFullYear() + '';
    var todayMonthStr = (today.getMonth() < 10) ? '0' + (today.getMonth() + 1) : '' + (today.getMonth() + 1);
    var todayDayStr = (today.getDate() < 10) ? '0' + today.getDate() : '' + today.getDate();
    return todayMonthStr + '/' + todayDayStr + '/' + todayYearStr;
};

// =====================
// MODELS

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
        "payDate": formatDate(new Date()),
        "federalFilingStatus": 'Single',
        "federalAdditionalWithholding": 0.0,
        "federalExemptions": 0,
        "stateFilingStatus": 'Single',
        "stateExemptions": 0,
        "stateAdditionalWithholding": 0.0
    }
});
// User
app.User = Backbone.Model.extend({
    defaults: {
        email: ''
    }
});

// =====================
// COLLECTIONS

// Paychecks
app.PaycheckCollection = Backbone.Collection.extend({
    model: app.Paycheck
});

// =====================
// VIEWS

// PaychecksView
app.PaychecksView = Backbone.View.extend({
    el: '#paychecks',
    initialize: function() {
        var source = $('#paychecksTemplate').html();
        this.template = Handlebars.compile(source);
        this.collection.on('add', this.render, this);  // might be able to do this with bindings
    },
    render: function() {
        var html = this.template(this.collection.toJSON());
        this.$el.html(html);
    }
});
// UserView
app.UserView = Backbone.View.extend({
    el: '#userid',
    initialize: function() {
        var source = $('#userTemplate').html();
        this.template = Handlebars.compile(source);
    },
    render: function() {
        if (app.currentUser != null) {
            var html = this.template(app.currentUser.toJSON());
            this.$el.html(html);
        }
    }
});

// =====================
// APP INITIALIZATION
app.paychecks = new app.PaycheckCollection();
app.paychecksView = new app.PaychecksView({
    collection: app.paychecks
});
app.userView = new app.UserView();
app.currentUser = null;
// =====================
// TESTING
//var paycheck = new app.Paycheck({
//    "employee": 'Brett Groshong',
//    "grossPay": 1000.00,
//    "netPay": 123.45
//});
//
//$(document).ready(function() {
//    app.paychecks.add(paycheck);
//});