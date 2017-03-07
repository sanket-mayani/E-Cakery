package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Flavour;
import model.Product;
import model.Seller;
import model.User;
import model.DAO;




/**
 * Servlet implementation class Product
 */
@WebServlet("/AddProduct")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name=request.getParameter("name");
		String description=request.getParameter("description");
		float price=Float.parseFloat(request.getParameter("price"));
		String tier=request.getParameter("tier");
		String imageid=request.getParameter("imageid");
		String flavour_name=request.getParameter("flavour");
		Flavour flavour=new Flavour();
		flavour.setName(flavour_name);
		List al=new ArrayList();
		DAO dao=new DAO();
		al=dao.searchFlavour(flavour);
		HttpSession session = request.getSession();
		Seller seller=(Seller)session.getAttribute("seller");
		Product product=new Product();
		product.setName(name);
		product.setDescription(description);
		product.setPrice(price);
		product.setTier(tier);
		product.setImage_id(imageid);
		product.setFlavour((Flavour)al.get(0));
		product.setSeller(seller);
		dao.insertProduct(product);
		response.sendRedirect("add-product.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
