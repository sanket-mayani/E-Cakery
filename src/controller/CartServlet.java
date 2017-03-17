package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Cart;
import model.Item;
import model.Product;
/**
 * Servlet implementation class CartServlet
 */

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String productid = request.getParameter("productid");      // so we cn get the value of parameter passed by url rewriting using getparameter method
	
		String quantityinstring = request.getParameter("quantity");    // this is used whn quantity is changed by the user at cart page
		
		HttpSession session = request.getSession();      // return the current httpsession associated with d request

		synchronized(session)
		{
			Cart cart = (Cart)session.getAttribute("cart");
			
			if(cart == null)
			{
				cart =new Cart();
				session.setAttribute("cart",cart);
				
			}
			
		// if user tries to set a negative quantity then it will set to 0 automatically 	
			
			int quantity =1;        // by default we use quantity as '1' of any item thts why we took it as 1
			
			try
			{
				quantity = Integer.parseInt(quantityinstring);
					if (quantity <0)
					{
						quantity = 1;
					}
				
			}
			
			catch(NumberFormatException e)         // so if user didnt change the quantity then exceptin occur 
			{										// and we just set quantitly as 1 : which is by default
				quantity = 1;
			}
			
		Product product = new Product(Integer.parseInt(productid));	   // we ve to mk dis const. public to be accessed here
		
		Item item =new Item();
			
		item.setProduct(product);
		item.setQuantity(quantity);
		
		// now chck quantity
		
		if(quantity>0)
		{
			cart.addItem(item);
		}
		else if (quantity <= 0)
		{
			cart.removeItem(item);
		}
		
		session.setAttribute("cart",cart);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("Cart2.jsp");
		
		dispatcher.forward(request,response);
		
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
