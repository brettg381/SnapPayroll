/*************************************
 * IOP javascript interface
 *************************************/

// ===============================
// SETUP

iop = {};
iop.URL_BASE = 'https://branch.iopdev.intuit.com/test';
iop.SETUP_WS = '/webservices/json/SetupWebService';
iop.MOBILE_WS = '/webservices/json/MobileManager';
iop.PAYCHECK_WS = '/webservices/json/PaycheckMgr';

iop.employees = [];
iop.paySchedules = [];
iop.wageItemIds = ['HOURLY_PAY', 'OVERTIME', 'SALARY', 'BONUS', 'COMMISSION', 'DOUBLE_OVERTIME'];
iop.wageItemNames = ['hourly_t', 'overtime_t', 'salary_t', 'bonus_t', 'commission_t', 'double time_t'];

// ===============================
// HELPERS

iop.getCookie = function(c_name) {
    var c_value = document.cookie;
    var c_start = c_value.indexOf(" " + c_name + "=");
    if (c_start == -1) {
        c_start = c_value.indexOf(c_name + "=");
    }
    if (c_start == -1) {
        c_value = null;
    }
    else {
        c_start = c_value.indexOf("=", c_start) + 1;
        var c_end = c_value.indexOf(";", c_start);
        if (c_end == -1) {
            c_end = c_value.length;
        }
        c_value = unescape(c_value.substring(c_start,c_end));
    }
    return c_value;
}

iop.sendRequest = function(obj, endPoint) {
    var dfd = $.Deferred();
    $.ajax({
        url: iop.URL_BASE + endPoint,
        xhrFields: {
            withCredentials: true
        },
        type: 'POST',
        contentType: 'application/json',
        dataType: 'json',
        data: JSON.stringify(obj),
        success: function(data, status, jqXHR) {
            if (typeof data.Fault == 'undefined') {
                var response = data[Object.keys(data)[0]];
                if (typeof response.return == 'undefined') {
                    dfd.resolve();
                } else {
                    dfd.resolve(response.return);
                }
            } else {
                dfd.reject(data);
            }
        },
        error: function(jqXHR, status, errorThrown) {
            console.error('Error from IOP request : ' + errorThrown);
        }
    });
    return dfd.promise();
}

// ===============================
// SIGN IN & SIGN UP INTERFACES

/**
 * Signs a user in to IOP.
 * @param email
 * @param password
 * @returns a $.Deferred promise for completion binding.
 */
iop.signIn = function(email, password) {
    var obj = {"loginMobileMulti": {
        "userName": email,
        "password": password
    }};
    var dfd = $.Deferred();
    var req = iop.sendRequest(obj, true);
    req.done(function(data) {
        iop.company = data;

        // TODO we need to fetch a lot more here.

        dfd.resolve();
    });
    req.fail(dfd.reject);
    return dfd.promise();

}

/**
 * Creates an IOP user account and company.
 * @param email
 * @param password
 * @returns a $.Deferred promise for completion binding.
 */
iop.signUp = function(email, password) {
    // during sign up we follow the formula:
    // 1) update the company model with email and password
    // 2) add company wage item HOURLY_PAY
    // 3) get company wage item
    // 4) build an employee model (store ID)
    // 5) saveCompanyPaySchedule (add company pay schedule, from an employee)
    // 6) updateEmployeeModelById: this will insert the company pay schedule into the employee (only do this once)
    // 7) updateEmployeeModelById: by putting the hourWage JSON Array into the updateEmployee model and calling
    //    the update method, the hourlyWage pay type will get created. Assume that we can do the same with
    //    allWages JSON array.
}

/**
 * Sets up the wage items for a company. This has to be done with
 * sequential requests.
 */
iop.setupWageItem = function(idx) {
    var obj = {"addNewCompanyWageItem" : {
        "companyWageItemModel" : {
            "name": iop.wageItemNames[idx],
            "wageItemId": iop.wageItemIds[idx]
        }
    }};
    return iop.sendRequest(obj, false);
}

iop.logOut = function() {
    var obj = {"logout": {}};
    return iop.sendRequest(obj, true);
}

// ===============================
// PAY SCHEDULE

/**
 *
 * @param payFrequency pay frequency string (eg. "EVERY_WEEK")
 * @param payDate a Date representing the pay date and end of the pay period
 * @param desc description of the schedule (eg. "Weekly Pay Schedule")
 * @returns a $.Deferred promise.
 */
iop.createPaySchedule = function(payFrequency, payDate, desc) {
    var month = payDate.getMonth() + 1;
    var day = payDate.getDate();
    var year = payDate.getFullYear();
    var obj = {"saveCompanyPaySchedule" : {
        "paySchedule": {
            "payFrequency": payFrequency,
            "nextPayDay": {
                "year": year,
                "month": month,
                "day": day
            },
            "periodEndDate": {
                "year": year,
                "month": month,
                "day": day
            },
            "useAsDefault": false,
            "isCustom": false,
            "description": desc
        }
    }}
    return iop.sendRequest(obj, false);
}

/**
 * Fills the iop.paySchedules array with iop.paySchedule objects
 * associated with the current company.
 */
iop.getPaySchedules = function() {
    iop.paySchedules = 0;   // clear the iop.paySchedules array
    var obj = {"getPayScheduleModels" : {}};
    var dfd = $.Deferred();
    var req = iop.sendRequest(obj, false);
    req.done(function(arr) {
        iop.paySchedules = arr;
        dfd.resolve();
    });
    req.fail(dfd.reject);
}

// ===============================
// PAYCHECK
iop.createPaycheck = function() {
//    periodStartDate DateModel
//    periodEndDate
//    checkDate
//    employeePayInfo EmployeePayInfoModelLite[]
//    skipSalariedHoursAdjustment bool
//    allowMultipleChecks bool

}

// ===============================
// EMPLOYEE

/**
 * Fills the iop.employees array with the iop.employee objects
 * associated with the current company.
 */
iop.getEmployees = function() {
    iop.employees.length = 0   // clear the iop.employees array
    var obj = {"getEmployeeModels" : {}};
    var dfd = $.Deferred();
    var req = iop.sendRequest(obj, false);
    req.done(function(arr) {
        iop.employees = arr;
        dfd.resolve();
    });
    req.fail(dfd.reject);
    return dfd.promise();
}

/**
 * Gets an iop.employee from its assigned index value.
 * @param index the value of iop.employee.index
 * @returns a $.Deferred promise object for completion binding.
 *          ret.done is passed the iop.employee object
 */
iop.getEmployeeByIndex = function(index) {
    var obj = {"getEmployeeModelById" : {
        "index" : index
    }};
    return iop.sendRequest(obj, false);
}

/**
 * Creates an employee in IOP and adds it to iop.emplooyees
 * @param firstName
 * @param lastName
 * @returns a $.Deferred promise object for completion binding.
 *          On successful completion, the new employee is added to
 *          iop.employees.
 */
iop.createEmployee = function(firstName, lastName) {
    var obj = {"addEmployeeModel": {
        "employeeModel": {
            "firstName" : firstName,
            "lastName" : lastName,
            "homeAddress": {
                "id": 0,
                "version": 0,
                "address1": "",
                "address2": "",
                "city": "",
                "county": "",
                "isDefaultAddressOK": true,
                "isTaxAddress": false,
                "state": "CA",
                "taxAddress": {
                    "id": 0,
                    "version": 0,
                    "address1": "",
                    "address2": "",
                    "city": "",
                    "county": "",
                    "isDefaultAddressOK": true,
                    "isTaxAddress": false,
                    "state": "CA",
                    "zip": ""
                },
                "validateAddress": true,
                "zip": ""
            },
            "payRateType": 'Salary',
            "salaryRate": 1000.00,
            "salaryFrequency": 'Week',
            "salaryHoursPerDay": 8,
            "salaryDaysPerWeek": 5,
            "employmentStatus": true,
            "federalTaxSetup": {
                "filingStatus": 1,
                "allowances": 0,
                "allowanceAmount": 0,
                "additionalWithholding": 0,
                "isIncomeTaxWithholdingRequired": true,
                "hasRegularAllowances": true,
                "hasAdditionalWithholding": true,
                "hasExemptionAmount": false
            }
        }
    }};
    var dfd = $.Deferred();
    var req = iop.sendRequest(obj, false);
    req.done(function (index) {
        var getReq = iop.getEmployeeByIndex(index);
        getReq.done(function(ee) {
            iop.employees.push(ee);
            dfd.resolve();
        });
        getReq.fail(dfd.reject);
    });
    req.fail(dfd.reject);
    return dfd.promise();
}

/**
 * Sends an updated iop.employee model as an update to IOP.
 * This would be used after modifying the values in an iop.employee model
 * in the iop.employees array.
 * @param index assigned value of the key "index" in the iop.employee
 */
iop.syncEmployee = function(index) {
    var eeModel = null;
    for (var i = 0; i < iop.employees.length; i++) {
        if (iop.employees[i].index == index) {
            eeModel = iop.employees[i];
            break;
        }
    }
    var dfd = $.Deferred();
    if (eeModel == null) {
        dfd.reject();
    }
    var obj = {"updateEmployeeModelByIndex": {
        "employeeModel": eeModel,
        "index": index,
        "persist": true
    }};
    var req = iop.sendRequest(obj, false);
    req.done(dfd.resolve);
    req.fail(dfd.reject);
    return dfd.promise();
}

// ===============================
// MODELS

iop.models = {};
iop.models.company = {
    "acceptedCustomerServiceAgreement": true,
    "businessName": "SNAPDEFAULT",
    "companyType": 'SmallBusiness',
    "featureSetType": 'BasicMinus',
    "serviceType": 'IOP',
    "employeeCountRange": 'OneToTwentyFive',
    "confirmEMailAddress": false,
    "primaryContact": {  // user
        "firstName": "SNAPDEFAULT",
        "lastName": "SNAPDEFAULT",
        "eMailAddress": "",
        "userID": "",
        "password": ""
    },
    "businessAddress": {
        "address1": "121 Main St.",
        "address2":"Building 8",
        "city": "Mountain View",
        "state": "CA",
        "zip":"94039"
    },
    "phone": "555-555-5555",
    "phoneExtension": "",
    "directDeposit": false,
    "havePaidEmployeesThisYear": false,
    "startPayrollThisQtr": true,
    "havePaidTimeOff": false,
    "haveContractor": false,
    "haveTimeTracking": false,
    "companyTaxSetup": {
        "filingName": $('#coName').val(),
        "filingType": "other",
        "isFilingAddressSameAsBusinessAddress": true,
        "federalEIN": "",
        "federalDepositSchedules": [
            {
                "id": 0,
                "version": 0,
                "scheduleId": 1,
                "filingType": "form941",
                "effectiveDate": "2013-01-01T00:00:00-08:00",
                "endDate": "3000-01-01T00:00:00-08:00"
            }
        ],
        "stateTaxSetup": [
            {
                "state": "CA",
                "stateSchedules": [
                    {
                        "id": 0,
                        "version": 0,
                        "scheduleId": 20,
                        "effectiveDate": "2013-01-01T00:00:00-08:00",
                        "endDate": "3000-01-01T00:00:00-08:00"
                    }
                ],
                "stateTaxRates": [
                    {
                        "id": 0,
                        "version": 0,
                        "rate": 0.001,
                        "taxItemId": 9,
                        "effectiveDate": "2013-01-01T00:00:00-08:00",
                        "state": "CA",
                        "endDate": "3000-01-01T00:00:00-08:00",
                        "taxRateType": -1
                    },
                    {
                        "id": 0,
                        "version": 0,
                        "rate": 0.034,
                        "taxItemId": 10,
                        "effectiveDate": "2013-01-01T00:00:00-08:00",
                        "state": "CA",
                        "endDate": "3000-01-01T00:00:00-08:00",
                        "taxRateType": -1
                    }
                ]
            }
        ]
    }
};
