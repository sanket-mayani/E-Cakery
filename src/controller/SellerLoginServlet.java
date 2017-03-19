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

import model.User;
import model.DAO;
import model.Seller;


/**
 * Servlet implementation class Register
 */
@WebServlet("/SellerLogin")
public class SellerLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SellerLoginServlet() {
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
		DAO v1=new DAO();
		
		Seller v=v1.getSellerByEmail(s1);
		if(v!=null)
		{
			if(v.getPw().equals(s2))
			{
				session.setAttribute("seller", v);
				session.setAttribute("message", "Welcome");
				session.setAttribute("class", "alert-success");
				response.sendRedirect("seller-home.jsp");
			}
			else
			{
				session.setAttribute("message", "Invalid Password");
				session.setAttribute("class", "alert-danger");
				response.sendRedirect("seller-index.jsp");
			}
		}
		else
		{
			session.setAttribute("message", "Email Id Not Registered");
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
