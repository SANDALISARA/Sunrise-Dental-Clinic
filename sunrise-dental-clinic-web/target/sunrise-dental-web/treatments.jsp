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

    String json = (String) request.getAttribute("json");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>
        Treatments - Sunrise Dental Clinic
    </title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

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

        h1,
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
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        label {
            font-weight: bold;
            margin-bottom: 6px;
        }

        input,
        textarea {
            padding: 11px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
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
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background-color: #f1f5f9;
        }

        .treatment-code {
            color: #1976d2;
            font-weight: bold;
        }

        .price {
            font-weight: bold;
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

            table {
                font-size: 12px;
            }
        }

    </style>

</head>

<body>

<div class="container">

    <h1>
        Dental Treatment Management
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

        <a href="bill">
            Billing
        </a>

        <a href="logout">
            Logout
        </a>

    </div>


    <!-- ========================================== -->
    <!-- ADD TREATMENT -->
    <!-- ========================================== -->

    <div class="card">

        <h2>
            Add Dental Treatment
        </h2>

        <form method="post"
              action="treatments">

            <input type="hidden"
                   name="action"
                   value="create">


            <div class="form-grid">


                <div class="form-group">

                    <label>
                        Treatment Name
                    </label>

                    <input type="text"
                           name="treatmentName"
                           placeholder="e.g. Dental Cleaning"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Treatment Price (LKR)
                    </label>

                    <input type="number"
                           name="price"
                           min="0"
                           step="0.01"
                           placeholder="e.g. 5000.00"
                           required>

                </div>


                <div class="form-group full-width">

                    <label>
                        Description
                    </label>

                    <textarea name="description"
                              placeholder="Enter treatment description"
                              required></textarea>

                </div>


                <div class="full-width">

                    <button type="submit">
                        Add Treatment
                    </button>

                </div>

            </div>

        </form>

    </div>


    <!-- ========================================== -->
    <!-- TREATMENT INFORMATION -->
    <!-- ========================================== -->

    <div class="card">

        <h2>
            Available Treatments
        </h2>

        <%
            boolean hasTreatments = false;

            try {

                if (json != null && !json.isBlank()) {

                    JsonElement root =
                            JsonParser.parseString(json);

                    if (root.isJsonArray()) {

                        JsonArray treatments =
                                root.getAsJsonArray();

                        if (!treatments.isEmpty()) {

                            hasTreatments = true;
        %>


        <table>

            <thead>

            <tr>

                <th>ID</th>

                <th>
                    Treatment Code
                </th>

                <th>
                    Treatment Name
                </th>

                <th>
                    Description
                </th>

                <th>
                    Price (LKR)
                </th>

            </tr>

            </thead>


            <tbody>

            <%

                for (JsonElement element : treatments) {

                    JsonObject treatment =
                            element.getAsJsonObject();


                    String id =
                            treatment.has("id")
                            ? treatment.get("id")
                                       .getAsString()
                            : "";


                    String treatmentCode =
                            treatment.has("treatmentCode")
                            && !treatment.get("treatmentCode")
                                         .isJsonNull()
                            ? treatment.get("treatmentCode")
                                       .getAsString()
                            : "";


                    String treatmentName =
                            treatment.has("treatmentName")
                            && !treatment.get("treatmentName")
                                         .isJsonNull()
                            ? treatment.get("treatmentName")
                                       .getAsString()
                            : "";


                    String description =
                            treatment.has("description")
                            && !treatment.get("description")
                                         .isJsonNull()
                            ? treatment.get("description")
                                       .getAsString()
                            : "";


                    String price =
                            treatment.has("price")
                            && !treatment.get("price")
                                         .isJsonNull()
                            ? treatment.get("price")
                                       .getAsString()
                            : "0";

            %>


            <tr>

                <td>
                    <%= id %>
                </td>


                <td class="treatment-code">
                    <%= treatmentCode %>
                </td>


                <td>
                    <%= treatmentName %>
                </td>


                <td>
                    <%= description %>
                </td>


                <td class="price">
                    Rs. <%= price %>
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
                        "Treatment JSON error: "
                                + e.getMessage()
                );
            }


            if (!hasTreatments) {

        %>


        <div class="empty-message">

            No dental treatments are available.

        </div>


        <%

            }

        %>

    </div>

</div>

</body>

</html>