package sunrise.dental.service.api;

import sunrise.dental.service.dao.TreatmentDAO;
import sunrise.dental.service.dto.TreatmentDTO;

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


@Path("/treatments")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class TreatmentResource {


    private final TreatmentDAO dao =
            new TreatmentDAO();


    // =========================================================
    // GET ALL TREATMENTS
    // =========================================================
    @GET
    public List<TreatmentDTO> getAllTreatments()
            throws Exception {

        System.out.println(
                "GET /api/treatments called"
        );

        return dao.findAll();
    }


    // =========================================================
    // GET TREATMENT BY ID
    // =========================================================
    @GET
    @Path("/{id}")
    public TreatmentDTO getTreatmentById(
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


    // =========================================================
    // CREATE TREATMENT
    // =========================================================
    @POST
    public Response createTreatment(
            TreatmentDTO treatment)
            throws Exception {

        System.out.println(
                "POST /api/treatments called"
        );


        System.out.println(
                "Treatment Name: "
                        + treatment.treatmentName
        );


        System.out.println(
                "Description: "
                        + treatment.description
        );


        System.out.println(
                "Price: "
                        + treatment.price
        );


        // Validation
        if (treatment.treatmentName == null
                || treatment.treatmentName.isBlank()) {

            return Response
                    .status(
                            Response.Status.BAD_REQUEST
                    )
                    .entity(
                            "Treatment name is required"
                    )
                    .build();
        }


        if (treatment.price <= 0) {

            return Response
                    .status(
                            Response.Status.BAD_REQUEST
                    )
                    .entity(
                            "Treatment price must be greater than 0"
                    )
                    .build();
        }


        TreatmentDTO created =
                dao.create(treatment);


        System.out.println(
                "Treatment successfully created"
        );


        return Response
                .status(
                        Response.Status.CREATED
                )
                .entity(created)
                .build();
    }


    // =========================================================
    // UPDATE TREATMENT
    // =========================================================
    @PUT
    @Path("/{id}")
    public Response updateTreatment(
            @PathParam("id") int id,
            TreatmentDTO treatment)
            throws Exception {

        boolean updated =
                dao.update(
                        id,
                        treatment
                );


        if (!updated) {

            throw new NotFoundException(
                    "Treatment not found"
            );
        }


        return Response
                .ok()
                .entity(
                        "Treatment updated successfully"
                )
                .build();
    }


    // =========================================================
    // DELETE TREATMENT
    // =========================================================
    @DELETE
    @Path("/{id}")
    public Response deleteTreatment(
            @PathParam("id") int id)
            throws Exception {

        boolean deleted =
                dao.delete(id);


        if (!deleted) {

            throw new NotFoundException(
                    "Treatment not found"
            );
        }


        return Response
                .noContent()
                .build();
    }
}