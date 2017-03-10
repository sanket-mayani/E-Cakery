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
		
		if(ServletFileUpload.isMultipartContent(request))
		{
			try{
				List<FileItem> fileItems = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
				
				for(FileItem fileItem : fileItems)
				{
					if(!fileItem.isFormField())
					{
						String name = new File(fileItem.getName()).getName();
						
						if(name.endsWith(".jpg") || name.endsWith(".jpeg"))
						{
							fileItem.write(new File(getServletContext().getInitParameter("Upload-Path") + File.separator + name));
							out.print("Success");
						}
						else
							out.println("Not a photo");
						
					}
				}
			}catch(Exception e){
				System.out.println(e);
			}
		}
		
		
		/*String name=request.getParameter("name");
		String description=request.getParameter("desc");
		float price=Float.parseFloat(request.getParameter("price"));
		String tier=request.getParameter("floor");
		Part image=request.getPart("image");
		InputStream input = null ;
		if(image!=null){
			System.out.println(image.getName());
			System.out.println(image.getSize());
			System.out.println(image.getContentType());
			
			input = image.getInputStream();
		}
			
		byte[] bytes = new byte[5000000];
		if(input!=null){
			input.read(bytes);
		}
		
		
		String flavour_name=request.getParameter("flavour");
		
		Flavour flavour=new Flavour();
		flavour.setName(flavour_name);
		List al=new ArrayList();
		DAO dao=new DAO();
		al=dao.searchFlavour(flavour);
		
		HttpSession session = request.getSession();
		Seller seller=(Seller)session.getAttribute("seller");
		
		Product product=new Product();
		product.setName(name);
		product.setDescription(description);
		product.setPrice(price);
		product.setTier(tier);
		product.setImage(bytes);
		product.setFlavour((Flavour)al.get(0));
		product.setSeller(seller);
		dao.insertProduct(product);
		response.sendRedirect("add-product.jsp"); */

	}

}
