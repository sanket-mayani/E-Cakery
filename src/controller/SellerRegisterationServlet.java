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

import model.DAO;
import model.Seller;

/**
 * Servlet implementation class Register
 */
@WebServlet("/SellerRegistration")
public class SellerRegisterationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SellerRegisterationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String s1=request.getParameter("name");
		String s2=request.getParameter("email");
		String s3=request.getParameter("pw");
		long l1=Long.parseLong(request.getParameter("mobile"));
		String s4=request.getParameter("vat");
		String s5=request.getParameter("pan");
		String s6=request.getParameter("acc");
		String s7=request.getParameter("ifsc");
		
		DAO dao = new DAO();
		HttpSession session = request.getSession();
		
		Seller seller = new Seller();
		seller.setUn(s2);
		
		List ls=new ArrayList();
		ls=dao.searchSeller(seller);
		if(ls.isEmpty()){
			seller.setName(s1);
			seller.setPw(s3);
			seller.setMobile(l1);
			seller.setVatid(s4);
			seller.setPan(s5);
			seller.setAccno(s6);
			seller.setIfsc(s7);
			dao.insertSeller(seller);
			
			session.setAttribute("message","Registration Successfull");
			session.setAttribute("class", "alert-success");
			response.sendRedirect("seller-index.jsp");
		}
		else{
			session.setAttribute("message","Email Id Already Registered");
			session.setAttribute("class", "alert-danger");
			response.sendRedirect("seller-index.jsp");
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
