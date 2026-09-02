package sunrise.dental.service.api;

import sunrise.dental.service.dao.PatientDAO;
import sunrise.dental.service.dto.PatientDTO;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.List;

@Path("/patients")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class PatientResource {

    private final PatientDAO dao =
            new PatientDAO();

    @GET
    public List<PatientDTO> all()
            throws Exception {

        return dao.findAll();
    }

    @GET
    @Path("/{id}")
    public PatientDTO byId(
            @PathParam("id") int id)
            throws Exception {

        PatientDTO patient =
                dao.findById(id);

        if (patient == null) {
            throw new NotFoundException(
                    "Patient not found"
            );
        }

        return patient;
    }

    @POST
    public Response create(PatientDTO patient)
            throws Exception {

        PatientDTO created =
                dao.create(patient);

        return Response
                .status(Response.Status.CREATED)
                .entity(created)
                .build();
    }

    @PUT
    @Path("/{id}")
    public Response update(
            @PathParam("id") int id,
            PatientDTO patient)
            throws Exception {

        boolean updated =
                dao.update(id, patient);

        if (!updated) {
            throw new NotFoundException(
                    "Patient not found"
            );
        }

        return Response.ok().build();
    }

    @DELETE
    @Path("/{id}")
    public Response delete(
            @PathParam("id") int id)
            throws Exception {

        boolean deleted =
                dao.delete(id);

        if (!deleted) {
            throw new NotFoundException(
                    "Patient not found"
            );
        }

        return Response
                .noContent()
                .build();
    }
}