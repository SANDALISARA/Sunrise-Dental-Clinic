package sunrise.dental.web;

import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

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

        if ("create".equals(action)) {

            JsonObject patient = new JsonObject();

            patient.addProperty(
                    "patientName",
                    req.getParameter("patientName")
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
                    "dateOfBirth",
                    req.getParameter("dateOfBirth")
            );

            patient.addProperty(
                    "medicalHistory",
                    req.getParameter("medicalHistory")
            );

            RestClient.post(
                    "patients",
                    patient.toString()
            );
        }

        resp.sendRedirect("patients");
    }
}