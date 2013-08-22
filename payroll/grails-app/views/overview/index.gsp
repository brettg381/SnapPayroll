<!DOCTYPE html>
<html class="harmony">
<head>
	<title>Intuit Easy Paycheck</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="shortcut icon" href="../images/intuit-favicon.ico">

	<!-- Harmony Component Stylesheets (Compiled SASS/Compass) -->
	<link href="../harmony/css/screen.css" rel="stylesheet">
	<link rel="stylesheet" href="../harmony/css/kalendae.css">
	<link rel="stylesheet" href="../harmony/css/jquery.fancybox.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="../harmony/css/template.css">

	<!-- Custom CSS -->
	<link rel="stylesheet" href="../css/payroll/site.css">

	<!-- Harmony Component Libraries -->
	<script src="../harmony/js/jquery.min.js"></script>
	<script src="../harmony/js/jquery.history.min.js"></script>
	<script src="../harmony/js/jquery.tinyscrollbar.js"></script>
	<script src="../harmony/js/modernizr.min.js"></script>
	<script src="../harmony/js/kalendae.js"></script>
    <script src="../harmony/js/jquery.fancybox.pack.js"></script>

</head>
<body class="harmony">

<!-- TOP NAV -->
<header>
    <div class="title">Easy Paychecks</div>
</header>

<!-- MAIN CONTENT SECTION -->
<div id="main">
	<div id="page" class="page">
		<!-- STAGE -->
		<div class="stage">
			<h2>Employees</h2>
			<!-- INSIGHT -->
			<img src="../images/payroll/pie-chart-infographic.png" style="float:left;"/>
			<!-- CALL TO ACTION -->
			<div class="action">
                <g:if test="${eeInstanceTotal == 0}">
    				<p>Need to pay employees?<p/>
	       			<a href="/harmony-lite/payroll/getStarted" class="button primary">Get started with payroll</a>
                </g:if>
                <g:else>
                    <a href="/harmony-lite/payroll/runPayroll" class="button primary">Run payroll</a>
                </g:else>
			</div>
		</div>
		<div class="content">
			<!-- EMPLOYEE ACTIONS -->
			<div class="buttonbar">
            	<button class="button secondary disabled right" disabled>Add employee</button>
        	</div>
			<!-- EMPLOYEE DISPLAY -->
			<table id="employees">
    			<tr>
        			<th class="sort-desc">Employees<span></span></th>
    	    		<th>Pay Schedule</th>
	        		<th>Pay Rate</th>
        			<th>Pay Method</th>
    			</tr>
                <g:if test="${eeInstanceTotal == 0}">
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </g:if>

                <g:each in="${eeInstanceList}" status="i" var="eeInstance">
                    <tr>
                        <td>${fieldValue(bean: eeInstance, field: "name")}</td>
                        <td>Weekly</td>
                        <td>$10.00 / hour</td>
                        <td>Paper Check</td>
                    </tr>
                </g:each>
<!--
    			<tr>
    	    		<td>Brian Tublin</td>
	        		<td>Every Other Wednesday</td>
		        	<td>$15.00 / hr</td>
		    	    <td>Paper Check</td>
    			</tr>
-->
			</table>
		</div>
	</div>
</div>
</body>
</html>