package sunrise.dental.web;

import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "DentistServlet", urlPatterns = {"/dentists"})
public class DentistServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        String json = RestClient.get("dentists");

        req.setAttribute("json", json);

        req.getRequestDispatcher("dentists.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req,
                           HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        if ("create".equals(action)) {

            JsonObject dentist = new JsonObject();

            dentist.addProperty(
                    "dentistName",
                    req.getParameter("dentistName")
            );

            dentist.addProperty(
                    "specialization",
                    req.getParameter("specialization")
            );

            dentist.addProperty(
                    "phone",
                    req.getParameter("phone")
            );

            dentist.addProperty(
                    "email",
                    req.getParameter("email")
            );

            RestClient.post(
                    "dentists",
                    dentist.toString()
            );
        }

        resp.sendRedirect("dentists");
    }
}