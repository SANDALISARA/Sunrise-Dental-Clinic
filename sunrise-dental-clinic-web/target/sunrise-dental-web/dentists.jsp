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

    <title>Dentists - Sunrise Dental Clinic</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">

</head>

<body>

<h1>Dentist Management</h1>

<nav>
    <a href="dashboard.jsp">Dashboard</a> |
    <a href="patients">Patients</a> |
    <a href="appointments">Appointments</a> |
    <a href="logout">Logout</a>
</nav>

<hr>

<h2>Register Dentist</h2>

<form method="post" action="dentists">

    <input type="hidden"
           name="action"
           value="create">

    <label>
        Dentist Name
        <input name="name" required>
    </label>

    <label>
        Specialization
        <input name="specialization"
               placeholder="e.g. General Dentistry"
               required>
    </label>

    <label>
        Phone Number
        <input name="phone"
               type="tel"
               required>
    </label>

    <label>
        Email
        <input name="email"
               type="email">
    </label>

    <button type="submit">
        Add Dentist
    </button>

</form>

<hr>

<h2>Dentist Information</h2>

<pre>
<%= request.getAttribute("json") == null
        ? ""
        : request.getAttribute("json") %>
</pre>

</body>
</html>