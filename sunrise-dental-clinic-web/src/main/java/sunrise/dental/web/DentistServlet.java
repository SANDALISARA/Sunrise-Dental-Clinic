package sunrise.dental.web;

import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet(
        name = "DentistServlet",
        urlPatterns = {"/dentists"}
)
public class DentistServlet
        extends HttpServlet {


    // =========================================================
    // DISPLAY DENTISTS
    // =========================================================
    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {


        try {


            String json =
                    RestClient.get(
                            "dentists"
                    );


            req.setAttribute(
                    "json",
                    json
            );


        } catch (Exception e) {


            e.printStackTrace();


            req.setAttribute(
                    "error",
                    "Unable to load dentist information."
            );
        }


        req.getRequestDispatcher(
                "/dentists.jsp"
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


                JsonObject dentist =
                        createDentistJson(
                                req
                        );


                String result =
                        RestClient.post(
                                "dentists",
                                dentist.toString()
                        );


                System.out.println(
                        "Dentist Create Response: "
                                + result
                );
            }


            // =================================================
            // UPDATE
            // =================================================
            else if ("update".equals(action)) {


                String dentistId =
                        req.getParameter(
                                "dentistId"
                        );


                if (dentistId == null
                        || dentistId.isBlank()) {

                    throw new IllegalArgumentException(
                            "Dentist ID is missing."
                    );
                }


                JsonObject dentist =
                        createDentistJson(
                                req
                        );


                String result =
                        RestClient.put(
                                "dentists/"
                                        + dentistId,
                                dentist.toString()
                        );


                System.out.println(
                        "Dentist Update Response: "
                                + result
                );
            }


            // =================================================
            // DELETE
            // =================================================
            else if ("delete".equals(action)) {


                String dentistId =
                        req.getParameter(
                                "dentistId"
                        );


                if (dentistId == null
                        || dentistId.isBlank()) {

                    throw new IllegalArgumentException(
                            "Dentist ID is missing."
                    );
                }


                String result =
                        RestClient.delete(
                                "dentists/"
                                        + dentistId
                        );


                System.out.println(
                        "Dentist Delete Response: "
                                + result
                );
            }


        } catch (Exception e) {


            e.printStackTrace();


            System.out.println(
                    "Dentist operation error: "
                            + e.getMessage()
            );
        }


        resp.sendRedirect(
                req.getContextPath()
                        + "/dentists"
        );
    }


    // =========================================================
    // CREATE DENTIST JSON
    // =========================================================
    private JsonObject createDentistJson(
            HttpServletRequest req) {


        JsonObject dentist =
                new JsonObject();


        dentist.addProperty(
                "dentistName",
                req.getParameter(
                        "dentistName"
                )
        );


        dentist.addProperty(
                "specialization",
                req.getParameter(
                        "specialization"
                )
        );


        dentist.addProperty(
                "phone",
                req.getParameter(
                        "phone"
                )
        );


        dentist.addProperty(
                "email",
                req.getParameter(
                        "email"
                )
        );


        return dentist;
    }
}