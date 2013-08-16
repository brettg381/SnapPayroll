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
	<link rel="stylesheet" href="../css/hlite/site.css">

	<!-- Harmony Component Libraries -->
	<script src="../harmony/js/jquery.min.js"></script>
	<script src="../harmony/js/jquery.history.min.js"></script>
	<script src="../harmony/js/jquery.tinyscrollbar.js"></script>
	<script src="../harmony/js/modernizr.min.js"></script>
	<script src="../harmony/js/kalendae.js"></script>
    <script src="../harmony/js/jquery.fancybox.pack.js"></script>

</head>
<body class="harmony">

<!-- LEFT NAV -->
<nav>
    <div class="logo" title="Intuit"></div>
    <div class="nav-drawer">
        <div class="back"><a href="#back">Back</a></div>
        <div class="primary scrollable">
            <ul>
                <li class="icon dashboard"><a href="#">Dashboard</a>
                    <ul>
                        <li class="section">Dashboard</li>
                    </ul>
                </li>
                <li class="icon expenses"><a href="#">Expenses</a>
                    <ul>
                        <li class="section">Expenses</li>
                    </ul>
                </li>
                <li class="icon customers"><a href="#">Customers</a>
                    <ul>
                        <li class="section">Customers</li>
                    </ul>
                </li>
                <li class="icon vendors"><a href="#">Vendors</a>
                    <ul>
                        <li class="section">Vendors</li>
                    </ul>
                </li>
                <li class="icon employees"><a href="#">Employees</a>
                    <ul>
                        <li class="section">Employees</li>
                    </ul>
                </li>
                <li class="icon accountant"><a href="#">Accountant</a>
                    <ul>
                        <li class="section">Accountant</li>
                    </ul>
                </li>
                <li class="icon billsdotcom"><a href="#">Bills.com</a>
                    <ul>
                        <li class="section">Bills.com</li>
                    </ul>
                </li>
                <li class="icon help"><a href="#">Help</a>
                    <ul>
                        <li class="section">Help</li>
                    </ul>
                </li>
                <li class="icon settings"><a href="#">Settings</a>
                    <ul>
                        <li class="section">Settings</li>
                    </ul>
                </li>
            </ul>
        </div>
        <div class="secondary scrollable">
            <!-- The secondary nav will be placed here via JavaScript. -->
        </div>
    </div>
</nav>

<!-- TOP NAV -->
<header>
    <a href="#nav" class="menu" title="Menu"></a>
    <div class="title">Easy Paycheck</div>
    <div class="actions">
        <a href="#" class="create" title="Create New"></a>
        <a href="#" class="todo" title="To Do"></a>
        <a href="#" class="help" title="Help"></a>
        <a href="#" class="account" title="My Account"></a>
        <div class="search">
            <form action="#" method="post">
                <input type="search" title="Search">
                <input type="submit" value="Search">
            </form>
        </div>
    </div>
</header>

<!-- MAIN CONTENT SECTION -->
<div id="main">
	<div id="page" class="page">
		<!-- STAGE -->
		<div class="stage">
			<h2>Employees</h2>
			<!-- INSIGHT -->
			<img src="../images/hlite/pie-chart-infographic.png" style="float: left;"/>
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
                <div class="select">
                    <select name="employees" id="employees">
                        <option selected disabled>Active Employees&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option value="1">Option 1</option>
                    </select>
                </div>
				<div class="search">
            		<form action="#" method="post">
                		<input type="search" title="Search" placeholder="Find an employee">
                		<input type="submit" value="Search">
            		</form>
            	</div>

            	<button class="button secondary right disabled" disabled>Add employee</button>
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