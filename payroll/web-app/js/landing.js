var transferLandingData = function() {
    $('#hoursWorked').val($('#landingHoursWorked').val());
    $('#payRate').val($('#landingPayRate').val());
    $('#payDate').val($('#landingPayDate').val());
    $('#payPeriod').val($('#landingPayPeriod').val());
    $('#payType').val($('#landingPayType').val());
    $('#fedFilingStatus').val($('#landingFedFilingStatus').val());
    $('#fedAllowances').val($('#landingFedAllowances').val());
    $('#fedAdditionalWithheld').val($('#landingFedAdditionalWithheld').val());
    $('#ca_stateFilingStatus').val($('#landing_ca_stateFilingStatus').val());
    $('#ca_stateExemptions').val($('#landing_ca_stateAdditionalWithholding').val());
    $('#ca_stateAdditionalWithholding').val($('#landing_ca_stateAdditionalWithholding').val());
}