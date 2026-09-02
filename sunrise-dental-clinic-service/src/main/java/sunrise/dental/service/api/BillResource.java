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

    @GET
    public List<BillDTO> all()
            throws Exception {

        return dao.findAll();
    }

    @POST
    public Response create(
            BillDTO bill)
            throws Exception {

        BillDTO created =
                dao.createBill(bill);

        return Response
                .status(Response.Status.CREATED)
                .entity(created)
                .build();
    }
}