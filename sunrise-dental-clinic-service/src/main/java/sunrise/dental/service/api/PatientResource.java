package sunrise.dental.service.api;

import sunrise.dental.service.dao.PatientDAO;
import sunrise.dental.service.dto.PatientDTO;

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

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;


@Path("/patients")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class PatientResource {


    private final PatientDAO dao =
            new PatientDAO();


    // =========================================================
    // GET ALL PATIENTS
    // =========================================================
    @GET
    public List<PatientDTO> getAllPatients()
            throws Exception {

        return dao.findAll();
    }


    // =========================================================
    // GET PATIENT BY ID
    // =========================================================
    @GET
    @Path("/{id}")
    public PatientDTO getPatient(
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


    // =========================================================
    // CREATE PATIENT
    // =========================================================
    @POST
    public Response createPatient(
            PatientDTO patient)
            throws Exception {


        if (patient == null) {

            return Response
                    .status(
                            Response.Status.BAD_REQUEST
                    )
                    .entity(
                            "Patient information is required"
                    )
                    .build();
        }


        if (patient.patientName == null
                || patient.patientName.isBlank()) {

            return Response
                    .status(
                            Response.Status.BAD_REQUEST
                    )
                    .entity(
                            "Patient name is required"
                    )
                    .build();
        }


        PatientDTO created =
                dao.create(patient);


        return Response
                .status(
                        Response.Status.CREATED
                )
                .entity(created)
                .build();
    }


    // =========================================================
    // UPDATE PATIENT
    // =========================================================
    @PUT
    @Path("/{id}")
    public Response updatePatient(
            @PathParam("id") int id,
            PatientDTO patient)
            throws Exception {


        if (patient == null) {

            return Response
                    .status(
                            Response.Status.BAD_REQUEST
                    )
                    .entity(
                            "Patient information is required"
                    )
                    .build();
        }


        if (patient.patientName == null
                || patient.patientName.isBlank()) {

            return Response
                    .status(
                            Response.Status.BAD_REQUEST
                    )
                    .entity(
                            "Patient name is required"
                    )
                    .build();
        }


        boolean updated =
                dao.update(
                        id,
                        patient
                );


        if (!updated) {

            throw new NotFoundException(
                    "Patient not found"
            );
        }


        return Response
                .ok()
                .entity(
                        dao.findById(id)
                )
                .build();
    }


    // =========================================================
    // DELETE PATIENT
    // =========================================================
    @DELETE
    @Path("/{id}")
    public Response deletePatient(
            @PathParam("id") int id)
            throws Exception {


        try {


            boolean deleted =
                    dao.delete(id);


            if (!deleted) {

                throw new NotFoundException(
                        "Patient not found"
                );
            }


            return Response
                    .ok()
                    .entity(
                            "Patient deleted successfully"
                    )
                    .build();


        } catch (
                SQLIntegrityConstraintViolationException e) {


            return Response
                    .status(
                            Response.Status.CONFLICT
                    )
                    .entity(
                            "Patient cannot be deleted because "
                            + "appointment or billing records "
                            + "are linked to this patient."
                    )
                    .build();
        }
    }
}