package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DAO;
import model.Order;
import model.Product;


@WebServlet("/RateProduct")
public class RateProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public RateProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int oid = Integer.parseInt(request.getParameter("oid"));
		int rating = Integer.parseInt(request.getParameter("rating"));
		
		DAO dao = new DAO();
		synchronized (this) {
			Order order = dao.getOrderByOid(oid);
			order.setUserRating(rating);
			Product product = order.getProduct();
			int num = product.getNumOfRatings();
			float total = product.getRating() * num;
			product.setRating((total+rating)/(num+1));
			product.setNumOfRatings(num+1);
			dao.updateProduct(product);
			dao.updateOrder(order);
		}
		
		response.sendRedirect(request.getHeader("referer"));
	}

}
