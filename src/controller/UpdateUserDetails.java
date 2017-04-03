package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.City;
import model.DAO;
import model.User;
import model.City;

/**
 * Servlet implementation class UpdateUserDetails
 */
@WebServlet("/UpdateUserDetails")
public class UpdateUserDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateUserDetails() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		
		User user = null;
		if(session.getAttribute("user")==null)
				response.sendRedirect(request.getHeader("referer"));
		else
		{
			user = (User)session.getAttribute("user");
			String action = request.getParameter("action");
			DAO dao = new DAO();
			
			// updating personal details	
			
			if(action.equals("PersonalDetails"))
			{
				String fname=request.getParameter("fname");
				String lname=request.getParameter("lname");
				long mobile=Long.parseLong((request.getParameter("mobile")));
										
				user.setFn(fname);
				user.setLn(lname);
				user.setMob(mobile);
				
				session.setAttribute("message", "Details Updated Successfully");
				session.setAttribute("class", "alert-success");
			}
		
			// updating address details	
			
			else if(action.equals("AddressDetails"))
			{
				String address = request.getParameter("address");
				int pincode = Integer.parseInt(request.getParameter("pincode"));
				String city = request.getParameter("city");
				
				City cityob = dao.getCityByName(city);
				
				user.setAddress(address);
				user.setCity(cityob);
				user.setPincode(pincode);
				
				session.setAttribute("message", "Address Updated Successfully");
				session.setAttribute("class", "alert-success");
			}
				
			// changing password	
			
			else if (action.equals("PasswordChange"))
			{
				String currentpassword = request.getParameter("currentpassword");
				String newpassword = request.getParameter("newpassword");
				String newpassword2 = request.getParameter("newpassword2");
				
				String currentPasswordFromDB = user.getPw();
				
				if(currentpassword.equals(currentPasswordFromDB))
				{
					if(newpassword.equals(newpassword2))
					{
						user.setPw(newpassword);
						session.setAttribute("message", "Password Changed Successfully");
						session.setAttribute("class", "alert-success");
					}
					else
					{
						session.setAttribute("message", "Re-Entered Password doesn't match");
						session.setAttribute("class", "alert-danger");
					}
				}
				else
				{
					session.setAttribute("message", "Incorrect Current Password");
					session.setAttribute("class", "alert-danger");
				}	
			}
			
			dao.updateUser(user);
			response.sendRedirect(request.getHeader("referer"));
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
