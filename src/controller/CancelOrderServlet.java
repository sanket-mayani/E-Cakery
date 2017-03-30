package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DAO;
import model.Order;

/**
 * Servlet implementation class CancelOrderServlet
 */
@WebServlet("/CancelOrder")
public class CancelOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	// This Servlet is invoked when customer cancels an order
	// It accepts two parameters
	// 1. oid - order which is to be cancelled
	// 2. reason - as chosen by the customer
	
    public CancelOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		//get the parameters
		int oid = Integer.parseInt(request.getParameter("oid"));
		String reason = request.getParameter("reason");
		
		DAO dao = new DAO();
		
		// get the order from db, change its status and cancellation reason
		Order order = dao.getOrderByOid(oid);
		order.setStatus("cancelled by customer");
		order.setCancellationReason(reason);
		
		// updaete the order in db
		synchronized (this) {
			dao.updateOrder(order);
		}
		
		// get back to my orders page
		response.sendRedirect("MyOrders");
	}

}
