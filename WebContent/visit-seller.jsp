<%@page import="model.Cart"%>
<%@page import="model.User"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Session"%>
<%@page import="model.DAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="model.Seller,java.util.List,model.Product,model.DAO,java.util.Set,model.Category"%>
<!DOCTYPE html>
<html>

<%request.getRequestDispatcher("message-on-top.jsp").include(request, response);%>

<%!
	User user = null;
	Cart cart = new Cart();
	Seller seller = null;
	DAO dao = new DAO();
	List<Product> products =  null;
	List<Product> photoCakes = null;
%>
<%	
	if(session.getAttribute("user")!=null)
		user = (User)session.getAttribute("user");
	
	if(session.getAttribute("cart")!=null)
		cart = (Cart)session.getAttribute("cart");
	else
		session.setAttribute("cart", cart);
	
	seller = dao.getSellerBySid(Integer.parseInt(request.getParameter("sid")));

	products = dao.getProductsBySeller(seller,false);
	photoCakes = dao.getProductsBySeller(seller,true);
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Visit Seller (<%out.print(seller.getName());%>)</title>

	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
</head>
<body id="catalogue">

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
							   	<%if(user==null){%>
							   		<li><a data-toggle="modal" href="#login_modal">Login</a></li>
							   		<li><a data-toggle="modal" href="#registration_modal">Create New Account</a></li>
							   	<%}else{%>
							   		<li><a href="UserProfile">My Profile</a></li>
							   		<li><a href="UserOrders">My Orders</a></li>
							   		<li class="divider"></li>
							   		<li><a data-toggle="modal" href="#registration_modal">Create New Account</a></li>
							   		<li><a href="LogOut">Logout</a></li>
							   	<%}%>	
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
				<span>Visit Seller (<%out.print(seller.getName());%>)</span>
			</div>
		</div>
		
		<div class="row" style="margin-top: 30px;">
			<div class="col-xs-12">
				<h3 class="font1">Photograph Cakes</h3><hr>
			</div>
		</div>
		
		<div class="row">
			<%if(photoCakes.size()>0)
			{
				for(Product product : photoCakes)
				{
			%>
					<div class="col-sm-3 col-xs-6 cake_display">
						<div style="border: 1px solid #6d2854; padding-bottom: 5px;">
							<a href="PhotoCake?pid=<%out.print(product.getPid());%>"><img src="FetchImage?id=<%out.print(product.getImage());%>"></a>
							<div class="center font1">
								<h4><a href="Product?pid=<%out.print(product.getPid());%>"><%out.print(product.getName());%></a></h4>
								<span><small>weight: <%out.print(product.getWeight());%> kg</small></span><br>
								<span><small>Rs. <%out.print(product.getPrice());%></small></span><br>
								<small><%out.print(product.getRating());%> <span class="glyphicon glyphicon-star">/</span> 5.0 <span class="glyphicon glyphicon-star">	</span> (<%out.print(product.getNumOfRatings());%> ratings)</small><br>				
							</div>
						</div>
					</div>
			<%	}
			}else
			{
			%>
				<p class="col-xs-12 red">No cake added of this type.</a></p>
			<%
			}
			%>
		</div>
		
		<div class="row" style="margin-top: 30px;">
			<div class="col-xs-12">
				<h3 class="font1">Non-Photograph Cakes</h3><hr>
			</div>
		</div>
		
		<div class="row">
			<%if(products.size()>0)
			{
				for(Product product : products)
				{
			%>
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
			<%	}
			}else
			{
			%>
				<p class="col-xs-12 red">No cake added of this type.</a></p>
			<%
			}
			%>
		</div>
    
	</div><!-- End of main container -->
	
	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>
    
    <%request.getRequestDispatcher("registration-and-login-modal.jsp").include(request, response);%>

</body>
</html>