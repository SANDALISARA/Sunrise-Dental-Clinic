<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String role =
            (String) session.getAttribute("role");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Sunrise Dental Clinic - Dashboard</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/water.css@2/out/water.css">

</head>

<body>

<h1>Sunrise Dental Clinic</h1>

<h2>Dashboard</h2>

<p>
    Welcome,
    <strong><%= session.getAttribute("user") %></strong>
</p>

<p>
    Role:
    <strong><%= role %></strong>
</p>

<hr>

<nav>

    <a href="patients">
        Patients
    </a>
    |

    <a href="appointments">
        Appointments
    </a>
    |

    <a href="dentists">
        Dentists
    </a>
    |

    <a href="treatments">
        Treatments
    </a>
    |

    <a href="bill">
        Billing
    </a>
    |

    <a href="reports">
        Reports
    </a>
    |

    <a href="help">
        Help
    </a>
    |

    <a href="logout">
        Logout
    </a>

</nav>

<hr>

<h3>Clinic Management System</h3>

<ul>

    <li>Patient Registration and Management</li>

    <li>Appointment Scheduling</li>

    <li>Dentist Management</li>

    <li>Treatment Management</li>

    <li>Automatic Billing</li>

    <li>Clinic Reports</li>

</ul>

</body>

</html>