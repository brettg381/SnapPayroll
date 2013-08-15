package com.intuit.ems.spw

class Paycheck {

	String employee
	Date created
	Date payDate
	String payPeriod
	String state
	String payType   // hourly || salary

	// salary
	float payAmount

	// hourly
	float hoursWorked
	float payRate
	float salary		// additional pay
	float bonus
	float commission
	float otHoursWorked	// overtime
	float otPayRate
	float otTotal 

	float grossPay
	float netPay

	// YTD
	float ytdGrossPay
	float ytdNetPay
	float ytdSalary
	float ytdBonus
	float ytdCommission

    static constraints = {
    }
}
