<%@page import="java.util.ArrayList"%>
<%@page import="model.Category"%>
<%@page import="model.Flavour"%>
<%@page import="model.City"%>
<%@page import="java.util.List"%>
<%@page import="model.DAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<%request.getRequestDispatcher("message-on-top.jsp").include(request, response);%>

<%
	if(session.getAttribute("admin") == null)
		response.sendRedirect("admin-index.jsp");
%>

<%
	DAO dao = new DAO();
	List<City> cities = dao.getAllCities();	
	List<Flavour> flavours = dao.getAllFlavours();
	List<Category> categories = dao.getAllCategories();
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>E-Cakery Admin Panel</title>
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>

	<div class="container-fluid" id="heading_section">
		<div class="container">
			
			<div class="row">
				<div class="col-sm-6">
					<h2 id="title"><a href="admin-index.jsp" class="white">E-Cakery</a></h2>
				</div>
				<div class="col-sm-6" id="cart_section">
					<span class="dropdown">
						<button class="dropdown-toggle" data-toggle="dropdown">Hello, Admin
						<span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li class="active"><a href="">My Orders</a></li>
						   	<li><a href="">Catalogue</a></li>
						   	<li><a href="">Payments</a></li>
						   	<li><a href="">My Account</a></li>
						   	<li class="divider"></li>
						   	<li><a href="AdminLogout">Logout</a></li>
						</ul>	
					</span>
				</div>
			</div>
			
		</div>
	</div><!-- End of heading section -->

	<div class="container" style="margin-bottom: 50px; margin-top: 5px;">
		
		<div class="row">
			<div class="col-sm-6 col-sm-offset-3">
				<h3>Choose an operation</h3>
				<div class="list-group">
					<a href="#" class="list-group-item"><span class="text-primary">1. Manage Orders and Payments</span></a>
					<a href="#" class="list-group-item"><span class="text-primary">2. Manage Users</span></a>
					<a href="#" class="list-group-item"><span class="text-primary">3. Manage Sellers</span></a>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12">
				<h3>List of Cities</h3>
				<hr>
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12">
				<div class="well">
					<%if(cities!=null)
					{
						int i = 1;
						for(City city : cities)
						{
							out.println(i+". "+city.getName());%><br><%
							i++;
						}
					}
					else
					{
					%>
						<h4>No city added</h4>
					<%	
					}
					%>
				</div>
				<form action="">
					<table style="border-collapse: separate; border-spacing: 10px 0px;">
						<tr>
							<td>Add New City:</td>
							<td><input type="text" name="city" class="form-control" placeholder="Enter name of city" required></td>
							<td><input class="btn btn-success" type="submit" value="Add City"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		
		<div class="row" style="margin-top: 30px;">
			<div class="col-xs-12">
				<h3>List of Flavours</h3>
				<hr>
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12">
				<div class="well">
					<%if(flavours!=null)
					{
						int i = 1;
						for(Flavour flavour : flavours)
						{
							out.println(i+". "+flavour.getName());%><br><%
							i++;
						}
					}
					else
					{
					%>
						<h4>No flavour added</h4>
					<%
					}
					%>
				</div>
				<form action="">
					<table style="border-collapse: separate; border-spacing: 10px 0px;">
						<tr>
							<td>Add New Flavour:</td>
							<td><input type="text" name="flavour" class="form-control" placeholder="Enter name of flavour" required></td>
							<td><input class="btn btn-success" type="submit" value="Add Flavour"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		
		<div class="row" style="margin-top: 30px;">
			<div class="col-xs-12">
				<h3>List of Categories</h3>
				<hr>
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12">
				<div class="well">
					<%if(categories!=null)
					{
						int i = 1;
						for(Category category : categories)
						{
							out.println(i+". "+category.getName());%><br><%
							i++;
						}
					}
					else
					{
					%>
						<h4>No category added</h4>
					<%
					}
					%>
				</div>
				<form action="">
					<table style="border-collapse: separate; border-spacing: 10px 0px;">
						<tr>
							<td>Add New Category:</td>
							<td><input type="text" name="category" class="form-control" placeholder="Enter name of category" required></td>
							<td><input class="btn btn-success" type="submit" value="Add Category"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	
	</div><!-- End of main container -->

	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>

</body>
</html>