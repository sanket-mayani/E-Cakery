<%@page import="model.Category"%>
<%@page import="model.Flavour"%>
<%@page import="model.Product"%>
<%@page import="model.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.City"%>
<%@page import="java.util.List"%>
<%@page import="model.DAO"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<%
	User user = null;
	DAO dao = new DAO();
	List<City> cities = null;
	Cart cart = new Cart();
	List<Product> products = null;
	float weight = 0;
	int floors = 0;
	int price = 0;
	int sortBy = 1;
	City city = null;
	int currentPage = 1;
	long maxPages = 0;
	int start = 0;
	String categoryName = null;
	Category category = null;
%>

<%
	if(session.getAttribute("user")!=null)
		user = (User)session.getAttribute("user");

	if(session.getAttribute("cart")!=null)
		cart = (Cart)session.getAttribute("cart");
	else
		session.setAttribute("cart", cart);
	
	if(session.getAttribute("city")!=null)
		city = (City)session.getAttribute("city");
	else
		city = dao.getAllCities().get(0);
	
	if(session.getAttribute("weight")!=null)
		weight = (Float)session.getAttribute("weight");
	
	if(session.getAttribute("floors")!=null)
		floors = (Integer)session.getAttribute("floors");
	
	if(session.getAttribute("price")!=null)
		price = (Integer)session.getAttribute("price");
	
	if(session.getAttribute("sortBy") != null)
		sortBy = (Integer)session.getAttribute("sortBy");		
	
	if(session.getAttribute("page")!=null)
		currentPage = (Integer)session.getAttribute("page");
	
	if(request.getParameter("category")!=null)
		categoryName = request.getParameter("category");
	
	category = dao.getCategoryByName(categoryName);
	cities = dao.getAllCities();
	
	start = currentPage*8-8;
	products = dao.fetchCakes(city, null, category, weight, floors, price, sortBy, start);
	maxPages = dao.getMaxPages(city,null,category,weight, floors, sortBy, price);
	
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title><%out.print(categoryName);%> Cakes</title>

	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>

	<div class="container-fluid" id="heading_section">
			<div class="container">
			
				<div class="row">
					<div class="col-sm-6">
						<h2 id="title"><a href="index.jsp" class="white">E-Cakery</a></h2>
					</div>
					<div class="col-sm-6" id="cart_section">
						<a href="Cart" class="white" id="cart"><span class="glyphicon glyphicon-shopping-cart"></span> <%out.print(cart.getCount());%> items</a>
						<span>|</span>
						<span class="dropdown">
							<button class="dropdown-toggle" data-toggle="dropdown">Hi, <%if(user==null){%>Guest<%}else{out.print(user.getFn());}%>
							<span class="caret"></span></button>
							<ul class="dropdown-menu">
							   	<%if(user==null){%><li><a data-toggle="modal" href="#login_modal">Login</a></li><%}%>
							   	<li><a data-toggle="modal" href="#registration_modal">Create New Account</a></li>
							   	<%if(user!=null){%><li><a href="LogOut">Logout</a></li><%}%>
							</ul>	
						</span>
					</div>
				</div>
			
			</div>
	</div><!-- End of heading section -->
	
	<div class="container">
	
		<div class="row">
			<div class="col-xs-12">
				<span><a class="color1" href="index.jsp">Home</a></span>
				<span>></span>
				<span><%out.print(categoryName);%> Cakes</span>
			</div>
		</div>
		
		<div class="row" style="margin-top: 20px;">
			<form action="" class="form-horizontal">			
				<div class="col-xs-6 col-sm-3">
					<select class="form-control" onchange="location = this.value">
						<option value="ChangePreference?weight=0&page=1" <%if(weight == 0){%>selected<%}%>>Select Weight</option>
						<option value="ChangePreference?weight=0.5&page=1" <%if(weight == 0.5){%>selected<%}%>>0.5 kg</option>
						<option value="ChangePreference?weight=1&page=1" <%if(weight == 1){%>selected<%}%>>1.0 kg</option> 
						<option value="ChangePreference?weight=1.5&page=1" <%if(weight == 1.5){%>selected<%}%>>1.5 kg</option>
						<option value="ChangePreference?weight=2&page=1" <%if(weight == 2.0){%>selected<%}%>>2.0 kg</option>
						<option value="ChangePreference?weight=3&page=1" <%if(weight == 3){%>selected<%}%>>3.0 kg</option>
					</select>
				</div>
				<div class="col-xs-6 col-sm-3">
					<select class="form-control" onchange="location = this.value">
						<option value="ChangePreference?floors=0&page=1" <%if(floors == 0){%>selected<%}%>>Select Floors</option>
						<option value="ChangePreference?floors=1&page=1" <%if(floors == 1){%>selected<%}%>>1</option>
						<option value="ChangePreference?floors=2&page=1" <%if(floors == 2){%>selected<%}%>>2</option>
						<option value="ChangePreference?floors=3&page=1" <%if(floors == 3){%>selected<%}%>>3</option>
						<option value="ChangePreference?floors=4&page=1" <%if(floors == 4){%>selected<%}%>>4</option>
						<option value="ChangePreference?floors=5&page=1" <%if(floors == 5){%>selected<%}%>>5</option>
					</select>
				</div>
				<div class="col-xs-6 col-sm-3">
					<select class="form-control" onchange="location = this.value">
						<option value="ChangePreference?price=0&page=1" <%if(price == 0){%>selected<%}%>>Select Price</option>
						<option value="ChangePreference?price=1&page=1" <%if(price == 1){%>selected<%}%>><= 250</option>
						<option value="ChangePreference?price=2&page=1" <%if(price == 2){%>selected<%}%>>251 - 500</option>
						<option value="ChangePreference?price=3&page=1" <%if(price == 3){%>selected<%}%>>501 - 750</option>
						<option value="ChangePreference?price=4&page=1" <%if(price == 4){%>selected<%}%>>751 - 1000</option>
						<option value="ChangePreference?price=5&page=1" <%if(price == 5){%>selected<%}%>>> 1000</option>
					</select>
				</div>
			</form>
		</div>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-xs-6">
				Select City:
				<select onchange="location = this.value">
					<%for(City c : cities){%>
						<option value="ChangePreference?city=<%out.print(c.getName());%>&page=1" <%if(city.getCid() == c.getCid()){%>selected<%}%> ><%out.print(c.getName());%></option>
					<%}%>
				</select>
			</div>
			<div class="col-xs-6 right">
				Sort By:
				<select onchange="location = this.value">
					<option value="ChangePreference?sortBy=1&page=1" <%if(sortBy == 1){%>selected<%}%>>Popularity</option>
					<option value="ChangePreference?sortBy=2&page=1" <%if(sortBy == 2){%>selected<%}%>>Rating</option>
					<option value="ChangePreference?sortBy=3&page=1" <%if(sortBy == 3){%>selected<%}%>>Price (Low to High)</option>
					<option value="ChangePreference?sortBy=4&page=1" <%if(sortBy == 4){%>selected<%}%>>Price(High to Low)</option>
				</select>
			</div>
		</div>
		
		<div class="row" style="margin-top: 30px;">
			<%for(Product product : products){%>
				<div class="col-sm-3 col-xs-6 cake_display">
					<div style="border: 1px solid #6d2854; padding-bottom: 5px;">
						<a href="Product?pid=<%out.print(product.getPid());%>"><img src="FetchImage?id=<%out.print(product.getImage());%>"></a>
						<div class="center font1">
							<h4><a href="Product?pid=<%out.print(product.getPid());%>"><%out.print(product.getName());%></a></h4>
							<span><small>weight: <%out.print(product.getWeight());%> kg</small></span><br>
							<span><small>Rs. <%out.print(product.getPrice());%></small></span><br>
							<small><%out.print(product.getRating());%> <span class="glyphicon glyphicon-star">/</span> 5.0 <span class="glyphicon glyphicon-star">	</span> (<%out.print(product.getNumOfRatings());%> ratings)</small><br>
							<%if(cart.contains(product)){%>
								<a style="margin-top: 5px;" class="btn btn-success" disabled>Added to Cart</a>
							<%}else{%>
								<a href="AddToCart?pid=<%out.print(product.getPid());%>" style="margin-top: 5px;" class="btn btn-success">Add to Cart</a>
							<%}%>							
						</div>
					</div>
				</div>
			<%}%>
		</div>
		
		<%if(products.size() > 0){%>
		<div class="row container">
            <ul class="pager col-xs-4 col-sm-4">
                <li class="previous" <%if(currentPage<=1){%> style="display:none;" <%}%>><a href="ChangePreference?page=<%out.print(currentPage-1);%>"><span class="glyphicon glyphicon-hand-left "></span> Previous</a></li>
            </ul>
            <ul class="pager col-xs-4 col-sm-4 pull-right">
                <li class="next" <%if(currentPage>=maxPages){%> style="display:none;" <%}%>><a href="ChangePreference?page=<%out.print(currentPage+1);%>">Next <span class="glyphicon glyphicon-hand-right"></span></a></li>
            </ul>
            <div id="page_nums" class="col-sm-4"> 
                <ul class="pagination">
                    <li><form action="ChangePreference">Page<input name="page" type="number" style="width: 40px;" min="1" max="<%out.print(maxPages);%>" value="<%out.print(currentPage);%>"> of <%out.print(maxPages);%> <input type="submit" value="Go"></form></li>
                </ul>
            </div>
        </div>
        <%}else{%>
        	<h3 class="red">No Cakes Found</h3>
 		<%}%>
	
	</div><!-- End of main container -->

	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>

</body>
</html>