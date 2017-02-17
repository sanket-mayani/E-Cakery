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

import model.User;
import model.DAO;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class RegisterationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String s1 = request.getParameter("fn");
		String s2 = request.getParameter("ln");
		String s3 = request.getParameter("email");
		String s4 = request.getParameter("pw");
		long l1 = Long.parseLong(request.getParameter("mobile"));
		
		HttpSession session = request.getSession();
		DAO dao = new DAO();
		User user = new User();
		user.setUn(s3);
		
		
		List ls=new ArrayList();
		ls=dao.searchUser(user);
		if(ls.isEmpty()){
			user.setPw(s4);
			user.setFn(s1);
			user.setLn(s2);
			user.setMob(l1);
			dao.insertUser(user);
			
			session.setAttribute("message","Registration Successfull");
			session.setAttribute("class", "alert-success");
			response.sendRedirect("index.jsp");
		}
		else{
			session.setAttribute("message","Email Id Already Registered");
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
