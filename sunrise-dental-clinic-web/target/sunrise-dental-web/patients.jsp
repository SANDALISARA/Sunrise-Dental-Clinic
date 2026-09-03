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
        Patients - Sunrise Dental Clinic
    </title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f5f7fa;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 30px auto;
        }

        h1 {
            color: #263238;
        }

        h2 {
            margin-top: 35px;
            color: #263238;
        }

        .nav {
            margin-bottom: 25px;
        }

        .nav a {
            text-decoration: none;
            margin-right: 15px;
            color: #1976d2;
            font-weight: bold;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 30px;
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
            margin-bottom: 6px;
            font-weight: bold;
        }

        input,
        select,
        textarea {
            padding: 10px;
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
            padding: 11px 20px;
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
            margin-top: 15px;
            background-color: white;
        }

        th {
            background-color: #37474f;
            color: white;
            text-align: left;
            padding: 12px;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background-color: #f1f5f9;
        }

        .empty-message {
            padding: 20px;
            background-color: #fff3cd;
            border-radius: 6px;
            color: #856404;
        }

        .patient-number {
            font-weight: bold;
            color: #1976d2;
        }

        @media (max-width: 768px) {

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
        Patient Management
    </h1>

    <div class="nav">

        <a href="dashboard.jsp">
            Dashboard
        </a>

        <a href="appointments">
            Appointments
        </a>

        <a href="logout">
            Logout
        </a>

    </div>


    <!-- ================================ -->
    <!-- REGISTER PATIENT -->
    <!-- ================================ -->

    <div class="card">

        <h2>
            Register Patient
        </h2>

        <form method="post" action="patients">

            <input type="hidden"
                   name="action"
                   value="create">

            <div class="form-grid">

                <div class="form-group">

                    <label>
                        Patient Name
                    </label>

                    <input type="text"
                           name="patientName"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Date of Birth
                    </label>

                    <input type="date"
                           name="dateOfBirth"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Gender
                    </label>

                    <select name="gender"
                            required>

                        <option value="">
                            Select Gender
                        </option>

                        <option value="Male">
                            Male
                        </option>

                        <option value="Female">
                            Female
                        </option>

                        <option value="Other">
                            Other
                        </option>

                    </select>

                </div>


                <div class="form-group">

                    <label>
                        Phone Number
                    </label>

                    <input type="text"
                           name="phone">

                </div>


                <div class="form-group">

                    <label>
                        Email
                    </label>

                    <input type="email"
                           name="email">

                </div>


                <div class="form-group full-width">

                    <label>
                        Address
                    </label>

                    <textarea name="address"></textarea>

                </div>


                <div class="form-group full-width">

                    <label>
                        Medical History
                    </label>

                    <textarea name="medicalHistory"></textarea>

                </div>


                <div class="full-width">

                    <button type="submit">
                        Register Patient
                    </button>

                </div>

            </div>

        </form>

    </div>


    <!-- ================================ -->
    <!-- PATIENT RESULTS -->
    <!-- ================================ -->

    <div class="card">

        <h2>
            Registered Patients
        </h2>

        <%
            boolean hasPatients = false;

            try {

                if (json != null && !json.isBlank()) {

                    JsonElement root =
                            JsonParser.parseString(json);

                    if (root.isJsonArray()) {

                        JsonArray patients =
                                root.getAsJsonArray();

                        if (!patients.isEmpty()) {

                            hasPatients = true;
        %>

        <table>

            <thead>

            <tr>
                <th>ID</th>
                <th>Patient No.</th>
                <th>Name</th>
                <th>Date of Birth</th>
                <th>Gender</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Address</th>
                <th>Medical History</th>
            </tr>

            </thead>

            <tbody>

            <%
                for (JsonElement element : patients) {

                    JsonObject patient =
                            element.getAsJsonObject();

                    String id =
                            patient.has("id")
                            ? patient.get("id").getAsString()
                            : "";

                    String patientNumber =
                            patient.has("patientNumber")
                            && !patient.get("patientNumber").isJsonNull()
                            ? patient.get("patientNumber").getAsString()
                            : "";

                    String patientName =
                            patient.has("patientName")
                            && !patient.get("patientName").isJsonNull()
                            ? patient.get("patientName").getAsString()
                            : "";

                    String dateOfBirth =
                            patient.has("dateOfBirth")
                            && !patient.get("dateOfBirth").isJsonNull()
                            ? patient.get("dateOfBirth").getAsString()
                            : "";

                    String gender =
                            patient.has("gender")
                            && !patient.get("gender").isJsonNull()
                            ? patient.get("gender").getAsString()
                            : "";

                    String phone =
                            patient.has("phone")
                            && !patient.get("phone").isJsonNull()
                            ? patient.get("phone").getAsString()
                            : "";

                    String email =
                            patient.has("email")
                            && !patient.get("email").isJsonNull()
                            ? patient.get("email").getAsString()
                            : "";

                    String address =
                            patient.has("address")
                            && !patient.get("address").isJsonNull()
                            ? patient.get("address").getAsString()
                            : "";

                    String medicalHistory =
                            patient.has("medicalHistory")
                            && !patient.get("medicalHistory").isJsonNull()
                            ? patient.get("medicalHistory").getAsString()
                            : "";
            %>

            <tr>

                <td>
                    <%= id %>
                </td>

                <td class="patient-number">
                    <%= patientNumber %>
                </td>

                <td>
                    <%= patientName %>
                </td>

                <td>
                    <%= dateOfBirth %>
                </td>

                <td>
                    <%= gender %>
                </td>

                <td>
                    <%= phone %>
                </td>

                <td>
                    <%= email %>
                </td>

                <td>
                    <%= address %>
                </td>

                <td>
                    <%= medicalHistory %>
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
                        "Patient JSON parsing error: "
                                + e.getMessage()
                );
            }

            if (!hasPatients) {
        %>

        <div class="empty-message">

            No patient records are available.

        </div>

        <%
            }
        %>

    </div>

</div>

</body>

</html>