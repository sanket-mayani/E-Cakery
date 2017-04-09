<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Order"%>
<%@page import="model.User"%>
<%@page import="model.Cart"%>
<%@page import="model.Item"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE>
<html>

<%request.getRequestDispatcher("message-on-top.jsp").include(request, response);%>

<%
	Cart cart = new Cart();
	User user = null;
	ArrayList<Order> successList = null;
	ArrayList<Item> failureList = null;
%>

<%
	if(session.getAttribute("cart") != null)
		cart = (Cart)session.getAttribute("cart");
	else
		session.setAttribute("cart", cart);
	
	if(session.getAttribute("user")!=null)
		user = (User)session.getAttribute("user");

	successList = (ArrayList<Order>)session.getAttribute("successList");
	failureList = (ArrayList<Item>)session.getAttribute("failureList");
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Summary</title>

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
	
	<div class="container" style="margin-bottom: 30px;">
	
		<div class="row" style="margin-bottom: 30px;">
			<div class="col-xs-12">
				<span><a class="color1" href="index.jsp">Home</a></span>
				<span>></span>
				<span><a class="color1" href="Cart">Cart (<%out.print(cart.getCount());%> items)</a></span>
				<span>></span>
				<span>Summary</span>
			</div>
		</div>
		
		<%if(successList.size()>0){%>
			<h3 class="text-success font1 center" style="margin-top: 50px;">Order for the following items placed successfully</h3><hr>
			<%for(Order order : successList){%>
				<div class="panel panel-default">
			  			<div class="panel-heading font1" style="font-size: small;">
			  				<div class="row">
			  					<div class="col-sm-5">
			  						<p><a href="Order?oid=<%out.print(order.getOid());%>">Order# <%out.print(order.getOid());%></a></p>
			  						<p>Order placed on <%out.print(new SimpleDateFormat("dd MMMMM, yyyy hh:mm aaa").format(order.getPlacedAt()));%></p>
			  					</div>
			  					<div class="col-sm-3">
			  						<p>Total: <%out.print((order.getAmount()*order.getQuantity())+(30*order.getQuantity()));%></p>
			  					</div>
			  					<div class="col-sm-4 center">
			  					</div>
			  				</div>
			  			</div>
			  			<div class="panel-body hidden-xs">
			  				<table style="width: 100%;">
			  					<tr>
			  						<td style="width: 100px; height: 100px; border: 0px solid black;">
			  							<img src="FetchImage?id=<%out.print(order.getProduct().getImage());%>" style="width: 100%; height: 80%;">
			  						</td>
			  						<td style="vertical-align: top; padding-left: 20px;">
			  							<span class="font1"><strong><a href="<%if(!order.getProduct().getIsPhotoCake()){%>Product<%}else{%>PhotoCake<%}%>?pid=<%out.print(order.getProduct().getPid());%>"><%out.print(order.getProduct().getName());%></a></strong></span><br><br>
			  							<span><small>sold by: <%out.print(order.getSeller().getName());%></small></span><br>
			  							<span><small>price: <%out.print(order.getAmount());%> (+30 Delivery)</small></span><br>
			  							<span><small>Qty: <%out.print(order.getQuantity());%></small></span>
			  						</td>
			  					</tr>
			  				</table>
			  			</div>
			  			<div class="panel-body hidden-sm hidden-md hidden-lg">
			  				<span><strong><a href="<%if(!order.getProduct().getIsPhotoCake()){%>Product<%}else{%>PhotoCake<%}%>?pid=<%out.print(order.getProduct().getPid());%>"><%out.print(order.getProduct().getName());%></a></strong></span><br>
			  				<div style="margin-top: 10px;">
			  					<img src="FetchImage?id=<%out.print(order.getProduct().getImage());%>" style="width: 100px; height: 80px; float: left; margin-right: 20px;">
			  					<div>
			  						<span><small>sold by: <%out.print(order.getSeller().getName());%></small></span><br>
			  						<span><small>price: <%out.print(order.getAmount());%> (+30 Delivery)</small></span><br>
			  						<span><small>Qty: <%out.print(order.getQuantity());%></small></span>
			  					</div>
			  				</div>
			  			</div>
					</div>
			<%}%>
		<%}%>
		
		<%if(failureList.size()>0){%>
			<h3 class="text-danger font1 center" style="margin-top: 50px;">Order for the following items could not be placed, please try with less number of quantity</h3><hr>
			<%for(Item item : failureList){%>
				<div class="panel panel-default">
			  			<div class="panel-heading font1" style="font-size: small;">
			  				<div class="row">
			  					<div class="col-xs-12 center">
			  						<p class="text-danger">Available Quantity : <%out.print(item.getProduct().getQuantity());%></p>
			  					</div>
			  				</div>
			  			</div>
			  			<div class="panel-body hidden-xs">
			  				<table style="width: 100%;">
			  					<tr>
			  						<td style="width: 100px; height: 100px; border: 0px solid black;">
			  							<img src="FetchImage?id=<%out.print(item.getProduct().getImage());%>" style="width: 100%; height: 80%;">
			  						</td>
			  						<td style="vertical-align: top; padding-left: 20px;">
			  							<span class="font1"><strong><a href="<%if(!item.getProduct().getIsPhotoCake()){%>Product<%}else{%>PhotoCake<%}%>?pid=<%out.print(item.getProduct().getPid());%>"><%out.print(item.getProduct().getName());%></a></strong></span><br><br>
			  							<span><small>sold by: <%out.print(item.getProduct().getSeller().getName());%></small></span><br>
			  							<span><small>price: <%out.print(item.getProduct().getPrice());%> (+30 Delivery)</small></span><br>
			  							<span><small>Ordered Qty: <%out.print(item.getQuantity());%></small></span>
			  						</td>
			  					</tr>
			  				</table>
			  			</div>
			  			<div class="panel-body hidden-sm hidden-md hidden-lg">
			  				<span><strong><a href="<%if(!item.getProduct().getIsPhotoCake()){%>Product<%}else{%>PhotoCake<%}%>?pid=<%out.print(item.getProduct().getPid());%>"><%out.print(item.getProduct().getName());%></a></strong></span><br>
			  				<div style="margin-top: 10px;">
			  					<img src="FetchImage?id=<%out.print(item.getProduct().getImage());%>" style="width: 100px; height: 80px; float: left; margin-right: 20px;">
			  					<div>
			  						<span><small>sold by: <%out.print(item.getProduct().getSeller().getName());%></small></span><br>
			  						<span><small>price: <%out.print(item.getProduct().getPrice());%> (+30 Delivery)</small></span><br>
			  						<span><small>Ordered Qty: <%out.print(item.getQuantity());%></small></span>
			  					</div>
			  				</div>
			  			</div>
					</div>
			<%}%>
		<%}%>
		
		<div class="row right">
			<div class="col-xs-12">
				<a href="index.jsp" class="btn btn-primary">Continue Shopping</a>
			</div>
		</div>
	
	</div><!-- End of main container -->
	
	<%request.getRequestDispatcher("registration-and-login-modal.jsp").include(request, response);%>

	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>

</body>
</html>