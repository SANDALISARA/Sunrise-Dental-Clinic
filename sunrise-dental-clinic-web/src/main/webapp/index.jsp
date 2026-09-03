<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Staff Login - Sunrise Dental Clinic
    </title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {

            margin: 0;

            min-height: 100vh;

            font-family:
                    "Segoe UI",
                    Arial,
                    sans-serif;

            background:
                linear-gradient(
                    135deg,
                    #f4fbfd,
                    #eef6fb
                );

            display: flex;

            align-items: center;

            justify-content: center;
        }


        .login-wrapper {

            width: 95%;

            max-width: 1000px;

            min-height: 600px;

            background: #ffffff;

            border-radius: 20px;

            overflow: hidden;

            display: grid;

            grid-template-columns:
                    1.1fr 0.9fr;

            box-shadow:
                0 20px 60px
                rgba(13, 76, 121, 0.15);
        }


        /* =========================================
           LEFT SIDE
        ========================================= */

        .brand-section {

            background:
                linear-gradient(
                    145deg,
                    #064f8c,
                    #087ca7,
                    #14a8b5
                );

            color: white;

            padding: 55px;

            display: flex;

            flex-direction: column;

            align-items: center;

            justify-content: center;

            text-align: center;

            position: relative;
        }


        .brand-section::before {

            content: "";

            position: absolute;

            width: 300px;

            height: 300px;

            border-radius: 50%;

            background:
                rgba(255,255,255,0.06);

            top: -120px;

            left: -100px;
        }


        .brand-section::after {

            content: "";

            position: absolute;

            width: 250px;

            height: 250px;

            border-radius: 50%;

            background:
                rgba(255,255,255,0.05);

            bottom: -100px;

            right: -80px;
        }


        .logo-box {

            width: 240px;

            height: 240px;

            background: #ffffff;

            border-radius: 20px;

            display: flex;

            align-items: center;

            justify-content: center;

            padding: 15px;

            margin-bottom: 25px;

            position: relative;

            z-index: 2;

            box-shadow:
                0 12px 30px
                rgba(0,0,0,0.14);
        }


        .logo-box img {

            width: 100%;

            height: 100%;

            object-fit: contain;
        }


        .brand-section h1 {

            margin: 0;

            font-size: 32px;

            letter-spacing: 1px;

            position: relative;

            z-index: 2;
        }


        .brand-section .tagline {

            margin-top: 10px;

            font-size: 15px;

            letter-spacing: 2px;

            color: #d8f4f7;

            position: relative;

            z-index: 2;
        }


        .brand-section .description {

            max-width: 400px;

            margin-top: 25px;

            line-height: 1.7;

            color: #e8f7fa;

            font-size: 14px;

            position: relative;

            z-index: 2;
        }



        /* =========================================
           LOGIN SIDE
        ========================================= */

        .login-section {

            padding: 55px;

            display: flex;

            flex-direction: column;

            justify-content: center;
        }


        .small-title {

            color: #f5a400;

            text-transform: uppercase;

            letter-spacing: 2px;

            font-size: 13px;

            font-weight: 700;

            margin-bottom: 8px;
        }


        .login-section h2 {

            margin: 0;

            color: #064f8c;

            font-size: 30px;
        }


        .welcome-text {

            margin-top: 10px;

            margin-bottom: 30px;

            color: #6a7680;

            line-height: 1.6;
        }


        .form-group {

            margin-bottom: 20px;
        }


        .form-group label {

            display: block;

            margin-bottom: 7px;

            color: #263238;

            font-size: 14px;

            font-weight: 600;
        }


        .form-control {

            width: 100%;

            height: 48px;

            border:
                1px solid #d8e1e6;

            border-radius: 9px;

            padding: 0 14px;

            font-size: 14px;

            outline: none;

            background: #fbfdfe;

            transition: 0.3s;
        }


        .form-control:focus {

            border-color: #159eae;

            box-shadow:
                0 0 0 3px
                rgba(21, 158, 174, 0.12);

            background: #ffffff;
        }


        select.form-control {

            cursor: pointer;
        }


        .login-button {

            width: 100%;

            height: 50px;

            border: none;

            border-radius: 9px;

            background:
                linear-gradient(
                    90deg,
                    #06558f,
                    #0f95ad
                );

            color: white;

            font-size: 16px;

            font-weight: 600;

            cursor: pointer;

            margin-top: 5px;

            transition: 0.3s;

            box-shadow:
                0 8px 20px
                rgba(8, 112, 153, 0.18);
        }


        .login-button:hover {

            transform:
                translateY(-1px);

            box-shadow:
                0 12px 24px
                rgba(8, 112, 153, 0.25);
        }


        .error-message {

            margin-top: 18px;

            padding: 12px 14px;

            border-radius: 8px;

            background: #fff1f1;

            border: 1px solid #f4cccc;

            color: #b3261e;

            font-size: 14px;
        }


        .login-footer {

            margin-top: 28px;

            padding-top: 20px;

            border-top:
                1px solid #edf0f2;

            text-align: center;

            font-size: 12px;

            color: #8a959d;
        }


        .security-note {

            margin-top: 16px;

            background: #f0fbfc;

            border-left:
                4px solid #14a8b5;

            padding: 12px;

            border-radius: 6px;

            font-size: 12px;

            color: #526168;
        }



        /* =========================================
           RESPONSIVE
        ========================================= */

        @media(max-width: 850px) {

            .login-wrapper {

                grid-template-columns: 1fr;

                max-width: 560px;
            }


            .brand-section {

                padding: 35px;
            }


            .logo-box {

                width: 170px;

                height: 170px;
            }


            .brand-section h1 {

                font-size: 26px;
            }


            .brand-section .description {

                display: none;
            }


            .login-section {

                padding: 35px;
            }
        }


        @media(max-width: 480px) {

            .login-wrapper {

                width: 100%;

                min-height: 100vh;

                border-radius: 0;
            }


            .login-section {

                padding: 30px 22px;
            }


            .brand-section {

                padding: 25px;
            }
        }

    </style>

</head>


<body>


<div class="login-wrapper">


    <!-- ==========================================
         LEFT BRAND SECTION
    =========================================== -->

    <div class="brand-section">


        <div class="logo-box">

            <img src="images/sunrise-logo.png"
                 alt="Sunrise Dental Clinic Logo">

        </div>


        <h1>
            Sunrise Dental Clinic
        </h1>


        <div class="tagline">
            YOUR SMILE, OUR CARE
        </div>


        <div class="description">

            Secure staff access to the Sunrise Dental Clinic
            Management System for patient registration,
            appointment scheduling, dental treatment management,
            billing and clinic administration.

        </div>


    </div>



    <!-- ==========================================
         LOGIN SECTION
    =========================================== -->

    <div class="login-section">


        <div class="small-title">
            Staff Portal
        </div>


        <h2>
            Welcome Back
        </h2>


        <div class="welcome-text">

            Select your staff role and enter your
            account credentials to continue.

        </div>



        <form method="post"
              action="login">




             <!-- USERNAME -->

           <div class="form-group">

    <label for="username">
        User Account
    </label>

    <select id="username"
            name="username"
            class="form-control"
            required>

        <option value="">
            Select user account
        </option>

        <option value="admin">
            Administrator
        </option>

        <option value="reception">
            Receptionist
        </option>

        <option value="dentist">
            Dentist
        </option>

    </select>

</div>

            <!-- PASSWORD -->

            <div class="form-group">

                <label for="password">
                    Password
                </label>


                <input id="password"
                       class="form-control"
                       type="password"
                       name="password"
                       placeholder="Enter your password"
                       autocomplete="current-password"
                       required>

            </div>



            <!-- LOGIN BUTTON -->

            <button type="submit"
                    class="login-button">

                Sign In

            </button>


        </form>



        <!-- ERROR -->

        <%
            String error =
                    (String) request.getAttribute("error");

            if (error != null) {
        %>


        <div class="error-message">

            <strong>Login Failed:</strong>

            <%= error %>

        </div>


        <%
            }
        %>



        <div class="security-note">

            This portal is restricted to authorised
            Sunrise Dental Clinic staff members only.

        </div>



        <div class="login-footer">

            © 2026 Sunrise Dental Clinic Management System

        </div>


    </div>


</div>


</body>

</html>