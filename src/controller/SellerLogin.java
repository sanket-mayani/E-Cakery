package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Loginvo;
import model.Registerdao;
import model.SellerLoginvo;


/**
 * Servlet implementation class Register
 */
@WebServlet("/SellerLogin")
public class SellerLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SellerLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String s1=request.getParameter("email");
		String s2=request.getParameter("pw");
		SellerLoginvo v=new SellerLoginvo();
		v.setUn(s1);
		
		Registerdao v1=new Registerdao();
		List<SellerLoginvo> ls=v1.search(v);
		SellerLoginvo sl;
		if(!ls.isEmpty())
		{
		try {
			Iterator<SellerLoginvo> listIterator = ls.iterator();
			while (listIterator.hasNext()) {
				sl=listIterator.next();
				if(sl.getPw().equals(s2)){
					HttpSession session = request.getSession(); 
					session.setAttribute("sloginvo", sl);
					response.sendRedirect("SellerHome.jsp");
				}
				else{
					response.sendRedirect("SellerLogin.jsp");
				}
			}
		
		} catch (Exception e) {
			
		}
		}else{
			response.sendRedirect("SellerLogin.jsp");
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
