package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.City;
import model.DAO;
import model.Seller;

/**
 * Servlet implementation class UpdateSellerAddressServlet
 */
@WebServlet("/UpdateSellerAddressServlet")
public class UpdateSellerAddressServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateSellerAddressServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String name = request.getParameter("name");
		String m=request.getParameter("mobile");
		long mobile;
		String acc = request.getParameter("acc");
		String pan = request.getParameter("pan");
		String vat = request.getParameter("vat");
		String ifsc = request.getParameter("ifsc");
		String address = request.getParameter("address");
		String p=request.getParameter("pin");
		int pin;
		String c = request.getParameter("city");
		List al=new ArrayList();
		City city=new City();
		DAO dao=new DAO();
		if(c!=null)
		{
			city.setName(c);
			al=dao.searchCity(city);
			if(!al.isEmpty()){
				city=(City)al.get(0);
			}
		}
		HttpSession session=request.getSession();
		Seller seller=(Seller) session.getAttribute("seller");
		session.removeAttribute("seller");
		if(name!=null){
		seller.setName(name);
		}
		if(m!=null){
		mobile=Long.parseLong(m);
		seller.setMobile(mobile);
		}
		if(acc!=null){
		seller.setAccno(acc);
		}
		if(pan!=null){
		seller.setPan(pan);
		}
		if(vat!=null){
		seller.setVatid(vat);
		}
		if(ifsc!=null){
		seller.setIfsc(ifsc);
		}
		if(address!=null){
		seller.setAddress(address);
		}
		if(p!=null){
			pin = Integer.parseInt(p);	
			seller.setPincode(pin);
		}
		if(city.getName()!=null){
		seller.setCity(city);
		}
		dao.updateSeller(seller);
		session.setAttribute("seller", seller);
		response.sendRedirect("seller-home.jsp");
		}
		
		
}


