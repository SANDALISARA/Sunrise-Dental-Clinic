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


    String patientsJson =
            (String) request.getAttribute(
                    "patientsJson"
            );


    String appointmentsJson =
            (String) request.getAttribute(
                    "appointmentsJson"
            );


    String treatmentsJson =
            (String) request.getAttribute(
                    "treatmentsJson"
            );


    String billResult =
            (String) request.getAttribute(
                    "billResult"
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
        Billing - Sunrise Dental Clinic
    </title>


    <style>

        * {
            box-sizing: border-box;
        }


        body {

            margin: 0;

            font-family:
                    "Segoe UI",
                    Arial,
                    sans-serif;

            background:
                    #f4f8fb;

            color:
                    #263238;
        }


        .container {

            width:
                    92%;

            max-width:
                    1150px;

            margin:
                    35px auto;
        }


        h1 {

            color:
                    #07558e;

            margin-bottom:
                    25px;
        }


        h2 {

            margin-top:
                    0;
        }


        .nav {

            margin-bottom:
                    28px;
        }


        .nav a {

            color:
                    #087ca7;

            text-decoration:
                    none;

            margin-right:
                    20px;

            font-weight:
                    600;
        }


        .card {

            background:
                    white;

            padding:
                    28px;

            border-radius:
                    13px;

            margin-bottom:
                    25px;

            box-shadow:
                    0 4px 16px
                    rgba(0,0,0,0.07);
        }


        .form-grid {

            display:
                    grid;

            grid-template-columns:
                    repeat(2, 1fr);

            gap:
                    22px;
        }


        .form-group {

            display:
                    flex;

            flex-direction:
                    column;
        }


        label {

            margin-bottom:
                    8px;

            font-weight:
                    600;
        }


        input,
        select {

            width:
                    100%;

            padding:
                    13px;

            border:
                    1px solid #ccd8df;

            border-radius:
                    7px;

            font-size:
                    15px;

            background:
                    white;
        }


        input:focus,
        select:focus {

            outline:
                    none;

            border-color:
                    #0d95ad;

            box-shadow:
                    0 0 0 3px
                    rgba(13,149,173,0.12);
        }


        button {

            border:
                    none;

            border-radius:
                    7px;

            padding:
                    12px 20px;

            cursor:
                    pointer;

            color:
                    white;

            font-weight:
                    600;

            font-size:
                    14px;

            background:
                    linear-gradient(
                            90deg,
                            #07558e,
                            #0d9aae
                    );
        }


        button:hover {

            opacity:
                    0.92;
        }


        .full-width {

            grid-column:
                    1 / -1;
        }


        .error {

            padding:
                    14px;

            background:
                    #fff0f0;

            color:
                    #b3261e;

            border:
                    1px solid #f2c2c2;

            border-radius:
                    7px;

            margin-bottom:
                    20px;
        }


        .success {

            padding:
                    14px;

            background:
                    #ecfff3;

            color:
                    #176b3a;

            border:
                    1px solid #bce6ca;

            border-radius:
                    7px;

            margin-bottom:
                    20px;
        }


        .appointment-help {

            margin-top:
                    7px;

            color:
                    #68777e;

            font-size:
                    13px;
        }


        .bill-header {

            border-bottom:
                    2px solid #edf1f3;

            padding-bottom:
                    15px;

            margin-bottom:
                    20px;
        }


        .bill-header h2 {

            color:
                    #07558e;

            margin-bottom:
                    5px;
        }


        .bill-number {

            color:
                    #087f9a;

            font-weight:
                    bold;
        }


        .bill-table {

            width:
                    100%;

            border-collapse:
                    collapse;

            margin-top:
                    15px;
        }


        .bill-table td {

            padding:
                    12px;

            border-bottom:
                    1px solid #e1e8ec;
        }


        .bill-table td:first-child {

            font-weight:
                    600;

            width:
                    40%;

            color:
                    #47565d;
        }


        .total-row {

            font-size:
                    18px;

            font-weight:
                    bold;

            color:
                    #07558e;
        }


        .status {

            display:
                    inline-block;

            padding:
                    5px 12px;

            border-radius:
                    20px;

            font-size:
                    13px;

            font-weight:
                    bold;
        }


        .pending {

            background:
                    #fff3d5;

            color:
                    #8b6500;
        }


        .paid {

            background:
                    #ddf7e7;

            color:
                    #17703d;
        }


        .bill-actions {

            margin-top:
                    22px;

            display:
                    flex;

            gap:
                    12px;

            flex-wrap:
                    wrap;
        }


        .pay-button {

            background:
                    #16874d;
        }


        .print-button {

            background:
                    #07558e;
        }


        @media(max-width: 800px) {

            .form-grid {

                grid-template-columns:
                        1fr;
            }


            .full-width {

                grid-column:
                        auto;
            }
        }

    </style>

</head>


<body>


<div class="container">


    <h1>
        Dental Billing
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

        <a href="treatments">
            Treatments
        </a>

        <a href="reports">
            Reports
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



    <!-- ================================================= -->
    <!-- CREATE BILL -->
    <!-- ================================================= -->

    <div class="card">


        <h2>
            Create Patient Bill
        </h2>


        <form method="post"
              action="bill">


            <input type="hidden"
                   name="action"
                   value="create">


            <div class="form-grid">


                <!-- ===================================== -->
                <!-- PATIENT -->
                <!-- ===================================== -->

                <div class="form-group">


                    <label>
                        Patient
                    </label>


                    <select name="patientId"
                            id="patientSelect"
                            onchange="filterAppointments()"
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


                                        JsonObject p =
                                                element
                                                        .getAsJsonObject();


                                        int id =
                                                p.get("id")
                                                        .getAsInt();


                                        String number =
                                                p.has("patientNumber")
                                                ? p.get("patientNumber")
                                                   .getAsString()
                                                : "";


                                        String name =
                                                p.has("patientName")
                                                ? p.get("patientName")
                                                   .getAsString()
                                                : "";
                        %>


                        <option value="<%= id %>">

                            <%= number %>
                            -
                            <%= name %>

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



                <!-- ===================================== -->
                <!-- APPOINTMENT -->
                <!-- ===================================== -->

                <div class="form-group">


                    <label>
                        Scheduled Appointment
                    </label>


                    <select name="appointmentId"
                            id="appointmentSelect"
                            required
                            disabled>


                        <option value="">
                            Select Patient First
                        </option>


                        <%
                            try {

                                if (appointmentsJson != null) {


                                    JsonArray appointments =
                                            JsonParser
                                                    .parseString(
                                                            appointmentsJson
                                                    )
                                                    .getAsJsonArray();


                                    for (
                                            JsonElement element
                                            : appointments) {


                                        JsonObject a =
                                                element
                                                        .getAsJsonObject();


                                        String status =
                                                a.has("status")
                                                ? a.get("status")
                                                   .getAsString()
                                                : "";


                                        // ONLY SCHEDULED
                                        if (!"Scheduled"
                                                .equalsIgnoreCase(
                                                        status
                                                )) {

                                            continue;
                                        }


                                        int id =
                                                a.get("id")
                                                        .getAsInt();


                                        int patientId =
                                                a.get("patientId")
                                                        .getAsInt();


                                        String number =
                                                a.has(
                                                        "appointmentNumber"
                                                )
                                                ? a.get(
                                                        "appointmentNumber"
                                                  ).getAsString()
                                                : "";


                                        String date =
                                                a.has(
                                                        "appointmentDate"
                                                )
                                                ? a.get(
                                                        "appointmentDate"
                                                  ).getAsString()
                                                : "";


                                        String time =
                                                a.has(
                                                        "appointmentTime"
                                                )
                                                ? a.get(
                                                        "appointmentTime"
                                                  ).getAsString()
                                                : "";


                                        String dentist =
                                                a.has("dentistName")
                                                && !a.get("dentistName")
                                                     .isJsonNull()
                                                ? a.get("dentistName")
                                                   .getAsString()
                                                : "";


                                        if (time.length() >= 5) {

                                            time =
                                                    time.substring(
                                                            0,
                                                            5
                                                    );
                                        }
                        %>


                        <option value="<%= id %>"
                                data-patient="<%= patientId %>"
                                style="display:none;">

                            <%= number %>
                            |
                            <%= date %>
                            <%= time %>
                            |
                            <%= dentist %>

                        </option>


                        <%
                                    }
                                }

                            } catch (Exception e) {

                                System.out.println(
                                        "Appointment dropdown error: "
                                                + e.getMessage()
                                );
                            }
                        %>


                    </select>


                    <span class="appointment-help"
                          id="appointmentHelp">

                        Select a patient to view their
                        scheduled appointments.

                    </span>


                </div>



                <!-- ===================================== -->
                <!-- TREATMENT -->
                <!-- ===================================== -->

                <div class="form-group">


                    <label>
                        Treatment
                    </label>


                    <select name="treatmentId"
                            id="treatmentSelect"
                            required>


                        <option value="">
                            Select Treatment
                        </option>


                        <%
                            try {

                                if (treatmentsJson != null) {


                                    JsonArray treatments =
                                            JsonParser
                                                    .parseString(
                                                            treatmentsJson
                                                    )
                                                    .getAsJsonArray();


                                    for (
                                            JsonElement element
                                            : treatments) {


                                        JsonObject t =
                                                element
                                                        .getAsJsonObject();


                                        int id =
                                                t.get("id")
                                                        .getAsInt();


                                        String code =
                                                t.has("treatmentCode")
                                                ? t.get("treatmentCode")
                                                   .getAsString()
                                                : "";


                                        String name =
                                                t.has("treatmentName")
                                                ? t.get("treatmentName")
                                                   .getAsString()
                                                : "";


                                        double price =
                                                t.has("price")
                                                ? t.get("price")
                                                   .getAsDouble()
                                                : 0;
                        %>


                        <option value="<%= id %>">

                            <%= code %>
                            -
                            <%= name %>
                            -
                            LKR
                            <%= String.format("%.2f", price) %>

                        </option>


                        <%
                                    }
                                }

                            } catch (Exception e) {

                                System.out.println(
                                        "Treatment dropdown error: "
                                                + e.getMessage()
                                );
                            }
                        %>


                    </select>


                </div>



                <!-- ===================================== -->
                <!-- CONSULTATION FEE -->
                <!-- ===================================== -->

                <div class="form-group">


                    <label>
                        Consultation Fee (LKR)
                    </label>


                    <input type="number"
                           name="consultationFee"
                           min="0"
                           step="0.01"
                           placeholder="e.g. 2500.00"
                           required>


                </div>



                <div class="full-width">


                    <button type="submit">

                        Calculate & Save Bill

                    </button>


                </div>


            </div>


        </form>


    </div>



    <!-- ================================================= -->
    <!-- BILL RESULT -->
    <!-- ================================================= -->

    <%
        if (billResult != null
                && !billResult.isBlank()) {


            try {


                JsonObject bill =
                        JsonParser
                                .parseString(
                                        billResult
                                )
                                .getAsJsonObject();


                int billId =
                        bill.has("id")
                        ? bill.get("id")
                              .getAsInt()
                        : 0;


                String billNumber =
                        bill.has("billNumber")
                        ? bill.get("billNumber")
                              .getAsString()
                        : "";


                int patientId =
                        bill.has("patientId")
                        ? bill.get("patientId")
                              .getAsInt()
                        : 0;


                int appointmentId =
                        bill.has("appointmentId")
                        ? bill.get("appointmentId")
                              .getAsInt()
                        : 0;


                int treatmentId =
                        bill.has("treatmentId")
                        ? bill.get("treatmentId")
                              .getAsInt()
                        : 0;


                double treatmentFee =
                        bill.has("treatmentFee")
                        ? bill.get("treatmentFee")
                              .getAsDouble()
                        : 0;


                double consultationFee =
                        bill.has("consultationFee")
                        ? bill.get("consultationFee")
                              .getAsDouble()
                        : 0;


                double totalAmount =
                        bill.has("totalAmount")
                        ? bill.get("totalAmount")
                              .getAsDouble()
                        : 0;


                String paymentStatus =
                        bill.has("paymentStatus")
                        ? bill.get("paymentStatus")
                              .getAsString()
                        : "Pending";


                // -----------------------------------------
                // LOOK UP DISPLAY VALUES
                // -----------------------------------------

                String patientName = "";
                String patientNumber = "";

                String appointmentNumber = "";
                String appointmentDate = "";
                String appointmentTime = "";
                String dentistName = "";

                String treatmentName = "";
                String treatmentCode = "";


                // PATIENT
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


                        JsonObject p =
                                element
                                        .getAsJsonObject();


                        if (p.get("id").getAsInt()
                                == patientId) {


                            patientName =
                                    p.has("patientName")
                                    ? p.get("patientName")
                                       .getAsString()
                                    : "";


                            patientNumber =
                                    p.has("patientNumber")
                                    ? p.get("patientNumber")
                                       .getAsString()
                                    : "";


                            break;
                        }
                    }
                }


                // APPOINTMENT
                if (appointmentsJson != null) {

                    JsonArray appointments =
                            JsonParser
                                    .parseString(
                                            appointmentsJson
                                    )
                                    .getAsJsonArray();


                    for (
                            JsonElement element
                            : appointments) {


                        JsonObject a =
                                element
                                        .getAsJsonObject();


                        if (a.get("id").getAsInt()
                                == appointmentId) {


                            appointmentNumber =
                                    a.has("appointmentNumber")
                                    ? a.get("appointmentNumber")
                                       .getAsString()
                                    : "";


                            appointmentDate =
                                    a.has("appointmentDate")
                                    ? a.get("appointmentDate")
                                       .getAsString()
                                    : "";


                            appointmentTime =
                                    a.has("appointmentTime")
                                    ? a.get("appointmentTime")
                                       .getAsString()
                                    : "";


                            dentistName =
                                    a.has("dentistName")
                                    && !a.get("dentistName")
                                         .isJsonNull()
                                    ? a.get("dentistName")
                                       .getAsString()
                                    : "";


                            if (appointmentTime.length()
                                    >= 5) {

                                appointmentTime =
                                        appointmentTime
                                                .substring(
                                                        0,
                                                        5
                                                );
                            }


                            break;
                        }
                    }
                }


                // TREATMENT
                if (treatmentsJson != null) {

                    JsonArray treatments =
                            JsonParser
                                    .parseString(
                                            treatmentsJson
                                    )
                                    .getAsJsonArray();


                    for (
                            JsonElement element
                            : treatments) {


                        JsonObject t =
                                element
                                        .getAsJsonObject();


                        if (t.get("id").getAsInt()
                                == treatmentId) {


                            treatmentName =
                                    t.has("treatmentName")
                                    ? t.get("treatmentName")
                                       .getAsString()
                                    : "";


                            treatmentCode =
                                    t.has("treatmentCode")
                                    ? t.get("treatmentCode")
                                       .getAsString()
                                    : "";


                            break;
                        }
                    }
                }
    %>


    <div class="card"
         id="billResultCard">


        <div class="bill-header">


            <h2>
                Patient Bill
            </h2>


            <span class="bill-number">

                Bill No:
                <%= billNumber %>

            </span>


        </div>


        <table class="bill-table">


            <tr>

                <td>Patient</td>

                <td>
                    <%= patientNumber %>
                    -
                    <%= patientName %>
                </td>

            </tr>


            <tr>

                <td>Appointment</td>

                <td>
                    <%= appointmentNumber %>
                </td>

            </tr>


            <tr>

                <td>Appointment Date</td>

                <td>
                    <%= appointmentDate %>
                </td>

            </tr>


            <tr>

                <td>Appointment Time</td>

                <td>
                    <%= appointmentTime %>
                </td>

            </tr>


            <tr>

                <td>Dentist</td>

                <td>
                    <%= dentistName %>
                </td>

            </tr>


            <tr>

                <td>Treatment</td>

                <td>
                    <%= treatmentCode %>
                    -
                    <%= treatmentName %>
                </td>

            </tr>


            <tr>

                <td>Treatment Fee</td>

                <td>
                    LKR
                    <%= String.format(
                            "%.2f",
                            treatmentFee
                    ) %>
                </td>

            </tr>


            <tr>

                <td>Consultation Fee</td>

                <td>
                    LKR
                    <%= String.format(
                            "%.2f",
                            consultationFee
                    ) %>
                </td>

            </tr>


            <tr class="total-row">

                <td>Total Amount</td>

                <td>
                    LKR
                    <%= String.format(
                            "%.2f",
                            totalAmount
                    ) %>
                </td>

            </tr>


            <tr>

                <td>Payment Status</td>

                <td>


                    <span class="status
                        <%= "Paid"
                                .equalsIgnoreCase(
                                        paymentStatus
                                )
                                ? "paid"
                                : "pending" %>">


                        <%= paymentStatus %>


                    </span>


                </td>

            </tr>


        </table>



        <div class="bill-actions">


            <%
                if ("Pending"
                        .equalsIgnoreCase(
                                paymentStatus
                        )) {
            %>


            <form method="post"
                  action="bill">


                <input type="hidden"
                       name="action"
                       value="pay">


                <input type="hidden"
                       name="billId"
                       value="<%= billId %>">


                <input type="hidden"
                       name="appointmentId"
                       value="<%= appointmentId %>">


                <button type="submit"
                        class="pay-button"
                        onclick="
                            return confirm(
                                'Confirm payment received?'
                            );
                        ">

                    Mark as Paid

                </button>


            </form>


            <%
                }
            %>



            <button type="button"
                    class="print-button"
                    onclick="printReceipt()">

                Print Receipt

            </button>


        </div>


    </div>



    <!-- ================================================= -->
    <!-- RECEIPT DATA FOR JAVASCRIPT -->
    <!-- ================================================= -->

    <script>

        const receiptData = {

            billNumber:
                "<%= billNumber.replace("\"", "\\\"") %>",

            patient:
                "<%= (patientNumber + " - " + patientName)
                        .replace("\"", "\\\"") %>",

            appointment:
                "<%= appointmentNumber.replace("\"", "\\\"") %>",

            appointmentDate:
                "<%= appointmentDate.replace("\"", "\\\"") %>",

            appointmentTime:
                "<%= appointmentTime.replace("\"", "\\\"") %>",

            dentist:
                "<%= dentistName.replace("\"", "\\\"") %>",

            treatment:
                "<%= (treatmentCode + " - " + treatmentName)
                        .replace("\"", "\\\"") %>",

            treatmentFee:
                "<%= String.format("%.2f", treatmentFee) %>",

            consultationFee:
                "<%= String.format("%.2f", consultationFee) %>",

            total:
                "<%= String.format("%.2f", totalAmount) %>",

            status:
                "<%= paymentStatus %>"
        };

    </script>


    <%
            } catch (Exception e) {

                System.out.println(
                        "Bill result error: "
                                + e.getMessage()
                );
            }
        }
    %>


</div>



<script>

// =============================================================
// FILTER APPOINTMENTS BY PATIENT
// =============================================================

function filterAppointments() {


    const patientSelect =
            document.getElementById(
                    "patientSelect"
            );


    const appointmentSelect =
            document.getElementById(
                    "appointmentSelect"
            );


    const help =
            document.getElementById(
                    "appointmentHelp"
            );


    const patientId =
            patientSelect.value;


    appointmentSelect.innerHTML =
            "";


    if (!patientId) {


        appointmentSelect.disabled =
                true;


        const option =
                document.createElement(
                        "option"
                );


        option.value = "";

        option.textContent =
                "Select Patient First";


        appointmentSelect.appendChild(
                option
        );


        help.textContent =
                "Select a patient to view "
                + "their scheduled appointments.";


        return;
    }


    // The original appointment information
    // is stored in this JavaScript array.

    const appointments = [

        <%
            try {

                if (appointmentsJson != null) {


                    JsonArray appointments =
                            JsonParser
                                    .parseString(
                                            appointmentsJson
                                    )
                                    .getAsJsonArray();


                    boolean first = true;


                    for (
                            JsonElement element
                            : appointments) {


                        JsonObject a =
                                element
                                        .getAsJsonObject();


                        String status =
                                a.has("status")
                                ? a.get("status")
                                   .getAsString()
                                : "";


                        if (!"Scheduled"
                                .equalsIgnoreCase(
                                        status
                                )) {

                            continue;
                        }


                        int id =
                                a.get("id")
                                        .getAsInt();


                        int patientId =
                                a.get("patientId")
                                        .getAsInt();


                        String number =
                                a.has("appointmentNumber")
                                ? a.get("appointmentNumber")
                                   .getAsString()
                                : "";


                        String date =
                                a.has("appointmentDate")
                                ? a.get("appointmentDate")
                                   .getAsString()
                                : "";


                        String time =
                                a.has("appointmentTime")
                                ? a.get("appointmentTime")
                                   .getAsString()
                                : "";


                        String dentist =
                                a.has("dentistName")
                                && !a.get("dentistName")
                                     .isJsonNull()
                                ? a.get("dentistName")
                                   .getAsString()
                                : "";


                        if (time.length() >= 5) {

                            time =
                                    time.substring(
                                            0,
                                            5
                                    );
                        }


                        if (!first) {
                            out.print(",");
                        }


                        first = false;
        %>


        {
            id: "<%= id %>",
            patientId: "<%= patientId %>",
            text:
                "<%= number %> | "
                + "<%= date %> "
                + "<%= time %> | "
                + "<%= dentist.replace("\"", "\\\"") %>"
        }


        <%
                    }
                }

            } catch (Exception e) {

                System.out.println(
                        "Appointment JS error: "
                                + e.getMessage()
                );
            }
        %>

    ];


    const placeholder =
            document.createElement(
                    "option"
            );


    placeholder.value = "";

    placeholder.textContent =
            "Select Appointment";


    appointmentSelect.appendChild(
            placeholder
    );


    let count = 0;


    appointments.forEach(
            function (appointment) {


                if (appointment.patientId
                        === patientId) {


                    const option =
                            document.createElement(
                                    "option"
                            );


                    option.value =
                            appointment.id;


                    option.textContent =
                            appointment.text;


                    appointmentSelect.appendChild(
                            option
                    );


                    count++;
                }
            }
    );


    appointmentSelect.disabled =
            count === 0;


    if (count === 0) {


        placeholder.textContent =
                "No Scheduled Appointments";


        help.textContent =
                "This patient has no appointment "
                + "waiting for billing.";


    } else {


        help.textContent =
                count
                + " scheduled appointment(s) "
                + "available for billing.";
    }
}



// =============================================================
// PRINT COMPLETE RECEIPT
// =============================================================

function printReceipt() {


    if (typeof receiptData
            === "undefined") {


        alert(
            "No bill is available to print."
        );


        return;
    }


    const printWindow =
            window.open(
                    "",
                    "_blank",
                    "width=850,height=900"
            );


    const html = `

        <!DOCTYPE html>

        <html>

        <head>

            <title>
                Sunrise Dental Clinic Receipt
            </title>

            <style>

                body {

                    font-family:
                        Arial,
                        sans-serif;

                    margin:
                        45px;

                    color:
                        #222;
                }


                .receipt {

                    max-width:
                        700px;

                    margin:
                        auto;
                }


                .header {

                    text-align:
                        center;

                    border-bottom:
                        2px solid #07558e;

                    padding-bottom:
                        20px;

                    margin-bottom:
                        25px;
                }


                .header h1 {

                    color:
                        #07558e;

                    margin:
                        0;
                }


                .tagline {

                    color:
                        #0795ad;

                    margin-top:
                        5px;
                }


                h2 {

                    text-align:
                        center;

                    margin:
                        25px 0;
                }


                table {

                    width:
                        100%;

                    border-collapse:
                        collapse;
                }


                td {

                    padding:
                        11px;

                    border-bottom:
                        1px solid #ddd;
                }


                td:first-child {

                    font-weight:
                        bold;

                    width:
                        42%;
                }


                .total {

                    font-size:
                        18px;

                    font-weight:
                        bold;

                    color:
                        #07558e;
                }


                .paid {

                    color:
                        #16874d;

                    font-weight:
                        bold;
                }


                .footer {

                    text-align:
                        center;

                    margin-top:
                        40px;

                    padding-top:
                        20px;

                    border-top:
                        1px solid #ddd;

                    font-size:
                        13px;
                }

            </style>

        </head>


        <body>


            <div class="receipt">


                <div class="header">

                    <h1>
                        Sunrise Dental Clinic
                    </h1>

                    <div class="tagline">
                        Your Smile, Our Care
                    </div>

                </div>


                <h2>
                    Payment Receipt
                </h2>


                <table>


                    <tr>

                        <td>Bill Number</td>

                        <td>
                            \${receiptData.billNumber}
                        </td>

                    </tr>


                    <tr>

                        <td>Patient</td>

                        <td>
                            \${receiptData.patient}
                        </td>

                    </tr>


                    <tr>

                        <td>Appointment</td>

                        <td>
                            \${receiptData.appointment}
                        </td>

                    </tr>


                    <tr>

                        <td>Appointment Date</td>

                        <td>
                            \${receiptData.appointmentDate}
                        </td>

                    </tr>


                    <tr>

                        <td>Appointment Time</td>

                        <td>
                            \${receiptData.appointmentTime}
                        </td>

                    </tr>


                    <tr>

                        <td>Dentist</td>

                        <td>
                            \${receiptData.dentist}
                        </td>

                    </tr>


                    <tr>

                        <td>Treatment</td>

                        <td>
                            \${receiptData.treatment}
                        </td>

                    </tr>


                    <tr>

                        <td>Treatment Fee</td>

                        <td>
                            LKR
                            \${receiptData.treatmentFee}
                        </td>

                    </tr>


                    <tr>

                        <td>Consultation Fee</td>

                        <td>
                            LKR
                            \${receiptData.consultationFee}
                        </td>

                    </tr>


                    <tr class="total">

                        <td>Total Amount</td>

                        <td>
                            LKR
                            \${receiptData.total}
                        </td>

                    </tr>


                    <tr>

                        <td>Payment Status</td>

                        <td class="paid">
                            \${receiptData.status}
                        </td>

                    </tr>


                </table>


                <div class="footer">

                    Thank you for choosing
                    Sunrise Dental Clinic.

                    <br><br>

                    This receipt was generated by the
                    Sunrise Dental Clinic Management System.

                </div>


            </div>


        </body>

        </html>

    `;


    printWindow.document.open();

    printWindow.document.write(
            html
    );

    printWindow.document.close();


    printWindow.onload =
            function () {

                printWindow.focus();

                printWindow.print();
            };
}


</script>


</body>

</html>