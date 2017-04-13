package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.DAO;
import model.Seller;

@WebServlet("/ChangeStoreLocation")
public class ChangeStoreLocationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ChangeStoreLocationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("seller")!=null)
		{
			Seller seller = (Seller)session.getAttribute("seller");
			DAO dao = new DAO();
			
			double lat = Double.parseDouble(request.getParameter("lat"));
			double lng = Double.parseDouble(request.getParameter("lng"));
			
			seller.setLatitude(lat);
			seller.setLongitude(lng);
			
			synchronized (this) {
				dao.updateSeller(seller);
			}
			
			session.setAttribute("message", "Store Location Updated Successfully");
			session.setAttribute("class", "alert-success");
			response.sendRedirect("StoreLocation");
		}
		else
		{
			response.sendRedirect("seller-index.jsp");
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
