var calculate = function() {
    var obj = {
    "grossPay":1000.0,
    "grossQTD":0.0,
    "grossMTD":0.0,
    "grossYTD":0.0,
    "periodsInYear":52,
    "payDate":"20130828",
    "federalFilingStatus":"Single",
    "federalAdditionalWithholding":0.0,
    "federalExemptions":0,
    "stateFilingStatus":"SingleOrDualIncome",
    "stateExemptions":0,
    "stateAdditionalWithholding":0.0
    };

    $.ajax({
        url: 'http://pocketpayroll-lb-QA-ssl-1602432401.us-east-1.elb.amazonaws.com/v1/usa/ca',
        contentType: 'application/json',
        beforeSend: function (request) {
            request.setRequestHeader('X-Intuit-ApiKey', '44F0DCC0-6D52-4BDC-95E1-9784496A177A');
        },
        type: 'POST',
        dataType: 'json',
        data: JSON.stringify(obj),
        success: function(data, status, jqXHR) {
            console.log(data);
        },
        error: function(jqXHR, status, errorThrown) {
            console.log(errorThrown);
        }
    });
};

//calculate();
