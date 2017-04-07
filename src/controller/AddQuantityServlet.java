package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.DAO;
import model.Product;

@WebServlet("/AddQuantity")
public class AddQuantityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddQuantityServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int pid = Integer.parseInt(request.getParameter("pid"));
		int qtyToAdd = Integer.parseInt(request.getParameter("qty"));
		
		DAO dao = new DAO();
		Product product = dao.getProductById(pid);
		
		int qtyLeft = product.getQuantity();
		product.setQuantity(qtyLeft + qtyToAdd);
		
		synchronized (this) {
			dao.updateProduct(product);
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("message", "Quantity Updated Successfully");
		session.setAttribute("class", "alert-success");
		
		response.sendRedirect(request.getHeader("referer"));
		
	}

}
