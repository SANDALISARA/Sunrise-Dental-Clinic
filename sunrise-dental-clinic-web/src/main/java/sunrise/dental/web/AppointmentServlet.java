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
public class AppointmentServlet
        extends HttpServlet {


    // =========================================================
    // DISPLAY APPOINTMENT PAGE
    // =========================================================
    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {


        loadData(req);


        req.getRequestDispatcher(
                "/appointments.jsp"
        ).forward(req, resp);
    }


    // =========================================================
    // CREATE / UPDATE / CANCEL
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


        try {


            // =================================================
            // CREATE
            // =================================================
            if ("create".equals(action)) {


                JsonObject appointment =
                        createAppointmentJson(
                                req
                        );


                String result =
                        RestClient.post(
                                "appointments",
                                appointment.toString()
                        );


                System.out.println(
                        "Appointment Create Response: "
                                + result
                );


                // If REST gives a conflict message,
                // show it on the page.
                if (result != null
                        && result.contains(
                                "already booked"
                        )) {

                    req.setAttribute(
                            "error",
                            result
                    );
                }


                else {

                    req.setAttribute(
                            "success",
                            "Appointment scheduled successfully."
                    );
                }
            }


            // =================================================
            // UPDATE
            // =================================================
            else if ("update".equals(action)) {


                String appointmentId =
                        req.getParameter(
                                "appointmentId"
                        );


                if (appointmentId == null
                        || appointmentId.isBlank()) {

                    throw new IllegalArgumentException(
                            "Appointment ID is missing."
                    );
                }


                JsonObject appointment =
                        createAppointmentJson(
                                req
                        );


                String result =
                        RestClient.put(
                                "appointments/"
                                        + appointmentId,
                                appointment.toString()
                        );


                System.out.println(
                        "Appointment Update Response: "
                                + result
                );


                if (result != null
                        && result.contains(
                                "already booked"
                        )) {

                    req.setAttribute(
                            "error",
                            result
                    );
                }


                else {

                    req.setAttribute(
                            "success",
                            "Appointment updated successfully."
                    );
                }
            }


            // =================================================
            // CANCEL
            // =================================================
            else if ("cancel".equals(action)) {


                String appointmentId =
                        req.getParameter(
                                "appointmentId"
                        );


                if (appointmentId == null
                        || appointmentId.isBlank()) {

                    throw new IllegalArgumentException(
                            "Appointment ID is missing."
                    );
                }


                RestClient.put(
                        "appointments/"
                                + appointmentId
                                + "/cancel",
                        "{}"
                );


                req.setAttribute(
                        "success",
                        "Appointment cancelled successfully."
                );
            }


        } catch (Exception e) {


            e.printStackTrace();


            req.setAttribute(
                    "error",
                    e.getMessage()
            );
        }


        // Reload appointment, patient and dentist data
        loadData(req);


        req.getRequestDispatcher(
                "/appointments.jsp"
        ).forward(req, resp);
    }


    // =========================================================
    // LOAD DATA FOR DROPDOWNS + TABLE
    // =========================================================
    private void loadData(
            HttpServletRequest req) {


        try {


            req.setAttribute(
                    "appointmentsJson",
                    RestClient.get(
                            "appointments"
                    )
            );


            req.setAttribute(
                    "patientsJson",
                    RestClient.get(
                            "patients"
                    )
            );


            req.setAttribute(
                    "dentistsJson",
                    RestClient.get(
                            "dentists"
                    )
            );


        } catch (Exception e) {


            e.printStackTrace();


            req.setAttribute(
                    "error",
                    "Unable to load appointment information."
            );
        }
    }


    // =========================================================
    // BUILD APPOINTMENT JSON
    // =========================================================
    private JsonObject createAppointmentJson(
            HttpServletRequest req) {


        JsonObject appointment =
                new JsonObject();


        appointment.addProperty(
                "patientId",
                Integer.parseInt(
                        req.getParameter(
                                "patientId"
                        )
                )
        );


        appointment.addProperty(
                "dentistId",
                Integer.parseInt(
                        req.getParameter(
                                "dentistId"
                        )
                )
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

            status =
                    "Scheduled";
        }


        appointment.addProperty(
                "status",
                status
        );


        return appointment;
    }
}