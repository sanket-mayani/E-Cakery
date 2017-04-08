package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Cart;
import model.DAO;
import model.Item;
import model.Order;
import model.Product;
import model.Seller;
import model.User;
import java.util.Date;

@WebServlet("/PlaceOrder")
public class PlaceOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public PlaceOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		
		Cart cart = null;
		User user = null;
		
		DAO dao = new DAO();
		
		if(session.getAttribute("cart")!=null && ((Cart)session.getAttribute("cart")).getCount()>0)
		{	
			cart = (Cart)session.getAttribute("cart");
		
			if(session.getAttribute("user") != null)
			{	
				user = (User)session.getAttribute("user");
		
				String fn =request.getParameter("fn");
				String ln =request.getParameter("ln");
				String email = request.getParameter("email");
				long mobile = Long.parseLong(request.getParameter("mobile"));
				String address = request.getParameter("address");
				int pin = Integer.parseInt(request.getParameter("pin"));
				
				//System.out.println("checkbox val" + checkbox);
				
				if(request.getParameter("SaveAsDefault") != null)
				{
					user.setAddress(address);
					user.setPincode(pin);
					dao.updateUser(user);
				}
				
				
				ArrayList<Item> items =cart.getItems();
				ArrayList<Item> successList = new ArrayList<Item>();
				ArrayList<Item> failureList = new ArrayList<Item>();
				
				for(Item item : items)
				{
					Product product =item.getProduct();
					Seller seller =item.getProduct().getSeller();
					int quantityOrdered = item.getQuantity();
					float amount =(item.getProduct().getPrice());
					
					
			        Order order = new Order();
			        
			        String msg = null;
			        if(request.getParameter("msg"+item.getProduct().getPid()) != null)
			        	msg = request.getParameter("msg"+item.getProduct().getPid());
			        else
			        	break;
			        
			        order.setMessage(msg);
			        order.setFname(fn);
			        order.setLname(ln);
			        order.setEmail(email);
			        order.setMobile(mobile);
			        order.setPincode(pin);
			        order.setAddress(address);
			          				        	
			        Date now = new Date();
			        order.setPlacedAt(now);      
			       	
			        order.setUser(user);
			        order.setSeller(seller);
			        order.setProduct(product);
			        	
					String status ="placed";
					order.setStatus(status);
					
					order.setQuantity(quantityOrdered);          
					order.setAmount(amount);
					
					boolean result = false;
					
					synchronized (this) {
						result = dao.placeOrder(order);
					}
					
					if(result)
						successList.add(item);
					else
						failureList.add(item);
					
				}
				
				for(Item item : successList)
					cart.removeItem(item);
				session.setAttribute("cart", cart);
				
				session.setAttribute("successList", successList);
				session.setAttribute("failureList", failureList);
				
				response.sendRedirect("Summary");
				
			}
			else
				response.sendRedirect(request.getHeader("referer"));
		}
		else
		{
			session.setAttribute("message", "Cart is Empty");
			session.setAttribute("class", "alert-danger");
			response.sendRedirect("index.jsp");
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
