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

    <title>Patients - Sunrise Dental Clinic</title>

    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">

</head>

<body>

<h1>Patient Management</h1>

<nav>
    <a href="dashboard.jsp">Dashboard</a> |
    <a href="appointments">Appointments</a> |
    <a href="logout">Logout</a>
</nav>

<hr>

<h2>Register Patient</h2>

<form method="post" action="patients">

    <input type="hidden"
           name="action"
           value="create">

    <label>
        Patient Name
        <input name="name" required>
    </label>

    <label>
        Date of Birth
        <input name="dateOfBirth"
               type="date"
               required>
    </label>

    <label>
        Gender
        <select name="gender" required>
            <option value="">Select Gender</option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
        </select>
    </label>

    <label>
        Address
        <textarea name="address"
                  rows="3"
                  required></textarea>
    </label>

    <label>
        Phone Number
        <input name="phone"
               type="tel"
               pattern="[0-9]{7,15}"
               required>
    </label>

    <label>
        Email
        <input name="email"
               type="email">
    </label>

    <label>
        Medical History
        <textarea name="medicalHistory"
                  rows="4"></textarea>
    </label>

    <button type="submit">
        Register Patient
    </button>

</form>

<hr>

<h2>Patient Search / Results</h2>

<pre>
<%= request.getAttribute("json") == null
        ? ""
        : request.getAttribute("json") %>
</pre>

</body>
</html>