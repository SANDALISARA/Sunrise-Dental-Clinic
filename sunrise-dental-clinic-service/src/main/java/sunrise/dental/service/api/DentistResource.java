package sunrise.dental.service.api;

import sunrise.dental.service.dao.DentistDAO;
import sunrise.dental.service.dto.DentistDTO;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.List;

@Path("/dentists")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class DentistResource {

    private final DentistDAO dao =
            new DentistDAO();

    @GET
    public List<DentistDTO> all()
            throws Exception {

        return dao.findAll();
    }

    @GET
    @Path("/{id}")
    public DentistDTO byId(
            @PathParam("id") int id)
            throws Exception {

        DentistDTO dentist =
                dao.findById(id);

        if (dentist == null) {
            throw new NotFoundException(
                    "Dentist not found"
            );
        }

        return dentist;
    }

    @POST
    public Response create(
            DentistDTO dentist)
            throws Exception {

        return Response
                .status(Response.Status.CREATED)
                .entity(dao.create(dentist))
                .build();
    }

    @PUT
    @Path("/{id}")
    public Response update(
            @PathParam("id") int id,
            DentistDTO dentist)
            throws Exception {

        if (!dao.update(id, dentist)) {

            throw new NotFoundException(
                    "Dentist not found"
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
                    "Dentist not found"
            );
        }

        return Response
                .noContent()
                .build();
    }
}