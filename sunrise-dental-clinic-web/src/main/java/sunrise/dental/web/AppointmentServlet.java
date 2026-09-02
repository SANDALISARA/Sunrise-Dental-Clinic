package sunrise.dental.web;

import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(
        name = "AppointmentServlet",
        urlPatterns = {"/appointments"}
)
public class AppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        String json = RestClient.get("appointments");

        req.setAttribute("json", json);

        req.getRequestDispatcher("appointments.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req,
                           HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        if ("create".equals(action)) {

            JsonObject appointment = new JsonObject();

            try {

                appointment.addProperty(
                        "patientId",
                        Integer.parseInt(
                                req.getParameter("patientId")
                        )
                );

                appointment.addProperty(
                        "dentistId",
                        Integer.parseInt(
                                req.getParameter("dentistId")
                        )
                );

            } catch (NumberFormatException e) {

                appointment.addProperty(
                        "patientId",
                        0
                );

                appointment.addProperty(
                        "dentistId",
                        0
                );
            }

            appointment.addProperty(
                    "appointmentDate",
                    req.getParameter("appointmentDate")
            );

            appointment.addProperty(
                    "appointmentTime",
                    req.getParameter("appointmentTime")
            );

            appointment.addProperty(
                    "reason",
                    req.getParameter("reason")
            );

            appointment.addProperty(
                    "status",
                    "Scheduled"
            );

            RestClient.post(
                    "appointments",
                    appointment.toString()
            );
        }

        else if ("update".equals(action)) {

            String id = req.getParameter("appointmentId");

            JsonObject appointment = new JsonObject();

            appointment.addProperty(
                    "appointmentDate",
                    req.getParameter("appointmentDate")
            );

            appointment.addProperty(
                    "appointmentTime",
                    req.getParameter("appointmentTime")
            );

            appointment.addProperty(
                    "status",
                    req.getParameter("status")
            );

            RestClient.put(
                    "appointments/" + id,
                    appointment.toString()
            );
        }

        else if ("cancel".equals(action)) {

            String id = req.getParameter("appointmentId");

            JsonObject appointment = new JsonObject();

            appointment.addProperty(
                    "status",
                    "Cancelled"
            );

            RestClient.put(
                    "appointments/" + id,
                    appointment.toString()
            );
        }

        resp.sendRedirect("appointments");
    }
}