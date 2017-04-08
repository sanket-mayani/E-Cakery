<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Session"%>
<%@page import="model.DAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="model.Seller,java.util.List,model.Product,model.DAO,java.util.Set,model.Category"%>
<!DOCTYPE html>
<html>

<%request.getRequestDispatcher("message-on-top.jsp").include(request, response);%>

<%!
	Seller seller;
	DAO dao = new DAO();
	List<Product> products =  null;
	List<Product> photoCakes = null;
%>
<%	
	if(session.getAttribute("seller") != null)
		seller = (Seller)session.getAttribute("seller");
	else
		response.sendRedirect("seller-index.jsp");

	products = dao.getProductsBySeller(seller,false);
	photoCakes = dao.getProductsBySeller(seller,true);
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Catalogue</title>

	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
</head>
<body id="catalogue">

	<div class="container-fluid" id="heading_section">
		<div class="container">
			
			<div class="row">
				<div class="col-sm-6">
					<h2 id="title"><a href="seller-index.jsp" class="white">E-Cakery</a></h2>
				</div>
				<div class="col-sm-6" id="cart_section">
					<span class="dropdown">
						<button class="dropdown-toggle" data-toggle="dropdown">Hi, <%out.print(seller.getName());%>
						<span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li><a href="SellerHome">My Orders</a></li>
						   	<li class="active"><a href="Catalogue">Catalogue</a></li>
						   	<li><a href="Payments">Payments</a></li>
						   	<li><a href="SellerAccount">My Account</a></li>
						   	<li class="divider"></li>
						   	<li><a href="seller-index.jsp">Logout</a></li>
						</ul>	
					</span>
				</div>
			</div>
			
		</div>
	</div><!-- End of heading section -->
    
    <div class="container">
    
    	<div class="row">
			<div class="col-xs-12">
				<span><a class="color1" href="SellerHome">Home</a></span>
				<span>></span>
				<span>Catalogue</span>
			</div>
		</div>
		
		<div class="row" style="margin-top: 30px;">
			<div class="col-xs-12">
				<h3 class="font1">Photograph Cakes (<a href="AddPhotoCake">Add New Photo Cake</a>)</h3><hr>
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
							<a href="ViewPhotoCake?pid=<%out.print(product.getPid());%>"><img src="FetchImage?id=<%out.print(product.getImage());%>"></a>
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
				<h3 class="font1">Non-Photograph Cakes (<a href="AddNewCake">Add New Cake</a>)</h3><hr>
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
							<a href="ViewCake?pid=<%out.print(product.getPid());%>"><img src="FetchImage?id=<%out.print(product.getImage());%>"></a>
							<div class="center font1">
								<h4><a href="Product?pid=<%out.print(product.getPid());%>"><%out.print(product.getName());%></a></h4>
								<span><small>weight: <%out.print(product.getWeight());%> kg</small></span><br>
								<span><small>Rs. <%out.print(product.getPrice());%></small></span><br>
								<small><%out.print(product.getRating());%> <span class="glyphicon glyphicon-star">/</span> 5.0 <span class="glyphicon glyphicon-star">	</span> (<%out.print(product.getNumOfRatings());%> ratings)</small><br>
								<span>Qty left: <span style="color: <%if(product.getQuantity()<10){%>red;<%}else{%>green;<%}%>"><%out.print(product.getQuantity());%></span></span><br>							
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

</body>
</html>