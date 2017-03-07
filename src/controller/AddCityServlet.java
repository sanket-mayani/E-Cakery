package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.City;
import model.Seller;
import model.SellerCity;
import model.User;
import model.DAO;




/**
 * Servlet implementation class AddCity
 */
@WebServlet("/AddCity")
public class AddCityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCityServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DAO dao=new DAO();
	    HttpSession session=request.getSession();
        City city = new City();
        Seller seller=(Seller)session.getAttribute("seller");
        SellerCity sellercity = new SellerCity();
        List l=new ArrayList();
        String[] selectedcity = request.getParameterValues("city");
        for(int i=0;i<selectedcity.length;i++){
            city.setName(selectedcity[i]);
            l=dao.searchCity(city);
            sellercity.setSeller(seller);
            sellercity.setCity((City) l.get(0));
            dao.insertSellerCity(sellercity);
             
        }
		response.sendRedirect("seller-home.jsp");

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
