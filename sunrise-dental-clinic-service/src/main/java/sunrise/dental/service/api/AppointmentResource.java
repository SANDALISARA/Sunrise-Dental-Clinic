package sunrise.dental.service.api;

import sunrise.dental.service.dao.AppointmentDAO;
import sunrise.dental.service.dto.AppointmentDTO;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.NotFoundException;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;

import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.List;

@Path("/appointments")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class AppointmentResource {

    private final AppointmentDAO dao =
            new AppointmentDAO();


    @GET
    public List<AppointmentDTO> getAllAppointments()
            throws Exception {

        System.out.println(
                "GET /api/appointments called"
        );

        return dao.findAll();
    }


    @GET
    @Path("/{id}")
    public AppointmentDTO getAppointmentById(
            @PathParam("id") int id)
            throws Exception {

        AppointmentDTO appointment =
                dao.findById(id);

        if (appointment == null) {

            throw new NotFoundException(
                    "Appointment not found"
            );
        }

        return appointment;
    }


    @POST
    public Response createAppointment(
            AppointmentDTO appointment)
            throws Exception {

        System.out.println(
                "POST /api/appointments called"
        );

        System.out.println(
                "Patient ID: "
                        + appointment.patientId
        );

        System.out.println(
                "Dentist ID: "
                        + appointment.dentistId
        );

        System.out.println(
                "Date: "
                        + appointment.appointmentDate
        );

        System.out.println(
                "Time: "
                        + appointment.appointmentTime
        );

        System.out.println(
                "Reason: "
                        + appointment.reason
        );


        if (appointment.patientId <= 0) {

            return Response
                    .status(
                            Response.Status.BAD_REQUEST
                    )
                    .entity(
                            "Valid patient ID is required"
                    )
                    .build();
        }


        if (appointment.dentistId <= 0) {

            return Response
                    .status(
                            Response.Status.BAD_REQUEST
                    )
                    .entity(
                            "Valid dentist ID is required"
                    )
                    .build();
        }


        AppointmentDTO created =
                dao.create(appointment);


        return Response
                .status(
                        Response.Status.CREATED
                )
                .entity(created)
                .build();
    }


    @PUT
    @Path("/{id}")
    public Response updateAppointment(
            @PathParam("id") int id,
            AppointmentDTO appointment)
            throws Exception {

        if (!dao.update(
                id,
                appointment)) {

            throw new NotFoundException(
                    "Appointment not found"
            );
        }

        return Response
                .ok()
                .build();
    }


    @PUT
    @Path("/{id}/cancel")
    public Response cancelAppointment(
            @PathParam("id") int id)
            throws Exception {

        if (!dao.cancel(id)) {

            throw new NotFoundException(
                    "Appointment not found"
            );
        }

        return Response
                .ok()
                .entity(
                        "Appointment cancelled"
                )
                .build();
    }


    @DELETE
    @Path("/{id}")
    public Response deleteAppointment(
            @PathParam("id") int id)
            throws Exception {

        if (!dao.delete(id)) {

            throw new NotFoundException(
                    "Appointment not found"
            );
        }

        return Response
                .noContent()
                .build();
    }
}