package sunrise.dental.web;

import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(
        name = "AppointmentServlet",
        urlPatterns = {"/appointments"}
)
public class AppointmentServlet extends HttpServlet {

    // =========================================================
    // DISPLAY APPOINTMENTS PAGE
    // URL:
    // /sunrise-dental-clinic-web/appointments
    // =========================================================
    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println(
                "AppointmentServlet doGet() called"
        );

        try {

            // Call REST service
            String json =
                    RestClient.get(
                            "appointments"
                    );

            System.out.println(
                    "Appointment GET response: "
                            + json
            );

            // Send JSON to JSP
            req.setAttribute(
                    "json",
                    json
            );

            // Open appointment JSP
            req.getRequestDispatcher(
                    "/appointments.jsp"
            ).forward(req, resp);

        } catch (Exception e) {

            System.out.println(
                    "Appointment GET error: "
                            + e.getMessage()
            );

            e.printStackTrace();

            req.setAttribute(
                    "error",
                    "Unable to load appointment information."
            );

            req.getRequestDispatcher(
                    "/appointments.jsp"
            ).forward(req, resp);
        }
    }


    // =========================================================
    // CREATE / UPDATE / CANCEL APPOINTMENT
    // =========================================================
    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding(
                "UTF-8"
        );

        String action =
                req.getParameter(
                        "action"
                );

        System.out.println(
                "AppointmentServlet doPost() called"
        );

        System.out.println(
                "Appointment action = "
                        + action
        );


        try {

            // =================================================
            // CREATE APPOINTMENT
            // =================================================
            if ("create".equals(action)) {

                JsonObject appointment =
                        new JsonObject();


                // ---------------------------------------------
                // PATIENT ID
                // ---------------------------------------------
                int patientId;

                try {

                    patientId =
                            Integer.parseInt(
                                    req.getParameter(
                                            "patientId"
                                    )
                            );

                } catch (Exception e) {

                    patientId = 0;
                }


                // ---------------------------------------------
                // DENTIST ID
                // ---------------------------------------------
                int dentistId;

                try {

                    dentistId =
                            Integer.parseInt(
                                    req.getParameter(
                                            "dentistId"
                                    )
                            );

                } catch (Exception e) {

                    dentistId = 0;
                }


                appointment.addProperty(
                        "patientId",
                        patientId
                );


                appointment.addProperty(
                        "dentistId",
                        dentistId
                );


                appointment.addProperty(
                        "appointmentDate",
                        req.getParameter(
                                "appointmentDate"
                        )
                );


                appointment.addProperty(
                        "appointmentTime",
                        req.getParameter(
                                "appointmentTime"
                        )
                );


                appointment.addProperty(
                        "reason",
                        req.getParameter(
                                "reason"
                        )
                );


                appointment.addProperty(
                        "status",
                        "Scheduled"
                );


                System.out.println(
                        "Sending Appointment JSON:"
                );

                System.out.println(
                        appointment.toString()
                );


                // Send JSON to REST API
                String result =
                        RestClient.post(
                                "appointments",
                                appointment.toString()
                        );


                System.out.println(
                        "Appointment POST response:"
                );

                System.out.println(
                        result
                );
            }


            // =================================================
            // UPDATE APPOINTMENT
            // =================================================
            else if ("update".equals(action)) {

                String appointmentId =
                        req.getParameter(
                                "appointmentId"
                        );


                JsonObject appointment =
                        new JsonObject();


                int patientId;

                try {

                    patientId =
                            Integer.parseInt(
                                    req.getParameter(
                                            "patientId"
                                    )
                            );

                } catch (Exception e) {

                    patientId = 0;
                }


                int dentistId;

                try {

                    dentistId =
                            Integer.parseInt(
                                    req.getParameter(
                                            "dentistId"
                                    )
                            );

                } catch (Exception e) {

                    dentistId = 0;
                }


                appointment.addProperty(
                        "patientId",
                        patientId
                );


                appointment.addProperty(
                        "dentistId",
                        dentistId
                );


                appointment.addProperty(
                        "appointmentDate",
                        req.getParameter(
                                "appointmentDate"
                        )
                );


                appointment.addProperty(
                        "appointmentTime",
                        req.getParameter(
                                "appointmentTime"
                        )
                );


                appointment.addProperty(
                        "reason",
                        req.getParameter(
                                "reason"
                        )
                );


                String status =
                        req.getParameter(
                                "status"
                        );


                if (status == null
                        || status.isBlank()) {

                    status = "Scheduled";
                }


                appointment.addProperty(
                        "status",
                        status
                );


                System.out.println(
                        "Updating Appointment ID: "
                                + appointmentId
                );


                String result =
                        RestClient.put(
                                "appointments/"
                                        + appointmentId,
                                appointment.toString()
                        );


                System.out.println(
                        "Appointment UPDATE response: "
                                + result
                );
            }


            // =================================================
            // CANCEL APPOINTMENT
            // =================================================
            else if ("cancel".equals(action)) {

                String appointmentId =
                        req.getParameter(
                                "appointmentId"
                        );


                System.out.println(
                        "Cancelling Appointment ID: "
                                + appointmentId
                );


                String result =
                        RestClient.put(
                                "appointments/"
                                        + appointmentId
                                        + "/cancel",
                                "{}"
                        );


                System.out.println(
                        "Appointment CANCEL response: "
                                + result
                );
            }


            // =================================================
            // UNKNOWN ACTION
            // =================================================
            else {

                System.out.println(
                        "Unknown appointment action: "
                                + action
                );
            }


        } catch (Exception e) {

            System.out.println(
                    "Appointment POST error: "
                            + e.getMessage()
            );

            e.printStackTrace();
        }


        // Return to appointments page
        resp.sendRedirect(
                req.getContextPath()
                        + "/appointments"
        );
    }
}