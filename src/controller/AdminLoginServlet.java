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

import model.Admin;
import model.User;
import model.DAO;
import model.Seller;


/**
 * Servlet implementation class Register
 */
@WebServlet("/AdminLogin")
public class AdminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminLoginServlet() {
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
		
		HttpSession session = request.getSession();
		
		DAO dao=new DAO();
		Admin admin=dao.getAdminByEmail(s1);
		if(admin != null)
		{
			if(admin.getPw().equals(s2))
			{
				session = request.getSession(); 
				session.setAttribute("admin", admin);
				response.sendRedirect("admin-home.jsp");
			}
			else
			{
				session.setAttribute("message", "Wrong Password");
				session.setAttribute("class", "alert-danger");
				response.sendRedirect("admin-index.jsp");
			}
		}
		else
		{
			session.setAttribute("message", "Email Not Registered");
			session.setAttribute("class", "alert-danger");
			response.sendRedirect("admin-index.jsp");
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
