package sunrise.dental.service.api;

import sunrise.dental.service.dao.AppointmentDAO;
import sunrise.dental.service.dto.AppointmentDTO;

import jakarta.ws.rs.*;
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
    public List<AppointmentDTO> all()
            throws Exception {

        return dao.findAll();
    }

    @GET
    @Path("/{id}")
    public AppointmentDTO byId(
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
    public Response create(
            AppointmentDTO appointment)
            throws Exception {

        return Response
                .status(Response.Status.CREATED)
                .entity(
                        dao.create(appointment)
                )
                .build();
    }

    @PUT
    @Path("/{id}")
    public Response update(
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

        return Response.ok().build();
    }

    @PUT
    @Path("/{id}/cancel")
    public Response cancel(
            @PathParam("id") int id)
            throws Exception {

        if (!dao.cancel(id)) {

            throw new NotFoundException(
                    "Appointment not found"
            );
        }

        return Response.ok().build();
    }

    @DELETE
    @Path("/{id}")
    public Response delete(
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