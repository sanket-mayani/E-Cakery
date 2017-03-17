package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.City;
import model.DAO;
import model.Product;

/**
 * Servlet implementation class FetchCakesByCityServlet
 */
@WebServlet("/ChangeCity")
public class ChangeCityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ChangeCityServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		String cityName = request.getParameter("city");		
		City city = new City();
		city.setName(cityName);
		DAO dao = new DAO();
		List<City> cities = dao.searchCity(city);
		city = cities.get(0);
		session.setAttribute("city",city);
		
		//List<Product> products = dao.fetchCakesByCity(city);
		//request.setAttribute("products", products);
		
		response.sendRedirect("index.jsp");
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
