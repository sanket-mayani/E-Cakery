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

import model.Loginvo;
import model.Registerdao;




/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
		Loginvo v=new Loginvo();
		v.setUn(s1);
		
		Registerdao v1=new Registerdao();
		List<Loginvo> ls=v1.search(v);
		if(!ls.isEmpty())
		{
		try {
			Iterator<Loginvo> listIterator = ls.iterator();
			while (listIterator.hasNext()) {
				if(listIterator.next().getPw().equals(s2)){
					response.sendRedirect("user-home.jsp");
				}
				else{
					HttpSession session = request.getSession();
					session.setAttribute("message", "Incorrect Password");
					session.setAttribute("class", "alert-danger");
					response.sendRedirect("index.jsp");
				}
			}
		
		} catch (Exception e) {
			
		}
		}else{
			response.sendRedirect("index.jsp"); //won't execute
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
