package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;






import model.AdminLoginvo;
import model.Loginvo;
import model.Registerdao;
import model.SellerLoginvo;

/**
 * Servlet implementation class UserCheck
 */
@WebServlet("/UserCheck")
public class UserCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserCheck() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter pw=response.getWriter();
		String user=request.getParameter("u");
		String type=request.getParameter("type");
		Registerdao r=new Registerdao();	
		try {
			List ls=new ArrayList();
			if(type.equals("seller"))
			{	SellerLoginvo sl=new SellerLoginvo();
				sl.setUn(user);
				ls=r.search(sl);
			}else if(type.equals("user"))
			{
				Loginvo l=new Loginvo();
				l.setUn(user);
				ls=r.search(l);
			}else if(type.equals("admin"))
			{
				AdminLoginvo al=new AdminLoginvo();
				al.setUn(user);
				ls=r.search(al);
			}
			if(ls.isEmpty()){
				pw.println("0");
			}
			else{
				pw.println("1");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
