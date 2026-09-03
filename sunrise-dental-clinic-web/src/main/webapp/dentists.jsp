<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="com.google.gson.JsonElement" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.google.gson.JsonParser" %>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String json =
            (String) request.getAttribute("json");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>
        Dentists - Sunrise Dental Clinic
    </title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f5f7fa;
        }

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 30px auto;
        }

        h1 {
            color: #263238;
        }

        h2 {
            color: #263238;
        }

        .nav {
            margin-bottom: 25px;
        }

        .nav a {
            text-decoration: none;
            color: #1976d2;
            font-weight: bold;
            margin-right: 15px;
        }

        .card {
            background-color: white;
            padding: 25px;
            margin-bottom: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .form-grid {
            display: grid;
            grid-template-columns:
                    repeat(2, 1fr);
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: bold;
            margin-bottom: 6px;
        }

        input {
            padding: 11px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        button {
            background-color: #1976d2;
            color: white;
            border: none;
            padding: 12px 22px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }

        button:hover {
            background-color: #125ea7;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th {
            background-color: #37474f;
            color: white;
            padding: 13px;
            text-align: left;
        }

        td {
            padding: 13px;
            border-bottom:
                    1px solid #ddd;
        }

        tr:hover {
            background-color: #f1f5f9;
        }

        .dentist-number {
            font-weight: bold;
            color: #1976d2;
        }

        .empty-message {
            background-color: #fff3cd;
            color: #856404;
            padding: 15px;
            border-radius: 6px;
            margin-top: 15px;
        }

        @media(max-width: 700px) {

            .form-grid {
                grid-template-columns: 1fr;
            }
        }

    </style>

</head>


<body>

<div class="container">


    <h1>
        Dentist Management
    </h1>


    <div class="nav">

        <a href="dashboard.jsp">
            Dashboard
        </a>

        <a href="patients">
            Patients
        </a>

        <a href="appointments">
            Appointments
        </a>

        <a href="logout">
            Logout
        </a>

    </div>


    <!-- REGISTER DENTIST -->

    <div class="card">

        <h2>
            Register Dentist
        </h2>


        <form method="post"
              action="dentists">


            <!-- VERY IMPORTANT -->

            <input type="hidden"
                   name="action"
                   value="create">


            <div class="form-grid">


                <div class="form-group">

                    <label>
                        Dentist Name
                    </label>

                    <input type="text"
                           name="dentistName"
                           placeholder="e.g. Dr. Perera"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Specialization
                    </label>

                    <input type="text"
                           name="specialization"
                           placeholder="e.g. General Dentistry"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Phone Number
                    </label>

                    <input type="text"
                           name="phone"
                           placeholder="e.g. 0771234567"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Email
                    </label>

                    <input type="email"
                           name="email"
                           placeholder="e.g. dentist@gmail.com">

                </div>


                <div>

                    <button type="submit">
                        Add Dentist
                    </button>

                </div>


            </div>

        </form>

    </div>


    <!-- DENTIST TABLE -->

    <div class="card">

        <h2>
            Registered Dentists
        </h2>


        <%
            boolean hasDentists = false;

            try {

                if (json != null
                        && !json.isBlank()) {

                    JsonElement root =
                            JsonParser.parseString(json);

                    if (root.isJsonArray()) {

                        JsonArray dentists =
                                root.getAsJsonArray();

                        if (!dentists.isEmpty()) {

                            hasDentists = true;
        %>


        <table>

            <thead>

            <tr>

                <th>ID</th>

                <th>
                    Dentist No.
                </th>

                <th>
                    Dentist Name
                </th>

                <th>
                    Specialization
                </th>

                <th>
                    Phone
                </th>

                <th>
                    Email
                </th>

            </tr>

            </thead>


            <tbody>


            <%

                for (JsonElement element
                        : dentists) {

                    JsonObject d =
                            element
                                    .getAsJsonObject();


                    String id =
                            d.has("id")
                            ? d.get("id")
                                .getAsString()
                            : "";


                    String dentistNumber =
                            d.has("dentistNumber")
                            && !d.get("dentistNumber")
                                 .isJsonNull()
                            ? d.get("dentistNumber")
                                .getAsString()
                            : "";


                    String dentistName =
                            d.has("dentistName")
                            && !d.get("dentistName")
                                 .isJsonNull()
                            ? d.get("dentistName")
                                .getAsString()
                            : "";


                    String specialization =
                            d.has("specialization")
                            && !d.get("specialization")
                                 .isJsonNull()
                            ? d.get("specialization")
                                .getAsString()
                            : "";


                    String phone =
                            d.has("phone")
                            && !d.get("phone")
                                 .isJsonNull()
                            ? d.get("phone")
                                .getAsString()
                            : "";


                    String email =
                            d.has("email")
                            && !d.get("email")
                                 .isJsonNull()
                            ? d.get("email")
                                .getAsString()
                            : "";

            %>


            <tr>

                <td>
                    <%= id %>
                </td>


                <td class="dentist-number">
                    <%= dentistNumber %>
                </td>


                <td>
                    <%= dentistName %>
                </td>


                <td>
                    <%= specialization %>
                </td>


                <td>
                    <%= phone %>
                </td>


                <td>
                    <%= email %>
                </td>

            </tr>


            <%

                }

            %>


            </tbody>

        </table>


        <%

                        }
                    }
                }

            } catch (Exception e) {

                System.out.println(
                        "Dentist JSON error: "
                                + e.getMessage()
                );
            }


            if (!hasDentists) {

        %>


        <div class="empty-message">

            No dentist records are available.

        </div>


        <%

            }

        %>


    </div>


</div>

</body>

</html>