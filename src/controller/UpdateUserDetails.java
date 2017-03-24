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
		
		PrintWriter out = response.getWriter();
		
		String action = request.getParameter("action");
		
		HttpSession session = request.getSession();
		
		User user = (User)session.getAttribute("user");
		
		DAO dao = new DAO();
		
	// updating personal details	
		
		if(action.equals("PersonalDetails"))
		{
		String fname=request.getParameter("fname");
		String lname=request.getParameter("lname");
		long mobile=Long.parseLong((request.getParameter("mobile")));
		
									out.println(fname);
									out.println(lname);
									out.println(mobile);
									
		user.setFn(fname);
		user.setLn(lname);
		user.setMob(mobile);
		
									out.println("personal details are being updated \n\n");
		
		}
	
		// updating address details	
		
		else if(action.equals("AddressDetails"))
		{
			String address = request.getParameter("address");
			int pincode = Integer.parseInt(request.getParameter("pincode"));
			String city = request.getParameter("city");
										
										out.println(address);
										out.println(pincode);
										out.println(city);
										
			
			City cityob = new City();
			cityob.setName(city);
			
			user.setAddress(address);
			user.setCity(cityob);
			user.setPincode(pincode);
				
										out.println("address details are being updated \n\n");
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
										out.println("password is being changed");
				}
				else
				{
					//give an error of enterd passwords dont match
				}
			}
			else
			{
				//give an error of incoorect passwd enterd
			}

			
		}
		
	
		dao.updateUser(user);
		out.println("details updated succesfully.");
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
