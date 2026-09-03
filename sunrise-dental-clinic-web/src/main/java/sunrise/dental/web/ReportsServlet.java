package sunrise.dental.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet(
        name = "ReportsServlet",
        urlPatterns = {"/reports"}
)
public class ReportsServlet
        extends HttpServlet {


    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {


        String type =
                req.getParameter(
                        "type"
                );


        if (type == null) {

            type =
                    "daily-appointments";
        }


        String json;


        switch (type) {


            case "patients":

                json =
                        RestClient.get(
                                "patients"
                        );

                break;


            case "treatments":

                json =
                        RestClient.get(
                                "treatments"
                        );

                break;


            case "income":

                json =
                        RestClient.get(
                                "bills"
                        );

                break;


            case "dentist-appointments":

                json =
                        RestClient.get(
                                "appointments"
                        );

                break;


            case "daily-appointments":

            default:

                json =
                        RestClient.get(
                                "appointments"
                        );

                break;
        }


        req.setAttribute(
                "type",
                type
        );


        req.setAttribute(
                "json",
                json
        );


        req.getRequestDispatcher(
                "/reports.jsp"
        ).forward(req, resp);
    }
}