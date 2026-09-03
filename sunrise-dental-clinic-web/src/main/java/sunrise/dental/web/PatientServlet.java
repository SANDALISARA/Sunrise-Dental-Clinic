package sunrise.dental.web;

import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "PatientServlet", urlPatterns = {"/patients"})
public class PatientServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        String json = RestClient.get("patients");

        req.setAttribute("json", json);

        req.getRequestDispatcher("patients.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        System.out.println("Patient action = " + action);

        if ("create".equals(action)) {

            JsonObject patient = new JsonObject();

            patient.addProperty(
                    "patientName",
                    req.getParameter("patientName")
            );

            patient.addProperty(
                    "dateOfBirth",
                    req.getParameter("dateOfBirth")
            );

            patient.addProperty(
                    "gender",
                    req.getParameter("gender")
            );

            patient.addProperty(
                    "address",
                    req.getParameter("address")
            );

            patient.addProperty(
                    "phone",
                    req.getParameter("phone")
            );

            patient.addProperty(
                    "email",
                    req.getParameter("email")
            );

            patient.addProperty(
                    "medicalHistory",
                    req.getParameter("medicalHistory")
            );

            System.out.println(
                    "Sending patient JSON: "
                    + patient
            );

            String result = RestClient.post(
                    "patients",
                    patient.toString()
            );

            System.out.println(
                    "REST response: "
                    + result
            );
        }

        resp.sendRedirect("patients");
    }
}