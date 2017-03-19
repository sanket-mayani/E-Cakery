package controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class FetchImageServlet
 */
@WebServlet("/FetchImage")
public class FetchImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public FetchImageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String id = request.getParameter("id");
		
		File file = new File(getServletContext().getInitParameter("Upload-Path")+File.separator+id);

		response.setContentType(getServletContext().getMimeType(file.getName()));
		response.setHeader("Content-Length", String.valueOf(file.length()));
		response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");

		BufferedInputStream input = null;
		BufferedOutputStream output = null;

		try {
		    input = new BufferedInputStream(new FileInputStream(file));
		    output = new BufferedOutputStream(response.getOutputStream());

		    byte[] buffer = new byte[(int) file.length()];
		    int length;
		    while ((length = input.read(buffer)) > 0) {
		        output.write(buffer, 0, length);
		    }
		} finally {
		    if (output != null) try { output.close(); } catch (IOException logOrIgnore) {}
		    if (input != null) try { input.close(); } catch (IOException logOrIgnore) {}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
