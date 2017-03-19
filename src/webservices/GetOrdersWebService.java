package webservices;
import java.util.List;

import javax.ws.rs.GET;  
import javax.ws.rs.Path;  
import javax.ws.rs.Produces;  
import javax.ws.rs.core.MediaType;  



import javax.ws.rs.core.Response;

import model.DAO;
import model.Flavour;
import javax.ws.rs.core.GenericEntity;
@Path("/getorders")  
public class GetOrdersWebService {  
  // This method is called if HTML and XML is not requested  
	DAO dao=new DAO();
	
		@GET
		@Produces(MediaType.APPLICATION_JSON)
		public Response flavours() {
			GenericEntity< List< Flavour > > entity;
			entity  = new GenericEntity< List< Flavour > >( dao.getFlavour() ){ };
			 return Response.ok( entity ).build();
		}

}
