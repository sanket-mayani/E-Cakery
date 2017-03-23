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


/**
 * Servlet implementation class PlaceOrder
 */
@WebServlet("/PlaceOrder")
public class PlaceOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PlaceOrder() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		
		Cart cart = null; User user = null;
		
		if(session.getAttribute("cart") != null)
			cart = (Cart)session.getAttribute("cart");
		else
			session.setAttribute("cart", cart);

		if(session.getAttribute("user") != null)
			user = (User)session.getAttribute("user");
		
		PrintWriter out = response.getWriter();
		
		String fn =request.getParameter("fn");
		
		String ln =request.getParameter("ln");
		
		String email = request.getParameter("email");
		
		long mobile = Long.parseLong(request.getParameter("mobile"));
		
		String address = request.getParameter("address");
		
		int pin = Integer.parseInt(request.getParameter("pin"));
		
		String city = request.getParameter("city");
		
		
		
		ArrayList<Item> items =cart.getItems();
		
		out.println("items in the list are :" + items.size());
		
		out.println("\n");
		
		for(int i=0; i < items.size(); i++)
		{
			Product product =items.get(i).getProduct();
			Seller seller =items.get(i).getProduct().getSeller();
			
			int quantity = items.get(i).getQuantity();
			
			out.println("quantity of this item is : " + quantity);
			
			float amount =(items.get(i).getProduct().getPrice()) * quantity;
			
			DAO dao = new DAO();
			
	        Order order = new Order();
	        out.println("adding records into db now into order table \n");
	     // ADDING customer personal info into db      
	        	order.setFname(fn);
	        	order.setLname(ln);
	        	order.setEmail(email);
	        	order.setMobile(mobile);
	        	order.setPincode(pin);
	        	order.setAddress(address);
	        
	     // adding date and time into database   	
	        	
	        	Date now = new Date();       // current date and time
	    // date object is created which gvs current date and time
		// date format in mysql will be "yyyy:mm:dd" 
	        	
	        //	order.setDate(now);
	        //	order.setTime(now);
	    
	        	order.setDateTime(now);        // this will add timestamp : date n time togehter
	        	
	    // adding pid and sid for this item we ve fetched abv
	        	
	        	order.setUser(user);
	        	order.setSeller(seller);
	        	order.setProduct(product);
	        	
			String status ="placed";
			
			order.setStatus(status);
			
		// adding quantity and amnt 
			
			order.setQuantity(quantity);
			order.setAmount(amount);
			
			dao.insertOrder(order);      // method need to save everything in DB
		}
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
