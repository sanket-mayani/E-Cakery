package webservices;
import java.util.List;









import javax.ws.rs.GET;  
import javax.ws.rs.Path;  
import javax.ws.rs.Produces;  
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;  







import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import model.Admin;
import model.DAO;
import model.Order;
import model.Seller;
import model.User;

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
		@GET
		@Path("/usercheck")
		@Produces(MediaType.APPLICATION_JSON)
		public String login(@QueryParam("username") String email, @QueryParam("password") String password) {	
			User user=dao.getUserByEmail(email);
			if(user != null)
			{
				if(user.getPw().equals(password))
				{
					 JSONObject obj = new JSONObject();
				        try {
				            obj.put("status", new Boolean("true"));
				        } catch (JSONException e) {
				            // TODO Auto-generated catch block
				        }
				        return obj.toString();
				}
				else
				{
					 JSONObject obj = new JSONObject();
				        try {
				            obj.put("status", new Boolean("false"));
				            obj.put("error_msg", "Incorrect Password");
				        } catch (JSONException e) {
				            // TODO Auto-generated catch block
				        }
				        return obj.toString();
				}
			}
			else
			{
				JSONObject obj = new JSONObject();
		        try {
		            obj.put("status", new Boolean("false"));
		            obj.put("error_msg", "Email id not registered");
		        } catch (JSONException e) {
		            // TODO Auto-generated catch block
		        }
		        return obj.toString();
			}

				
		}

}
