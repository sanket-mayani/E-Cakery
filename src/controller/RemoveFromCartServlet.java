package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Cart;
import model.DAO;
import model.Item;
import model.Product;

/**
 * Servlet implementation class RemoveFromCartServlet
 */
@WebServlet("/RemoveFromCart")
public class RemoveFromCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RemoveFromCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int pid = Integer.parseInt(request.getParameter("pid"));
		DAO dao = new DAO();
		Product product = dao.getProductById(pid);
		
		Item item = new Item();
		item.setProduct(product);
		
		HttpSession session = request.getSession();
		Cart cart = new Cart();
		if(session.getAttribute("cart") != null)
			cart = (Cart)session.getAttribute("cart");
		
		cart.removeItem(item);
		session.setAttribute("cart", cart);
		
		response.sendRedirect(request.getHeader("referer"));
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
