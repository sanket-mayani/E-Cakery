package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.City;
import model.DAO;
import model.Flavour;


@WebServlet("/AddFlavour")
public class AddFlavourServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddFlavourServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String flavourName = request.getParameter("flavour");
		
		DAO dao = new DAO();
		List<Flavour> flavours = dao.getAllFlavours();
		HttpSession session = request.getSession();
		
		boolean duplicate = false;
		
		for(Flavour f : flavours)
		{
			if(f.getName().equalsIgnoreCase(flavourName))
			{
				duplicate = true;
				break;
			}
		}
		
		if(!duplicate)
		{
			Flavour flavour = new Flavour();
			flavour.setName(flavourName);
			synchronized (this) {
				dao.insertFlavour(flavour);
			}
			session.setAttribute("message", "Flavour "+flavourName+" added in the list of flavours");
			session.setAttribute("class", "alert-success");
		}
		else
		{
			session.setAttribute("message", "Flavour "+flavourName+" already exists");
			session.setAttribute("class", "alert-danger");
		}
		
		response.sendRedirect("AdminHome");
	}

}
