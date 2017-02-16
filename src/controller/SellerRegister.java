package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Registerdao;
import model.SellerLoginvo;
import model.SellerRegistervo;

/**
 * Servlet implementation class Register
 */
@WebServlet("/SellerRegister")
public class SellerRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SellerRegister() {
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
		
		SellerLoginvo slvo=new SellerLoginvo();
		slvo.setUn(s3);
		slvo.setPw(s4);
		Registerdao rdo=new Registerdao();
		rdo.insert(slvo);
		SellerRegistervo srvo=new SellerRegistervo();
		srvo.setFn(s1);
		srvo.setLn(s2);
		srvo.setMob(l1);
		srvo.setV(slvo);
		rdo.insert(srvo);
		response.sendRedirect("SellerLogin.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
