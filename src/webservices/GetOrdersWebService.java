package webservices;
import java.util.List;




import javax.ws.rs.GET;  
import javax.ws.rs.Path;  
import javax.ws.rs.Produces;  
import javax.ws.rs.core.MediaType;  


import model.DAO;
import model.Order;

@Path("/webservices")  
public class GetOrdersWebService {  
  // This method is called if HTML and XML is not requested  
	DAO dao=new DAO();
	
		@GET
		@Path("/getpackedorders")
		@Produces(MediaType.APPLICATION_JSON)
		public List<Order> orders() {
			return dao.getPackedOrders();
		}

}
