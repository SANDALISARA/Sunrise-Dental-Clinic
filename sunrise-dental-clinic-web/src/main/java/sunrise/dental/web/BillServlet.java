package sunrise.dental.web;

import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "BillServlet", urlPatterns = {"/bill"})
public class BillServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("bill.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req,
                           HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        JsonObject bill = new JsonObject();

        try {

            bill.addProperty(
                    "patientId",
                    Integer.parseInt(
                            req.getParameter("patientId")
                    )
            );

            bill.addProperty(
                    "appointmentId",
                    Integer.parseInt(
                            req.getParameter("appointmentId")
                    )
            );

        } catch (NumberFormatException e) {

            bill.addProperty("patientId", 0);
            bill.addProperty("appointmentId", 0);
        }

        double consultationFee = 0;
        double treatmentFee = 0;

        try {

            consultationFee = Double.parseDouble(
                    req.getParameter("consultationFee")
            );

        } catch (Exception ignored) {
        }

        try {

            treatmentFee = Double.parseDouble(
                    req.getParameter("treatmentFee")
            );

        } catch (Exception ignored) {
        }

        double total = consultationFee + treatmentFee;

        bill.addProperty(
                "consultationFee",
                consultationFee
        );

        bill.addProperty(
                "treatmentFee",
                treatmentFee
        );

        bill.addProperty(
                "totalAmount",
                total
        );

        String json = RestClient.post(
                "bills",
                bill.toString()
        );

        req.setAttribute("json", json);

        req.getRequestDispatcher("bill.jsp")
                .forward(req, resp);
    }
}