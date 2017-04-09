package controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.DAO;
import model.Order;

/**
 * Servlet implementation class ChangeStatusServlet
 */
@WebServlet("/ChangeStatus")
public class ChangeStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	// This servlet changes the status of the order in DB
	// Parameters accepted are...
	// 1. oid - order id
	// 2. status - new status of order
	
    public ChangeStatusServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		// get the parameters from request
		int oid = Integer.parseInt(request.getParameter("oid"));
		String status = request.getParameter("status");
		
		// get the order from db whose status needs to be changed, and update the status
		DAO dao = new DAO();
		Order order = dao.getOrderByOid(oid);
		order.setStatus(status);
		
		// if new status is 'shipped' then also add shipping date-time
		if(status.equals("shipped"))
		{
			order.setShippedAt(new Date());
		}
		
		// if new status is 'cancelled by seller' then also add cancellation date-time
		if(status.equals("cancelled by seller"))
		{
			order.setCancelledAt(new Date());
			order.setCancellationReason("Can't fulfill");
		}
		
		// finally, update the order in db
		synchronized (this) {
			dao.updateOrder(order);
		}
		
		// Set the msg to be displayed on seller-home page and return to that page
		HttpSession session = request.getSession();
		session.setAttribute("message", "Moved to "+status+" orders");
		session.setAttribute("class", "alert-success");
		response.sendRedirect(request.getHeader("referer"));
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
