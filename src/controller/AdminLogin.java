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

import model.AdminLoginvo;
import model.User;
import model.DAO;
import model.Seller;


/**
 * Servlet implementation class Register
 */
@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminLogin() {
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
		AdminLoginvo v=new AdminLoginvo();
		v.setUn(s1);
		
		DAO v1=new DAO();
		List<AdminLoginvo> ls=v1.search(v);
		AdminLoginvo al;
		if(!ls.isEmpty())
		{
		try {
			Iterator<AdminLoginvo> listIterator = ls.iterator();
			while (listIterator.hasNext()) {
				al=listIterator.next();
				if(al.getPw().equals(s2)){
					HttpSession session = request.getSession(); 
					session.setAttribute("aloginvo", al);
					response.sendRedirect("AdminHome.jsp");
				}
				else{
					response.sendRedirect("AdminLogin.jsp");
				}
			}
		
		} catch (Exception e) {
			
		}
		}else{
			response.sendRedirect("AdminLogin.jsp");
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
