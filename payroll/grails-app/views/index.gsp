<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Easy Paychecks</title>
        <meta name="description" content="Easy paycheck calculation">
        <r:require module="payroll"/>
	</head>
	<body>
        <div id="landingLayout" class="frameLayout harmony">
            <div class="row-fluid">
                <div class="offset1 span6">
                    <div class="invisibleHeader">
                        <r:img dir="/images/payroll" file="logo-large.png" class="logo"/>
                    </div>
                    <div id="landingCalcFormWrapper">
                        <div id="landingCalcForm">
                            <h1>Let's calculate a new paycheck!</h1>
                            <r:img dir="/images/payroll" file="landing-arrow.png" id="startPointer"/>
                            <form class="form-horizontal" method="post" action="../">
                                <div class="accordion-group">
                                    <div class="control-group">
                                        <label class="control-label" for="landingInputState">State</label>
                                        <div class="controls">
                                            <select id="landingInputState" class="input-medium">
                                                <!--<option value="al">Alabama</option>-->
                                                <!--<option value="az">Arizona</option>-->
                                                <option value="ca" selected>California</option>
                                                <!--<option value="ga">Georgia</option>-->
                                                <!--<option value="il">Illinois</option>-->
                                                <!--<option value="la">Louisiana</option>-->
                                                <!--<option value="md">Maryland</option>-->
                                                <!--<option value="ny">New York</option>-->
                                                <!--<option value="nc">North Carolina</option>-->
                                                <!--<option value="va">Virginia</option>-->
                                                <!--<option value="wa">Washington</option>-->
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <!-- =============== -->
                                <!-- PAY INFORMATION -->
                                <div id="landingAccordion" class="accordion">
                                    <div class="accordion-group">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" href="#landingPayInformationSection" data-parent="#landingAccordion">
                                                <h4 class="form_title arrow-right">Pay Information </h4>
                                            </a>
                                        </div>
                                        <div id="landingPayInformationSection" class="accordion-body collapse in">
                                            <div class="control-group">
                                                <label class="control-label" for="landingPayType">Pay Type</label>
                                                <div class="controls">
                                                    <select id="landingPayType" class="input-medium">
                                                        <option>Hourly</option>
                                                        <option>Salary</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landingPayRate">Pay Rate</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" id="landingPayRate" class="input-small" placeholder="0.00">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="control-group hourly">
                                                <label class="control-label" for="landingHoursWorked">Hours Worked</label>
                                                <div class="controls">
                                                    <input type="text" class="input-small" id="landingHoursWorked" placeholder="0.0">
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landingPayDate">Pay Date</label>
                                                <div class="controls">
                                                    <input type="text" class="input-small" id="landingPayDate">
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landingPayPeriod">Pay Period</label>
                                                <div class="controls">
                                                    <select id="landingPayPeriod" class="input-medium">
                                                        <option>Weekly</option>
                                                        <option>Bi-weekly</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- ==================== -->
                                    <!-- FEDERAL WITHHOLDING -->
                                    <div class="accordion-group">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle" data-toggle="collapse" href="#landingFederalWithHoldingsSection" data-parent="#landingAccordion">
                                                <h4 class="form_title arrow-right">Federal Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="landingFederalWithHoldingsSection" class="accordion-body collapse">
                                            <span class="info">Enter the info from the employee completed W4 Form. If you don't have the employee's W4 yet, don't worry, we'll fill in the safest tax rates for you.</span>
                                            <div class="control-group">
                                                <label class="control-label" for="landingFedFilingStatus">Filing Status</label>
                                                <div class="controls">
                                                    <select id="landingFedFilingStatus">
                                                        <option value="Single">Single</option>
                                                        <option value="Married">Married</option>
                                                        <option value="Single">Married but Single Rate</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landingFedAllowances">Number of Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input-mini" id="landingFedAllowances" placeholder="0">
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landingFedAdditionalWithheld">Additional</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" id="landingFedAdditionalWithheld" class="input-small" placeholder="0.00">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- ================== -->
                                    <!-- STATE  -->

                                    <!-- ALABAMA -->
                                    <div id="landing-state-al" class="accordion-group state-al hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#landingAccordion" href="#landingCollapseAL">
                                                <h4 class="form_title arrow-right">Alabama State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="landingCollapseAL" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="landing_al_stateFilingStatus">Filling Status</label>
                                                <div class="controls">
                                                    <select name="landing_al_stateFilingStatus" id="landing_al_stateFilingStatus">
                                                        <option value="S">Single</option>
                                                        <option value="0" selected="selected">Single, No Exemption</option>
                                                        <option value="M">Married</option>
                                                        <option value="MS">Married, Filing Separately</option>
                                                        <option value="H">Head of Family</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_al_stateExemptions">Number Of Dependents</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="landing_al_stateExemptions" id="landing_al_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_al_stateAdditionalWithholding">Additional Amount</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="landing_al_stateAdditionalWithholding" id="landing_al_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_al_workSiteZip">Zip Code</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="landing_al_workSiteZip" id="landing_al_workSiteZip" placeholder="" maxlength="5"/>
                                                </div>
                                            </div>
                                            <!--
                                            <div class="control-group">
                                                <label class="control-label" for="al_workSiteZip">City</label>
                                                <div class="controls">
                                                    <select name="al_workSiteCity" id="al_workSiteCity" disabled></select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="al_workSiteZip">County</label>
                                                <div class="controls">
                                                    <select name="al_workSiteCounty" id="al_workSiteCounty" disabled></select>
                                                </div>
                                            </div>
                                            -->
                                        </div>
                                    </div>
                                    <!-- ARIZONA -->
                                    <div id="landing-state-az" class="accordion-group state-az hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#landingAccordion" href="#landingCollapseAZ">
                                                <h4 class="form_title arrow-right">Arizona State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="landingCollapseAZ" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="landing_az_stateFilingStatus">Withholding Rate</label>
                                                <div class="controls">
                                                    <select name="landing_az_stateFilingStatus" id="landing_az_stateFilingStatus">
                                                        <option value="V1_A">0.0%</option>
                                                        <option value="V1_B">0.8%</option>
                                                        <option value="V1_C">1.3%</option>
                                                        <option value="V1_D">1.8%</option>
                                                        <option value="V1_E">2.7%</option>
                                                        <option value="V1_F">3.6%</option>
                                                        <option value="V1_G">4.2%</option>
                                                        <option value="V1_H" selected="selected">5.1%</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_az_stateAdditionalWithholding">Additional Amount</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="landing_az_stateAdditionalWithholding" id="landing_az_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- CALIFORNIA -->
                                    <div id="landing-state-ca" class="accordion-group state-ca accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#landingAccordion" href="#landingCollapseCA">
                                                <h4 class="form_title arrow-right">California State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="landingCollapseCA" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="landing_ca_stateFilingStatus">Filling Status</label>
                                                <div class="controls">
                                                    <select name="landing_ca_stateFilingStatus" id="landing_ca_stateFilingStatus">
                                                        <option value="SingleOrDualIncome" selected="selected">Single/Married (2+ incomes)</option>
                                                        <option value="MarriedOneIncome">Married (1 income)</option>
                                                        <option value="HeadOfHousehold">Head Of Household</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_ca_stateExemptions">Number of Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="landing_ca_stateExemptions" id="landing_ca_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_ca_stateAdditionalWithholding">Additional Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="landing_ca_stateAdditionalWithholding" id="landing_ca_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- COLORADO -->
                                    <div id="landing-state-co" class="accordion-group state-co hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#landingAccordion" href="#landingCollapseCO">
                                                <h4 class="form_title arrow-right">Colorado State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="landingCollapseCO" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="landing_co_stateExemptions">Number of Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="landing_ca_stateExemptions" id="landing_co_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_co_stateAdditionalWithholding">Additional Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="landing_co_stateAdditionalWithholding" id="landing_co_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- GEORGIA -->
                                    <div id="landing-state-ga" class="accordion-group state-ga hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#landingAccordion" href="#landingCollapseGA">
                                                <h4 class="form_title arrow-right">Georgia State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="landingCollapseGA" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="landing_ga_stateFilingStatus">Filling Status</label>
                                                <div class="controls">
                                                    <select name="landing_ga_stateFilingStatus" id="landing_ga_stateFilingStatus">
                                                        <option value="Single" selected="selected">Single</option>
                                                        <option value="MarriedJointlyTwoWorking">Married-Joint, 2 Working</option>
                                                        <option value="MarriedJointlyOneWorking">Married-Joint, 1 Working</option>
                                                        <option value="MarriedFilingSeparate">Married-Filing Separate</option>
                                                        <option value="HeadOfHousehold">Head Of Household</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_ga_stateExemptions">Total Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="landing_ga_stateExemptions" id="landing_ga_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_ga_stateAdditionalWithholding">Additional Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="landing_ga_stateAdditionalWithholding" id="landing_ga_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- ILLINOIS -->
                                    <div id="landing-state-il" class="accordion-group state-il hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#landingAccordion" href="#landingCollapseIL">
                                                <h4 class="form_title arrow-right">Illinois State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="landingCollapseIL" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="il_stateFilingStatus">Filling Status</label>
                                                <div class="controls">
                                                    <select name="il_stateFilingStatus">
                                                        <option value="Regular" selected="selected">Regular</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_il_stateExemptions">Basic Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="landing_il_stateExemptions" id="landing_il_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_il_stateAdditionalWithholding">Additional Withheld</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="landing_il_stateAdditionalWithholding" id="landing_il_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- LOUISIANA -->
                                    <div id="landing-state-la" class="accordion-group state-la hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#landingAccordion" href="#landingCollapseLA">
                                                <h4 class="form_title arrow-right">Louisiana State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="landingCollapseLA" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="landing_la_stateFilingStatus">Filling Status</label>
                                                <div class="controls">
                                                    <select name="landing_la_stateFilingStatus" id="landing_la_stateFilingStatus">
                                                        <option value="Regular" selected="selected">Regular</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_la_stateExemptions">Total Exemptions</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="landing_la_stateExemptions" id="landing_la_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_la_stateSecondaryExemptions">Total Dependents</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="landing_la_stateSecondaryExemptions" id="landing_la_stateSecondaryExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_la_stateAdditionalWithholding">Amount to be Withheld</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="landing_la_stateAdditionalWithholding" id="landing_la_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- MARYLAND -->
                                    <div id="landing-state-md" class="accordion-group state-md hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#landingAccordion" href="#landingCollapseMD">
                                                <h4 class="form_title arrow-right">Maryland State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="landingCollapseMD" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="landing_md_stateFilingStatus">Filling Status</label>
                                                <div class="controls">
                                                    <select name="landing_md_stateFilingStatus" id="landing_md_stateFilingStatus">
                                                        <option value="Single" selected="selected">Single</option>
                                                        <option value="Married">Married</option>
                                                        <option value="Single">Married, but Single Rate</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_md_residenceCounty">Residence County</label>
                                                <div class="controls">
                                                    <select name="landing_md_residenceCounty" id="landing_md_residenceCounty">
                                                        <option value="Allegany">Allegany</option>
                                                        <option value="Anne Arundel">Anne Arundel</option>
                                                        <option value="Baltimore">Baltimore</option>
                                                        <option value="Calvert">Calvert</option>
                                                        <option value="Caroline">Caroline</option>
                                                        <option value="Carroll">Carroll</option>
                                                        <option value="Cecil">Cecil</option>
                                                        <option value="Charles">Charles</option>
                                                        <option value="Dorchester">Dorchester</option>
                                                        <option value="Frederick">Frederick</option>
                                                        <option value="Garrett">Garrett</option>
                                                        <option value="Harford">Harford</option>
                                                        <option value="Howard">Howard</option>
                                                        <option value="Kent">Kent</option>
                                                        <option value="Montgomery">Montgomery</option>
                                                        <option value="Prince Georges">Prince Georges</option>
                                                        <option value="Queen Annes">Queen Annes</option>
                                                        <option value="St Marys">St Marys</option>
                                                        <option value="Somerset">Somerset</option>
                                                        <option value="Talbot">Talbot</option>
                                                        <option value="Washington">Washington</option>
                                                        <option value="Wicomico">Wicomico</option>
                                                        <option value="Worcester">Worcester</option>
                                                        <option value="Baltimore (Ind City)">Baltimore (Ind City)</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_md_stateExemptions">Total Exemptions</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="landing_md_stateExemptions" id="landing_md_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_md_stateAdditionalWithholding">Additional Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="landing_md_stateAdditionalWithholding" id="landing_md_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- NEW YORK -->
                                    <div id="landing-state-ny" class="accordion-group state-ny hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#landingAccordion" href="#landingCollapseNY">
                                                <h4 class="form_title arrow-right">New York State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="landingCollapseNY" class="accordion-body collapse">
                                            <!-- RESIDENCE -->
                                            <div class="control-group">
                                                <label class="control-label" for="landing_ny_residenceCity">Residence</label>
                                                <div class="controls">
                                                    <select name="landing_ny_residenceCity" id="landing_ny_residenceCity">
                                                        <option value="" selected="selected">Other</option>
                                                        <option value="Yonkers">Yonkers</option>
                                                        <option value="New York">New York City</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <!-- WORK SITE -->
                                            <div class="control-group">
                                                <label class="control-label" for="landing_ny_workSiteCity">Work Site</label>
                                                <div class="controls">
                                                    <select name="landing_ny_workSiteCity" id="landing_ny_workSiteCity">
                                                        <option value="" selected="selected">Other</option>
                                                        <option value="Yonkers">Yonkers</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <!-- RESIDENCE FILLING STATUS -->
                                            <div class="control-group">
                                                <label class="control-label" for="landing_ny_residenceFilingStatus">Filling Status</label>
                                                <div class="controls">
                                                    <select name="landing_ny_residenceFilingStatus" id="landing_ny_residenceFilingStatus">
                                                        <option value="SingleOrHeadOfHousehold" selected="selected">Single</option>
                                                        <option value="Married">Married</option>
                                                        <option value="SingleOrHeadOfHousehold">Married, but Single Rate</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <!-- RESIDENCE EXEMPTIONS -->
                                            <div class="control-group">
                                                <label class="control-label" for="landing_ny_residenceExemptions">NYC Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre ny-residence" name="landing_ny_residenceExemptions" id="landing_ny_residenceExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <!-- RESIDENCE WHITEHOLDING -->
                                            <div class="control-group">
                                                <label class="control-label" for="landing_ny_residenceAdditionalWithholding">Additional NYC Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre ny-residence" name="landing_ny_residenceAdditionalWithholding" id="landing_ny_residenceAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- WORK SITE ADDITIONAL -->
                                            <div class="control-group">
                                                <label class="control-label" for="landing_ny_workSiteAdditionalWithholding">Additional Yonkers Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency ny-worksite" name="landing_ny_workSiteAdditionalWithholding" id="landing_ny_workSiteAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- STATE EXEMPTIONS -->
                                            <div class="control-group">
                                                <label class="control-label" for="landing_ny_stateExemptions">Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="landing_ny_stateExemptions" id="landing_ny_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <!-- ADDITIONAL WITHHOLDING -->
                                            <div class="control-group">
                                                <label class="control-label" for="landing_ny_stateAdditionalWithholding">Additional State Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="landing_ny_stateAdditionalWithholding" id="landing_ny_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- NORTH CAROLINA -->
                                    <div id="landing-state-nc" class="accordion-group state-nc hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#landingAccordion" href="#landingCollapseNC">
                                                <h4 class="form_title arrow-right">North Carolina State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="landingCollapseNC" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="landing_nc_stateFilingStatus">Filing Status</label>
                                                <div class="controls">
                                                    <select name="landing_nc_stateFilingStatus" id="landing_nc_stateFilingStatus">
                                                        <option value="Single" selected="selected">Single</option>
                                                        <option value="HeadOfHousehold">Head Of Household</option>
                                                        <option value="MarriedOrWidow">Married Or Widow(er)</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_nc_stateExemptions">Total Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="landing_nc_stateExemptions" id="landing_nc_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_nc_stateAdditionalWithholding">Additional Withholdings</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="landing_nc_stateAdditionalWithholding" id="landing_nc_stateAdditionalWithholding" placeholder="0"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- VIRGINIA -->
                                    <div id="landing-state-va" class="accordion-group state-va hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#landingAccordion" href="#landingCollapseVA">
                                                <h4 class="form_title arrow-right">Virginia State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="landingCollapseVA" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="landing_va_stateFilingStatus">Filing Status</label>
                                                <div class="controls">
                                                    <select name="landing_va_stateFilingStatus" id="landing_va_stateFilingStatus">
                                                        <option value="Regular" selected="selected">Regular</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_va_stateExemptions">Total Exemptions</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="landing_va_stateExemptions" id="landing_va_stateExemptions"placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="landing_va_stateAdditionalWithholding">Additional Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="landing_va_stateAdditionalWithholding" id="landing_va_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- WASHINGTON -->
                                    <div id="landing-state-wa" class="accordion-group state-wa hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#landingAccordion" href="#landingCollapseWA">
                                                <h4 class="form_title arrow-right">Washington State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="landingCollapseWA" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="landing_wa_workersCompRate">Workers' Comp Rate</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="landing_wa_workersCompRate" id="landing_wa_workersCompRate" placeholder="0.00" /> /hr
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <button id="landingCalculateButton" class="button primary">Calculate Check</button>
                        </div>
                    </div>
                </div>
                <div class="span4">
                    <div id="landingInfoWrapper">
                        <div id="landingControls">
                            <span id="landingSignUp">Sign Up</span>
                            <span id="landingSignIn">Log In</span>
                        </div>
                        <div id="landingInfo">
                            <h3>Calculate paychecks for FREE!</h3>
                            <div class="landingInfoItem">
                                <r:img dir="/images/payroll" file="taxes-light.png"/>
                                <span><b>Get accurate calculations</b> based on up-to-date tax rates</span>
                            </div>
                            <div class="landingInfoItem">
                                <r:img dir="/images/payroll" file="history-light.png"/>
                                <span><b>Simplify taxes and accounting</b> by saving your check history</span>
                            </div>
                            <div class="landingInfoItem">
                                <r:img dir="/images/payroll" file="paychecks-light.png"/>
                                <span><b>Calculate future checks faster</b> with saved employee details</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="overviewLayout" class="frameLayout harmony hidden">
            <div class="west">
                <div class="nav">
                    <div class="app-title"></div>
                    <ul>
                        <li class="paychecks selected">Paychecks</li>
                        <li class="employees">Employees</li>
                    </ul>
                </div>
            </div>
            <div class="north">
                <div id="mainMenu">
                    <a href="help.html" class="right menuItem" target="_blank"><r:img dir="/images/payroll" file="help_symbol.png" alt="Help"/></a>
                    <div id="userActions" class="pull-right dropbdown right menuItem">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <span class="userid"></span>
                            <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                            <li><a id="logout" href="">Log Out</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="center">
                <div id="paychecksOverview">
                    <h1 class="title">Paychecks</h1>
                    <div id="paycheckInsight" class="insight">
                    </div>
                    <div class="data">
                        <table id="paycheckTable">
                            <thead>
                                <tr>
                                    <th>Employee</th>
                                    <th>Pay Date</th>
                                    <th>Gross Pay</th>
                                    <th>Net Pay</th>
                                </tr>
                            </thead>
                            <tbody id="paychecks">
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="employeesOverview" class="hidden">
                    <h1 class="title">Employees<button id="addEmployeeButton" class="button primary right">Add new employee</button></h1>
                    <div class="data">
                        <table id="employeesTable">
                            <thead>
                            <tr>
                                <th>Employee</th>
                                <th>Pay Type</th>
                                <th>Gross Rate</th>
                                <th>Checks</th>
                                <th>Total 2013 Net Pay</th>
                            </tr>
                            </thead>
                            <tbody id="employees">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="action-layout" class="frameLayout harmony hidden">
            <header class="trowser paycheckInput">
                <div class="title">Calculate Paycheck</div>
                <div class="actions">
                    <a class="help" title="Help" href="help.html" target="_blank"></a>
                </div>
            </header>
            <header class="trowser employeeInput hidden">
                <div class="title">Add Employee</div>
                <div class="actions">
                    <a class="help" title="Help" href="help.html" target="_blank"></a>
                </div>
            </header>
            <div id="middle">
                <div id="left-wrapper">
                    <div id="left">
                        <div class="paycheckInput">
                            <h1>Let's calculate a new paycheck!</h1>
                            <form class="form-horizontal" id="calculator-form" method="post" action="../">
                                <div class="accordion-group">
                                    <div class="control-group">
                                        <label class="control-label" for="inputEmployee">Employee</label>
                                        <div class="controls">
                                            <input type="text" id="inputEmployee" placeholder="Employee 1">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="inputState">State</label>
                                        <div class="controls">
                                            <select id="inputState" class="input-medium">
                                                <!--<option value="al">Alabama</option>-->
                                                <!--<option value="az">Arizona</option>-->
                                                <option value="ca" selected>California</option>
                                                <!--<option value="ga">Georgia</option>-->
                                                <!--<option value="il">Illinois</option>-->
                                                <!--<option value="la">Louisiana</option>-->
                                                <!--<option value="md">Maryland</option>-->
                                                <!--<option value="ny">New York</option>-->
                                                <!--<option value="nc">North Carolina</option>-->
                                                <!--<option value="va">Virginia</option>-->
                                                <!--<option value="wa">Washington</option>-->
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                    <!-- =============== -->
                                    <!-- PAY INFORMATION -->
                                    <div id="paymentAccordion" class="accordion">
                                        <div class="accordion-group">
                                            <div class="accordion-heading">

                                                <a class="accordion-toggle collapsed disabled" data-toggle="collapse" href="#payInformationSection" data-parent="#paymentAccordion">
                                                    <h4 class="form_title arrow-right">Pay Information </h4>
                                                </a>
                                            </div>
                                            <div id="payInformationSection" class="accordion-body collapse in">
                                                <div class="control-group">
                                                    <label class="control-label" for="payType">Pay Type</label>
                                                    <div class="controls">
                                                        <select id="payType" class="input-medium">
                                                            <option>Hourly</option>
                                                            <option>Salary</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="payRate">Pay Rate</label>
                                                    <div class="controls">
                                                        <div class="input-prepend">
                                                            <span class="add-on">$</span>
                                                            <input type="text" id="payRate" class="input-small" placeholder="0.00">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="control-group hourly">
                                                    <label class="control-label" for="hoursWorked">Hours Worked</label>
                                                    <div class="controls">
                                                        <input type="text" class="input-small" id="hoursWorked" placeholder="0.0">
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="payDate">Pay Date</label>
                                                    <div class="controls">
                                                        <input type="text" class="input-small" id="payDate">
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="payPeriod">Pay Period</label>
                                                    <div class="controls">
                                                        <select id="payPeriod" class="input-medium">
                                                            <option>Weekly</option>
                                                            <option>Bi-weekly</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- ============== -->
                                        <!-- ADDITIONAL PAY -->
                                        <div class="accordion-group">
                                            <div class="accordion-heading">
                                                <a class="accordion-toggle" data-toggle="collapse" data-parent="#paymentAccordion" href="#additionalPaySection">
                                                    <h4 class="form_title arrow-right">Additional Pay <small>(Optional)</small></h4>
                                                </a>
                                            </div>
                                            <div id="additionalPaySection" class="accordion-body collapse">
                                                <div class="control-group hourly">
                                                    <label class="control-label" for="overtimeHoursWorked">Overtime Worked</label>
                                                    <div class="controls">
                                                        <input type="text" class="input-small" id="overtimeHoursWorked" placeholder="0.0">
                                                    </div>
                                                </div>
                                                <div class="control-group hourly">
                                                    <label class="control-label" for="salary">Salary</label>
                                                    <div class="controls">
                                                        <div class="input-prepend">
                                                            <span class="add-on">$</span>
                                                            <input type="text" id="salary" class="input-small" placeholder="0.00">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="bonus">Bonus</label>
                                                    <div class="controls">
                                                        <div class="input-prepend">
                                                            <span class="add-on">$</span>
                                                            <input type="text" id="bonus" class="input-small" placeholder="0.00">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="commission">Commission</label>
                                                    <div class="controls">
                                                        <div class="input-prepend">
                                                            <span class="add-on">$</span>
                                                            <input type="text" id="commission" class="input-small" placeholder="0.00">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    <!-- ==================== -->
                                    <!-- FEDERAL -->
                                    <div class="accordion-group">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle" data-toggle="collapse" href="#federalWithHoldingsSection" data-parent="#paymentAccordion">
                                                <h4 class="form_title arrow-right">Federal Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="federalWithHoldingsSection" class="accordion-body collapse">
                                            <span class="info">Enter the info from the employee completed W4 Form. If you don't have the employee's W4 yet, don't worry, we'll fill in the safest tax rates for you.</span>
                                            <div class="control-group">
                                                <label class="control-label" for="fedFilingStatus">Filing Status</label>
                                                <div class="controls">
                                                    <select id="fedFilingStatus">
                                                        <option value="Single">Single</option>
                                                        <option value="Married">Married</option>
                                                        <option value="Single">Married but Single Rate</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="fedAllowances">Number of Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input-mini" id="fedAllowances" placeholder="0">
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="fedAdditionalWithheld">Additional</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" id="fedAdditionalWithheld" class="input-small" placeholder="0.00">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- ================== -->
                                    <!-- STATE -->
                                    <!-- ALABAMA -->
                                    <div class="accordion-group state-al hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#paymentAccordion" href="#collapseAL">
                                                <h4 class="form_title arrow-right">Alabama State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="collapseAL" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="al_stateFilingStatus">Filling Status</label>
                                                <div class="controls">
                                                    <select name="al_stateFilingStatus" id="al_stateFilingStatus">
                                                        <option value="S">Single</option>
                                                        <option value="0" selected="selected">Single, No Exemption</option>
                                                        <option value="M">Married</option>
                                                        <option value="MS">Married, Filing Separately</option>
                                                        <option value="H">Head of Family</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="al_stateExemptions">Number Of Dependents</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="al_stateExemptions" id="al_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="al_stateAdditionalWithholding">Additional Amount</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="al_stateAdditionalWithholding" id="al_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="al_workSiteZip">Zip Code</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="al_workSiteZip" id="al_workSiteZip" placeholder="" maxlength="5"/>
                                                </div>
                                            </div>
                                            <!--
                                            <div class="control-group">
                                                <label class="control-label" for="al_workSiteZip">City</label>
                                                <div class="controls">
                                                    <select name="al_workSiteCity" id="al_workSiteCity" disabled></select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="al_workSiteZip">County</label>
                                                <div class="controls">
                                                    <select name="al_workSiteCounty" id="al_workSiteCounty" disabled></select>
                                                </div>
                                            </div>
                                            -->
                                        </div>
                                    </div>
                                    <!-- ARIZONA -->
                                    <div class="accordion-group state-az hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#paymentAccordion" href="#collapseAZ">
                                                <h4 class="form_title arrow-right">Arizona State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="collapseAZ" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="az_stateFilingStatus">Withholding Rate</label>
                                                <div class="controls">
                                                    <select name="az_stateFilingStatus" id="az_stateFilingStatus">
                                                        <option value="V1_A">0.0%</option>
                                                        <option value="V1_B">0.8%</option>
                                                        <option value="V1_C">1.3%</option>
                                                        <option value="V1_D">1.8%</option>
                                                        <option value="V1_E">2.7%</option>
                                                        <option value="V1_F">3.6%</option>
                                                        <option value="V1_G">4.2%</option>
                                                        <option value="V1_H" selected="selected">5.1%</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="az_stateAdditionalWithholding">Additional Amount</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="az_stateAdditionalWithholding" id="az_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- CALIFORNIA -->
                                    <div class="accordion-group state-ca accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#paymentAccordion" href="#collapseCA">
                                                <h4 class="form_title arrow-right">California State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="collapseCA" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="ca_stateFilingStatus">Filling Status</label>
                                                <div class="controls">
                                                    <select name="ca_stateFilingStatus" id="ca_stateFilingStatus">
                                                        <option value="SingleOrDualIncome" selected="selected">Single/Married (2+ incomes)</option>
                                                        <option value="MarriedOneIncome">Married (1 income)</option>
                                                        <option value="HeadOfHousehold">Head Of Household</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="ca_stateExemptions">Number of Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="ca_stateExemptions" id="ca_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="ca_stateAdditionalWithholding">Additional Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="ca_stateAdditionalWithholding" id="ca_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- COLORADO -->
                                    <div class="accordion-group state-co hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#paymentAccordion" href="#collapseCO">
                                                <h4 class="form_title arrow-right">Colorado State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="collapseCO" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="co_stateExemptions">Number of Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="ca_stateExemptions" id="co_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="co_stateAdditionalWithholding">Additional Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="co_stateAdditionalWithholding" id="co_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- GEORGIA -->
                                    <div class="accordion-group state-ga hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#paymentAccordion" href="#collapseGA">
                                                <h4 class="form_title arrow-right">Georgia State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="collapseGA" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="ga_stateFilingStatus">Filling Status</label>
                                                <div class="controls">
                                                    <select name="ga_stateFilingStatus" id="ga_stateFilingStatus">
                                                        <option value="Single" selected="selected">Single</option>
                                                        <option value="MarriedJointlyTwoWorking">Married-Joint, 2 Working</option>
                                                        <option value="MarriedJointlyOneWorking">Married-Joint, 1 Working</option>
                                                        <option value="MarriedFilingSeparate">Married-Filing Separate</option>
                                                        <option value="HeadOfHousehold">Head Of Household</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="ga_stateExemptions">Total Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="ga_stateExemptions" id="ga_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="ga_stateAdditionalWithholding">Additional Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="ga_stateAdditionalWithholding" id="ga_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- ILLINOIS -->
                                    <div class="accordion-group state-il hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#paymentAccordion" href="#collapseIL">
                                                <h4 class="form_title arrow-right">Illinois State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="collapseIL" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="il_stateFilingStatus">Filling Status</label>
                                                <div class="controls">
                                                    <select name="il_stateFilingStatus" id="il_stateFilingStatus">
                                                        <option value="Regular" selected="selected">Regular</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="il_stateExemptions">Basic Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="il_stateExemptions" id="il_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="il_stateAdditionalWithholding">Additional Withheld</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="il_stateAdditionalWithholding" id="il_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- LOUISIANA -->
                                    <div class="accordion-group state-la hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#paymentAccordion" href="#collapseLA">
                                                <h4 class="form_title arrow-right">Louisiana State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="collapseLA" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="la_stateFilingStatus">Filling Status</label>
                                                <div class="controls">
                                                    <select name="la_stateFilingStatus" id="la_stateFilingStatus">
                                                        <option value="Regular" selected="selected">Regular</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="la_stateExemptions">Total Exemptions</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="la_stateExemptions" id="la_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="la_stateSecondaryExemptions">Total Dependents</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="la_stateSecondaryExemptions" id="la_stateSecondaryExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="la_stateAdditionalWithholding">Amount to be Withheld</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="la_stateAdditionalWithholding" id="la_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- MARYLAND -->
                                    <div class="accordion-group state-md hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#paymentAccordion" href="#collapseMD">
                                                <h4 class="form_title arrow-right">Maryland State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="collapseMD" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="md_stateFilingStatus">Filling Status</label>
                                                <div class="controls">
                                                    <select name="md_stateFilingStatus" id="md_stateFilingStatus">
                                                        <option value="Single" selected="selected">Single</option>
                                                        <option value="Married">Married</option>
                                                        <option value="Single">Married, but Single Rate</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="md_residenceCounty">Residence County</label>
                                                <div class="controls">
                                                    <select name="md_residenceCounty" id="md_residenceCounty">
                                                        <option value="Allegany">Allegany</option>
                                                        <option value="Anne Arundel">Anne Arundel</option>
                                                        <option value="Baltimore">Baltimore</option>
                                                        <option value="Calvert">Calvert</option>
                                                        <option value="Caroline">Caroline</option>
                                                        <option value="Carroll">Carroll</option>
                                                        <option value="Cecil">Cecil</option>
                                                        <option value="Charles">Charles</option>
                                                        <option value="Dorchester">Dorchester</option>
                                                        <option value="Frederick">Frederick</option>
                                                        <option value="Garrett">Garrett</option>
                                                        <option value="Harford">Harford</option>
                                                        <option value="Howard">Howard</option>
                                                        <option value="Kent">Kent</option>
                                                        <option value="Montgomery">Montgomery</option>
                                                        <option value="Prince Georges">Prince Georges</option>
                                                        <option value="Queen Annes">Queen Annes</option>
                                                        <option value="St Marys">St Marys</option>
                                                        <option value="Somerset">Somerset</option>
                                                        <option value="Talbot">Talbot</option>
                                                        <option value="Washington">Washington</option>
                                                        <option value="Wicomico">Wicomico</option>
                                                        <option value="Worcester">Worcester</option>
                                                        <option value="Baltimore (Ind City)">Baltimore (Ind City)</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="md_stateExemptions">Total Exemptions</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="md_stateExemptions" id="md_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="md_stateAdditionalWithholding">Additional Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="md_stateAdditionalWithholding" id="md_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- NEW YORK -->
                                    <div class="accordion-group state-ny hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#paymentAccordion" href="#collapseNY">
                                                <h4 class="form_title arrow-right">New York State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="collapseNY" class="accordion-body collapse">
                                            <!-- RESIDENCE -->
                                            <div class="control-group">
                                                <label class="control-label" for="ny_residenceCity">Residence</label>
                                                <div class="controls">
                                                    <select name="ny_residenceCity" id="ny_residenceCity">
                                                        <option value="" selected="selected">Other</option>
                                                        <option value="Yonkers">Yonkers</option>
                                                        <option value="New York">New York City</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <!-- WORK SITE -->
                                            <div class="control-group">
                                                <label class="control-label" for="ny_workSiteCity">Work Site</label>
                                                <div class="controls">
                                                    <select name="ny_workSiteCity" id="ny_workSiteCity">
                                                        <option value="" selected="selected">Other</option>
                                                        <option value="Yonkers">Yonkers</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <!-- RESIDENCE FILLING STATUS -->
                                            <div class="control-group">
                                                <label class="control-label" for="ny_residenceFilingStatus">Filling Status</label>
                                                <div class="controls">
                                                    <select name="ny_residenceFilingStatus" id="ny_residenceFilingStatus" >
                                                        <option value="SingleOrHeadOfHousehold" selected="selected">Single</option>
                                                        <option value="Married">Married</option>
                                                        <option value="SingleOrHeadOfHousehold">Married, but Single Rate</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <!-- RESIDENCE EXEMPTIONS -->
                                            <div class="control-group">
                                                <label class="control-label" for="ny_residenceExemptions">NYC Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre ny-residence" name="ny_residenceExemptions" id="ny_residenceExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <!-- RESIDENCE WHITEHOLDING -->
                                            <div class="control-group">
                                                <label class="control-label" for="ny_residenceAdditionalWithholding">Additional NYC Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre ny-residence" name="ny_residenceAdditionalWithholding" id="ny_residenceAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- WORK SITE ADDITIONAL -->
                                            <div class="control-group">
                                                <label class="control-label" for="ny_workSiteAdditionalWithholding">Additional Yonkers Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency ny-worksite" name="ny_workSiteAdditionalWithholding" id="ny_workSiteAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- STATE EXEMPTIONS -->
                                            <div class="control-group">
                                                <label class="control-label" for="ny_stateExemptions">Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="ny_stateExemptions" id="ny_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <!-- ADDITIONAL WITHHOLDING -->
                                            <div class="control-group">
                                                <label class="control-label" for="ny_stateAdditionalWithholding">Additional State Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="ny_stateAdditionalWithholding" id="ny_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- NORTH CAROLINA -->
                                    <div class="accordion-group state-nc hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#paymentAccordion" href="#collapseNC">
                                                <h4 class="form_title arrow-right">North Carolina State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="collapseNC" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="nc_stateFilingStatus">Filing Status</label>
                                                <div class="controls">
                                                    <select name="nc_stateFilingStatus" id="nc_stateFilingStatus">
                                                        <option value="Single" selected="selected">Single</option>
                                                        <option value="HeadOfHousehold">Head Of Household</option>
                                                        <option value="MarriedOrWidow">Married Or Widow(er)</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="nc_stateExemptions">Total Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="nc_stateExemptions" id="nc_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="nc_stateAdditionalWithholding">Additional Withholdings</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="nc_stateAdditionalWithholding" id="nc_stateAdditionalWithholding" placeholder="0"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- VIRGINIA -->
                                    <div class="accordion-group state-va hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#paymentAccordion" href="#collapseVA">
                                                <h4 class="form_title arrow-right">Virginia State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="collapseVA" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="va_stateFilingStatus">Filing Status</label>
                                                <div class="controls">
                                                    <select name="va_stateFilingStatus" id="va_stateFilingStatus">
                                                        <option value="Regular" selected="selected">Regular</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="va_stateExemptions">Total Exemptions</label>
                                                <div class="controls">
                                                    <input type="text" class="input_pre" name="va_stateExemptions" id="va_stateExemptions" placeholder="0"/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="va_stateAdditionalWithholding">Additional Withholding</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="va_stateAdditionalWithholding" id="va_stateAdditionalWithholding" placeholder="0.00"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- WASHINGTON -->
                                    <div class="accordion-group state-wa hidden accordion-last">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" data-parent="#paymentAccordion" href="#collapseWA">
                                                <h4 class="form_title arrow-right">Washington State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="collapseWA" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="wa_workersCompRate">Workers' Comp Rate</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" class="input_pre currency" name="wa_workersCompRate" id="wa_workersCompRate" placeholder="0.00" /> /hr
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="employeeInput hidden">
                            <h1>Let's add a new employee!</h1>
                            <form class="form-horizontal" id="addEmployeeForm" method="post" action="../">
                                <div class="accordion-group">
                                    <div class="control-group">
                                        <label class="control-label" for="eeInputName">Employee name</label>
                                        <div class="controls">
                                            <input type="text" id="eeInputName" placeholder="Employee 1">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="eeInputName">Employee email</label>
                                        <div class="controls">
                                            <input type="text" id="eeInputEmail" placeholder="example@example.com">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="eeInputState">State</label>
                                        <div class="controls">
                                            <select id="eeInputState" class="input-medium">
                                                <!--<option value="al">Alabama</option>-->
                                                <!--<option value="az">Arizona</option>-->
                                                <option value="ca" selected>California</option>
                                                <!--<option value="ga">Georgia</option>-->
                                                <!--<option value="il">Illinois</option>-->
                                                <!--<option value="la">Louisiana</option>-->
                                                <!--<option value="md">Maryland</option>-->
                                                <!--<option value="ny">New York</option>-->
                                                <!--<option value="nc">North Carolina</option>-->
                                                <!--<option value="va">Virginia</option>-->
                                                <!--<option value="wa">Washington</option>-->
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <!-- =============== -->
                                <!-- PAY INFORMATION -->
                                <div id="eeInputAccordion" class="accordion">
                                    <div class="accordion-group">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle collapsed disabled" data-toggle="collapse" href="#eeInputPaySection" data-parent="#eeInputAccordion">
                                                <h4 class="form_title arrow-right">Pay Information </h4>
                                            </a>
                                        </div>
                                        <div id="eeInputPaySection" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="eeInputPayRate">Pay Rate</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" id="eeInputPayRate" class="input-small" placeholder="0.00">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="eeInputPayPeriod">Pay frequency</label>
                                                <div class="controls">
                                                    <select id="eeInputPayPeriod" class="input-medium">
                                                        <option>Weekly</option>
                                                        <option>Bi-weekly</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="eeInputPayType">Pay Type</label>
                                                <div class="controls">
                                                    <select id="eeInputPayType" class="input-medium">
                                                        <option>Hourly</option>
                                                        <option>Salary</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">Have you already paid this employee in 2013?</label>
                                                <div class="controls">
                                                    <label class="radio inline">
                                                        <input type="radio" name="optionsRadios" id="eeInputPreviousPayYes" value="yes" checked>
                                                        Yes
                                                    </label>
                                                    <label class="radio inline">
                                                        <input type="radio" name="optionsRadios" id="eeInputPreviousPayNo" value="no">
                                                        No
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- ==================== -->
                                    <!-- FEDERAL -->
                                    <div class="accordion-group">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle" data-toggle="collapse" href="#eeInputFedWithHoldingsSection" data-parent="#eeInputAccordion">
                                                <h4 class="form_title arrow-right">Federal Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="eeInputFedWithHoldingsSection" class="accordion-body collapse">
                                            <span class="info">Enter the info from the employee completed W4 Form. If you don't have the employee's W4 yet, don't worry, we'll fill in the safest tax rates for you.</span>
                                            <div class="control-group">
                                                <label class="control-label" for="eeInputFedFilingStatus">Filing Status</label>
                                                <div class="controls">
                                                    <select id="eeInputFedFilingStatus">
                                                        <option value="Single">Single</option>
                                                        <option value="Married">Married</option>
                                                        <option value="Single">Married but Single Rate</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="eeInputFedAllowances">Number of Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input-mini" id="eeInputFedAllowances" placeholder="0">
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="eeInputFedAdditionalWithheld">Additional</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" id="eeInputFedAdditionalWithheld" class="input-small" placeholder="0.00">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- ================== -->
                                    <!-- STATE -->
                                    <div class="accordion-group">
                                        <div class="accordion-heading">
                                            <a class="accordion-toggle" data-toggle="collapse" href="#eeInputStateWithHoldingsSection" data-parent="#eeInputAccordion">
                                                <h4 class="form_title arrow-right">California State Withholdings</h4>
                                            </a>
                                        </div>
                                        <div id="eeInputStateWithHoldingsSection" class="accordion-body collapse">
                                            <div class="control-group">
                                                <label class="control-label" for="eeInputStateFilingStatus">Filing Status</label>
                                                <div class="controls">
                                                    <select id="eeInputStateFilingStatus">
                                                        <option value="SingleOrDualIncome">Single/Married (2+ incomes)</option>
                                                        <option value="MarriedOneIncome">Married (1 income)</option>
                                                        <option value="HeadOfHousehold">Head of Household</option>
                                                        <option value="DoNotWithhold">Do Not Withhold</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="eeInputStateAllowances">Number of Allowances</label>
                                                <div class="controls">
                                                    <input type="text" class="input-mini" id="eeInputStateAllowances" placeholder="0">
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="eeInputstateAdditionalWithheld">Additional</label>
                                                <div class="controls">
                                                    <div class="input-prepend">
                                                        <span class="add-on">$</span>
                                                        <input type="text" id="eeInputStateAdditionalWithheld" class="input-small" placeholder="0.00">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div id="right" class="striped">
                    <div class="paycheckInput">
                        <div id="sample-check-wrapper">
                            <div id="sample-check-body">
                                <div id="address">
                                    <span class="name bold"></span>
                                    <span class="street"></span>
                                    <span class="city"></span>
                                </div>
                                <div id="details">
                                    <span class="desc">pay to</span>
                                    <span id="recipient">Employee 1</span>
                                    <span id="amount">$0.00</span>
                                </div>
                                <div id="itemization">
                                    <table border="0">
                                        <tr>
                                            <th class="first" width="70%">Gross Pay</th>
                                            <th width="30%">Current</th>
                                        </tr>
                                        <tr>
                                            <td class="first">Hourly</td>
                                            <td id="displayGrossHourly">$0.00</td>
                                        </tr>
                                        <tr>
                                            <td class="first">Overtime</td>
                                            <td id="displayGrossOvertime">$0.00</td>
                                        </tr>
                                        <tr>
                                            <td class="first">Salary</td>
                                            <td id="displayAdditionalSalary">$0.00</td>
                                        </tr>
                                        <tr>
                                            <td class="first">Bonus</td>
                                            <td id="displayAdditionalBonus">$0.00</td>
                                        </tr>
                                        <tr>
                                            <td class="first">Commission</td>
                                            <td id="displayAdditionalCommission">$0.00</td>
                                        </tr>
                                    </table>
                                    <table border="0">
                                        <tr>
                                            <th class="first" width="70%">Taxes withheld</th>
                                            <th width="30%">&nbsp;</th>
                                        </tr>
                                        <tr>
                                            <td class="first">Social Security</td>
                                            <td id="SocSecurity">-$0.00</td>
                                        </tr>
                                        <tr>
                                            <td class="first">State Disability Insurance</td>
                                            <td id="CA_SDI">-$0.00</td>
                                        </tr>
                                        <tr>
                                            <td class="first">Medicare</td>
                                            <td id="Medicare">-$0.00</td>
                                        </tr>
                                        <tr>
                                            <td class="first">Federal Income Tax</td>
                                            <td id="FedIncome">-$0.00</td>
                                        </tr>
                                        <tr>
                                            <td class="first">State Income Tax</td>
                                            <td id="CA_Income">-$0.00</td>
                                        </tr>
                                    </table>
                                    <table class="total" border="0">
                                        <tr>
                                            <th class="first" width="70%">Net pay this check</th>
                                            <td id="netPay">$0.00</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div id="sample-check-footer">
                                <r:img dir="/images/payroll" file="pagecornerturned.png" id="corner"/>
                            </div>
                        </div>
                    </div>
                    <div class="employeeInput hidden">
                        <div id="badge">
                            <r:img dir="/images/payroll" file="mock-gravatar.png" id="badgeImage"/>
                            <div id="badgeNameAbbreviation"><span>E1</span></div>
                            <div id="badgeName"><span>Employee 1</span></div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="footer">
                <div class="sticky-footer paycheckInput">
                    <div class="dark left">
                        <button id="cancelSaveCheckButton" class="button hidden">Cancel</button>
                    </div>
                    <button id="saveCheckButton" class="right button primary">Save check</button>
                </div>
                <div class="sticky-footer employeeInput hidden">
                    <div class="dark left">
                        <button id="cancelAddEmployeeButton" class="button">Cancel</button>
                    </div>
                    <button id="finishAddEmployeeButton" class="button primary right">Add</button>
                </div>
            </div>
        </div>
        <!-- MODALS -->
        <div id="modalLayout" class="frameLayout harmony hidden">
            <div class="modal-overlay" id="signupModal" style="display:none;">
                <div class="scrim">
                    <div class="layout">
                        <div class="modal-content">
                            <div class="modal-main-col">
                                <h1>To save your checks, sign up for free!</h1>
                                <form class="form-horizontal" id="signupForm" method="post" action="../">
                                    <div class="control-group">
                                        <label class="control-label" for="signupEmail"><b>Your Email</b></label>
                                        <div class="controls">
                                            <input type="text" id="signupEmail" placeholder="example@example.com">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="signupPassword"><b>Password</b></label>
                                        <div class="controls">
                                            <input type="password" id="signupPassword">
                                        </div>
                                    </div>
                                </form>
                                <button id="signupCancelButton" class="button secondary">No Thanks</button>
                                <button id="signupGoButton" class="button primary">Sign Up!</button>
                            </div>
                            <div class="modal-right-col">
                                <ul>
                                    <li>
                                        <r:img dir="/images/payroll" file="taxes-dark.png"/>
                                        <span><b>Get accurate calculations</b> based on up-to-date tax rates</span>
                                    </li>
                                    <li>
                                        <r:img dir="/images/payroll" file="history-dark.png"/>
                                        <span><b>Simplify taxes and accounting</b> by saving your check history</span>
                                    </li>
                                    <li>
                                        <r:img dir="/images/payroll" file="paychecks-dark.png"/>
                                        <span><b>Calculate future checks faster</b> with saved employee details</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-overlay" id="signinModal" style="display:none;">
                <div class="scrim">
                    <div class="layout">
                        <div class="modal-content">
                            <div class="modal-main-col">
                                <h1>Welcome back!</h1>
                                <form class="form-horizontal" id="loginForm" method="post" action="../">
                                    <div class="control-group">
                                        <label class="control-label" for="signupEmail"><b>Your Email</b></label>
                                        <div class="controls">
                                            <input type="text" id="loginEmail" placeholder="example@example.com">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="signupPassword"><b>Password</b></label>
                                        <div class="controls">
                                            <input type="password" id="loginPassword">
                                        </div>
                                    </div>
                                </form>
                                <button id="loginCancelButton" class="button secondary">Cancel</button>
                                <button id="loginGoButton" class="button primary">Go!</button>
                            </div>
                            <div class="modal-right-col">
                                <ul>
                                    <li>
                                        <r:img dir="/images/payroll" file="taxes-dark.png"/>
                                        <span><b>Get accurate calculations</b> based on up-to-date tax rates</span>
                                    </li>
                                    <li>
                                        <r:img dir="/images/payroll" file="history-dark.png"/>
                                        <span><b>Simplify taxes and accounting</b> by saving your check history</span>
                                    </li>
                                    <li>
                                        <r:img dir="/images/payroll" file="paychecks-dark.png"/>
                                        <span><b>Calculate future checks faster</b> with saved employee details</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- TEMPLATES -->
        <script type="text/template" id="paycheckInsightTemplate">
            <div class="insightBlock">
                <div id="insightTotalNetPay">
                    <span class="insightValueSm">{{fmtDollars this.totalNet}}</span>
                    <span class="insightLabelSm">NET PAY</span>
                </div>
                <div id="insightTotalTaxesWithheld">
                    <span class="insightValueSm">{{fmtDollars this.totalTaxes}}</span>
                    <span class="insightLabelSm">TAXES WITHHELD</span>
                </div>
            </div>
            <div id="donutchart" class="insightBlock">
            </div>
            <div class="insightBlock">
                <div id="insightTotalGrossPay">
                    <span class="insightValueLg">{{fmtDollars this.totalGross}}</span>
                    <span class="insightLabelLg">TOTAL GROSS PAY FOR 2013</span>
                </div>
            </div>
            <div class="call-to-action">
                <button id="calculateCheckButton" class="button primary">Calculate New Check</button>
            </div>
        </script>
        <script type="text/template" id="paychecksTemplate">
            {{#each []}}
                <tr>
                    <td>
                        <div class="mugshot">
                            <div class="namePlate">
                                <span class="abbreviation">{{this.eeAbbr}}</span>
                            </div>
                            <img src="http://www.gravatar.com/avatar/{{md5 this.eeEmail}}?s=26&d=blank"/>
                        </div>
                        <span>{{this.employee}}</span></td>
                    <td>{{fmtDate this.payDate}}</td>
                    <td>{{fmtDollars this.grossPay}}</td>
                    <td>{{fmtDollars this.netPay}}</td>
                </tr>
            {{/each}}
        </script>
        <script type="text/template" id="userTemplate">{{email}}</script>
        <script type="text/template" id="employeesTemplate">
            {{#each []}}
            <tr>
                <td>
                    <div class="mugshot">
                        <div class="namePlate">
                            <span class="abbreviation">{{this.abbr}}</span>
                            {{this.email}}
                        </div>
                        <img src="http://www.gravatar.com/avatar/{{md5 this.email}}?s=26&d=blank"/>
                    </div>
                    <span class="name">{{this.name}}</span>
                </td>
                <td>{{this.payType}}</td>
                <td>{{fmtDollars this.payRate}}</td>
                <td>{{this.numChecks}}</td>
                <td>{{fmtDollars this.netPay}}</td>
            </tr>
            {{/each}}
        </script>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
	</body>
</html>
