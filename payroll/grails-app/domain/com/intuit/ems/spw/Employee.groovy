package com.intuit.ems.spw

class Employee {

	String name
	Company company
	Date created
	Data modified
	boolean isActive

	Paycheck templatePaycheck

	static hasMany = [paychecks: Paycheck]
	static mappedBy = [paychecks: "employee"]
    static constraints = {
    }
}
