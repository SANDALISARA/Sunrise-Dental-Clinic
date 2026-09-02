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

    <title>Treatments - Sunrise Dental Clinic</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">

</head>

<body>

<h1>Dental Treatment Management</h1>

<nav>
    <a href="dashboard.jsp">Dashboard</a> |
    <a href="patients">Patients</a> |
    <a href="appointments">Appointments</a> |
    <a href="bill">Billing</a> |
    <a href="logout">Logout</a>
</nav>

<hr>

<h2>Add Dental Treatment</h2>

<form method="post" action="treatments">

    <input type="hidden"
           name="action"
           value="create">

    <label>
        Treatment Name
        <input name="name"
               placeholder="e.g. Dental Cleaning"
               required>
    </label>

    <label>
        Description
        <textarea name="description"
                  rows="3"></textarea>
    </label>

    <label>
        Treatment Price (LKR)
        <input name="price"
               type="number"
               step="0.01"
               min="0"
               required>
    </label>

    <button type="submit">
        Add Treatment
    </button>

</form>

<hr>

<h2>Available Treatments</h2>

<pre>
<%= request.getAttribute("json") == null
        ? ""
        : request.getAttribute("json") %>
</pre>

</body>
</html>