package sunrise.dental.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "ReportsServlet", urlPatterns = {"/reports"})
public class ReportsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        String type = req.getParameter("type");

        if (type == null || type.isEmpty()) {
            type = "appointments";
        }

        String json;

        switch (type) {

            case "patients":
                json = RestClient.get("patients");
                break;

            case "dentists":
                json = RestClient.get("dentists");
                break;

            case "treatments":
                json = RestClient.get("treatments");
                break;

            case "bills":
                json = RestClient.get("bills");
                break;

            case "appointments":
            default:
                json = RestClient.get("appointments");
                break;
        }

        req.setAttribute("json", json);
        req.setAttribute("reportType", type);

        req.getRequestDispatcher("reports.jsp")
                .forward(req, resp);
    }
}