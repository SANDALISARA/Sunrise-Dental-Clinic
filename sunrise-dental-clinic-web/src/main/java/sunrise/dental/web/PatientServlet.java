package sunrise.dental.web;

import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet(
        name = "PatientServlet",
        urlPatterns = {"/patients"}
)
public class PatientServlet
        extends HttpServlet {


    // =========================================================
    // DISPLAY PATIENTS
    // =========================================================
    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {


        try {


            String json =
                    RestClient.get(
                            "patients"
                    );


            req.setAttribute(
                    "json",
                    json
            );


        } catch (Exception e) {


            e.printStackTrace();


            req.setAttribute(
                    "error",
                    "Unable to load patient information."
            );
        }


        req.getRequestDispatcher(
                "/patients.jsp"
        ).forward(req, resp);
    }


    // =========================================================
    // CREATE / UPDATE / DELETE
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


                JsonObject patient =
                        createPatientJson(req);


                String result =
                        RestClient.post(
                                "patients",
                                patient.toString()
                        );


                System.out.println(
                        "Patient Create Response: "
                                + result
                );
            }


            // =================================================
            // UPDATE
            // =================================================
            else if ("update".equals(action)) {


                String patientId =
                        req.getParameter(
                                "patientId"
                        );


                if (patientId == null
                        || patientId.isBlank()) {


                    throw new IllegalArgumentException(
                            "Patient ID is missing."
                    );
                }


                JsonObject patient =
                        createPatientJson(req);


                String result =
                        RestClient.put(
                                "patients/"
                                        + patientId,
                                patient.toString()
                        );


                System.out.println(
                        "Patient Update Response: "
                                + result
                );
            }


            // =================================================
            // DELETE
            // =================================================
            else if ("delete".equals(action)) {


                String patientId =
                        req.getParameter(
                                "patientId"
                        );


                if (patientId == null
                        || patientId.isBlank()) {


                    throw new IllegalArgumentException(
                            "Patient ID is missing."
                    );
                }


                String result =
                        RestClient.delete(
                                "patients/"
                                        + patientId
                        );


                System.out.println(
                        "Patient Delete Response: "
                                + result
                );
            }


        } catch (Exception e) {


            e.printStackTrace();


            System.out.println(
                    "Patient operation error: "
                            + e.getMessage()
            );
        }


        resp.sendRedirect(
                req.getContextPath()
                        + "/patients"
        );
    }


    // =========================================================
    // CREATE JSON OBJECT
    // =========================================================
    private JsonObject createPatientJson(
            HttpServletRequest req) {


        JsonObject patient =
                new JsonObject();


        patient.addProperty(
                "patientName",
                req.getParameter(
                        "patientName"
                )
        );


        patient.addProperty(
                "dateOfBirth",
                req.getParameter(
                        "dateOfBirth"
                )
        );


        patient.addProperty(
                "gender",
                req.getParameter(
                        "gender"
                )
        );


        patient.addProperty(
                "phone",
                req.getParameter(
                        "phone"
                )
        );


        patient.addProperty(
                "email",
                req.getParameter(
                        "email"
                )
        );


        patient.addProperty(
                "address",
                req.getParameter(
                        "address"
                )
        );


        patient.addProperty(
                "medicalHistory",
                req.getParameter(
                        "medicalHistory"
                )
        );


        return patient;
    }
}