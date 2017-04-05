package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Cart;
import model.DAO;
import model.Product;

/**
 * Servlet implementation class UpdateQuantityServlet
 */
@WebServlet("/UpdateQuantity")
public class UpdateQuantityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateQuantityServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int pid = Integer.parseInt(request.getParameter("pid"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		
		//System.out.println(pid+" "+quantity);
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("cart")!=null){
			Cart cart = (Cart)session.getAttribute("cart");
			
			DAO dao = new DAO();
			Product product = new Product();
			product.setPid(pid);
			int quantityInDB = dao.getQuantity(product);
			if(quantityInDB >= quantity)
				cart.updateQuantity(pid, quantity);
			else
			{
				session.setAttribute("message", "Quantity could not be set to "+quantity+", since only "+quantityInDB+" left in stock.");
				session.setAttribute("class", "alert-danger");
			}
				
			session.setAttribute("cart",cart);
		}
		
		response.sendRedirect(request.getHeader("referer"));
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
