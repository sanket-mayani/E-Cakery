<%@page import="model.Seller"%>
<%@page import="model.Category"%>
<%@page import="model.DAO"%>
<%@page import="model.Product"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<%request.getRequestDispatcher("message-on-top.jsp").include(request, response);%>

<%
	Seller seller = null;
	DAO dao = new DAO();
	int pid;
	Product product = null;
%>

<%
	if(session.getAttribute("seller")!=null)
		seller = (Seller)session.getAttribute("seller");
	
	pid = Integer.parseInt(request.getParameter("pid"));
	product = dao.getProductById(pid);
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title><%out.print(product.getName());%></title>

	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body id="product">

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
						   	<li><a href="Catalogue">Catalogue</a></li>
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
	
	<div class="container" style="margin-bottom: 30px;">
	
		<div class="row">
			<div class="col-xs-12">
				<span><a class="color1" href="index.jsp">Home</a></span>
				<span>></span>
				<span><a class="color1" href="Catalogue">Catalogue</a></span>
				<span>></span>
				<span><%out.print(product.getName());%></span>
			</div>
		</div>
		
		<div class="row" style="margin-top: 30px;">
			<div class="col-sm-4" id="product_image_section">
				<img src="FetchImage?id=<%out.print(product.getImage());%>">
			</div>
			<div class="col-sm-8">
				<h3 class="font1"><%out.print(product.getName());%></h3>
				<hr>
				<div class="row font1">
					<div class="col-xs-4">
						&#8377 <%out.print(product.getPrice());%>
					</div>
					<div class="col-xs-4">
						<span class="glyphicon glyphicon-hdd"></span> <%out.print(product.getWeight());%> kg
					</div>
					<div class="col-xs-4">
						<%out.print(product.getRating());%> <span class="glyphicon glyphicon-star">/</span> 5.0 <span class="glyphicon glyphicon-star">	</span> (<%out.print(product.getNumOfRatings());%> ratings)
					</div>
				</div>
				<div class="row" style="margin-top: 20px;">
					<div class="col-xs-12">
						<h4 class="font2"><strong>Description</strong></h4>
						<p><%out.print(product.getDescription());%></p>
					</div>
				</div>
				<div class="row" style="margin-top: 20px;">
					<div class="col-xs-12">
						<h4 class="font2"><strong>Overview</strong></h4>
						<table>
							<tr>
								<td>Flavour </td>
								<td> : <%out.print(product.getFlavour().getName());%></td>
							</tr>
							<tr>
								<td>Category </td>
								<td> : <%for(Category c : product.getCategories()){out.print(c.getName()+" ");}%></td>
							</tr>
							<tr>
								<td>No. of floors </td>
								<td> : <%out.print(product.getTier());%></td>
							</tr>
							<tr>
								<td>Qty left </td>
								<td> : <span style="color: <%if(product.getQuantity()<10){%>red;<%}else{%>green;<%}%>"><%out.print(product.getQuantity());%></span></td>
							</tr>
						</table>
					</div>
				</div>
				<div class="row" style="margin-top: 20px;">
					<form action="AddQuantity" method="post" class="form-horizontal">
						<input type="hidden" name="pid" value="<%out.print(product.getPid());%>">
						<div class="col-xs-12">
							<hr>
							<div class="form-group row">
							    <label for="qty" class="control-label col-sm-3 col-xs-12">Update Qty:</label>
							    <div class="col-xs-9 col-sm-6">
							    	<input type="number" class="form-control" id="qty" name="qty" placeholder="How many you want to add?" min="1">
							    </div>
								<div class="col-xs-3 col-sm-3">
									<input type="submit" value="Add" class="btn btn-success col-xs-12">
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="row" style="margin-top: 10px;">
					<form action="UpdatePrice" method="post" class="form-horizontal">
						<input type="hidden" name="pid" value="<%out.print(product.getPid());%>">
						<div class="col-xs-12">
							<div class="form-group row">
							    <label for="price" class="control-label col-sm-3 col-xs-12">Update Price:</label>
							    <div class="col-xs-9 col-sm-6">
							    	<input type="number" class="form-control" id="price" name="price" placeholder="Enter new price" min="1">
							    </div>
								<div class="col-xs-3 col-sm-3">
									<input type="submit" value="Update" class="btn btn-success col-xs-12">
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	
	</div><!-- End of main container -->
	
	<%request.getRequestDispatcher("registration-and-login-modal.jsp").include(request, response);%>

	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>
    
</body>
</html>