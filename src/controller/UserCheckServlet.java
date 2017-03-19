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
import model.User;
import model.DAO;
import model.Seller;

@WebServlet("/UserCheck")
public class UserCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UserCheckServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter pw=response.getWriter();
		String user=request.getParameter("u");
		String type=request.getParameter("type");
		DAO r=new DAO();	
		try {
			
			if(type.equals("seller"))
			{	
				Seller sl=r.getSellerByEmail(user);
				if(sl == null){
					pw.println("0");
				}
				else{
					pw.println("1");
				}
			}else if(type.equals("user"))
			{
				User l=r.getUserByEmail(user);
				if(l == null){
					pw.println("0");
				}
				else{
					pw.println("1");
				}
			}else if(type.equals("admin"))
			{
				AdminLoginvo al=r.getAdminByEmail(user);
				if(al == null){
					pw.println("0");
				}
				else{
					pw.println("1");
				}
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
