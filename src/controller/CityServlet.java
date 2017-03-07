package controller;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.City;
import model.SellerCity;
import model.DAO;




/**
 * Servlet implementation class City
 */
@WebServlet("/GetCity")
public class CityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CityServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DAO dao=new DAO();
		List<City> city=dao.getCity();
		List<SellerCity> sellercity=dao.getSellerCity();
		Iterator<SellerCity> sellercityIterator = sellercity.iterator();
		while (sellercityIterator.hasNext()) {
			
				city.remove((sellercityIterator.next().getCity().getCid())-1);

		}
//		try {
//			Iterator<City> cityIterator = city.iterator();
//			int cid;
//			City c;
//			while (cityIterator.hasNext()) {
//				c=cityIterator.next();
//				cid=c.getCid();
//				Iterator<SellerCity> sellercityIterator = sellercity.iterator();
//				while(sellercityIterator.hasNext()){
//					int cidseller=sellercityIterator.next().getCity().getCid();
//					if(cid==cidseller){
//					city.remove(c);
//				}
//				}
//			
//			
//			}
//		
//		} catch (Exception e) {
//			
//		}
		
		HttpSession s1=request.getSession();
		s1.setAttribute("city",city);
		response.sendRedirect("get-city.jsp");

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
