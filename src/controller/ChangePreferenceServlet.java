package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Category;
import model.City;
import model.DAO;
import model.Flavour;
import model.Product;

/**
 * Servlet implementation class FetchCakesByCityServlet
 */
@WebServlet("/ChangePreference")
public class ChangePreferenceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ChangePreferenceServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		
		if(request.getParameter("city") != null)
		{
			String cityName = request.getParameter("city");		
			DAO dao = new DAO();
			City city = dao.getCityByName(cityName);
			session.setAttribute("city",city);
		}
		
		if(request.getParameter("weight") != null)
		{
			float weight = Float.parseFloat(request.getParameter("weight"));		
			session.setAttribute("weight",weight);
		}
		
		if(request.getParameter("floors") != null)
		{
			int floors = Integer.parseInt(request.getParameter("floors"));		
			session.setAttribute("floors",floors);
		}
		
		if(request.getParameter("price") != null)
		{
			int price = Integer.parseInt(request.getParameter("price"));		
			session.setAttribute("price",price);
		}
		
		if(request.getParameter("sortBy") != null)
		{
			int sortBy = Integer.parseInt(request.getParameter("sortBy"));		
			session.setAttribute("sortBy",sortBy);
		}
		
		if(request.getParameter("page") != null)
		{
			int currentPage= Integer.parseInt(request.getParameter("page"));		
			session.setAttribute("page",currentPage);
		}
		
		
		//List<Product> products = dao.fetchCakesByCity(city);
		//request.setAttribute("products", products);
		
		response.sendRedirect(request.getHeader("referer"));
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
