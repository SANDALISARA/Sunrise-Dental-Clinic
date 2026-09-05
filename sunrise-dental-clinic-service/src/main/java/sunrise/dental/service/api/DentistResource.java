package sunrise.dental.service.api;

import sunrise.dental.service.dao.DentistDAO;
import sunrise.dental.service.dto.DentistDTO;

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


@Path("/dentists")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class DentistResource {


    private final DentistDAO dao =
            new DentistDAO();


    // =========================================================
    // GET ALL DENTISTS
    // =========================================================
    @GET
    public List<DentistDTO> getAllDentists()
            throws Exception {

        return dao.findAll();
    }


    // =========================================================
    // GET DENTIST BY ID
    // =========================================================
    @GET
    @Path("/{id}")
    public DentistDTO getDentist(
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


    // =========================================================
    // CREATE DENTIST
    // =========================================================
    @POST
    public Response createDentist(
            DentistDTO dentist)
            throws Exception {


        if (dentist == null) {

            return Response
                    .status(
                            Response.Status.BAD_REQUEST
                    )
                    .entity(
                            "Dentist information is required"
                    )
                    .build();
        }


        if (dentist.dentistName == null
                || dentist.dentistName.isBlank()) {

            return Response
                    .status(
                            Response.Status.BAD_REQUEST
                    )
                    .entity(
                            "Dentist name is required"
                    )
                    .build();
        }


        DentistDTO created =
                dao.create(
                        dentist
                );


        return Response
                .status(
                        Response.Status.CREATED
                )
                .entity(
                        created
                )
                .build();
    }


    // =========================================================
    // UPDATE DENTIST
    // =========================================================
    @PUT
    @Path("/{id}")
    public Response updateDentist(
            @PathParam("id") int id,
            DentistDTO dentist)
            throws Exception {


        if (dentist == null) {

            return Response
                    .status(
                            Response.Status.BAD_REQUEST
                    )
                    .entity(
                            "Dentist information is required"
                    )
                    .build();
        }


        if (dentist.dentistName == null
                || dentist.dentistName.isBlank()) {

            return Response
                    .status(
                            Response.Status.BAD_REQUEST
                    )
                    .entity(
                            "Dentist name is required"
                    )
                    .build();
        }


        boolean updated =
                dao.update(
                        id,
                        dentist
                );


        if (!updated) {

            throw new NotFoundException(
                    "Dentist not found"
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
    // DELETE DENTIST
    // =========================================================
    @DELETE
    @Path("/{id}")
    public Response deleteDentist(
            @PathParam("id") int id)
            throws Exception {


        try {


            boolean deleted =
                    dao.delete(id);


            if (!deleted) {

                throw new NotFoundException(
                        "Dentist not found"
                );
            }


            return Response
                    .ok()
                    .entity(
                            "Dentist deleted successfully"
                    )
                    .build();


        } catch (
                SQLIntegrityConstraintViolationException e) {


            return Response
                    .status(
                            Response.Status.CONFLICT
                    )
                    .entity(
                            "Dentist cannot be deleted because "
                            + "appointment records are linked "
                            + "to this dentist."
                    )
                    .build();
        }
    }
}