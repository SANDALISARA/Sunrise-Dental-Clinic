package sunrise.dental.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(
        name = "LoginServlet",
        urlPatterns = {"/login"}
)
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String username =
                req.getParameter("username");

        String password =
                req.getParameter("password");

        String role = null;


        // Administrator
        if ("admin".equals(username)
                && "admin123".equals(password)) {

            role = "Administrator";
        }


        // Receptionist
        else if ("reception".equals(username)
                && "reception123".equals(password)) {

            role = "Receptionist";
        }


        // Dentist
        else if ("dentist".equals(username)
                && "dentist123".equals(password)) {

            role = "Dentist";
        }


        if (role != null) {

            HttpSession session =
                    req.getSession(true);

            session.setAttribute(
                    "user",
                    username
            );

            session.setAttribute(
                    "role",
                    role
            );

            resp.sendRedirect(
                    "dashboard.jsp"
            );

        } else {

            req.setAttribute(
                    "error",
                    "Invalid user account or password."
            );

            req.getRequestDispatcher(
                    "index.jsp"
            ).forward(req, resp);
        }
    }
}