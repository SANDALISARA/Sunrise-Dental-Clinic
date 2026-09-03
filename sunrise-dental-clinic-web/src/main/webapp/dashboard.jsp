<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // ============================================
    // CHECK LOGIN SESSION
    // ============================================

    if (session.getAttribute("user") == null) {

        response.sendRedirect("index.jsp");
        return;
    }

    String username =
            (String) session.getAttribute("user");

    String role =
            (String) session.getAttribute("role");

    if (role == null) {

        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Dashboard - Sunrise Dental Clinic
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

            background: #f4f8fb;

            color: #263238;
        }


        /* ========================================
           TOP HEADER
        ======================================== */

        .topbar {

            height: 75px;

            background:
                linear-gradient(
                    90deg,
                    #064f8c,
                    #078ba5
                );

            color: white;

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 35px;

            box-shadow:
                0 2px 10px
                rgba(0,0,0,0.12);
        }


        .brand {

            display: flex;

            align-items: center;

            gap: 14px;
        }


        .brand img {

            width: 52px;

            height: 52px;

            object-fit: contain;

            background: white;

            border-radius: 10px;

            padding: 4px;
        }


        .brand-text h2 {

            margin: 0;

            font-size: 20px;
        }


        .brand-text span {

            font-size: 11px;

            letter-spacing: 2px;

            color: #d8f6f8;
        }


        .user-area {

            display: flex;

            align-items: center;

            gap: 18px;
        }


        .user-info {

            text-align: right;
        }


        .user-info strong {

            display: block;

            font-size: 14px;
        }


        .user-info span {

            font-size: 12px;

            color: #d8f6f8;
        }


        .logout-btn {

            text-decoration: none;

            background: #ffffff;

            color: #075d8e;

            padding: 9px 16px;

            border-radius: 7px;

            font-size: 13px;

            font-weight: 600;

            transition: 0.2s;
        }


        .logout-btn:hover {

            background: #f6a700;

            color: white;
        }



        /* ========================================
           MAIN CONTENT
        ======================================== */

        .container {

            width: 92%;

            max-width: 1200px;

            margin: 35px auto;
        }


        .welcome-card {

            background: white;

            border-radius: 14px;

            padding: 30px;

            margin-bottom: 30px;

            box-shadow:
                0 3px 15px
                rgba(30,80,110,0.08);

            border-left:
                5px solid #f6a700;
        }


        .welcome-card h1 {

            margin: 0 0 7px;

            color: #064f8c;

            font-size: 28px;
        }


        .welcome-card p {

            margin: 5px 0;

            color: #66757d;
        }


        .role-badge {

            display: inline-block;

            margin-top: 12px;

            padding: 6px 14px;

            border-radius: 20px;

            background: #e8f8fa;

            color: #07899e;

            font-size: 12px;

            font-weight: 700;
        }



        /* ========================================
           SECTION TITLE
        ======================================== */

        .section-title {

            margin-bottom: 18px;
        }


        .section-title h2 {

            margin: 0;

            color: #263238;

            font-size: 21px;
        }


        .section-title p {

            margin-top: 5px;

            color: #7c8a91;

            font-size: 14px;
        }



        /* ========================================
           DASHBOARD CARDS
        ======================================== */

        .dashboard-grid {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 22px;
        }


        .dashboard-card {

            background: white;

            border-radius: 12px;

            padding: 25px;

            text-decoration: none;

            color: #263238;

            box-shadow:
                0 3px 15px
                rgba(30,80,110,0.08);

            border-top:
                4px solid #0796aa;

            transition: 0.25s;

            min-height: 175px;
        }


        .dashboard-card:hover {

            transform:
                translateY(-5px);

            box-shadow:
                0 10px 25px
                rgba(30,80,110,0.15);
        }


        .dashboard-card .icon {

            width: 48px;

            height: 48px;

            border-radius: 10px;

            background: #eaf8fa;

            color: #07899e;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 24px;

            margin-bottom: 15px;
        }


        .dashboard-card h3 {

            margin:
                0 0 8px;

            color: #075b8d;

            font-size: 18px;
        }


        .dashboard-card p {

            margin: 0;

            color: #718087;

            line-height: 1.5;

            font-size: 13px;
        }


        .orange {

            border-top-color: #f6a700;
        }


        .orange .icon {

            background: #fff5db;

            color: #e99c00;
        }



        /* ========================================
           ROLE MESSAGE
        ======================================== */

        .role-information {

            margin-top: 30px;

            background:
                linear-gradient(
                    90deg,
                    #edf9fb,
                    #f8fcfd
                );

            border-radius: 10px;

            padding: 20px;

            border-left:
                4px solid #0796aa;
        }


        .role-information h3 {

            margin:
                0 0 8px;

            color: #075b8d;
        }


        .role-information p {

            margin: 0;

            color: #607078;

            line-height: 1.6;

            font-size: 14px;
        }



        /* ========================================
           FOOTER
        ======================================== */

        footer {

            text-align: center;

            margin-top: 45px;

            padding: 25px;

            color: #8b979d;

            font-size: 12px;
        }



        /* ========================================
           RESPONSIVE
        ======================================== */

        @media(max-width: 900px) {

            .dashboard-grid {

                grid-template-columns:
                    repeat(2, 1fr);
            }
        }


        @media(max-width: 650px) {

            .topbar {

                height: auto;

                padding: 15px;

                flex-direction: column;

                gap: 12px;
            }


            .user-area {

                width: 100%;

                justify-content: space-between;
            }


            .dashboard-grid {

                grid-template-columns: 1fr;
            }


            .container {

                width: 94%;
            }
        }

    </style>

</head>


<body>


<!-- ==============================================
     HEADER
================================================ -->

<header class="topbar">


    <div class="brand">

        <img src="images/sunrise-logo.png"
             alt="Sunrise Dental Clinic Logo">


        <div class="brand-text">

            <h2>
                Sunrise Dental Clinic
            </h2>

            <span>
                YOUR SMILE, OUR CARE
            </span>

        </div>

    </div>



    <div class="user-area">


        <div class="user-info">

            <strong>
                <%= username %>
            </strong>

            <span>
                <%= role %>
            </span>

        </div>


        <a class="logout-btn"
           href="logout">

            Logout

        </a>

    </div>


</header>



<!-- ==============================================
     MAIN
================================================ -->

<div class="container">


    <!-- WELCOME -->

    <div class="welcome-card">

        <h1>

            Welcome,

            <%
                if ("Administrator".equals(role)) {
            %>

                Administrator

            <%
                } else if ("Receptionist".equals(role)) {
            %>

                Receptionist

            <%
                } else if ("Dentist".equals(role)) {
            %>

                Doctor

            <%
                }
            %>

        </h1>


        <p>
            Sunrise Dental Clinic Management System
        </p>


        <span class="role-badge">
            <%= role %> Dashboard
        </span>

    </div>



    <!-- =====================================================
         ADMINISTRATOR DASHBOARD
    ====================================================== -->

    <%
        if ("Administrator".equals(role)) {
    %>


    <div class="section-title">

        <h2>
            Administration
        </h2>

        <p>
            Manage clinic information and monitor
            overall system activities.
        </p>

    </div>


    <div class="dashboard-grid">


        <a href="patients"
           class="dashboard-card">

            <div class="icon">
                👤
            </div>

            <h3>
                Patient Management
            </h3>

            <p>
                View and manage registered
                patient information.
            </p>

        </a>



        <a href="dentists"
           class="dashboard-card">

            <div class="icon">
                🦷
            </div>

            <h3>
                Dentist Management
            </h3>

            <p>
                Add and manage dentists and
                their professional information.
            </p>

        </a>



        <a href="treatments"
           class="dashboard-card">

            <div class="icon">
                ✚
            </div>

            <h3>
                Treatment Management
            </h3>

            <p>
                Maintain dental treatments,
                descriptions and prices.
            </p>

        </a>



        <a href="appointments"
           class="dashboard-card orange">

            <div class="icon">
                📅
            </div>

            <h3>
                Appointments
            </h3>

            <p>
                View scheduled appointments
                across the dental clinic.
            </p>

        </a>



        <a href="reports"
           class="dashboard-card">

            <div class="icon">
                📊
            </div>

            <h3>
                Reports
            </h3>

            <p>
                Review clinic reports,
                appointments and billing information.
            </p>

        </a>



        <a href="help"
           class="dashboard-card">

            <div class="icon">
                ?
            </div>

            <h3>
                Help
            </h3>

            <p>
                View instructions for using
                the clinic management system.
            </p>

        </a>


    </div>


    <div class="role-information">

        <h3>
            Administrator Responsibilities
        </h3>

        <p>
            Administrators are responsible for managing
            dentists, treatments, patient information,
            appointments and clinic reports.
        </p>

    </div>


    <%
        }
    %>



    <!-- =====================================================
         RECEPTIONIST DASHBOARD
    ====================================================== -->

    <%
        if ("Receptionist".equals(role)) {
    %>


    <div class="section-title">

        <h2>
            Reception Desk
        </h2>

        <p>
            Manage patients, appointments and
            patient billing.
        </p>

    </div>


    <div class="dashboard-grid">


        <a href="patients"
           class="dashboard-card">

            <div class="icon">
                👤
            </div>

            <h3>
                Patient Registration
            </h3>

            <p>
                Register new patients and
                view existing patient records.
            </p>

        </a>



        <a href="appointments"
           class="dashboard-card orange">

            <div class="icon">
                📅
            </div>

            <h3>
                Schedule Appointment
            </h3>

            <p>
                Create and manage patient
                appointments with dentists.
            </p>

        </a>



        <a href="bill"
           class="dashboard-card">

            <div class="icon">
                ₨
            </div>

            <h3>
                Patient Billing
            </h3>

            <p>
                Calculate consultation and
                treatment charges for patients.
            </p>

        </a>



        <a href="treatments"
           class="dashboard-card">

            <div class="icon">
                ✚
            </div>

            <h3>
                Treatment Prices
            </h3>

            <p>
                View available dental treatments
                and predetermined prices.
            </p>

        </a>



        <a href="help"
           class="dashboard-card">

            <div class="icon">
                ?
            </div>

            <h3>
                Help
            </h3>

            <p>
                View guidance for operating
                the reception functions.
            </p>

        </a>


    </div>


    <div class="role-information">

        <h3>
            Receptionist Responsibilities
        </h3>

        <p>
            Reception staff can register patients,
            schedule appointments, manage appointment
            information and create patient bills.
        </p>

    </div>


    <%
        }
    %>



    <!-- =====================================================
         DENTIST DASHBOARD
    ====================================================== -->

    <%
        if ("Dentist".equals(role)) {
    %>


    <div class="section-title">

        <h2>
            Dentist Workspace
        </h2>

        <p>
            Access patient records, appointments
            and dental treatment information.
        </p>

    </div>


    <div class="dashboard-grid">


        <a href="appointments"
           class="dashboard-card orange">

            <div class="icon">
                📅
            </div>

            <h3>
                Daily Appointments
            </h3>

            <p>
                View scheduled patient appointments
                and appointment details.
            </p>

        </a>



        <a href="patients"
           class="dashboard-card">

            <div class="icon">
                👤
            </div>

            <h3>
                Patient Records
            </h3>

            <p>
                Review registered patient details
                and medical information.
            </p>

        </a>



        <a href="treatments"
           class="dashboard-card">

            <div class="icon">
                🦷
            </div>

            <h3>
                Dental Treatments
            </h3>

            <p>
                View treatment information
                and treatment prices.
            </p>

        </a>



        <a href="help"
           class="dashboard-card">

            <div class="icon">
                ?
            </div>

            <h3>
                Help
            </h3>

            <p>
                Access instructions for using
                dentist functions.
            </p>

        </a>


    </div>


    <div class="role-information">

        <h3>
            Dentist Responsibilities
        </h3>

        <p>
            Dentists can review their appointments,
            access patient information and view
            available treatments required for
            patient care.
        </p>

    </div>


    <%
        }
    %>


    <footer>

        © 2026 Sunrise Dental Clinic Management System
        &nbsp; | &nbsp;
        Your Smile, Our Care

    </footer>


</div>


</body>

</html>