package sunrise.dental.service.api;

import sunrise.dental.service.dao.BillDAO;
import sunrise.dental.service.dto.BillDTO;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.List;


@Path("/bills")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class BillResource {


    private final BillDAO dao =
            new BillDAO();


    // =========================================================
    // GET ALL BILLS
    // =========================================================
    @GET
    public List<BillDTO> getAllBills()
            throws Exception {

        return dao.findAll();
    }


    // =========================================================
    // GET ONE BILL
    // =========================================================
    @GET
    @Path("/{id}")
    public BillDTO getBill(
            @PathParam("id") int id)
            throws Exception {

        BillDTO bill =
                dao.findById(id);


        if (bill == null) {

            throw new NotFoundException(
                    "Bill not found"
            );
        }


        return bill;
    }


    // =========================================================
    // CREATE BILL
    // =========================================================
    @POST
    public Response createBill(
            BillDTO bill)
            throws Exception {

        BillDTO created =
                dao.createBill(bill);


        return Response
                .status(
                        Response.Status.CREATED
                )
                .entity(created)
                .build();
    }


    // =========================================================
    // PAY BILL
    //
    // PUT /api/bills/1/pay
    // =========================================================
    @PUT
    @Path("/{id}/pay")
    public Response payBill(
            @PathParam("id") int id)
            throws Exception {

        boolean paid =
                dao.markAsPaid(id);


        if (!paid) {

            throw new NotFoundException(
                    "Bill not found"
            );
        }


        return Response
                .ok()
                .entity(
                        dao.findById(id)
                )
                .build();
    }
}