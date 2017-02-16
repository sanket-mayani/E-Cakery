package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.jersey.spi.dispatch.RequestDispatcher;

import model.Loginvo;
import model.Registerdao;
import model.Registervo;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String s1=request.getParameter("fn");
		String s2=request.getParameter("ln");
		String s3=request.getParameter("email");
		String s4=request.getParameter("pw");
		long l1=Long.parseLong(request.getParameter("mobile"));
		
		Loginvo lvo=new Loginvo();
		lvo.setUn(s3);
		lvo.setPw(s4);
		Registerdao rdo=new Registerdao();
		rdo.insert(lvo);
		Registervo rvo=new Registervo();
		rvo.setFn(s1);
		rvo.setLn(s2);
		rvo.setMob(l1);
		rvo.setV(lvo);
		rdo.insert(rvo);
		
		HttpSession session = request.getSession();
		session.setAttribute("message","Registration Successfull");
		response.sendRedirect("index.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
