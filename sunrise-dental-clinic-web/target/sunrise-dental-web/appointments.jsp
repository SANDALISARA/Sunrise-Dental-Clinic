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

    <title>Appointments - Sunrise Dental Clinic</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>

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
        textarea,
        select {
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
            padding: 12px;
            text-align: left;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background-color: #f1f5f9;
        }

        .appointment-number {
            font-weight: bold;
            color: #1976d2;
        }

        .status {
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
        Appointment Management
    </h1>

    <div class="nav">

        <a href="dashboard.jsp">
            Dashboard
        </a>

        <a href="patients">
            Patients
        </a>

        <a href="dentists">
            Dentists
        </a>

        <a href="logout">
            Logout
        </a>

    </div>


    <!-- SCHEDULE APPOINTMENT -->

    <div class="card">

        <h2>
            Schedule Appointment
        </h2>

        <form method="post"
              action="appointments">

            <input type="hidden"
                   name="action"
                   value="create">

            <div class="form-grid">


                <div class="form-group">

                    <label>
                        Patient ID
                    </label>

                    <input name="patientId"
                           type="number"
                           min="1"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Dentist ID
                    </label>

                    <input name="dentistId"
                           type="number"
                           min="1"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Appointment Date
                    </label>

                    <input name="appointmentDate"
                           type="date"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Appointment Time
                    </label>

                    <input name="appointmentTime"
                           type="time"
                           required>

                </div>


                <div class="form-group full-width">

                    <label>
                        Reason for Visit
                    </label>

                    <textarea name="reason"
                              required></textarea>

                </div>


                <div class="full-width">

                    <button type="submit">
                        Schedule Appointment
                    </button>

                </div>

            </div>

        </form>

    </div>


    <!-- APPOINTMENT INFORMATION -->

    <div class="card">

        <h2>
            Appointment Information
        </h2>

        <%
            boolean hasAppointments = false;

            try {

                if (json != null && !json.isBlank()) {

                    JsonElement root =
                            JsonParser.parseString(json);

                    if (root.isJsonArray()) {

                        JsonArray appointments =
                                root.getAsJsonArray();

                        if (!appointments.isEmpty()) {

                            hasAppointments = true;
        %>

        <table>

            <thead>

            <tr>

                <th>ID</th>
                <th>Appointment No.</th>
                <th>Patient ID</th>
                <th>Dentist ID</th>
                <th>Date</th>
                <th>Time</th>
                <th>Reason</th>
                <th>Status</th>

            </tr>

            </thead>

            <tbody>

            <%

                for (JsonElement element : appointments) {

                    JsonObject a =
                            element.getAsJsonObject();

                    String id =
                            a.has("id")
                            ? a.get("id").getAsString()
                            : "";

                    String appointmentNumber =
                            a.has("appointmentNumber")
                            && !a.get("appointmentNumber").isJsonNull()
                            ? a.get("appointmentNumber").getAsString()
                            : "";

                    String patientId =
                            a.has("patientId")
                            ? a.get("patientId").getAsString()
                            : "";

                    String dentistId =
                            a.has("dentistId")
                            ? a.get("dentistId").getAsString()
                            : "";

                    String appointmentDate =
                            a.has("appointmentDate")
                            && !a.get("appointmentDate").isJsonNull()
                            ? a.get("appointmentDate").getAsString()
                            : "";

                    String appointmentTime =
                            a.has("appointmentTime")
                            && !a.get("appointmentTime").isJsonNull()
                            ? a.get("appointmentTime").getAsString()
                            : "";

                    String reason =
                            a.has("reason")
                            && !a.get("reason").isJsonNull()
                            ? a.get("reason").getAsString()
                            : "";

                    String status =
                            a.has("status")
                            && !a.get("status").isJsonNull()
                            ? a.get("status").getAsString()
                            : "";
            %>

            <tr>

                <td>
                    <%= id %>
                </td>

                <td class="appointment-number">
                    <%= appointmentNumber %>
                </td>

                <td>
                    <%= patientId %>
                </td>

                <td>
                    <%= dentistId %>
                </td>

                <td>
                    <%= appointmentDate %>
                </td>

                <td>
                    <%= appointmentTime %>
                </td>

                <td>
                    <%= reason %>
                </td>

                <td class="status">
                    <%= status %>
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
                        "Appointment JSON error: "
                                + e.getMessage()
                );
            }

            if (!hasAppointments) {
        %>

        <div class="empty-message">
            No appointment records are available.
        </div>

        <%
            }
        %>

    </div>

</div>

</body>

</html>