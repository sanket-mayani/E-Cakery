package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Registerdao;
import model.SellerInfovo;
import model.SellerLoginvo;
import model.SellerRegistervo;
import model.Sellerdao;

/**
 * Servlet implementation class Register
 */
@WebServlet("/SellerCity")
public class SellerCity extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SellerCity() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String s1=request.getParameter("vatid");
		String s2=request.getParameter("pan");
		String s3=request.getParameter("accno");
		
		SellerInfovo sivo=new SellerInfovo();
		sivo.setVatid(s1);
		sivo.setPan(s2);
		sivo.setAccno(s3);
		HttpSession session = request.getSession();
		sivo.setV((SellerLoginvo)session.getAttribute("sloginvo"));
		Sellerdao sido=new Sellerdao();
		sido.insert(sivo);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
