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

    String json =
            (String) request.getAttribute(
                    "json"
            );
%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>
        Patients - Sunrise Dental Clinic
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

            margin: 0;

            background:
                    #f4f8fb;

            color:
                    #263238;
        }


        .container {

            width: 94%;

            max-width: 1350px;

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

            margin-top:
                    0;
        }


        .nav {

            margin-bottom:
                    25px;
        }


        .nav a {

            text-decoration:
                    none;

            margin-right:
                    15px;

            color:
                    #087ca7;

            font-weight:
                    600;
        }


        .card {

            background:
                    white;

            padding:
                    25px;

            border-radius:
                    12px;

            margin-bottom:
                    30px;

            box-shadow:
                    0 3px 15px
                    rgba(0,0,0,0.07);
        }


        .form-grid {

            display:
                    grid;

            grid-template-columns:
                    repeat(2, 1fr);

            gap:
                    20px;
        }


        .form-group {

            display:
                    flex;

            flex-direction:
                    column;
        }


        .full-width {

            grid-column:
                    1 / -1;
        }


        label {

            margin-bottom:
                    6px;

            font-weight:
                    600;
        }


        input,
        select,
        textarea {

            padding:
                    11px;

            border:
                    1px solid #ccd7dd;

            border-radius:
                    7px;

            font-size:
                    14px;
        }


        input:focus,
        select:focus,
        textarea:focus {

            outline:
                    none;

            border-color:
                    #0e9caf;

            box-shadow:
                    0 0 0 3px
                    rgba(14,156,175,0.12);
        }


        textarea {

            resize:
                    vertical;

            min-height:
                    85px;
        }


        button {

            border:
                    none;

            padding:
                    10px 17px;

            border-radius:
                    6px;

            cursor:
                    pointer;

            font-size:
                    14px;

            font-weight:
                    600;

            color:
                    white;

            background:
                    linear-gradient(
                            90deg,
                            #064f8c,
                            #0d95ad
                    );
        }


        button:hover {

            opacity:
                    0.9;
        }


        .register-button {

            margin-top:
                    8px;
        }


        .edit-button {

            background:
                    #078ca4;
        }


        .delete-button {

            background:
                    #d84343;
        }


        .cancel-button {

            background:
                    #68777e;
        }


        .action-container {

            display:
                    flex;

            gap:
                    7px;

            align-items:
                    center;

            flex-wrap:
                    wrap;
        }


        .action-container form {

            margin:
                    0;
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

            background:
                    white;

            font-size:
                    14px;
        }


        th {

            background:
                    linear-gradient(
                            90deg,
                            #064f8c,
                            #087f9a
                    );

            color:
                    white;

            text-align:
                    left;

            padding:
                    12px;
        }


        td {

            padding:
                    11px;

            border-bottom:
                    1px solid #dde5e9;

            vertical-align:
                    top;
        }


        tbody tr:hover {

            background:
                    #f4fafc;
        }


        .patient-number {

            font-weight:
                    bold;

            color:
                    #087ca7;
        }


        .edit-card {

            display:
                    none;

            border-left:
                    5px solid #f5a400;
        }


        .empty-message {

            padding:
                    18px;

            background:
                    #fff4d9;

            border-radius:
                    7px;

            color:
                    #805e00;
        }


        @media(max-width: 800px) {

            .form-grid {

                grid-template-columns:
                        1fr;
            }
        }

    </style>

</head>


<body>


<div class="container">


    <h1>
        Patient Management
    </h1>


    <div class="nav">

        <a href="dashboard.jsp">
            Dashboard
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



    <!-- ========================================== -->
    <!-- REGISTER PATIENT -->
    <!-- ========================================== -->

    <div class="card">


        <h2>
            Register Patient
        </h2>


        <form method="post"
              action="patients">


            <input type="hidden"
                   name="action"
                   value="create">


            <div class="form-grid">


                <div class="form-group">

                    <label>
                        Patient Name
                    </label>

                    <input type="text"
                           name="patientName"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Date of Birth
                    </label>

                    <input type="date"
                           name="dateOfBirth"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Gender
                    </label>

                    <select name="gender"
                            required>

                        <option value="">
                            Select Gender
                        </option>

                        <option value="Male">
                            Male
                        </option>

                        <option value="Female">
                            Female
                        </option>

                        <option value="Other">
                            Other
                        </option>

                    </select>

                </div>


                <div class="form-group">

                    <label>
                        Phone Number
                    </label>

                    <input type="text"
                           name="phone">

                </div>


                <div class="form-group">

                    <label>
                        Email
                    </label>

                    <input type="email"
                           name="email">

                </div>


                <div class="form-group full-width">

                    <label>
                        Address
                    </label>

                    <textarea name="address"></textarea>

                </div>


                <div class="form-group full-width">

                    <label>
                        Medical History
                    </label>

                    <textarea name="medicalHistory"></textarea>

                </div>


                <div class="full-width">

                    <button type="submit"
                            class="register-button">

                        Register Patient

                    </button>

                </div>


            </div>

        </form>

    </div>



    <!-- ========================================== -->
    <!-- UPDATE PATIENT -->
    <!-- ========================================== -->

    <div class="card edit-card"
         id="editPatientCard">


        <h2>
            Update Patient
        </h2>


        <form method="post"
              action="patients">


            <input type="hidden"
                   name="action"
                   value="update">


            <input type="hidden"
                   name="patientId"
                   id="editPatientId">


            <div class="form-grid">


                <div class="form-group">

                    <label>
                        Patient Name
                    </label>

                    <input type="text"
                           name="patientName"
                           id="editPatientName"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Date of Birth
                    </label>

                    <input type="date"
                           name="dateOfBirth"
                           id="editDateOfBirth"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Gender
                    </label>

                    <select name="gender"
                            id="editGender"
                            required>

                        <option value="Male">
                            Male
                        </option>

                        <option value="Female">
                            Female
                        </option>

                        <option value="Other">
                            Other
                        </option>

                    </select>

                </div>


                <div class="form-group">

                    <label>
                        Phone Number
                    </label>

                    <input type="text"
                           name="phone"
                           id="editPhone">

                </div>


                <div class="form-group">

                    <label>
                        Email
                    </label>

                    <input type="email"
                           name="email"
                           id="editEmail">

                </div>


                <div class="form-group full-width">

                    <label>
                        Address
                    </label>

                    <textarea name="address"
                              id="editAddress">
                    </textarea>

                </div>


                <div class="form-group full-width">

                    <label>
                        Medical History
                    </label>

                    <textarea name="medicalHistory"
                              id="editMedicalHistory">
                    </textarea>

                </div>


                <div class="full-width">


                    <button type="submit">

                        Update Patient

                    </button>


                    <button type="button"
                            class="cancel-button"
                            onclick="cancelEdit()">

                        Cancel

                    </button>


                </div>


            </div>

        </form>

    </div>



    <!-- ========================================== -->
    <!-- PATIENT LIST -->
    <!-- ========================================== -->

    <div class="card">


        <h2>
            Registered Patients
        </h2>


        <%
            boolean hasPatients =
                    false;

            try {


                if (json != null
                        && !json.isBlank()) {


                    JsonElement root =
                            JsonParser
                                    .parseString(json);


                    if (root.isJsonArray()) {


                        JsonArray patients =
                                root
                                        .getAsJsonArray();


                        if (!patients.isEmpty()) {


                            hasPatients =
                                    true;
        %>


        <div class="table-wrapper">


            <table>


                <thead>

                <tr>

                    <th>ID</th>

                    <th>
                        Patient No.
                    </th>

                    <th>Name</th>

                    <th>
                        Date of Birth
                    </th>

                    <th>Gender</th>

                    <th>Phone</th>

                    <th>Email</th>

                    <th>Address</th>

                    <th>
                        Medical History
                    </th>

                    <th>Actions</th>

                </tr>

                </thead>


                <tbody>


                <%

                    for (
                            JsonElement element
                            : patients) {


                        JsonObject patient =
                                element
                                        .getAsJsonObject();


                        String id =
                                patient.has("id")
                                ? patient
                                  .get("id")
                                  .getAsString()
                                : "";


                        String patientNumber =
                                patient.has(
                                        "patientNumber"
                                )
                                && !patient
                                   .get(
                                           "patientNumber"
                                   )
                                   .isJsonNull()
                                ? patient
                                  .get(
                                          "patientNumber"
                                  )
                                  .getAsString()
                                : "";


                        String patientName =
                                patient.has(
                                        "patientName"
                                )
                                && !patient
                                   .get(
                                           "patientName"
                                   )
                                   .isJsonNull()
                                ? patient
                                  .get(
                                          "patientName"
                                  )
                                  .getAsString()
                                : "";


                        String dateOfBirth =
                                patient.has(
                                        "dateOfBirth"
                                )
                                && !patient
                                   .get(
                                           "dateOfBirth"
                                   )
                                   .isJsonNull()
                                ? patient
                                  .get(
                                          "dateOfBirth"
                                  )
                                  .getAsString()
                                : "";


                        String gender =
                                patient.has(
                                        "gender"
                                )
                                && !patient
                                   .get(
                                           "gender"
                                   )
                                   .isJsonNull()
                                ? patient
                                  .get(
                                          "gender"
                                  )
                                  .getAsString()
                                : "";


                        String phone =
                                patient.has(
                                        "phone"
                                )
                                && !patient
                                   .get(
                                           "phone"
                                   )
                                   .isJsonNull()
                                ? patient
                                  .get(
                                          "phone"
                                  )
                                  .getAsString()
                                : "";


                        String email =
                                patient.has(
                                        "email"
                                )
                                && !patient
                                   .get(
                                           "email"
                                   )
                                   .isJsonNull()
                                ? patient
                                  .get(
                                          "email"
                                  )
                                  .getAsString()
                                : "";


                        String address =
                                patient.has(
                                        "address"
                                )
                                && !patient
                                   .get(
                                           "address"
                                   )
                                   .isJsonNull()
                                ? patient
                                  .get(
                                          "address"
                                  )
                                  .getAsString()
                                : "";


                        String medicalHistory =
                                patient.has(
                                        "medicalHistory"
                                )
                                && !patient
                                   .get(
                                           "medicalHistory"
                                   )
                                   .isJsonNull()
                                ? patient
                                  .get(
                                          "medicalHistory"
                                  )
                                  .getAsString()
                                : "";


                        String safeName =
                                patientName
                                        .replace(
                                                "\\",
                                                "\\\\"
                                        )
                                        .replace(
                                                "'",
                                                "\\'"
                                        );


                        String safePhone =
                                phone
                                        .replace(
                                                "\\",
                                                "\\\\"
                                        )
                                        .replace(
                                                "'",
                                                "\\'"
                                        );


                        String safeEmail =
                                email
                                        .replace(
                                                "\\",
                                                "\\\\"
                                        )
                                        .replace(
                                                "'",
                                                "\\'"
                                        );


                        String safeAddress =
                                address
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


                        String safeHistory =
                                medicalHistory
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


                    <td>
                        <%= id %>
                    </td>


                    <td class="patient-number">
                        <%= patientNumber %>
                    </td>


                    <td>
                        <%= patientName %>
                    </td>


                    <td>
                        <%= dateOfBirth %>
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


                    <td>
                        <%= address %>
                    </td>


                    <td>
                        <%= medicalHistory %>
                    </td>


                    <td>


                        <div class="action-container">


                            <!-- EDIT -->

                            <button type="button"
                                    class="edit-button"
                                    onclick="editPatient(
                                            '<%= id %>',
                                            '<%= safeName %>',
                                            '<%= dateOfBirth %>',
                                            '<%= gender %>',
                                            '<%= safePhone %>',
                                            '<%= safeEmail %>',
                                            '<%= safeAddress %>',
                                            '<%= safeHistory %>'
                                    )">

                                Edit

                            </button>



                            <!-- DELETE -->

                            <form method="post"
                                  action="patients"
                                  onsubmit="
                                      return confirm(
                                          'Are you sure you want to delete this patient?'
                                      );
                                  ">


                                <input type="hidden"
                                       name="action"
                                       value="delete">


                                <input type="hidden"
                                       name="patientId"
                                       value="<%= id %>">


                                <button type="submit"
                                        class="delete-button">

                                    Delete

                                </button>


                            </form>


                        </div>


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
                    }
                }

            } catch (Exception e) {


                System.out.println(
                        "Patient JSON parsing error: "
                                + e.getMessage()
                );
            }


            if (!hasPatients) {
        %>


        <div class="empty-message">

            No patient records are available.

        </div>


        <%
            }
        %>


    </div>


</div>



<script>


function editPatient(
        id,
        name,
        dob,
        gender,
        phone,
        email,
        address,
        medicalHistory) {


    document.getElementById(
            "editPatientId"
    ).value = id;


    document.getElementById(
            "editPatientName"
    ).value = name;


    document.getElementById(
            "editDateOfBirth"
    ).value = dob;


    document.getElementById(
            "editGender"
    ).value = gender;


    document.getElementById(
            "editPhone"
    ).value = phone;


    document.getElementById(
            "editEmail"
    ).value = email;


    document.getElementById(
            "editAddress"
    ).value = address;


    document.getElementById(
            "editMedicalHistory"
    ).value = medicalHistory;


    const card =
            document.getElementById(
                    "editPatientCard"
            );


    card.style.display =
            "block";


    card.scrollIntoView({
        behavior: "smooth",
        block: "start"
    });
}



function cancelEdit() {


    document.getElementById(
            "editPatientCard"
    ).style.display =
            "none";
}


</script>


</body>

</html>