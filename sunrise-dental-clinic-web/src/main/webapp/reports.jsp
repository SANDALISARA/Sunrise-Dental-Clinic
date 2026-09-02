<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <title>Reports - Sunrise Dental Clinic</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">

</head>

<body>

<h1>Clinic Reports</h1>

<nav>
    <a href="dashboard.jsp">Dashboard</a> |
    <a href="patients">Patients</a> |
    <a href="appointments">Appointments</a> |
    <a href="bill">Billing</a> |
    <a href="logout">Logout</a>
</nav>

<hr>

<h2>Generate Reports</h2>

<ul>

    <li>
        <a href="reports?type=daily-appointments">
            Daily Appointments
        </a>
    </li>

    <li>
        <a href="reports?type=patient-summary">
            Patient Summary
        </a>
    </li>

    <li>
        <a href="reports?type=treatment-summary">
            Treatment Summary
        </a>
    </li>

    <li>
        <a href="reports?type=daily-income">
            Daily Income
        </a>
    </li>

    <li>
        <a href="reports?type=dentist-appointments">
            Dentist Appointment Report
        </a>
    </li>

</ul>

<hr>

<h2>Report Result</h2>

<pre>
<%= request.getAttribute("json") == null
        ? ""
        : request.getAttribute("json") %>
</pre>

</body>
</html>