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

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

@WebServlet("/PlaceOrder")
public class PlaceOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public PlaceOrder() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		
		Cart cart = null;
		User user = null;
		
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
				
				ArrayList<Item> items =cart.getItems();
				
				for(Item item : items)
				{
					Product product =item.getProduct();
					Seller seller =item.getProduct().getSeller();
					int QuantityOrdered = item.getQuantity();
					float amount =(item.getProduct().getPrice()) * QuantityOrdered ;
					
					DAO dao = new DAO();
			        Order order = new Order();
			           
			        order.setFname(fn);
			        order.setLname(ln);
			        order.setEmail(email);
			        order.setMobile(mobile);
			        order.setPincode(pin);
			        order.setAddress(address);
			          				        	
			        Date now = new Date();
			        order.setDateTime(now);      
			       	
			        order.setUser(user);
			        order.setSeller(seller);
			        order.setProduct(product);
			        	
					String status ="placed";
					order.setStatus(status);
					
					order.setQuantity(QuantityOrdered);          
					order.setAmount(amount);
					
					dao.insertOrder(order); 
					
					int QuantityInDatabase = product.getQuantity();
					
					int LeftQuantity = ( QuantityInDatabase - QuantityOrdered );
					
					product.setQuantity(LeftQuantity);
					
					dao.updateProduct(product);
				}
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
