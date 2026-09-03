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
            (String) request.getAttribute("patientsJson");

    String appointmentsJson =
            (String) request.getAttribute("appointmentsJson");

    String treatmentsJson =
            (String) request.getAttribute("treatmentsJson");

    String billResult =
            (String) request.getAttribute("billResult");

    String error =
            (String) request.getAttribute("error");

    String success =
            (String) request.getAttribute("success");
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
            font-family: "Segoe UI", Arial, sans-serif;
            background-color: #f5f8fa;
            color: #263238;
        }

        .container {
            width: 92%;
            max-width: 1100px;
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
            color: #087ca7;
            text-decoration: none;
            font-weight: 600;
            margin-right: 14px;
        }

        .card {
            background: white;
            padding: 25px;
            margin-bottom: 25px;
            border-radius: 12px;
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

        label {
            font-weight: 600;
            margin-bottom: 6px;
        }

        select,
        input {
            height: 46px;
            padding: 0 12px;
            border: 1px solid #ccd7dd;
            border-radius: 7px;
            font-size: 14px;
        }

        select:focus,
        input:focus {
            outline: none;
            border-color: #13a2b3;
            box-shadow: 0 0 0 3px rgba(19,162,179,0.12);
        }

        button {
            margin-top: 20px;
            background: linear-gradient(
                    90deg,
                    #064f8c,
                    #0d95ad
            );
            color: white;
            border: none;
            padding: 12px 22px;
            border-radius: 7px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
        }

        button:hover {
            opacity: 0.92;
        }

        .error {
            background: #fff1f1;
            color: #b3261e;
            border: 1px solid #f0c7c7;
            padding: 12px;
            border-radius: 7px;
            margin-bottom: 20px;
        }

        .success {
            background: #ecfff3;
            color: #16723c;
            border: 1px solid #bfe8cc;
            padding: 12px;
            border-radius: 7px;
            margin-bottom: 20px;
        }

        .result-box {
            background: #eefafb;
            border-left: 4px solid #13a2b3;
            padding: 18px;
            border-radius: 7px;
        }

        .result-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .result-table td {
            padding: 10px;
            border-bottom: 1px solid #dce7eb;
        }

        .result-table td:first-child {
            font-weight: 600;
            width: 35%;
        }

        .total {
            font-size: 20px;
            color: #064f8c;
            font-weight: bold;
        }

        .bill-actions {
            margin-top: 20px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .bill-actions form {
            margin: 0;
        }

        .pay-button {
            background: linear-gradient(
                    90deg,
                    #138a50,
                    #19a866
            );
        }

        .print-button {
            background: linear-gradient(
                    90deg,
                    #f0a000,
                    #f5b420
            );
        }

        .status-paid {
            color: #138a50;
            font-weight: bold;
        }

        .status-pending {
            color: #d58a00;
            font-weight: bold;
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


    <%
        if (error != null) {
    %>

    <div class="error">
        <%= error %>
    </div>

    <%
        }
    %>


    <%
        if (success != null) {
    %>

    <div class="success">
        <%= success %>
    </div>

    <%
        }
    %>


    <div class="card">

        <h2>
            Create Patient Bill
        </h2>

        <form method="post"
              action="bill">

            <!-- IMPORTANT -->
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

                                if (patientsJson != null
                                        && !patientsJson.isBlank()) {

                                    JsonArray patients =
                                            JsonParser
                                                    .parseString(
                                                            patientsJson
                                                    )
                                                    .getAsJsonArray();

                                    for (JsonElement element
                                            : patients) {

                                        JsonObject p =
                                                element
                                                        .getAsJsonObject();

                                        int id =
                                                p.get("id")
                                                        .getAsInt();

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
                        %>

                        <option value="<%= id %>">

                            <%= patientNumber %>
                            -
                            <%= patientName %>

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



                <!-- APPOINTMENT -->

                <div class="form-group">

                    <label>
                        Appointment
                    </label>

                    <select name="appointmentId"
                            required>

                        <option value="">
                            Select Appointment
                        </option>

                        <%
                            try {

                                if (appointmentsJson != null
                                        && !appointmentsJson.isBlank()) {

                                    JsonArray appointments =
                                            JsonParser
                                                    .parseString(
                                                            appointmentsJson
                                                    )
                                                    .getAsJsonArray();

                                    for (JsonElement element
                                            : appointments) {

                                        JsonObject a =
                                                element
                                                        .getAsJsonObject();

                                        int id =
                                                a.get("id")
                                                        .getAsInt();

                                        String number =
                                                a.has("appointmentNumber")
                                                && !a.get("appointmentNumber")
                                                     .isJsonNull()
                                                ? a.get("appointmentNumber")
                                                   .getAsString()
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
                        %>

                        <option value="<%= id %>">

                            <%= number %>
                            -
                            <%= date %>
                            <%= time %>

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

                </div>



                <!-- TREATMENT -->

                <div class="form-group">

                    <label>
                        Treatment
                    </label>

                    <select name="treatmentId"
                            required>

                        <option value="">
                            Select Treatment
                        </option>

                        <%
                            try {

                                if (treatmentsJson != null
                                        && !treatmentsJson.isBlank()) {

                                    JsonArray treatments =
                                            JsonParser
                                                    .parseString(
                                                            treatmentsJson
                                                    )
                                                    .getAsJsonArray();

                                    for (JsonElement element
                                            : treatments) {

                                        JsonObject t =
                                                element
                                                        .getAsJsonObject();

                                        int id =
                                                t.get("id")
                                                        .getAsInt();

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
                            Rs. <%= String.format("%.2f", price) %>

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



                <!-- CONSULTATION FEE -->

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


            </div>


            <button type="submit">

                Calculate & Save Bill

            </button>

        </form>

    </div>



    <!-- BILL RESULT -->

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


                int currentBillId =
                        bill.has("id")
                        ? bill.get("id").getAsInt()
                        : 0;


                String currentStatus =
                        bill.has("paymentStatus")
                        ? bill.get("paymentStatus").getAsString()
                        : "";
    %>


    <div class="card">

        <h2>
            Bill Result
        </h2>


        <div class="result-box"
             id="printableBill">

            <table class="result-table">


                <tr>

                    <td>
                        Bill Number
                    </td>

                    <td>
                        <%= bill.has("billNumber")
                            ? bill.get("billNumber").getAsString()
                            : "" %>
                    </td>

                </tr>


                <tr>

                    <td>
                        Patient ID
                    </td>

                    <td>
                        <%= bill.has("patientId")
                            ? bill.get("patientId").getAsInt()
                            : "" %>
                    </td>

                </tr>


                <tr>

                    <td>
                        Appointment ID
                    </td>

                    <td>
                        <%= bill.has("appointmentId")
                            ? bill.get("appointmentId").getAsInt()
                            : "" %>
                    </td>

                </tr>


                <tr>

                    <td>
                        Treatment ID
                    </td>

                    <td>
                        <%= bill.has("treatmentId")
                            ? bill.get("treatmentId").getAsInt()
                            : "" %>
                    </td>

                </tr>


                <tr>

                    <td>
                        Consultation Fee
                    </td>

                    <td>

                        Rs.
                        <%= bill.has("consultationFee")
                            ? String.format(
                                    "%.2f",
                                    bill.get("consultationFee")
                                        .getAsDouble()
                              )
                            : "0.00" %>

                    </td>

                </tr>


                <tr>

                    <td>
                        Treatment Fee
                    </td>

                    <td>

                        Rs.
                        <%= bill.has("treatmentFee")
                            ? String.format(
                                    "%.2f",
                                    bill.get("treatmentFee")
                                        .getAsDouble()
                              )
                            : "0.00" %>

                    </td>

                </tr>


                <tr>

                    <td>
                        Total Amount
                    </td>

                    <td class="total">

                        Rs.
                        <%= bill.has("totalAmount")
                            ? String.format(
                                    "%.2f",
                                    bill.get("totalAmount")
                                        .getAsDouble()
                              )
                            : "0.00" %>

                    </td>

                </tr>


                <tr>

                    <td>
                        Payment Status
                    </td>

                    <td>

                        <span class="
                            <%= "Paid".equalsIgnoreCase(currentStatus)
                                ? "status-paid"
                                : "status-pending" %>
                        ">

                            <%= currentStatus %>

                        </span>

                    </td>

                </tr>


            </table>

        </div>


        <!-- PAY / PRINT BUTTONS -->

        <div class="bill-actions">


            <%
                if ("Pending".equalsIgnoreCase(
                        currentStatus)) {
            %>


            <form method="post"
                  action="bill">

                <input type="hidden"
                       name="action"
                       value="pay">

                <input type="hidden"
                       name="billId"
                       value="<%= currentBillId %>">


                <button type="submit"
                        class="pay-button">

                    Mark as Paid

                </button>

            </form>


            <%
                }
            %>


            <button type="button"
                    class="print-button"
                    onclick="printBill()">

                Print Receipt

            </button>


        </div>


    </div>


    <%
            } catch (Exception e) {

                System.out.println(
                        "Bill result JSON error: "
                                + e.getMessage()
                );
            }
        }
    %>


</div>


<script>

function printBill() {

    const printable =
            document.getElementById(
                    "printableBill"
            );

    if (!printable) {

        alert(
            "No bill is available to print."
        );

        return;
    }


    const billContent =
            printable.innerHTML;


    const printWindow =
            window.open(
                    "",
                    "",
                    "width=800,height=700"
            );


    printWindow.document.write(`

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

                    padding:
                            40px;

                    color:
                            #263238;
                }


                .receipt-header {

                    text-align:
                            center;

                    margin-bottom:
                            30px;
                }


                .receipt-header h1 {

                    color:
                            #064f8c;

                    margin-bottom:
                            5px;
                }


                .receipt-header p {

                    color:
                            #078ba5;

                    margin:
                            4px;
                }


                table {

                    width:
                            100%;

                    border-collapse:
                            collapse;

                    margin-top:
                            20px;
                }


                td {

                    padding:
                            10px;

                    border-bottom:
                            1px solid #ddd;
                }


                td:first-child {

                    font-weight:
                            bold;

                    width:
                            40%;
                }


                .footer {

                    text-align:
                            center;

                    margin-top:
                            35px;

                    padding-top:
                            20px;

                    border-top:
                            1px solid #ddd;

                    color:
                            #777;

                    font-size:
                            13px;
                }

            </style>

        </head>


        <body>


            <div class="receipt-header">

                <h1>
                    Sunrise Dental Clinic
                </h1>

                <p>
                    Your Smile, Our Care
                </p>

                <h2>
                    Payment Receipt
                </h2>

            </div>


            ${billContent}


            <div class="footer">

                Thank you for choosing
                Sunrise Dental Clinic.

            </div>


        </body>

        </html>

    `);


    printWindow.document.close();

    printWindow.focus();

    printWindow.print();
}

</script>


</body>

</html>