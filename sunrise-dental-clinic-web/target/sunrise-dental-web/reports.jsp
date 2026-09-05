<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.google.gson.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>


<%
    if (session.getAttribute("user") == null) {

        response.sendRedirect(
                "index.jsp"
        );

        return;
    }


    String type =
            (String) request.getAttribute(
                    "type"
            );


    String json =
            (String) request.getAttribute(
                    "json"
            );


    String reportTitle =
            "Clinic Report";


    if ("daily-appointments".equals(type)) {

        reportTitle =
                "Appointment Report";
    }

    else if ("patients".equals(type)) {

        reportTitle =
                "Patient Report";
    }

    else if ("treatments".equals(type)) {

        reportTitle =
                "Treatment Report";
    }

    else if ("income".equals(type)) {

        reportTitle =
                "Income Report";
    }

    else if ("dentist-appointments".equals(type)) {

        reportTitle =
                "Dentist Appointment Report";
    }


    String generatedDate =
            new SimpleDateFormat(
                    "yyyy-MM-dd HH:mm"
            ).format(
                    new Date()
            );
%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>
        Reports - Sunrise Dental Clinic
    </title>


    <style>

        * {
            box-sizing: border-box;
        }


        body {

            font-family:
                    "Segoe UI",
                    Arial,
                    sans-serif;

            margin:
                    0;

            background:
                    #f4f8fb;

            color:
                    #263238;
        }


        .container {

            width:
                    92%;

            max-width:
                    1200px;

            margin:
                    30px auto;
        }


        h1 {

            color:
                    #064f8c;
        }


        h2 {

            color:
                    #263238;
        }


        .nav {

            margin-bottom:
                    25px;
        }


        .nav a {

            color:
                    #087ca7;

            text-decoration:
                    none;

            font-weight:
                    600;

            margin-right:
                    15px;
        }


        .card {

            background:
                    white;

            padding:
                    25px;

            margin-bottom:
                    25px;

            border-radius:
                    12px;

            box-shadow:
                    0 3px 15px
                    rgba(0,0,0,0.07);
        }


        .report-menu {

            display:
                    flex;

            gap:
                    10px;

            flex-wrap:
                    wrap;
        }


        .report-menu a {

            text-decoration:
                    none;

            background:
                    #eaf8fa;

            color:
                    #087a91;

            padding:
                    10px 16px;

            border-radius:
                    7px;

            font-weight:
                    600;

            transition:
                    0.2s;
        }


        .report-menu a:hover {

            background:
                    #0b94aa;

            color:
                    white;
        }


        .report-title-area {

            display:
                    flex;

            justify-content:
                    space-between;

            align-items:
                    center;

            gap:
                    15px;

            border-bottom:
                    1px solid #e2e9ed;

            padding-bottom:
                    15px;

            margin-bottom:
                    20px;
        }


        .report-title-area h2 {

            margin:
                    0;

            color:
                    #064f8c;
        }


        .report-type {

            display:
                    inline-block;

            margin-top:
                    6px;

            padding:
                    5px 11px;

            background:
                    #eaf8fa;

            color:
                    #087a91;

            border-radius:
                    20px;

            font-size:
                    13px;

            font-weight:
                    600;
        }


        .table-wrapper {

            overflow-x:
                    auto;
        }


        table {

            width:
                    100%;

            border-collapse:
                    collapse;

            margin-top:
                    20px;

            background:
                    white;
        }


        th {

            background:
                    linear-gradient(
                        90deg,
                        #064f8c,
                        #078ba5
                    );

            color:
                    white;

            padding:
                    12px;

            text-align:
                    left;

            font-size:
                    14px;
        }


        td {

            padding:
                    12px;

            border-bottom:
                    1px solid #ddd;

            font-size:
                    14px;
        }


        tbody tr:hover {

            background:
                    #f4f9fb;
        }


        .total-card {

            margin-top:
                    20px;

            padding:
                    20px;

            background:
                    #eaf8fa;

            border-left:
                    5px solid #0b94aa;

            border-radius:
                    8px;

            font-size:
                    20px;

            font-weight:
                    bold;

            color:
                    #064f8c;
        }


        .empty-message {

            padding:
                    22px;

            text-align:
                    center;

            background:
                    #fff4d9;

            color:
                    #805e00;

            border-radius:
                    7px;
        }


        button {

            background:
                    linear-gradient(
                        90deg,
                        #064f8c,
                        #0d95ad
                    );

            color:
                    white;

            border:
                    none;

            padding:
                    11px 20px;

            border-radius:
                    7px;

            cursor:
                    pointer;

            font-size:
                    14px;

            font-weight:
                    600;
        }


        button:hover {

            opacity:
                    0.9;
        }


        .print-actions {

            margin-top:
                    20px;
        }


        /* ========================================= */
        /* PRINT HEADER */
        /* ========================================= */

        .print-only {

            display:
                    none;
        }


        /* ========================================= */
        /* PRINT MODE */
        /* ========================================= */

        @media print {


            @page {

                size:
                        A4 portrait;

                margin:
                        15mm;
            }


            html,
            body {

                background:
                        white !important;

                margin:
                        0;

                padding:
                        0;
            }


            body * {

                visibility:
                        hidden;
            }


            #reportArea,
            #reportArea * {

                visibility:
                        visible;
            }


            #reportArea {

                position:
                        absolute;

                left:
                        0;

                top:
                        0;

                width:
                        100%;

                max-width:
                        none;

                margin:
                        0;

                padding:
                        0;

                border:
                        none;

                box-shadow:
                        none;

                background:
                        white;
            }


            .screen-only,
            .no-print {

                display:
                        none !important;
            }


            .print-only {

                display:
                        block !important;

                visibility:
                        visible !important;
            }


            .print-header {

                text-align:
                        center;

                padding-bottom:
                        18px;

                margin-bottom:
                        25px;

                border-bottom:
                        2px solid #064f8c;
            }


            .print-header h1 {

                color:
                        #064f8c;

                font-size:
                        26px;

                margin:
                        0;
            }


            .print-header .tagline {

                color:
                        #0d95ad;

                margin-top:
                        5px;

                font-size:
                        13px;
            }


            .print-header h2 {

                color:
                        #222;

                margin:
                        20px 0 5px;

                font-size:
                        20px;
            }


            .print-header .generated {

                color:
                        #666;

                font-size:
                        12px;

                margin:
                        0;
            }


            .report-title-area {

                display:
                        none;
            }


            .table-wrapper {

                overflow:
                        visible;
            }


            table {

                width:
                        100%;

                border-collapse:
                        collapse;

                margin-top:
                        10px;

                font-size:
                        10pt;
            }


            th {

                background:
                        #064f8c !important;

                color:
                        white !important;

                border:
                        1px solid #b7c0c5;

                padding:
                        8px;

                -webkit-print-color-adjust:
                        exact;

                print-color-adjust:
                        exact;
            }


            td {

                border:
                        1px solid #c9d0d4;

                padding:
                        8px;

                font-size:
                        10pt;
            }


            tr {

                page-break-inside:
                        avoid;
            }


            .total-card {

                margin-top:
                        20px;

                border:
                        1px solid #b7c0c5;

                border-left:
                        5px solid #0b94aa;

                background:
                        #f3fbfc !important;

                -webkit-print-color-adjust:
                        exact;

                print-color-adjust:
                        exact;
            }


            .print-footer {

                display:
                        block !important;

                visibility:
                        visible !important;

                margin-top:
                        35px;

                padding-top:
                        15px;

                border-top:
                        1px solid #ccc;

                text-align:
                        center;

                font-size:
                        11px;

                color:
                        #666;
            }
        }


        @media(max-width: 750px) {

            .report-title-area {

                flex-direction:
                        column;

                align-items:
                        flex-start;
            }

        }

    </style>

</head>


<body>


<div class="container">


    <!-- ============================================= -->
    <!-- SCREEN HEADER -->
    <!-- ============================================= -->

    <div class="screen-only">


        <h1>
            Clinic Reports
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



        <!-- ========================================= -->
        <!-- REPORT MENU -->
        <!-- ========================================= -->

        <div class="card">


            <h2>
                Generate Reports
            </h2>


            <div class="report-menu">


                <a href="reports?type=daily-appointments">

                    Appointment Report

                </a>


                <a href="reports?type=patients">

                    Patient Report

                </a>


                <a href="reports?type=treatments">

                    Treatment Report

                </a>


                <a href="reports?type=income">

                    Income Report

                </a>


                <a href="reports?type=dentist-appointments">

                    Dentist Appointment Report

                </a>


            </div>


        </div>


    </div>



    <!-- ============================================= -->
    <!-- PRINTABLE REPORT AREA -->
    <!-- ============================================= -->

    <div class="card"
         id="reportArea">



        <!-- ========================================= -->
        <!-- PRINT ONLY HEADER -->
        <!-- ========================================= -->

        <div class="print-only print-header">


            <h1>
                Sunrise Dental Clinic
            </h1>


            <div class="tagline">
                Your Smile, Our Care
            </div>


            <h2>
                <%= reportTitle %>
            </h2>


            <p class="generated">

                Generated:
                <%= generatedDate %>

            </p>


        </div>



        <!-- ========================================= -->
        <!-- SCREEN REPORT HEADER -->
        <!-- ========================================= -->

        <div class="report-title-area screen-only">


            <div>

                <h2>
                    Report Result
                </h2>


                <span class="report-type">

                    <%= reportTitle %>

                </span>

            </div>


        </div>



        <%
            try {


                if (json == null
                        || json.isBlank()) {


                    throw new Exception(
                            "No report data"
                    );
                }


                JsonElement root =
                        JsonParser
                                .parseString(
                                        json
                                );


                if (!root.isJsonArray()) {


                    throw new Exception(
                            "Invalid report response"
                    );
                }


                JsonArray data =
                        root.getAsJsonArray();



                // =============================================
                // PATIENT REPORT
                // =============================================

                if ("patients".equals(type)) {
        %>


        <div class="table-wrapper">


            <table>


                <thead>

                <tr>

                    <th>
                        Patient No.
                    </th>

                    <th>
                        Patient Name
                    </th>

                    <th>
                        Gender
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
                    for (JsonElement el : data) {


                        JsonObject p =
                                el.getAsJsonObject();


                        String patientNumber =
                                p.has("patientNumber")
                                && !p.get("patientNumber")
                                     .isJsonNull()
                                ? p.get("patientNumber")
                                   .getAsString()
                                : "";


                        String patientName =
                                p.has("patientName")
                                && !p.get("patientName")
                                     .isJsonNull()
                                ? p.get("patientName")
                                   .getAsString()
                                : "";


                        String gender =
                                p.has("gender")
                                && !p.get("gender")
                                     .isJsonNull()
                                ? p.get("gender")
                                   .getAsString()
                                : "";


                        String phone =
                                p.has("phone")
                                && !p.get("phone")
                                     .isJsonNull()
                                ? p.get("phone")
                                   .getAsString()
                                : "";


                        String email =
                                p.has("email")
                                && !p.get("email")
                                     .isJsonNull()
                                ? p.get("email")
                                   .getAsString()
                                : "";
                %>


                <tr>

                    <td>
                        <%= patientNumber %>
                    </td>

                    <td>
                        <%= patientName %>
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

                </tr>


                <%
                    }
                %>


                </tbody>


            </table>


        </div>


        <%
                }



                // =============================================
                // TREATMENT REPORT
                // =============================================

                else if ("treatments".equals(type)) {
        %>


        <div class="table-wrapper">


            <table>


                <thead>

                <tr>

                    <th>
                        Code
                    </th>

                    <th>
                        Treatment
                    </th>

                    <th>
                        Description
                    </th>

                    <th>
                        Price
                    </th>

                </tr>

                </thead>


                <tbody>


                <%

                    for (JsonElement el : data) {


                        JsonObject t =
                                el.getAsJsonObject();


                        String code =
                                t.has("treatmentCode")
                                && !t.get("treatmentCode")
                                     .isJsonNull()
                                ? t.get("treatmentCode")
                                   .getAsString()
                                : "";


                        String name =
                                t.has("treatmentName")
                                && !t.get("treatmentName")
                                     .isJsonNull()
                                ? t.get("treatmentName")
                                   .getAsString()
                                : "";


                        String description =
                                t.has("description")
                                && !t.get("description")
                                     .isJsonNull()
                                ? t.get("description")
                                   .getAsString()
                                : "";


                        double price =
                                t.has("price")
                                && !t.get("price")
                                     .isJsonNull()
                                ? t.get("price")
                                   .getAsDouble()
                                : 0;
                %>


                <tr>

                    <td>
                        <%= code %>
                    </td>

                    <td>
                        <%= name %>
                    </td>

                    <td>
                        <%= description %>
                    </td>

                    <td>

                        LKR
                        <%= String.format(
                                "%.2f",
                                price
                        ) %>

                    </td>

                </tr>


                <%
                    }
                %>


                </tbody>


            </table>


        </div>


        <%
                }



                // =============================================
                // INCOME REPORT
                // =============================================

                else if ("income".equals(type)) {


                    double totalIncome =
                            0;
        %>


        <div class="table-wrapper">


            <table>


                <thead>

                <tr>

                    <th>
                        Bill Number
                    </th>

                    <th>
                        Date
                    </th>

                    <th>
                        Patient ID
                    </th>

                    <th>
                        Amount
                    </th>

                    <th>
                        Status
                    </th>

                </tr>

                </thead>


                <tbody>


                <%

                    for (JsonElement el : data) {


                        JsonObject b =
                                el.getAsJsonObject();


                        String billNumber =
                                b.has("billNumber")
                                && !b.get("billNumber")
                                     .isJsonNull()
                                ? b.get("billNumber")
                                   .getAsString()
                                : "";


                        String billDate =
                                b.has("billDate")
                                && !b.get("billDate")
                                     .isJsonNull()
                                ? b.get("billDate")
                                   .getAsString()
                                : "";


                        int patientId =
                                b.has("patientId")
                                && !b.get("patientId")
                                     .isJsonNull()
                                ? b.get("patientId")
                                   .getAsInt()
                                : 0;


                        double amount =
                                b.has("totalAmount")
                                && !b.get("totalAmount")
                                     .isJsonNull()
                                ? b.get("totalAmount")
                                   .getAsDouble()
                                : 0;


                        String status =
                                b.has("paymentStatus")
                                && !b.get("paymentStatus")
                                     .isJsonNull()
                                ? b.get("paymentStatus")
                                   .getAsString()
                                : "";


                        if ("Paid"
                                .equalsIgnoreCase(
                                        status
                                )) {


                            totalIncome +=
                                    amount;
                        }
                %>


                <tr>

                    <td>
                        <%= billNumber %>
                    </td>

                    <td>
                        <%= billDate %>
                    </td>

                    <td>
                        <%= patientId %>
                    </td>

                    <td>

                        LKR
                        <%= String.format(
                                "%.2f",
                                amount
                        ) %>

                    </td>

                    <td>
                        <%= status %>
                    </td>

                </tr>


                <%
                    }
                %>


                </tbody>


            </table>


        </div>



        <div class="total-card">

            Total Paid Income:

            LKR
            <%= String.format(
                    "%.2f",
                    totalIncome
            ) %>

        </div>


        <%
                }



                // =============================================
                // DENTIST APPOINTMENT REPORT
                // =============================================

                else if ("dentist-appointments".equals(type)) {
        %>


        <div class="table-wrapper">


            <table>


                <thead>

                <tr>

                    <th>
                        Appointment No.
                    </th>

                    <th>
                        Patient
                    </th>

                    <th>
                        Dentist
                    </th>

                    <th>
                        Date
                    </th>

                    <th>
                        Time
                    </th>

                    <th>
                        Status
                    </th>

                </tr>

                </thead>


                <tbody>


                <%

                    for (JsonElement el : data) {


                        JsonObject a =
                                el.getAsJsonObject();


                        String appointmentNumber =
                                a.has("appointmentNumber")
                                && !a.get("appointmentNumber")
                                     .isJsonNull()
                                ? a.get("appointmentNumber")
                                   .getAsString()
                                : "";


                        String patient =
                                a.has("patientName")
                                && !a.get("patientName")
                                     .isJsonNull()
                                ? a.get("patientName")
                                   .getAsString()
                                : a.has("patientId")
                                  ? "Patient ID "
                                    + a.get("patientId")
                                       .getAsInt()
                                  : "";


                        String dentist =
                                a.has("dentistName")
                                && !a.get("dentistName")
                                     .isJsonNull()
                                ? a.get("dentistName")
                                   .getAsString()
                                : a.has("dentistId")
                                  ? "Dentist ID "
                                    + a.get("dentistId")
                                       .getAsInt()
                                  : "";


                        String date =
                                a.has("appointmentDate")
                                && !a.get("appointmentDate")
                                     .isJsonNull()
                                ? a.get("appointmentDate")
                                   .getAsString()
                                : "";


                        String time =
                                a.has("appointmentTime")
                                && !a.get("appointmentTime")
                                     .isJsonNull()
                                ? a.get("appointmentTime")
                                   .getAsString()
                                : "";


                        if (time.length() >= 5) {

                            time =
                                    time.substring(
                                            0,
                                            5
                                    );
                        }


                        String status =
                                a.has("status")
                                && !a.get("status")
                                     .isJsonNull()
                                ? a.get("status")
                                   .getAsString()
                                : "";
                %>


                <tr>

                    <td>
                        <%= appointmentNumber %>
                    </td>

                    <td>
                        <%= patient %>
                    </td>

                    <td>
                        <%= dentist %>
                    </td>

                    <td>
                        <%= date %>
                    </td>

                    <td>
                        <%= time %>
                    </td>

                    <td>
                        <%= status %>
                    </td>

                </tr>


                <%
                    }
                %>


                </tbody>


            </table>


        </div>


        <%
                }



                // =============================================
                // APPOINTMENT REPORT
                // =============================================

                else {
        %>


        <div class="table-wrapper">


            <table>


                <thead>

                <tr>

                    <th>
                        Appointment No.
                    </th>

                    <th>
                        Patient
                    </th>

                    <th>
                        Dentist
                    </th>

                    <th>
                        Date
                    </th>

                    <th>
                        Time
                    </th>

                    <th>
                        Reason
                    </th>

                    <th>
                        Status
                    </th>

                </tr>

                </thead>


                <tbody>


                <%

                    for (JsonElement el : data) {


                        JsonObject a =
                                el.getAsJsonObject();


                        String appointmentNumber =
                                a.has("appointmentNumber")
                                && !a.get("appointmentNumber")
                                     .isJsonNull()
                                ? a.get("appointmentNumber")
                                   .getAsString()
                                : "";


                        String patient =
                                a.has("patientName")
                                && !a.get("patientName")
                                     .isJsonNull()
                                ? a.get("patientName")
                                   .getAsString()
                                : a.has("patientId")
                                  ? "Patient ID "
                                    + a.get("patientId")
                                       .getAsInt()
                                  : "";


                        String dentist =
                                a.has("dentistName")
                                && !a.get("dentistName")
                                     .isJsonNull()
                                ? a.get("dentistName")
                                   .getAsString()
                                : a.has("dentistId")
                                  ? "Dentist ID "
                                    + a.get("dentistId")
                                       .getAsInt()
                                  : "";


                        String date =
                                a.has("appointmentDate")
                                && !a.get("appointmentDate")
                                     .isJsonNull()
                                ? a.get("appointmentDate")
                                   .getAsString()
                                : "";


                        String time =
                                a.has("appointmentTime")
                                && !a.get("appointmentTime")
                                     .isJsonNull()
                                ? a.get("appointmentTime")
                                   .getAsString()
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
                                && !a.get("reason")
                                     .isJsonNull()
                                ? a.get("reason")
                                   .getAsString()
                                : "";


                        String status =
                                a.has("status")
                                && !a.get("status")
                                     .isJsonNull()
                                ? a.get("status")
                                   .getAsString()
                                : "";
                %>


                <tr>

                    <td>
                        <%= appointmentNumber %>
                    </td>

                    <td>
                        <%= patient %>
                    </td>

                    <td>
                        <%= dentist %>
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
                        <%= status %>
                    </td>

                </tr>


                <%
                    }
                %>


                </tbody>


            </table>


        </div>


        <%
                }


            } catch (Exception e) {
        %>


        <div class="empty-message">

            No report data available.

        </div>


        <%

                System.out.println(
                        "Report rendering error: "
                                + e.getMessage()
                );
            }
        %>



        <!-- ========================================= -->
        <!-- PRINT FOOTER -->
        <!-- ========================================= -->

        <div class="print-only print-footer">

            Sunrise Dental Clinic Management System

            <br>

            Your Smile, Our Care

        </div>



        <!-- ========================================= -->
        <!-- PRINT BUTTON - SCREEN ONLY -->
        <!-- ========================================= -->

        <div class="print-actions no-print">


            <button type="button"
                    onclick="printReport()">

                Print Report

            </button>


        </div>


    </div>


</div>



<script>

function printReport() {


    const reportArea =
            document.getElementById(
                    "reportArea"
            );


    if (!reportArea) {


        alert(
                "Please generate a report before printing."
        );


        return;
    }


    window.print();
}

</script>


</body>

</html>