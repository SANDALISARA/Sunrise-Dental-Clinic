<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>

    <title>Login - Sunrise Dental Clinic</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">

</head>

<body>

<h2>Sunrise Dental Clinic</h2>

<h3>Staff Login</h3>

<form method="post" action="login">

    <label>
        Username
        <input type="text"
               name="username"
               required>
    </label>

    <label>
        Password
        <input type="password"
               name="password"
               required>
    </label>

    <button type="submit">
        Login
    </button>

</form>

<%
    String error =
            (String) request.getAttribute("error");

    if (error != null) {
%>

<p style="color:red;">
    <%= error %>
</p>

<%
    }
%>

<hr>

<h4>Demo Accounts</h4>

<table>

<tr>
    <th>Role</th>
    <th>Username</th>
    <th>Password</th>
</tr>

<tr>
    <td>Administrator</td>
    <td>admin</td>
    <td>admin123</td>
</tr>

<tr>
    <td>Receptionist</td>
    <td>reception</td>
    <td>reception123</td>
</tr>

<tr>
    <td>Dentist</td>
    <td>dentist</td>
    <td>dentist123</td>
</tr>

</table>

</body>
</html>