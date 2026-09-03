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

import java.util.List;

@Path("/patients")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class PatientResource {

    private final PatientDAO dao =
            new PatientDAO();


    // =========================================================
    // GET ALL PATIENTS
    // URL: GET /api/patients
    // =========================================================
    @GET
    public List<PatientDTO> getAllPatients()
            throws Exception {

        System.out.println(
                "GET /api/patients called"
        );

        return dao.findAll();
    }


    // =========================================================
    // GET PATIENT BY ID
    // URL: GET /api/patients/1
    // =========================================================
    @GET
    @Path("/{id}")
    public PatientDTO getPatientById(
            @PathParam("id") int id)
            throws Exception {

        System.out.println(
                "GET /api/patients/" + id
        );

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
    // CREATE / REGISTER PATIENT
    // URL: POST /api/patients
    // =========================================================
    @POST
    public Response createPatient(
            PatientDTO patient)
            throws Exception {

        System.out.println(
                "POST /api/patients called"
        );

        System.out.println(
                "Patient Name: "
                        + patient.patientName
        );

        System.out.println(
                "Date of Birth: "
                        + patient.dateOfBirth
        );

        System.out.println(
                "Gender: "
                        + patient.gender
        );

        System.out.println(
                "Address: "
                        + patient.address
        );

        System.out.println(
                "Phone: "
                        + patient.phone
        );

        System.out.println(
                "Email: "
                        + patient.email
        );

        System.out.println(
                "Medical History: "
                        + patient.medicalHistory
        );


        // Basic validation
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


        PatientDTO createdPatient =
                dao.create(patient);


        System.out.println(
                "Patient successfully created"
        );

        System.out.println(
                "New Patient ID: "
                        + createdPatient.id
        );

        System.out.println(
                "Patient Number: "
                        + createdPatient.patientNumber
        );


        return Response
                .status(
                        Response.Status.CREATED
                )
                .entity(createdPatient)
                .build();
    }


    // =========================================================
    // UPDATE PATIENT
    // URL: PUT /api/patients/1
    // =========================================================
    @PUT
    @Path("/{id}")
    public Response updatePatient(
            @PathParam("id") int id,
            PatientDTO patient)
            throws Exception {

        System.out.println(
                "PUT /api/patients/" + id
        );

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
                        "Patient updated successfully"
                )
                .build();
    }


    // =========================================================
    // DELETE PATIENT
    // URL: DELETE /api/patients/1
    // =========================================================
    @DELETE
    @Path("/{id}")
    public Response deletePatient(
            @PathParam("id") int id)
            throws Exception {

        System.out.println(
                "DELETE /api/patients/" + id
        );

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