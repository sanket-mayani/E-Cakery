package webservices;
import java.util.Date;
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
import model.Deliver;
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
		public List<Order> orders(@QueryParam("order_status") String status, @QueryParam("city") String city) {
			if(status.equals("packed")){
				return dao.getPackedOrders();
			}else{
				return dao.getDeliveredOrders();
			}
		}
		@GET
		@Path("/usercheck")
		@Produces(MediaType.APPLICATION_JSON)
		public String login(@QueryParam("username") String email, @QueryParam("password") String password) {	
			Deliver deliver=dao.getDeliverByEmail(email);
			if(deliver != null)
			{
				if(deliver.getPw().equals(password))
				{
					 JSONObject obj = new JSONObject();
				        try {
				            obj.put("status", new Boolean("true"));
				            obj.put("city", deliver.getCity().getName());
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
		@GET
		@Path("/update_status")
		@Produces(MediaType.APPLICATION_JSON)
		public String updateStatus(@QueryParam("order_no") String order_no,@QueryParam("status") String status) {	
			Order order=dao.getOrderByOid(Integer.parseInt(order_no));
			if(status.equals("packed")){
			order.setStatus("Delivered");
			Date now = new Date();
			order.setDeliveredAt(now);
			}
			else{
				if(order.getShippedAt()!=null){
					order.setStatus("shipped");
				}else{
					order.setStatus("packed");
				}
				order.setDeliveredAt(null);
			}
			dao.updateOrder(order);;
			JSONObject obj = new JSONObject();
	        try {
	            obj.put("status", new Boolean("true"));
	        }catch (JSONException e) {
	            // TODO Auto-generated catch block
	        }
	        return obj.toString();
		}

}
