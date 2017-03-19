package controller;

import java.io.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import model.Category;
import model.DAO;
import model.Flavour;
import model.Product;
import model.Seller;

/**
 * Servlet implementation class AddProductServlet
 */
@WebServlet("/AddProduct")
@MultipartConfig
public class AddProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProductServlet() {
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

		String name1 = null;
		FileItem file = null;
		DAO dao=new DAO();
		
		
		Product product=new Product();
		HttpSession session = request.getSession();		
		Seller seller = null;
		
		if(session.getAttribute("seller")!=null)
		{
			seller=(Seller)session.getAttribute("seller");


			if(ServletFileUpload.isMultipartContent(request))
			{
				try{
					List<FileItem> fileItems = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
					String value;
					List<String> values = new ArrayList<String>();
					
					for(FileItem fileItem : fileItems)
					{
	
						if(fileItem.isFormField()){
							String n = fileItem.getFieldName();
							 value = fileItem.getString();
							 if(n.equals("name")){
								 product.setName(value);
							 }else if(n.equals("desc")){
								 product.setDescription(value);
							 }
							 else if(n.equals("flavour")){
								 	Flavour flavour=dao.getFlavourByName(value);
									product.setFlavour(flavour);
							 }
							 else if(n.equals("occassion")){
								 	values.add(value);
							 }
							 else if(n.equals("floor")){
								 product.setTier(value);
							 }
							 else if(n.equals("price")){
								 float value1 = 0;	
								 if(value!=null){
										value1=Float.parseFloat(value);
									}
								 if(value1!=0){
								 product.setPrice(value1);}
							 }
							 else if(n.equals("quantity")){
								 product.setQuantity(value);
							 }
						}
						else if(!fileItem.isFormField()){
							file=fileItem;
							name1 = new File(file.getName()).getName();
							name1 = name1.toLowerCase();
							if(name1.endsWith(".jpg") || name1.endsWith(".jpeg"))
								product.setImage(name1);
							else
								response.sendRedirect("add-product.jsp");
						}
						
					}
					Set<Category> categories = new HashSet<Category>();
				 	for(String s: values)
				 	{
						Category category=dao.getCategoryByName(s);
						categories.add(category);
				 	}
					product.setCategories(categories);
				}
				catch(Exception e)
				{
					System.out.println(e);
				}
				
			}   
		
			product.setSeller(seller);
			dao.insertProduct(product);
			
			String extension = name1.substring(name1.lastIndexOf("."));
			product.setImage(product.getPid()+extension);
			dao.updateProduct(product);
			
			try {
					file.write(new File(getServletContext().getInitParameter("Upload-Path") + File.separator + (product.getImage())));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		}
		response.sendRedirect("add-product.jsp"); 

	}
}

