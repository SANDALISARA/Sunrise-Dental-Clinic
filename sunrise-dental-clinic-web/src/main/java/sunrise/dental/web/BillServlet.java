package sunrise.dental.web;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet(
        name = "BillServlet",
        urlPatterns = {"/bill"}
)
public class BillServlet
        extends HttpServlet {


    // =========================================================
    // DISPLAY BILL PAGE
    // =========================================================
    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        loadData(req);

        req.getRequestDispatcher(
                "/bill.jsp"
        ).forward(req, resp);
    }


    // =========================================================
    // CREATE BILL / PAY BILL
    // =========================================================
    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action =
                req.getParameter("action");


        try {

            // =================================================
            // CREATE BILL
            // =================================================
            if ("create".equals(action)) {

                String patientIdStr =
                        req.getParameter(
                                "patientId"
                        );

                String appointmentIdStr =
                        req.getParameter(
                                "appointmentId"
                        );

                String treatmentIdStr =
                        req.getParameter(
                                "treatmentId"
                        );

                String consultationFeeStr =
                        req.getParameter(
                                "consultationFee"
                        );


                if (patientIdStr == null
                        || patientIdStr.isBlank()) {

                    throw new IllegalArgumentException(
                            "Please select a patient."
                    );
                }


                if (appointmentIdStr == null
                        || appointmentIdStr.isBlank()) {

                    throw new IllegalArgumentException(
                            "Please select an appointment."
                    );
                }


                if (treatmentIdStr == null
                        || treatmentIdStr.isBlank()) {

                    throw new IllegalArgumentException(
                            "Please select a treatment."
                    );
                }


                if (consultationFeeStr == null
                        || consultationFeeStr.isBlank()) {

                    throw new IllegalArgumentException(
                            "Please enter the consultation fee."
                    );
                }


                int patientId =
                        Integer.parseInt(
                                patientIdStr
                        );


                int appointmentId =
                        Integer.parseInt(
                                appointmentIdStr
                        );


                int treatmentId =
                        Integer.parseInt(
                                treatmentIdStr
                        );


                double consultationFee =
                        Double.parseDouble(
                                consultationFeeStr
                        );


                // ---------------------------------------------
                // SECURITY / DATA VALIDATION
                // Check selected appointment actually belongs
                // to selected patient.
                // ---------------------------------------------

                String appointmentJson =
                        RestClient.get(
                                "appointments/"
                                        + appointmentId
                        );


                JsonObject appointment =
                        JsonParser
                                .parseString(
                                        appointmentJson
                                )
                                .getAsJsonObject();


                int actualPatientId =
                        appointment
                                .get("patientId")
                                .getAsInt();


                String appointmentStatus =
                        appointment
                                .get("status")
                                .getAsString();


                if (actualPatientId
                        != patientId) {

                    throw new IllegalArgumentException(
                            "The selected appointment "
                            + "does not belong to this patient."
                    );
                }


                if (!"Scheduled"
                        .equalsIgnoreCase(
                                appointmentStatus
                        )) {

                    throw new IllegalArgumentException(
                            "Only scheduled appointments "
                            + "can be billed."
                    );
                }


                // ---------------------------------------------
                // CREATE BILL JSON
                // ---------------------------------------------

                JsonObject bill =
                        new JsonObject();


                bill.addProperty(
                        "patientId",
                        patientId
                );


                bill.addProperty(
                        "appointmentId",
                        appointmentId
                );


                bill.addProperty(
                        "treatmentId",
                        treatmentId
                );


                bill.addProperty(
                        "consultationFee",
                        consultationFee
                );


                String result =
                        RestClient.post(
                                "bills",
                                bill.toString()
                        );


                req.setAttribute(
                        "billResult",
                        result
                );


                req.setAttribute(
                        "success",
                        "Bill created successfully. "
                        + "Please receive payment "
                        + "before completing the appointment."
                );
            }


            // =================================================
            // PAY BILL
            // =================================================
            else if ("pay".equals(action)) {


                String billIdStr =
                        req.getParameter(
                                "billId"
                        );


                String appointmentIdStr =
                        req.getParameter(
                                "appointmentId"
                        );


                if (billIdStr == null
                        || billIdStr.isBlank()) {

                    throw new IllegalArgumentException(
                            "Bill ID is missing."
                    );
                }


                if (appointmentIdStr == null
                        || appointmentIdStr.isBlank()) {

                    throw new IllegalArgumentException(
                            "Appointment ID is missing."
                    );
                }


                int billId =
                        Integer.parseInt(
                                billIdStr
                        );


                int appointmentId =
                        Integer.parseInt(
                                appointmentIdStr
                        );


                // ---------------------------------------------
                // 1. MARK BILL AS PAID
                // ---------------------------------------------

                String paidBill =
                        RestClient.put(
                                "bills/"
                                        + billId
                                        + "/pay",
                                "{}"
                        );


                // ---------------------------------------------
                // 2. MARK APPOINTMENT COMPLETED
                // ---------------------------------------------

                RestClient.put(
                        "appointments/"
                                + appointmentId
                                + "/complete",
                        "{}"
                );


                req.setAttribute(
                        "billResult",
                        paidBill
                );


                req.setAttribute(
                        "success",
                        "Payment completed successfully. "
                        + "The appointment has been marked "
                        + "as Completed."
                );
            }


            else {

                throw new IllegalArgumentException(
                        "Invalid billing action."
                );
            }


        } catch (Exception e) {

            e.printStackTrace();

            req.setAttribute(
                    "error",
                    e.getMessage()
            );
        }


        loadData(req);


        req.getRequestDispatcher(
                "/bill.jsp"
        ).forward(req, resp);
    }


    // =========================================================
    // LOAD BILL PAGE DATA
    // =========================================================
    private void loadData(
            HttpServletRequest req) {


        try {


            req.setAttribute(
                    "patientsJson",
                    RestClient.get(
                            "patients"
                    )
            );


            req.setAttribute(
                    "appointmentsJson",
                    RestClient.get(
                            "appointments"
                    )
            );


            req.setAttribute(
                    "treatmentsJson",
                    RestClient.get(
                            "treatments"
                    )
            );


            req.setAttribute(
                    "billsJson",
                    RestClient.get(
                            "bills"
                    )
            );


        } catch (Exception e) {


            e.printStackTrace();


            req.setAttribute(
                    "error",
                    "Unable to load billing information: "
                            + e.getMessage()
            );
        }
    }
}