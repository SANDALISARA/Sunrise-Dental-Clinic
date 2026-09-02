package sunrise.dental.web;

import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "TreatmentServlet", urlPatterns = {"/treatments"})
public class TreatmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        String json = RestClient.get("treatments");

        req.setAttribute("json", json);

        req.getRequestDispatcher("treatments.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req,
                           HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        if ("create".equals(action)) {

            JsonObject treatment = new JsonObject();

            treatment.addProperty(
                    "treatmentName",
                    req.getParameter("treatmentName")
            );

            treatment.addProperty(
                    "description",
                    req.getParameter("description")
            );

            try {

                double price = Double.parseDouble(
                        req.getParameter("price")
                );

                treatment.addProperty("price", price);

            } catch (NumberFormatException e) {

                treatment.addProperty("price", 0.0);
            }

            RestClient.post(
                    "treatments",
                    treatment.toString()
            );
        }

        resp.sendRedirect("treatments");
    }
}