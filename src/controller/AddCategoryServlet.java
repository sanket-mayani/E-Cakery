package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Category;
import model.City;
import model.DAO;


@WebServlet("/AddCategory")
public class AddCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddCategoryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String categoryName = request.getParameter("category");
		
		DAO dao = new DAO();
		List<Category> categories = dao.getAllCategories();
		HttpSession session = request.getSession();
		
		boolean duplicate = false;
		
		for(Category c : categories)
		{
			if(c.getName().equalsIgnoreCase(categoryName))
			{
				duplicate = true;
				break;
			}
		}
		
		if(!duplicate)
		{
			Category category = new Category();
			category.setName(categoryName);
			synchronized (this) {
				dao.insertCategory(category);
			}
			session.setAttribute("message", "Category "+categoryName+" added in the list of categories");
			session.setAttribute("class", "alert-success");
		}
		else
		{
			session.setAttribute("message", "Category "+categoryName+" already exists");
			session.setAttribute("class", "alert-danger");
		}
		
		response.sendRedirect("AdminHome");
	}

}
