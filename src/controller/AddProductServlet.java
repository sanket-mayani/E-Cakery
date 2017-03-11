package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

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

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String name1;
		FileItem file = null;
		DAO dao=new DAO();
		
		
		Product product=new Product();
//		HttpSession session = request.getSession();
//		Seller seller=(Seller)session.getAttribute("seller");


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
						 if(n.equals("name")){
							 product.setName(value);
						 }else if(n.equals("desc")){
							 product.setDescription(value);
						 }
						 else if(n.equals("flavour")){
							 Flavour flavour=new Flavour();
								flavour.setName(value);
								List al=new ArrayList();
								al=dao.searchFlavour(flavour);
								product.setFlavour((Flavour)al.get(0));
						 }
						 else if(n.equals("occassion")){
							 Category category=new Category();
								category.setName(value);
								List category_list=new ArrayList();
								category_list=dao.searchCategory(category);
								product.setCategory((Category)category_list.get(0));
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
						{
							out.print((fileItem.getName()));
							out.print("Success");
						}
						
						else if(!name1.endsWith(".jpg") || !name1.endsWith(".jpeg")){
							out.print("Not a photo");
						}
					}
					
				}
			}catch(Exception e){
				System.out.println(e);
			}
		}
		

//		Part image=request.getPart("image");
//		InputStream input = null ;
//		if(image!=null){
//			System.out.println(image.getName());
//			System.out.println(image.getSize());
//			System.out.println(image.getContentType());
//			
//			input = image.getInputStream();
//		}
//			
//		byte[] bytes = new byte[5000000];
//		if(input!=null){
//			input.read(bytes);
//		}
		
		
//		product.setSeller(seller);
		dao.insertProduct(product);
		product.setImage_id(product.getPid());
		dao.updateProduct(product);
		try {
			name1 = new File(file.getName()).getName();
			name1 = name1.toLowerCase();
			
			if(name1.endsWith(".jpg") || name1.endsWith(".jpeg"))
			{
				file.write(new File(getServletContext().getInitParameter("Upload-Path") + File.separator + (product.getPid()+".jpg")));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("add-product.jsp"); 

	}

}
