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

    <title>Appointments - Sunrise Dental Clinic</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">

</head>

<body>

<h1>Appointment Management</h1>

<nav>
    <a href="dashboard.jsp">Dashboard</a> |
    <a href="patients">Patients</a> |
    <a href="dentists">Dentists</a> |
    <a href="logout">Logout</a>
</nav>

<hr>

<h2>Schedule Appointment</h2>

<form method="post" action="appointments">

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
        Dentist ID
        <input name="dentistId"
               type="number"
               min="1"
               required>
    </label>

    <label>
        Appointment Date
        <input name="appointmentDate"
               type="date"
               required>
    </label>

    <label>
        Appointment Time
        <input name="appointmentTime"
               type="time"
               required>
    </label>

    <label>
        Reason for Visit
        <textarea name="reason"
                  rows="3"
                  required></textarea>
    </label>

    <button type="submit">
        Schedule Appointment
    </button>

</form>

<hr>

<h2>Appointment Information</h2>

<pre>
<%= request.getAttribute("json") == null
        ? ""
        : request.getAttribute("json") %>
</pre>

</body>
</html>