package sunrise.dental.service.api;

import sunrise.dental.service.dao.AppointmentDAO;
import sunrise.dental.service.dto.AppointmentDTO;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.NotFoundException;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;

import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.time.LocalTime;
import java.util.List;


@Path("/appointments")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class AppointmentResource {


    private final AppointmentDAO dao =
            new AppointmentDAO();


    // =========================================================
    // GET ALL
    // =========================================================
    @GET
    public List<AppointmentDTO> getAllAppointments()
            throws Exception {

        return dao.findAll();
    }


    // =========================================================
    // GET ONE
    // =========================================================
    @GET
    @Path("/{id}")
    public AppointmentDTO getAppointment(
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


    // =========================================================
    // CREATE
    // =========================================================
    @POST
    public Response createAppointment(
            AppointmentDTO appointment)
            throws Exception {


        String validation =
                validateAppointment(
                        appointment
                );


        if (validation != null) {

            return Response
                    .status(
                            Response.Status.BAD_REQUEST
                    )
                    .entity(validation)
                    .build();
        }


        try {


            AppointmentDTO created =
                    dao.create(
                            appointment
                    );


            return Response
                    .status(
                            Response.Status.CREATED
                    )
                    .entity(created)
                    .build();


        } catch (IllegalStateException e) {


            return Response
                    .status(
                            Response.Status.CONFLICT
                    )
                    .entity(
                            e.getMessage()
                    )
                    .build();
        }
    }


    // =========================================================
// COMPLETE APPOINTMENT
// =========================================================
@PUT
@Path("/{id}/complete")
public Response completeAppointment(
        @PathParam("id") int id)
        throws Exception {

    boolean completed =
            dao.complete(id);

    if (!completed) {

        return Response
                .status(Response.Status.NOT_FOUND)
                .entity(
                    "Appointment not found or "
                    + "cannot be completed."
                )
                .build();
    }

    return Response
            .ok(
                dao.findById(id)
            )
            .build();
}
    
    
    // =========================================================
    // UPDATE
    // =========================================================
    @PUT
    @Path("/{id}")
    public Response updateAppointment(
            @PathParam("id") int id,
            AppointmentDTO appointment)
            throws Exception {


        String validation =
                validateAppointment(
                        appointment
                );


        if (validation != null) {

            return Response
                    .status(
                            Response.Status.BAD_REQUEST
                    )
                    .entity(validation)
                    .build();
        }


        try {


            boolean updated =
                    dao.update(
                            id,
                            appointment
                    );


            if (!updated) {

                throw new NotFoundException(
                        "Appointment not found"
                );
            }


            return Response
                    .ok(
                            dao.findById(id)
                    )
                    .build();


        } catch (IllegalStateException e) {


            return Response
                    .status(
                            Response.Status.CONFLICT
                    )
                    .entity(
                            e.getMessage()
                    )
                    .build();
        }
    }


    // =========================================================
    // CANCEL
    // =========================================================
    @PUT
    @Path("/{id}/cancel")
    public Response cancelAppointment(
            @PathParam("id") int id)
            throws Exception {


        boolean cancelled =
                dao.cancel(id);


        if (!cancelled) {

            throw new NotFoundException(
                    "Appointment not found"
            );
        }


        return Response
                .ok(
                        dao.findById(id)
                )
                .build();
    }


    // =========================================================
    // VALIDATION
    // =========================================================
    private String validateAppointment(
            AppointmentDTO appointment) {


        if (appointment == null) {

            return "Appointment information is required.";
        }


        if (appointment.patientId <= 0) {

            return "Please select a patient.";
        }


        if (appointment.dentistId <= 0) {

            return "Please select a dentist.";
        }


        if (appointment.appointmentDate == null
                || appointment.appointmentDate.isBlank()) {

            return "Please select an appointment date.";
        }


        if (appointment.appointmentTime == null
                || appointment.appointmentTime.isBlank()) {

            return "Please select an appointment time.";
        }


        try {


            LocalTime time =
                    LocalTime.parse(
                            appointment.appointmentTime
                                    .substring(0, 5)
                    );


            LocalTime opening =
                    LocalTime.of(
                            9,
                            0
                    );


            // Last 30 minute appointment starts at 17:30
            LocalTime lastSlot =
                    LocalTime.of(
                            17,
                            30
                    );


            if (time.isBefore(opening)
                    || time.isAfter(lastSlot)) {

                return "Appointment time must be between "
                        + "9:00 AM and 5:30 PM.";
            }


            if (time.getMinute() != 0
                    && time.getMinute() != 30) {

                return "Appointments must use 30-minute time slots.";
            }


        } catch (Exception e) {

            return "Invalid appointment time.";
        }


        if (appointment.status == null
                || appointment.status.isBlank()) {

            appointment.status =
                    "Scheduled";
        }


        return null;
    }
}