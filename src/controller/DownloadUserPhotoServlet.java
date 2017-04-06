package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DownloadUserPhoto")
public class DownloadUserPhotoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DownloadUserPhotoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String imageName = request.getParameter("id");

		response.setContentType("text/html");  
		PrintWriter out = response.getWriter();  
		
		String filepath = getServletContext().getInitParameter("User-Photo-Upload-Path"); 
		response.setContentType("APPLICATION/OCTET-STREAM");   
		response.setHeader("Content-Disposition","attachment; filename=\"" + imageName + "\"");   
		  
		FileInputStream fileInputStream = new FileInputStream(filepath + File.separator + imageName);  
		            
		int i;   
		while ((i=fileInputStream.read()) != -1) {  
			out.write(i);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
