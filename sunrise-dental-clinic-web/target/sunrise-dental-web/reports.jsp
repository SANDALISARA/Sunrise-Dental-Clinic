<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.google.gson.*" %>

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
%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>
        Reports - Sunrise Dental Clinic
    </title>


    <style>

        body {

            font-family:
                    "Segoe UI",
                    Arial,
                    sans-serif;

            margin: 0;

            background:
                    #f4f8fb;
        }


        .container {

            width: 92%;

            max-width: 1200px;

            margin: 30px auto;
        }


        h1 {

            color: #064f8c;
        }


        .nav {

            margin-bottom: 25px;
        }


        .nav a {

            color: #087ca7;

            text-decoration: none;

            font-weight: 600;

            margin-right: 15px;
        }


        .card {

            background: white;

            padding: 25px;

            margin-bottom: 25px;

            border-radius: 12px;

            box-shadow:
                    0 3px 15px
                    rgba(0,0,0,0.07);
        }


        .report-menu {

            display: flex;

            gap: 10px;

            flex-wrap: wrap;
        }


        .report-menu a {

            text-decoration: none;

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
        }


        .report-menu a:hover {

            background:
                    #0b94aa;

            color:
                    white;
        }


        table {

            width: 100%;

            border-collapse:
                    collapse;

            margin-top:
                    20px;
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
        }


        td {

            padding:
                    12px;

            border-bottom:
                    1px solid #ddd;
        }


        tr:hover {

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


        button {

            background:
                    #064f8c;

            color:
                    white;

            border:
                    none;

            padding:
                    10px 18px;

            border-radius:
                    6px;

            cursor:
                    pointer;
        }

    </style>

</head>


<body>


<div class="container">


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



    <div class="card"
         id="reportArea">


        <h2>
            Report Result
        </h2>


        <%
            try {

                JsonArray data =
                        JsonParser
                                .parseString(json)
                                .getAsJsonArray();


                // ============================================
                // PATIENT REPORT
                // ============================================

                if ("patients".equals(type)) {
        %>


        <table>

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


            <%
                for (JsonElement el : data) {

                    JsonObject p =
                            el.getAsJsonObject();
            %>


            <tr>

                <td>
                    <%= p.has("patientNumber")
                        ? p.get("patientNumber").getAsString()
                        : "" %>
                </td>

                <td>
                    <%= p.get("patientName").getAsString() %>
                </td>

                <td>
                    <%= p.get("gender").getAsString() %>
                </td>

                <td>
                    <%= p.get("phone").getAsString() %>
                </td>

                <td>
                    <%= p.get("email").getAsString() %>
                </td>

            </tr>


            <%
                }
            %>


        </table>


        <%
            }


            // ============================================
            // TREATMENT REPORT
            // ============================================

            else if ("treatments".equals(type)) {
        %>


        <table>

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


            <%
                for (JsonElement el : data) {

                    JsonObject t =
                            el.getAsJsonObject();
            %>


            <tr>

                <td>
                    <%= t.get("treatmentCode").getAsString() %>
                </td>

                <td>
                    <%= t.get("treatmentName").getAsString() %>
                </td>

                <td>
                    <%= t.get("description").getAsString() %>
                </td>

                <td>

                    Rs.
                    <%= String.format(
                            "%.2f",
                            t.get("price").getAsDouble()
                    ) %>

                </td>

            </tr>


            <%
                }
            %>


        </table>


        <%
            }


            // ============================================
            // INCOME / BILL REPORT
            // ============================================

            else if ("income".equals(type)) {


                double totalIncome = 0;
        %>


        <table>

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


            <%
                for (JsonElement el : data) {

                    JsonObject b =
                            el.getAsJsonObject();


                    double amount =
                            b.get(
                                    "totalAmount"
                            ).getAsDouble();


                    String status =
                            b.get(
                                    "paymentStatus"
                            ).getAsString();


                    // Only PAID bills count as income
                    if ("Paid".equalsIgnoreCase(
                            status)) {

                        totalIncome +=
                                amount;
                    }
            %>


            <tr>

                <td>
                    <%= b.get("billNumber").getAsString() %>
                </td>

                <td>
                    <%= b.get("billDate").getAsString() %>
                </td>

                <td>
                    <%= b.get("patientId").getAsInt() %>
                </td>

                <td>

                    Rs.
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


        </table>


        <div class="total-card">

            Total Paid Income:
            Rs.
            <%= String.format(
                    "%.2f",
                    totalIncome
            ) %>

        </div>


        <%
            }


            // ============================================
            // APPOINTMENT REPORT
            // ============================================

            else {
        %>


        <table>

            <tr>

                <th>
                    Appointment No.
                </th>

                <th>
                    Patient ID
                </th>

                <th>
                    Dentist ID
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


            <%
                for (JsonElement el : data) {

                    JsonObject a =
                            el.getAsJsonObject();
            %>


            <tr>

                <td>
                    <%= a.get("appointmentNumber").getAsString() %>
                </td>

                <td>
                    <%= a.get("patientId").getAsInt() %>
                </td>

                <td>
                    <%= a.get("dentistId").getAsInt() %>
                </td>

                <td>
                    <%= a.get("appointmentDate").getAsString() %>
                </td>

                <td>
                    <%= a.get("appointmentTime").getAsString() %>
                </td>

                <td>
                    <%= a.get("reason").getAsString() %>
                </td>

                <td>
                    <%= a.get("status").getAsString() %>
                </td>

            </tr>


            <%
                }
            %>


        </table>


        <%
                }


            } catch (Exception e) {
        %>


        <p>
            No report data available.
        </p>


        <%
            }
        %>


    </div>



    <button onclick="window.print()">

        Print Report

    </button>


</div>


</body>

</html>