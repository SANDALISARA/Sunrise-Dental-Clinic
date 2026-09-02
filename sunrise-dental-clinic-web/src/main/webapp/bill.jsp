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

    <title>Billing - Sunrise Dental Clinic</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">

</head>

<body>

<h1>Dental Billing</h1>

<nav>
    <a href="dashboard.jsp">Dashboard</a> |
    <a href="patients">Patients</a> |
    <a href="appointments">Appointments</a> |
    <a href="treatments">Treatments</a> |
    <a href="reports">Reports</a> |
    <a href="logout">Logout</a>
</nav>

<hr>

<h2>Create Patient Bill</h2>

<form method="post" action="bill">

    <input type="hidden"
           name="action"
           value="create">

    <label>
        Patient ID
        <input name="patientId"
               type="number"
               min="1"
               required>
    </label>

    <label>
        Appointment ID
        <input name="appointmentId"
               type="number"
               min="1"
               required>
    </label>

    <label>
        Treatment ID
        <input name="treatmentId"
               type="number"
               min="1"
               required>
    </label>

    <label>
        Consultation Fee (LKR)
        <input name="consultationFee"
               type="number"
               step="0.01"
               min="0"
               required>
    </label>

    <button type="submit">
        Calculate & Save Bill
    </button>

</form>

<hr>

<h2>Bill Result</h2>

<pre>
<%= request.getAttribute("json") == null
        ? ""
        : request.getAttribute("json") %>
</pre>

</body>
</html>