package sunrise.dental.service.api;

import sunrise.dental.service.dao.TreatmentDAO;
import sunrise.dental.service.dto.TreatmentDTO;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.List;

@Path("/treatments")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class TreatmentResource {

    private final TreatmentDAO dao =
            new TreatmentDAO();

    @GET
    public List<TreatmentDTO> all()
            throws Exception {

        return dao.findAll();
    }

    @GET
    @Path("/{id}")
    public TreatmentDTO byId(
            @PathParam("id") int id)
            throws Exception {

        TreatmentDTO treatment =
                dao.findById(id);

        if (treatment == null) {

            throw new NotFoundException(
                    "Treatment not found"
            );
        }

        return treatment;
    }

    @POST
    public Response create(
            TreatmentDTO treatment)
            throws Exception {

        return Response
                .status(Response.Status.CREATED)
                .entity(
                        dao.create(treatment)
                )
                .build();
    }

    @PUT
    @Path("/{id}")
    public Response update(
            @PathParam("id") int id,
            TreatmentDTO treatment)
            throws Exception {

        if (!dao.update(id, treatment)) {

            throw new NotFoundException(
                    "Treatment not found"
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
                    "Treatment not found"
            );
        }

        return Response
                .noContent()
                .build();
    }
}