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

import model.User;
import model.DAO;




/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.sendRedirect("Home.jsp");
		String s1=request.getParameter("email");
		String s2=request.getParameter("pw");
		
		HttpSession session = request.getSession();
		DAO v1=new DAO();
		User user=v1.getUserByEmail(s1);
		if(user != null)
		{
			if(user.getPw().equals(s2))
			{
				session.setAttribute("user", user);
				session.setAttribute("message", "Welcome "+user.getFn()+" "+user.getLn());
				session.setAttribute("class", "alert-success");
				response.sendRedirect(request.getHeader("referer"));
			}
			else
			{
				session.setAttribute("message", "Incorrect Password");
				session.setAttribute("class", "alert-danger");
				response.sendRedirect(request.getHeader("referer"));
			}
		}
		else
		{
			session.setAttribute("message", "Email Id Not Registered");
			session.setAttribute("class", "alert-danger");
			response.sendRedirect(request.getHeader("referer"));
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
