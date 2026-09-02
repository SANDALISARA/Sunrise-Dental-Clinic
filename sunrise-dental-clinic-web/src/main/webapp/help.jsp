<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <title>Help & User Guide - Sunrise Dental Clinic</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">

    <style>

        .note {
            padding: .75rem 1rem;
            border-left: 4px solid #8a8aff;
        }

        .kbd {
            border: 1px solid #ccc;
            padding: 0 .3rem;
            border-radius: 4px;
            font-family: monospace;
        }

        @media print {

            nav,
            .no-print {
                display: none !important;
            }

            body {
                font-size: 12pt;
            }

        }

        details > summary {
            cursor: pointer;
        }

    </style>

</head>

<body>

<nav class="no-print">

    <a href="dashboard.jsp">Dashboard</a> |

    <a href="patients">Patients</a> |

    <a href="appointments">Appointments</a> |

    <a href="dentists">Dentists</a> |

    <a href="treatments">Treatments</a> |

    <a href="bill">Billing</a> |

    <a href="reports">Reports</a> |

    <a href="logout">Logout</a>

</nav>

<h1>Sunrise Dental Clinic</h1>

<h2>Help & User Guide</h2>

<p class="note">

    This guide explains how authorized users can log in
    and manage patients, appointments, dentists,
    treatments, billing and reports.

</p>

<hr>

<h2>1. Login</h2>

<ul>

    <li>
        Open the Sunrise Dental Clinic Management System.
    </li>

    <li>
        Enter a valid username and password.
    </li>

    <li>
        Only authorized users can access the system.
    </li>

    <li>
        The system supports Administrator, Receptionist
        and Dentist users.
    </li>

</ul>

<h2>2. Patient Management</h2>

<ol>

    <li>Open the Patients section.</li>

    <li>Enter the patient's personal information.</li>

    <li>Enter contact details and medical history.</li>

    <li>Click Register Patient.</li>

    <li>
        Patient information can be searched when required.
    </li>

</ol>

<h2>3. Appointment Management</h2>

<ol>

    <li>Open the Appointments section.</li>

    <li>Select the patient.</li>

    <li>Select the dentist.</li>

    <li>Select the appointment date and time.</li>

    <li>Enter the reason for the visit.</li>

    <li>Save the appointment.</li>

</ol>

<p>
    Each appointment receives a unique appointment number
    that can be used to locate appointment information.
</p>

<h2>4. Dentist Management</h2>

<ul>

    <li>Administrator can manage dentist information.</li>

    <li>
        A dentist can have multiple appointments
        at different times.
    </li>

    <li>
        Each appointment is allocated to one dentist.
    </li>

</ul>

<h2>5. Treatment Management</h2>

<ul>

    <li>
        Administrators can manage dental treatments.
    </li>

    <li>
        Each treatment has a predetermined price.
    </li>

    <li>
        Treatment information is used when preparing patient bills.
    </li>

</ul>

<h2>6. Billing</h2>

<ol>

    <li>Select the patient.</li>

    <li>Select the relevant appointment.</li>

    <li>Select the dental treatment.</li>

    <li>Enter or retrieve the consultation fee.</li>

    <li>
        The system calculates the total cost automatically.
    </li>

    <li>
        The bill can then be saved and printed.
    </li>

</ol>

<h2>7. Reports</h2>

<ul>

    <li>Daily appointment reports</li>

    <li>Patient summary reports</li>

    <li>Treatment reports</li>

    <li>Daily income reports</li>

    <li>Dentist appointment reports</li>

</ul>

<h2>8. Database Connection Problems</h2>

<details>

    <summary>Cannot connect to MySQL</summary>

    <ul>

        <li>Start MySQL using XAMPP.</li>

        <li>Check the database name.</li>

        <li>Check the username and password.</li>

        <li>
            Check the
            <code>db.properties</code>
            configuration file.
        </li>

    </ul>

</details>

<h2>9. REST Service Problems</h2>

<details>

    <summary>REST service is not reachable</summary>

    <ul>

        <li>Start GlassFish Server.</li>

        <li>Deploy the Sunrise Dental REST service.</li>

        <li>
            Check the REST API base URL.
        </li>

        <li>
            Test the health endpoint if available.
        </li>

    </ul>

</details>

<h2>10. Security</h2>

<p>

    The system is restricted to authorized users.
    Users must provide a valid username and password
    before accessing clinic information.

</p>

<h2>11. System Architecture</h2>

<p>

    The system follows a three-tier architecture:

</p>

<ul>

    <li>
        <strong>Presentation Layer:</strong>
        JSP and Servlet
    </li>

    <li>
        <strong>Business/Service Layer:</strong>
        RESTful Web Services
    </li>

    <li>
        <strong>Data Layer:</strong>
        DAO, DTO and MySQL Database
    </li>

</ul>

<h2>12. Future Enhancements</h2>

<p>

    The current version does not include online appointment
    scheduling, online payment processing, SMS notifications
    or mobile application support. These features can be
    considered for future development.

</p>

<div class="no-print">

    <button onclick="window.print()">
        Print User Guide
    </button>

</div>

</body>

</html>