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
        Dentists - Sunrise Dental Clinic
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
                    94%;

            max-width:
                    1250px;

            margin:
                    30px auto;
        }


        h1 {

            color:
                    #064f8c;
        }


        h2 {

            margin-top:
                    0;

            color:
                    #263238;
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


        input {

            padding:
                    11px;

            border:
                    1px solid #ccd7dd;

            border-radius:
                    7px;

            font-size:
                    14px;
        }


        input:focus {

            outline:
                    none;

            border-color:
                    #0e9caf;

            box-shadow:
                    0 0 0 3px
                    rgba(14,156,175,0.12);
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


        .edit-card {

            display:
                    none;

            border-left:
                    5px solid #f5a400;
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

            padding:
                    12px;

            text-align:
                    left;
        }


        td {

            padding:
                    11px;

            border-bottom:
                    1px solid #dde5e9;
        }


        tbody tr:hover {

            background:
                    #f4fafc;
        }


        .dentist-number {

            color:
                    #087ca7;

            font-weight:
                    bold;
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
        Dentist Management
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

        <a href="logout">
            Logout
        </a>

    </div>



    <!-- ========================================== -->
    <!-- REGISTER DENTIST -->
    <!-- ========================================== -->

    <div class="card">


        <h2>
            Register Dentist
        </h2>


        <form method="post"
              action="dentists">


            <input type="hidden"
                   name="action"
                   value="create">


            <div class="form-grid">


                <div class="form-group">

                    <label>
                        Dentist Name
                    </label>

                    <input type="text"
                           name="dentistName"
                           placeholder="e.g. Dr. Perera"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Specialization
                    </label>

                    <input type="text"
                           name="specialization"
                           placeholder="e.g. Orthodontics"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Phone Number
                    </label>

                    <input type="text"
                           name="phone"
                           placeholder="e.g. 0771234567"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Email
                    </label>

                    <input type="email"
                           name="email"
                           placeholder="e.g. dentist@sunrise.lk">

                </div>


                <div class="full-width">

                    <button type="submit">

                        Add Dentist

                    </button>

                </div>


            </div>


        </form>


    </div>



    <!-- ========================================== -->
    <!-- UPDATE DENTIST -->
    <!-- ========================================== -->

    <div class="card edit-card"
         id="editDentistCard">


        <h2>
            Update Dentist
        </h2>


        <form method="post"
              action="dentists">


            <input type="hidden"
                   name="action"
                   value="update">


            <input type="hidden"
                   name="dentistId"
                   id="editDentistId">


            <div class="form-grid">


                <div class="form-group">

                    <label>
                        Dentist Name
                    </label>

                    <input type="text"
                           name="dentistName"
                           id="editDentistName"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Specialization
                    </label>

                    <input type="text"
                           name="specialization"
                           id="editSpecialization"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Phone Number
                    </label>

                    <input type="text"
                           name="phone"
                           id="editPhone"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Email
                    </label>

                    <input type="email"
                           name="email"
                           id="editEmail">

                </div>


                <div class="full-width">


                    <button type="submit">

                        Update Dentist

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
    <!-- DENTIST LIST -->
    <!-- ========================================== -->

    <div class="card">


        <h2>
            Registered Dentists
        </h2>


        <%
            boolean hasDentists =
                    false;

            try {


                if (json != null
                        && !json.isBlank()) {


                    JsonElement root =
                            JsonParser
                                    .parseString(json);


                    if (root.isJsonArray()) {


                        JsonArray dentists =
                                root
                                        .getAsJsonArray();


                        if (!dentists.isEmpty()) {


                            hasDentists =
                                    true;
        %>


        <div class="table-wrapper">


            <table>


                <thead>

                <tr>

                    <th>ID</th>

                    <th>
                        Dentist No.
                    </th>

                    <th>
                        Dentist Name
                    </th>

                    <th>
                        Specialization
                    </th>

                    <th>
                        Phone
                    </th>

                    <th>
                        Email
                    </th>

                    <th>
                        Actions
                    </th>

                </tr>

                </thead>


                <tbody>


                <%

                    for (
                            JsonElement element
                            : dentists) {


                        JsonObject dentist =
                                element
                                        .getAsJsonObject();


                        String id =
                                dentist.has("id")
                                ? dentist
                                  .get("id")
                                  .getAsString()
                                : "";


                        String dentistNumber =
                                dentist.has(
                                        "dentistNumber"
                                )
                                && !dentist
                                   .get(
                                           "dentistNumber"
                                   )
                                   .isJsonNull()
                                ? dentist
                                  .get(
                                          "dentistNumber"
                                  )
                                  .getAsString()
                                : "";


                        String dentistName =
                                dentist.has(
                                        "dentistName"
                                )
                                && !dentist
                                   .get(
                                           "dentistName"
                                   )
                                   .isJsonNull()
                                ? dentist
                                  .get(
                                          "dentistName"
                                  )
                                  .getAsString()
                                : "";


                        String specialization =
                                dentist.has(
                                        "specialization"
                                )
                                && !dentist
                                   .get(
                                           "specialization"
                                   )
                                   .isJsonNull()
                                ? dentist
                                  .get(
                                          "specialization"
                                  )
                                  .getAsString()
                                : "";


                        String phone =
                                dentist.has(
                                        "phone"
                                )
                                && !dentist
                                   .get(
                                           "phone"
                                   )
                                   .isJsonNull()
                                ? dentist
                                  .get(
                                          "phone"
                                  )
                                  .getAsString()
                                : "";


                        String email =
                                dentist.has(
                                        "email"
                                )
                                && !dentist
                                   .get(
                                           "email"
                                   )
                                   .isJsonNull()
                                ? dentist
                                  .get(
                                          "email"
                                  )
                                  .getAsString()
                                : "";


                        String safeName =
                                dentistName
                                        .replace(
                                                "\\",
                                                "\\\\"
                                        )
                                        .replace(
                                                "'",
                                                "\\'"
                                        );


                        String safeSpecialization =
                                specialization
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
                %>


                <tr>


                    <td>
                        <%= id %>
                    </td>


                    <td class="dentist-number">
                        <%= dentistNumber %>
                    </td>


                    <td>
                        <%= dentistName %>
                    </td>


                    <td>
                        <%= specialization %>
                    </td>


                    <td>
                        <%= phone %>
                    </td>


                    <td>
                        <%= email %>
                    </td>


                    <td>


                        <div class="action-container">


                            <!-- EDIT -->

                            <button type="button"
                                    class="edit-button"
                                    onclick="editDentist(
                                        '<%= id %>',
                                        '<%= safeName %>',
                                        '<%= safeSpecialization %>',
                                        '<%= safePhone %>',
                                        '<%= safeEmail %>'
                                    )">

                                Edit

                            </button>



                            <!-- DELETE -->

                            <form method="post"
                                  action="dentists"
                                  onsubmit="
                                      return confirm(
                                          'Are you sure you want to delete this dentist?'
                                      );
                                  ">


                                <input type="hidden"
                                       name="action"
                                       value="delete">


                                <input type="hidden"
                                       name="dentistId"
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
                        "Dentist JSON parsing error: "
                                + e.getMessage()
                );
            }


            if (!hasDentists) {
        %>


        <div class="empty-message">

            No dentist records are available.

        </div>


        <%
            }
        %>


    </div>


</div>



<script>


function editDentist(
        id,
        dentistName,
        specialization,
        phone,
        email) {


    document.getElementById(
            "editDentistId"
    ).value =
            id;


    document.getElementById(
            "editDentistName"
    ).value =
            dentistName;


    document.getElementById(
            "editSpecialization"
    ).value =
            specialization;


    document.getElementById(
            "editPhone"
    ).value =
            phone;


    document.getElementById(
            "editEmail"
    ).value =
            email;


    const card =
            document.getElementById(
                    "editDentistCard"
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
            "editDentistCard"
    ).style.display =
            "none";
}


</script>


</body>

</html>