package sunrise.dental.web;

import com.google.gson.JsonObject;

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
public class BillServlet extends HttpServlet {

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


    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action =
                req.getParameter("action");

        try {

            // ======================================
            // CREATE BILL
            // ======================================
            if ("create".equals(action)) {

                String patientIdStr =
                        req.getParameter("patientId");

                String appointmentIdStr =
                        req.getParameter("appointmentId");

                String treatmentIdStr =
                        req.getParameter("treatmentId");

                String consultationFeeStr =
                        req.getParameter("consultationFee");


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
                        Integer.parseInt(patientIdStr);

                int appointmentId =
                        Integer.parseInt(appointmentIdStr);

                int treatmentId =
                        Integer.parseInt(treatmentIdStr);

                double consultationFee =
                        Double.parseDouble(
                                consultationFeeStr
                        );


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


                System.out.println(
                        "Sending Bill JSON: "
                                + bill
                );


                String result =
                        RestClient.post(
                                "bills",
                                bill.toString()
                        );


                System.out.println(
                        "Bill REST response: "
                                + result
                );


                req.setAttribute(
                        "billResult",
                        result
                );
            }


            // ======================================
            // PAY BILL
            // ======================================
            else if ("pay".equals(action)) {

                String billIdStr =
                        req.getParameter("billId");


                if (billIdStr == null
                        || billIdStr.isBlank()) {

                    throw new IllegalArgumentException(
                            "Bill ID is missing."
                    );
                }


                int billId =
                        Integer.parseInt(
                                billIdStr
                        );


                String result =
                        RestClient.put(
                                "bills/"
                                        + billId
                                        + "/pay",
                                "{}"
                        );


                req.setAttribute(
                        "billResult",
                        result
                );


                req.setAttribute(
                        "success",
                        "Payment completed successfully."
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
                    "Unable to load billing data: "
                            + e.getMessage()
            );
        }
    }
}