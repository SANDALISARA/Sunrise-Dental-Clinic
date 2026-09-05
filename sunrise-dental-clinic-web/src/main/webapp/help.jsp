<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String role = (String) session.getAttribute("role");

    if (role == null) {
        role = "Staff";
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Help & User Guide - Sunrise Dental Clinic</title>

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

        /* ==============================
           HEADER
           ============================== */

        .header {
            background: linear-gradient(
                    135deg,
                    #064f8c,
                    #0794ad
            );
            color: white;
            padding: 28px 0;
        }

        .header-content {
            width: 92%;
            max-width: 1100px;
            margin: auto;
        }

        .header h1 {
            margin: 0;
            font-size: 30px;
        }

        .header p {
            margin: 6px 0 0;
            opacity: 0.9;
        }

        /* ==============================
           NAVIGATION
           ============================== */

        .nav-container {
            background: white;
            border-bottom: 1px solid #dce5ea;
        }

        nav {
            width: 92%;
            max-width: 1100px;
            margin: auto;
            padding: 15px 0;
        }

        nav a {
            color: #087ca7;
            text-decoration: none;
            font-weight: 600;
            margin-right: 20px;
        }

        nav a:hover {
            color: #064f8c;
        }

        /* ==============================
           MAIN CONTENT
           ============================== */

        .container {
            width: 92%;
            max-width: 1100px;
            margin: 30px auto 50px;
        }

        .welcome-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.07);
            margin-bottom: 25px;
            border-left: 5px solid #f5a400;
        }

        .welcome-card h2 {
            color: #064f8c;
            margin-top: 0;
        }

        .role-badge {
            display: inline-block;
            background: #e8f7fa;
            color: #087c96;
            padding: 5px 12px;
            border-radius: 20px;
            font-weight: 600;
        }

        /* ==============================
           GUIDE CARDS
           ============================== */

        .guide-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .guide-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.06);
            border-top: 4px solid #0b91a8;
        }

        .guide-card h2 {
            color: #064f8c;
            margin-top: 0;
            font-size: 21px;
        }

        .number {
            display: inline-flex;
            width: 34px;
            height: 34px;
            align-items: center;
            justify-content: center;
            background: linear-gradient(
                    135deg,
                    #064f8c,
                    #0ba0b5
            );
            color: white;
            border-radius: 50%;
            margin-right: 8px;
            font-size: 15px;
        }

        ul,
        ol {
            line-height: 1.8;
            padding-left: 22px;
        }

        li {
            margin-bottom: 5px;
        }

        .info-box {
            background: #edf9fb;
            border-left: 4px solid #0b9db2;
            padding: 12px 15px;
            border-radius: 5px;
            margin-top: 15px;
            font-size: 14px;
        }

        /* ==============================
           ROLE SECTION
           ============================== */

        .role-section {
            background: white;
            padding: 25px;
            margin-top: 20px;
            border-radius: 12px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.06);
        }

        .role-section h2 {
            color: #064f8c;
            margin-top: 0;
        }

        .role-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin-top: 20px;
        }

        .role-card {
            background: #f6fafc;
            padding: 20px;
            border-radius: 9px;
            border: 1px solid #dce8ed;
        }

        .role-card h3 {
            color: #078ca4;
            margin-top: 0;
        }

        /* ==============================
           FAQ
           ============================== */

        .faq-section {
            background: white;
            padding: 25px;
            margin-top: 20px;
            border-radius: 12px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.06);
        }

        .faq-section h2 {
            color: #064f8c;
        }

        details {
            border-bottom: 1px solid #e1e7ea;
            padding: 14px 0;
        }

        summary {
            cursor: pointer;
            font-weight: 600;
            color: #075b8c;
        }

        details p {
            color: #555;
            line-height: 1.6;
        }

        /* ==============================
           BUTTONS
           ============================== */

        .actions {
            margin-top: 25px;
        }

        .print-button {
            background: linear-gradient(
                    90deg,
                    #064f8c,
                    #0c9db1
            );
            color: white;
            border: none;
            padding: 12px 22px;
            border-radius: 7px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
        }

        .print-button:hover {
            opacity: 0.92;
        }

        /* ==============================
           FOOTER
           ============================== */

        footer {
            text-align: center;
            color: #718087;
            padding: 25px;
            font-size: 14px;
        }

        /* ==============================
           RESPONSIVE
           ============================== */

        @media(max-width: 800px) {

            .guide-grid,
            .role-grid {
                grid-template-columns: 1fr;
            }

            nav a {
                display: inline-block;
                margin-bottom: 8px;
            }
        }

        /* ==============================
           PRINT
           ============================== */

        @media print {

            .no-print {
                display: none !important;
            }

            body {
                background: white;
            }

            .guide-card,
            .welcome-card,
            .role-section,
            .faq-section {
                box-shadow: none;
                border: 1px solid #ddd;
            }
        }

    </style>

</head>


<body>


<!-- ==============================
     HEADER
     ============================== -->

<header class="header">

    <div class="header-content">

        <h1>
            Sunrise Dental Clinic
        </h1>

        <p>
            Help & User Guide
        </p>

    </div>

</header>


<!-- ==============================
     NAVIGATION
     ============================== -->

<div class="nav-container no-print">

    <nav>

        <a href="dashboard.jsp">
            Dashboard
        </a>

        <a href="patients">
            Patients
        </a>

        <a href="appointments">
            Appointments
        </a>

        <a href="dentists">
            Dentists
        </a>

        <a href="treatments">
            Treatments
        </a>

        <a href="bill">
            Billing
        </a>

        <a href="reports">
            Reports
        </a>

        <a href="logout">
            Logout
        </a>

    </nav>

</div>


<main class="container">


    <!-- ==============================
         INTRODUCTION
         ============================== -->

    <section class="welcome-card">

        <h2>
            Welcome to the User Guide
        </h2>

        <p>
            This guide provides instructions for using the
            Sunrise Dental Clinic Management System.
            It explains the main functions available to
            authorized clinic staff.
        </p>

        <p>
            Logged in as:
            <strong>
                <%= session.getAttribute("user") %>
            </strong>

            &nbsp;

            <span class="role-badge">
                <%= role %>
            </span>
        </p>

    </section>



    <div class="guide-grid">


        <!-- ==============================
             LOGIN
             ============================== -->

        <section class="guide-card">

            <h2>
                <span class="number">1</span>
                Login
            </h2>

            <ol>

                <li>
                    Open the Sunrise Dental Clinic
                    Management System.
                </li>

                <li>
                    Select your authorized staff account.
                </li>

                <li>
                    Enter the correct password.
                </li>

                <li>
                    Click <strong>Login</strong>.
                </li>

                <li>
                    The system will display the dashboard
                    according to your user role.
                </li>

            </ol>

            <div class="info-box">
                Only authorized Administrators,
                Receptionists and Dentists can access
                the clinic system.
            </div>

        </section>



        <!-- ==============================
             PATIENTS
             ============================== -->

        <section class="guide-card">

            <h2>
                <span class="number">2</span>
                Patient Management
            </h2>

            <ol>

                <li>
                    Select <strong>Patients</strong>
                    from the menu.
                </li>

                <li>
                    Enter the patient's name,
                    date of birth and gender.
                </li>

                <li>
                    Enter the patient's address,
                    telephone number and email.
                </li>

                <li>
                    Add relevant medical history.
                </li>

                <li>
                    Click
                    <strong>Register Patient</strong>.
                </li>

            </ol>

            <div class="info-box">
                Always check the patient's information
                before saving the record.
            </div>

        </section>



        <!-- ==============================
             APPOINTMENTS
             ============================== -->

        <section class="guide-card">

            <h2>
                <span class="number">3</span>
                Appointment Management
            </h2>

            <ol>

                <li>
                    Open the
                    <strong>Appointments</strong>
                    section.
                </li>

                <li>
                    Select the required patient.
                </li>

                <li>
                    Select the appropriate dentist.
                </li>

                <li>
                    Choose the appointment date
                    and time.
                </li>

                <li>
                    Enter the reason for the visit.
                </li>

                <li>
                    Click
                    <strong>Schedule Appointment</strong>.
                </li>

            </ol>

            <div class="info-box">
                Each appointment receives a unique
                appointment number for identification
                and retrieval.
            </div>

        </section>



        <!-- ==============================
             DENTISTS
             ============================== -->

        <section class="guide-card">

            <h2>
                <span class="number">4</span>
                Dentist Management
            </h2>

            <ul>

                <li>
                    Authorized users can view dentist
                    information.
                </li>

                <li>
                    Administrators can add and manage
                    dentist details.
                </li>

                <li>
                    Each dentist can have multiple
                    appointments at different times.
                </li>

                <li>
                    Each appointment is assigned to
                    one dentist.
                </li>

            </ul>

        </section>



        <!-- ==============================
             TREATMENTS
             ============================== -->

        <section class="guide-card">

            <h2>
                <span class="number">5</span>
                Treatment Management
            </h2>

            <ol>

                <li>
                    Open the
                    <strong>Treatments</strong>
                    section.
                </li>

                <li>
                    Enter the treatment name.
                </li>

                <li>
                    Enter a description of the
                    treatment.
                </li>

                <li>
                    Enter the predetermined treatment
                    price.
                </li>

                <li>
                    Click
                    <strong>Add Treatment</strong>.
                </li>

            </ol>

            <div class="info-box">
                Treatment prices are used automatically
                during the billing process.
            </div>

        </section>



        <!-- ==============================
             BILLING
             ============================== -->

        <section class="guide-card">

            <h2>
                <span class="number">6</span>
                Billing & Payment
            </h2>

            <ol>

                <li>
                    Open the
                    <strong>Billing</strong>
                    section.
                </li>

                <li>
                    Select the patient.
                </li>

                <li>
                    Select the relevant appointment.
                </li>

                <li>
                    Select the dental treatment.
                </li>

                <li>
                    Enter the consultation fee.
                </li>

                <li>
                    Click
                    <strong>Calculate & Save Bill</strong>.
                </li>

                <li>
                    Check the calculated total.
                </li>

                <li>
                    After receiving payment, select
                    <strong>Mark as Paid</strong>.
                </li>

                <li>
                    Click
                    <strong>Print Receipt</strong>
                    to print the patient's receipt.
                </li>

            </ol>

            <div class="info-box">
                The total bill is calculated using
                the treatment fee and consultation fee.
            </div>

        </section>



        <!-- ==============================
             REPORTS
             ============================== -->

        <section class="guide-card">

            <h2>
                <span class="number">7</span>
                Clinic Reports
            </h2>

            <p>
                The Reports section provides useful
                information about clinic activities.
            </p>

            <ul>

                <li>
                    Daily Appointment Report
                </li>

                <li>
                    Patient Summary
                </li>

                <li>
                    Treatment Summary
                </li>

                <li>
                    Daily Income Report
                </li>

                <li>
                    Dentist Appointment Report
                </li>

            </ul>

            <div class="info-box">
                Select the required report from the
                Reports page to view the relevant
                clinic information.
            </div>

        </section>



        <!-- ==============================
             LOGOUT
             ============================== -->

        <section class="guide-card">

            <h2>
                <span class="number">8</span>
                Logout
            </h2>

            <ol>

                <li>
                    Complete your current work.
                </li>

                <li>
                    Click
                    <strong>Logout</strong>
                    from the navigation menu.
                </li>

                <li>
                    The system will return to the
                    login page.
                </li>

            </ol>

            <div class="info-box">
                Always log out after using the system,
                especially when using a shared clinic
                computer.
            </div>

        </section>


    </div>



    <!-- ==============================
         USER ROLES
         ============================== -->

    <section class="role-section">

        <h2>
            User Roles & Responsibilities
        </h2>

        <div class="role-grid">


            <div class="role-card">

                <h3>
                    Administrator
                </h3>

                <p>
                    Responsible for overall system
                    administration and clinic management.
                </p>

                <ul>
                    <li>Manage users</li>
                    <li>Manage dentists</li>
                    <li>Manage treatments</li>
                    <li>View reports</li>
                    <li>Monitor clinic information</li>
                </ul>

            </div>


            <div class="role-card">

                <h3>
                    Receptionist
                </h3>

                <p>
                    Responsible for day-to-day patient
                    and appointment activities.
                </p>

                <ul>
                    <li>Register patients</li>
                    <li>Search patient records</li>
                    <li>Schedule appointments</li>
                    <li>Manage billing</li>
                    <li>Print receipts</li>
                </ul>

            </div>


            <div class="role-card">

                <h3>
                    Dentist
                </h3>

                <p>
                    Responsible for accessing information
                    required for patient treatment.
                </p>

                <ul>
                    <li>View appointments</li>
                    <li>View patient information</li>
                    <li>View patient history</li>
                    <li>Review treatment information</li>
                </ul>

            </div>


        </div>

    </section>



    <!-- ==============================
         FAQ
         ============================== -->

    <section class="faq-section">

        <h2>
            Frequently Asked Questions
        </h2>


        <details>

            <summary>
                I cannot log in. What should I do?
            </summary>

            <p>
                Check that you selected the correct staff
                account and entered the correct password.
                If access is still unavailable, contact
                the system administrator.
            </p>

        </details>


        <details>

            <summary>
                How do I find a patient's appointment?
            </summary>

            <p>
                Open the Appointments section and locate
                the appointment using the patient's
                information or unique appointment number.
            </p>

        </details>


        <details>

            <summary>
                Why is a new bill marked as Pending?
            </summary>

            <p>
                A newly created bill remains Pending until
                payment has been received. After receiving
                payment, use the Mark as Paid option.
            </p>

        </details>


        <details>

            <summary>
                How do I print a receipt?
            </summary>

            <p>
                After creating the bill, use the
                Print Receipt button in the Billing
                section.
            </p>

        </details>


        <details>

            <summary>
                What should I do if I enter incorrect information?
            </summary>

            <p>
                Review information carefully before saving.
                If incorrect information has already been
                saved, use the available update function or
                contact an authorized administrator.
            </p>

        </details>


    </section>



    <!-- PRINT GUIDE -->

    <div class="actions no-print">

        <button class="print-button"
                onclick="window.print()">

            Print User Guide

        </button>

    </div>


</main>


<footer>

    Sunrise Dental Clinic Management System
    <br>
    Your Smile, Our Care

</footer>


</body>

</html>