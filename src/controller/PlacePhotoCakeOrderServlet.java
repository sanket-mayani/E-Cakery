package controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Category;
import model.City;
import model.DAO;
import model.Flavour;
import model.Order;
import model.Product;
import model.Seller;
import model.User;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class PlacePhotoCakeOrderServlet
 */
@WebServlet("/PlacePhotoCakeOrder")
@MultipartConfig
public class PlacePhotoCakeOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PlacePhotoCakeOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		boolean success = false;
		
		String name1 = null;
		FileItem file = null;
		DAO dao=new DAO();
		
		
		Order order = new Order();
		HttpSession session = request.getSession();		
		User user = null;
		
		if(session.getAttribute("user")!=null)
		{
			user=(User)session.getAttribute("user");

			if(ServletFileUpload.isMultipartContent(request))
			{
				try{
					List<FileItem> fileItems = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
					String value;
					
					for(FileItem fileItem : fileItems)
					{
	
						if(fileItem.isFormField()){
							String n = fileItem.getFieldName();
							 value = fileItem.getString();
							 if(n.equals("pid")){
								 Product product = dao.getProductById(Integer.parseInt(value));
								 order.setQuantity(1);
								 order.setAmount(product.getPrice());
								 order.setStatus("placed");
								 order.setUser(user);
								 order.setProduct(product);
								 order.setSeller(product.getSeller());
								 order.setPlacedAt(new Date());
								 order.setProduct(product);
							 }else if(n.equals("fn")){
								 order.setFname(value);
							 }else if(n.equals("ln")){
								 order.setLname(value);
							 }else if(n.equals("email")){
								 order.setEmail(value);
							 }else if(n.equals("mobile")){
								 order.setMobile(Long.parseLong(value));
							 }else if(n.equals("address")){
								 order.setAddress(value);
							 }else if(n.equals("pin")){
								 order.setPincode(Integer.parseInt(value));
							 }else if(n.equals("msg")){
								 order.setMessage(value);
							 }
						}
						else if(!fileItem.isFormField()){
							file=fileItem;
							name1 = new File(file.getName()).getName();
							name1 = name1.toLowerCase();
							if(name1.endsWith(".jpg") || name1.endsWith(".jpeg") || name1.endsWith(".png"))
							{
								order.setUserPhoto(name1);
								success = true;
							}
							else{
								success = false;
							}
						}
						
					}
				}
				catch(Exception e)
				{
					System.out.println(e);
				}
				
			}   
		
			if(success)
			{
				dao.insertOrder(order);
				
				String extension = name1.substring(name1.lastIndexOf("."));
				order.setUserPhoto(order.getOid()+extension);
				dao.updateOrder(order);
				
				try {
						file.write(new File(getServletContext().getInitParameter("User-Photo-Upload-Path") + File.separator + (order.getUserPhoto())));
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
				session.setAttribute("message", "Order Placed Successfully");
				session.setAttribute("class", "alert-success");
				response.sendRedirect(request.getHeader("referer"));
			}
			else
			{
				session.setAttribute("message", "Please choose a valid photo");
				session.setAttribute("class", "alert-danger");
				response.sendRedirect(request.getHeader("referer"));
			}
			
		}
		else
		{
			session.setAttribute("message", "Please Login First");
			session.setAttribute("class", "alert-danger");
			response.sendRedirect(request.getHeader("referer")); 
		}
		
	}
}
