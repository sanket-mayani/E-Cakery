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


@WebServlet("/AddCity")
public class AddCityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddCityServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String cityName = request.getParameter("city");
		
		DAO dao = new DAO();
		List<City> cities = dao.getAllCities();
		HttpSession session = request.getSession();
		
		boolean duplicate = false;
		
		for(City c : cities)
		{
			if(c.getName().equalsIgnoreCase(cityName))
			{
				duplicate = true;
				break;
			}
		}
		
		if(!duplicate)
		{
			City city = new City();
			city.setName(cityName);
			synchronized (this) {
				dao.insertCity(city);
			}
			session.setAttribute("message", "City "+cityName+" added in the list of cities");
			session.setAttribute("class", "alert-success");
		}
		else
		{
			session.setAttribute("message", "City "+cityName+" already exists");
			session.setAttribute("class", "alert-danger");
		}
		
		response.sendRedirect("AdminHome");
		
	}

}
