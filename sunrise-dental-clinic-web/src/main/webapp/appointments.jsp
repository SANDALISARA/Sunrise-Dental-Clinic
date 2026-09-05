<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="com.google.gson.JsonElement" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.google.gson.JsonParser" %>

<%
    if (session.getAttribute("user") == null) {

        response.sendRedirect(
                "index.jsp"
        );

        return;
    }


    String appointmentsJson =
            (String) request.getAttribute(
                    "appointmentsJson"
            );


    String patientsJson =
            (String) request.getAttribute(
                    "patientsJson"
            );


    String dentistsJson =
            (String) request.getAttribute(
                    "dentistsJson"
            );


    String error =
            (String) request.getAttribute(
                    "error"
            );


    String success =
            (String) request.getAttribute(
                    "success"
            );
%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>
        Appointments - Sunrise Dental Clinic
    </title>


    <style>

        * {
            box-sizing: border-box;
        }


        body {
            margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f4f8fb;
            color: #263238;
        }


        .container {
            width: 94%;
            max-width: 1300px;
            margin: 30px auto;
        }


        h1 {
            color: #064f8c;
        }


        h2 {
            margin-top: 0;
        }


        .nav {
            margin-bottom: 25px;
        }


        .nav a {
            text-decoration: none;
            color: #087ca7;
            margin-right: 15px;
            font-weight: 600;
        }


        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 25px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.07);
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
            font-weight: 600;
            margin-bottom: 6px;
        }


        input,
        select,
        textarea {
            padding: 11px;
            border: 1px solid #ccd7dd;
            border-radius: 7px;
            font-size: 14px;
        }


        input:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #0e9caf;
            box-shadow: 0 0 0 3px rgba(14,156,175,0.12);
        }


        textarea {
            resize: vertical;
            min-height: 80px;
        }


        button {
            border: none;
            padding: 10px 17px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            color: white;
            background: linear-gradient(
                    90deg,
                    #064f8c,
                    #0d95ad
            );
        }


        button:hover {
            opacity: 0.9;
        }


        .edit-button {
            background: #078ca4;
        }


        .cancel-button {
            background: #d84343;
        }


        .close-edit {
            background: #68777e;
        }


        .edit-card {
            display: none;
            border-left: 5px solid #f5a400;
        }


        .error {
            padding: 13px;
            background: #fff0f0;
            border: 1px solid #f1c0c0;
            color: #b3261e;
            border-radius: 7px;
            margin-bottom: 20px;
        }


        .success {
            padding: 13px;
            background: #ecfff3;
            border: 1px solid #bce6ca;
            color: #176b3a;
            border-radius: 7px;
            margin-bottom: 20px;
        }


        .info {
            background: #eefafb;
            border-left: 4px solid #0d95ad;
            padding: 13px;
            border-radius: 6px;
            margin-bottom: 20px;
        }


        .table-wrapper {
            overflow-x: auto;
        }


        table {
            width: 100%;
            border-collapse: collapse;
        }


        th {
            background: linear-gradient(
                    90deg,
                    #064f8c,
                    #087f9a
            );
            color: white;
            padding: 12px;
            text-align: left;
        }


        td {
            padding: 11px;
            border-bottom: 1px solid #dde5e9;
        }


        tbody tr:hover {
            background: #f4fafc;
        }


        .appointment-number {
            color: #087ca7;
            font-weight: bold;
        }


        /* ============================================= */
/* APPOINTMENT STATUS BADGES */
/* ============================================= */

.status-scheduled {
    display: inline-block;
    color: #07558e;
    background: #e3f2fd;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 700;
}

.status-completed {
    display: inline-block;
    color: #16874d;
    background: #ddf7e7;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 700;
}

.status-cancelled {
    display: inline-block;
    color: #b3261e;
    background: #ffe5e5;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 700;
}


/* ============================================= */
/* APPOINTMENT SECTION HEADERS */
/* ============================================= */

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    margin-bottom: 18px;
}

.section-header h2 {
    margin: 0;
}

.section-description {
    color: #68777e;
    font-size: 14px;
    margin-top: 7px;
    margin-bottom: 20px;
}

.scheduled-card {
    border-top: 4px solid #0d95ad;
}

.history-card {
    border-top: 4px solid #16874d;
}

.empty-table-message {
    text-align: center;
    color: #68777e;
    padding: 25px !important;
    background: #fafcfd;
}

        .actions {
            display: flex;
            gap: 7px;
            flex-wrap: wrap;
        }


        .actions form {
            margin: 0;
        }


        @media(max-width: 800px) {

            .form-grid {
                grid-template-columns: 1fr;
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

        <a href="bill">
            Billing
        </a>

        <a href="logout">
            Logout
        </a>

    </div>


    <% if (error != null) { %>

        <div class="error">
            <%= error %>
        </div>

    <% } %>


    <% if (success != null) { %>

        <div class="success">
            <%= success %>
        </div>

    <% } %>



    <!-- ======================================== -->
    <!-- CREATE APPOINTMENT -->
    <!-- ======================================== -->

    <div class="card">


        <h2>
            Schedule Appointment
        </h2>


        <div class="info">

            Appointment times are available every
            <strong>30 minutes</strong> from
            <strong>9:00 AM</strong> to
            <strong>5:30 PM</strong>.
            The clinic closes at 6:00 PM.

        </div>


        <form method="post"
              action="appointments">


            <input type="hidden"
                   name="action"
                   value="create">


            <div class="form-grid">


                <!-- PATIENT -->

                <div class="form-group">

                    <label>
                        Patient
                    </label>

                    <select name="patientId"
                            required>

                        <option value="">
                            Select Patient
                        </option>


                        <%
                            try {

                                if (patientsJson != null) {

                                    JsonArray patients =
                                            JsonParser
                                                    .parseString(
                                                            patientsJson
                                                    )
                                                    .getAsJsonArray();


                                    for (
                                            JsonElement element
                                            : patients) {


                                        JsonObject patient =
                                                element
                                                        .getAsJsonObject();
                        %>


                        <option value="<%= patient.get("id").getAsInt() %>">

                            <%= patient.has("patientNumber")
                                ? patient.get("patientNumber").getAsString()
                                : "" %>

                            -

                            <%= patient.has("patientName")
                                ? patient.get("patientName").getAsString()
                                : "" %>

                        </option>


                        <%
                                    }
                                }

                            } catch (Exception e) {

                                System.out.println(
                                        "Patient dropdown error: "
                                                + e.getMessage()
                                );
                            }
                        %>

                    </select>

                </div>



                <!-- DENTIST -->

                <div class="form-group">

                    <label>
                        Dentist
                    </label>


                    <select name="dentistId"
                            required>


                        <option value="">
                            Select Dentist
                        </option>


                        <%
                            try {

                                if (dentistsJson != null) {

                                    JsonArray dentists =
                                            JsonParser
                                                    .parseString(
                                                            dentistsJson
                                                    )
                                                    .getAsJsonArray();


                                    for (
                                            JsonElement element
                                            : dentists) {


                                        JsonObject dentist =
                                                element
                                                        .getAsJsonObject();
                        %>


                        <option value="<%= dentist.get("id").getAsInt() %>">

                            <%= dentist.has("dentistName")
                                ? dentist.get("dentistName").getAsString()
                                : "" %>

                            <%
                                if (dentist.has("specialization")
                                        && !dentist.get("specialization")
                                                   .isJsonNull()) {
                            %>

                                -
                                <%= dentist.get("specialization").getAsString() %>

                            <% } %>

                        </option>


                        <%
                                    }
                                }

                            } catch (Exception e) {

                                System.out.println(
                                        "Dentist dropdown error: "
                                                + e.getMessage()
                                );
                            }
                        %>

                    </select>

                </div>



                <!-- DATE -->

                <div class="form-group">

                    <label>
                        Appointment Date
                    </label>

                    <input type="date"
                           name="appointmentDate"
                           required>

                </div>



                <!-- TIME -->

                <div class="form-group">

                    <label>
                        Appointment Time
                    </label>

                    <select name="appointmentTime"
                            required>

                        <option value="">
                            Select Time
                        </option>

                        <option value="09:00">
                            9:00 AM
                        </option>

                        <option value="09:30">
                            9:30 AM
                        </option>

                        <option value="10:00">
                            10:00 AM
                        </option>

                        <option value="10:30">
                            10:30 AM
                        </option>

                        <option value="11:00">
                            11:00 AM
                        </option>

                        <option value="11:30">
                            11:30 AM
                        </option>

                        <option value="12:00">
                            12:00 PM
                        </option>

                        <option value="12:30">
                            12:30 PM
                        </option>

                        <option value="13:00">
                            1:00 PM
                        </option>

                        <option value="13:30">
                            1:30 PM
                        </option>

                        <option value="14:00">
                            2:00 PM
                        </option>

                        <option value="14:30">
                            2:30 PM
                        </option>

                        <option value="15:00">
                            3:00 PM
                        </option>

                        <option value="15:30">
                            3:30 PM
                        </option>

                        <option value="16:00">
                            4:00 PM
                        </option>

                        <option value="16:30">
                            4:30 PM
                        </option>

                        <option value="17:00">
                            5:00 PM
                        </option>

                        <option value="17:30">
                            5:30 PM
                        </option>

                    </select>

                </div>



                <!-- REASON -->

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



    <!-- ======================================== -->
    <!-- UPDATE APPOINTMENT -->
    <!-- ======================================== -->

    <div class="card edit-card"
         id="editAppointmentCard">


        <h2>
            Update Appointment
        </h2>


        <form method="post"
              action="appointments">


            <input type="hidden"
                   name="action"
                   value="update">


            <input type="hidden"
                   name="appointmentId"
                   id="editAppointmentId">


            <div class="form-grid">


                <!-- PATIENT -->

                <div class="form-group">

                    <label>
                        Patient
                    </label>


                    <select name="patientId"
                            id="editPatientId"
                            required>


                        <%
                            try {

                                if (patientsJson != null) {

                                    JsonArray patients =
                                            JsonParser
                                                    .parseString(
                                                            patientsJson
                                                    )
                                                    .getAsJsonArray();


                                    for (
                                            JsonElement element
                                            : patients) {


                                        JsonObject patient =
                                                element
                                                        .getAsJsonObject();
                        %>


                        <option value="<%= patient.get("id").getAsInt() %>">

                            <%= patient.has("patientName")
                                ? patient.get("patientName").getAsString()
                                : "" %>

                        </option>


                        <%
                                    }
                                }

                            } catch (Exception e) {
                            }
                        %>


                    </select>

                </div>



                <!-- DENTIST -->

                <div class="form-group">

                    <label>
                        Dentist
                    </label>


                    <select name="dentistId"
                            id="editDentistId"
                            required>


                        <%
                            try {

                                if (dentistsJson != null) {

                                    JsonArray dentists =
                                            JsonParser
                                                    .parseString(
                                                            dentistsJson
                                                    )
                                                    .getAsJsonArray();


                                    for (
                                            JsonElement element
                                            : dentists) {


                                        JsonObject dentist =
                                                element
                                                        .getAsJsonObject();
                        %>


                        <option value="<%= dentist.get("id").getAsInt() %>">

                            <%= dentist.has("dentistName")
                                ? dentist.get("dentistName").getAsString()
                                : "" %>

                        </option>


                        <%
                                    }
                                }

                            } catch (Exception e) {
                            }
                        %>


                    </select>

                </div>



                <div class="form-group">

                    <label>
                        Appointment Date
                    </label>

                    <input type="date"
                           name="appointmentDate"
                           id="editAppointmentDate"
                           required>

                </div>



                <div class="form-group">

                    <label>
                        Appointment Time
                    </label>


                    <select name="appointmentTime"
                            id="editAppointmentTime"
                            required>

                        <option value="09:00">9:00 AM</option>
                        <option value="09:30">9:30 AM</option>

                        <option value="10:00">10:00 AM</option>
                        <option value="10:30">10:30 AM</option>

                        <option value="11:00">11:00 AM</option>
                        <option value="11:30">11:30 AM</option>

                        <option value="12:00">12:00 PM</option>
                        <option value="12:30">12:30 PM</option>

                        <option value="13:00">1:00 PM</option>
                        <option value="13:30">1:30 PM</option>

                        <option value="14:00">2:00 PM</option>
                        <option value="14:30">2:30 PM</option>

                        <option value="15:00">3:00 PM</option>
                        <option value="15:30">3:30 PM</option>

                        <option value="16:00">4:00 PM</option>
                        <option value="16:30">4:30 PM</option>

                        <option value="17:00">5:00 PM</option>
                        <option value="17:30">5:30 PM</option>

                    </select>

                </div>



                <div class="form-group full-width">

                    <label>
                        Reason for Visit
                    </label>

                    <textarea name="reason"
                              id="editReason"
                              required></textarea>

                </div>



               <div class="form-group">

    <label>
        Status
    </label>

    <select name="status"
            id="editStatus">

        <option value="Scheduled">
            Scheduled
        </option>

        <option value="Cancelled">
            Cancelled
        </option>

    </select>

</div>



                <div class="full-width">


                    <button type="submit">

                        Update Appointment

                    </button>


                    <button type="button"
                            class="close-edit"
                            onclick="closeEdit()">

                        Cancel Edit

                    </button>


                </div>


            </div>


        </form>


    </div>



   <!-- ===================================================== -->
<!-- SCHEDULED APPOINTMENTS -->
<!-- ===================================================== -->

<div class="card scheduled-card">

    <div class="section-header">

        <div>

            <h2>
                Scheduled Appointments
            </h2>

            <div class="section-description">
                Active appointments waiting for treatment and billing.
            </div>

        </div>

    </div>


    <div class="table-wrapper">

        <table>

            <thead>

                <tr>

                    <th>Appointment No.</th>

                    <th>Patient</th>

                    <th>Dentist</th>

                    <th>Date</th>

                    <th>Time</th>

                    <th>Reason</th>

                    <th>Status</th>

                    <th>Actions</th>

                </tr>

            </thead>


            <tbody>

            <%

                boolean hasScheduledAppointments = false;


                try {


                    if (appointmentsJson != null
                            && !appointmentsJson.isBlank()) {


                        JsonArray appointments =
                                JsonParser
                                        .parseString(
                                                appointmentsJson
                                        )
                                        .getAsJsonArray();


                        for (JsonElement element : appointments) {


                            JsonObject a =
                                    element.getAsJsonObject();


                            String status =
                                    a.has("status")
                                    && !a.get("status").isJsonNull()
                                    ? a.get("status").getAsString()
                                    : "";


                            // Only show Scheduled appointments here
                            if (!"Scheduled".equalsIgnoreCase(status)) {

                                continue;
                            }


                            hasScheduledAppointments = true;


                            int id =
                                    a.get("id").getAsInt();


                            int patientId =
                                    a.get("patientId").getAsInt();


                            int dentistId =
                                    a.get("dentistId").getAsInt();


                            String appointmentNumber =
                                    a.has("appointmentNumber")
                                    && !a.get("appointmentNumber").isJsonNull()
                                    ? a.get("appointmentNumber").getAsString()
                                    : "";


                            String patientName =
                                    a.has("patientName")
                                    && !a.get("patientName").isJsonNull()
                                    ? a.get("patientName").getAsString()
                                    : "";


                            String dentistName =
                                    a.has("dentistName")
                                    && !a.get("dentistName").isJsonNull()
                                    ? a.get("dentistName").getAsString()
                                    : "";


                            String date =
                                    a.has("appointmentDate")
                                    && !a.get("appointmentDate").isJsonNull()
                                    ? a.get("appointmentDate").getAsString()
                                    : "";


                            String time =
                                    a.has("appointmentTime")
                                    && !a.get("appointmentTime").isJsonNull()
                                    ? a.get("appointmentTime").getAsString()
                                    : "";


                            // Convert 09:00:00 to 09:00
                            if (time.length() >= 5) {

                                time =
                                        time.substring(
                                                0,
                                                5
                                        );
                            }


                            String reason =
                                    a.has("reason")
                                    && !a.get("reason").isJsonNull()
                                    ? a.get("reason").getAsString()
                                    : "";


                            // Make reason safe for JavaScript
                            String safeReason =
                                    reason
                                            .replace(
                                                    "\\",
                                                    "\\\\"
                                            )
                                            .replace(
                                                    "'",
                                                    "\\'"
                                            )
                                            .replace(
                                                    "\r",
                                                    " "
                                            )
                                            .replace(
                                                    "\n",
                                                    " "
                                            );

            %>


            <tr>

                <td class="appointment-number">

                    <%= appointmentNumber %>

                </td>


                <td>

                    <%= patientName %>

                </td>


                <td>

                    <%= dentistName %>

                </td>


                <td>

                    <%= date %>

                </td>


                <td>

                    <%= time %>

                </td>


                <td>

                    <%= reason %>

                </td>


                <td>

                    <span class="status-scheduled">

                        Scheduled

                    </span>

                </td>


                <td>

                    <div class="actions">


                        <!-- EDIT APPOINTMENT -->

                        <button type="button"
                                class="edit-button"
                                onclick="editAppointment(
                                    '<%= id %>',
                                    '<%= patientId %>',
                                    '<%= dentistId %>',
                                    '<%= date %>',
                                    '<%= time %>',
                                    '<%= safeReason %>',
                                    'Scheduled'
                                )">

                            Edit

                        </button>



                        <!-- CANCEL APPOINTMENT -->

                        <form method="post"
                              action="appointments"
                              onsubmit="
                                  return confirm(
                                      'Are you sure you want to cancel this appointment?'
                                  );
                              ">


                            <input type="hidden"
                                   name="action"
                                   value="cancel">


                            <input type="hidden"
                                   name="appointmentId"
                                   value="<%= id %>">


                            <button type="submit"
                                    class="cancel-button">

                                Cancel

                            </button>


                        </form>


                    </div>

                </td>

            </tr>


            <%

                        }

                    }

                } catch (Exception e) {


                    System.out.println(
                            "Scheduled appointment table error: "
                                    + e.getMessage()
                    );

                }


                if (!hasScheduledAppointments) {

            %>


            <tr>

                <td colspan="8"
                    class="empty-table-message">

                    No scheduled appointments are available.

                </td>

            </tr>


            <%

                }

            %>

            </tbody>

        </table>

    </div>

</div>



<!-- ===================================================== -->
<!-- FINISHED APPOINTMENTS / HISTORY -->
<!-- ===================================================== -->

<div class="card history-card">


    <div class="section-header">

        <div>

            <h2>
                Finished Appointment History
            </h2>

            <div class="section-description">

                Completed and cancelled appointments are
                stored here for clinic records.

            </div>

        </div>

    </div>


    <div class="table-wrapper">

        <table>

            <thead>

                <tr>

                    <th>Appointment No.</th>

                    <th>Patient</th>

                    <th>Dentist</th>

                    <th>Date</th>

                    <th>Time</th>

                    <th>Reason</th>

                    <th>Status</th>

                </tr>

            </thead>


            <tbody>

            <%

                boolean hasFinishedAppointments = false;


                try {


                    if (appointmentsJson != null
                            && !appointmentsJson.isBlank()) {


                        JsonArray appointments =
                                JsonParser
                                        .parseString(
                                                appointmentsJson
                                        )
                                        .getAsJsonArray();


                        for (JsonElement element : appointments) {


                            JsonObject a =
                                    element.getAsJsonObject();


                            String status =
                                    a.has("status")
                                    && !a.get("status").isJsonNull()
                                    ? a.get("status").getAsString()
                                    : "";


                            // Do not show Scheduled appointments here
                            if ("Scheduled".equalsIgnoreCase(status)) {

                                continue;
                            }


                            hasFinishedAppointments = true;


                            String appointmentNumber =
                                    a.has("appointmentNumber")
                                    && !a.get("appointmentNumber").isJsonNull()
                                    ? a.get("appointmentNumber").getAsString()
                                    : "";


                            String patientName =
                                    a.has("patientName")
                                    && !a.get("patientName").isJsonNull()
                                    ? a.get("patientName").getAsString()
                                    : "";


                            String dentistName =
                                    a.has("dentistName")
                                    && !a.get("dentistName").isJsonNull()
                                    ? a.get("dentistName").getAsString()
                                    : "";


                            String date =
                                    a.has("appointmentDate")
                                    && !a.get("appointmentDate").isJsonNull()
                                    ? a.get("appointmentDate").getAsString()
                                    : "";


                            String time =
                                    a.has("appointmentTime")
                                    && !a.get("appointmentTime").isJsonNull()
                                    ? a.get("appointmentTime").getAsString()
                                    : "";


                            if (time.length() >= 5) {

                                time =
                                        time.substring(
                                                0,
                                                5
                                        );
                            }


                            String reason =
                                    a.has("reason")
                                    && !a.get("reason").isJsonNull()
                                    ? a.get("reason").getAsString()
                                    : "";

            %>


            <tr>


                <td class="appointment-number">

                    <%= appointmentNumber %>

                </td>


                <td>

                    <%= patientName %>

                </td>


                <td>

                    <%= dentistName %>

                </td>


                <td>

                    <%= date %>

                </td>


                <td>

                    <%= time %>

                </td>


                <td>

                    <%= reason %>

                </td>


                <td>


                    <% if ("Completed".equalsIgnoreCase(status)) { %>


                        <span class="status-completed">

                            Completed

                        </span>


                    <% } else if ("Cancelled".equalsIgnoreCase(status)) { %>


                        <span class="status-cancelled">

                            Cancelled

                        </span>


                    <% } else { %>


                        <span>

                            <%= status %>

                        </span>


                    <% } %>


                </td>


            </tr>


            <%

                        }

                    }

                } catch (Exception e) {


                    System.out.println(
                            "Finished appointment table error: "
                                    + e.getMessage()
                    );

                }


                if (!hasFinishedAppointments) {

            %>


            <tr>

                <td colspan="7"
                    class="empty-table-message">

                    No finished appointments are available yet.

                </td>

            </tr>


            <%

                }

            %>


            </tbody>

        </table>

    </div>

</div>
</div>



<script>


function editAppointment(
        id,
        patientId,
        dentistId,
        date,
        time,
        reason,
        status) {


    document.getElementById(
            "editAppointmentId"
    ).value = id;


    document.getElementById(
            "editPatientId"
    ).value = patientId;


    document.getElementById(
            "editDentistId"
    ).value = dentistId;


    document.getElementById(
            "editAppointmentDate"
    ).value = date;


    document.getElementById(
            "editAppointmentTime"
    ).value = time;


    document.getElementById(
            "editReason"
    ).value = reason;


    document.getElementById(
            "editStatus"
    ).value = status;


    const card =
            document.getElementById(
                    "editAppointmentCard"
            );


    card.style.display =
            "block";


    card.scrollIntoView({
        behavior: "smooth",
        block: "start"
    });
}



function closeEdit() {


    document.getElementById(
            "editAppointmentCard"
    ).style.display =
            "none";
}


</script>


</body>

</html>