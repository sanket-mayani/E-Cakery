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
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.sendRedirect("Home.jsp");
		String s1=request.getParameter("email");
		String s2=request.getParameter("pw");
		User v=new User();
		v.setUn(s1);
		
		HttpSession session = request.getSession();
		DAO v1=new DAO();
		List<User> ls=v1.searchUser(v);
		if(!ls.isEmpty())
		{
		try {
			Iterator<User> listIterator = ls.iterator();
			while (listIterator.hasNext()) {
				if(listIterator.next().getPw().equals(s2)){
					response.sendRedirect("user-home.jsp");
				}
				else{
					session.setAttribute("message", "Incorrect Password");
					session.setAttribute("class", "alert-danger");
					response.sendRedirect("index.jsp");
				}
			}
		
		} catch (Exception e) {
			
		}
		}else{
			session.setAttribute("message", "Email Id Not Registered");
			session.setAttribute("class", "alert-danger");
			response.sendRedirect("index.jsp");
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
