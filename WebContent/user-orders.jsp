<%@page import="model.Cart"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.DAO"%>
<%@page import="model.Order"%>
<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<%request.getRequestDispatcher("message-on-top.jsp").include(request, response);%>

<%
	User user = null;
	Cart cart = new Cart(); 
	List<Order> orders = null;
	DAO dao = new DAO();
%>

<%
	if(session.getAttribute("cart")!=null)
		cart = (Cart)session.getAttribute("cart");
	else
		session.setAttribute("cart", cart);

	if(session.getAttribute("user")!=null)
		user = (User)session.getAttribute("user");
	else
		response.sendRedirect("index.jsp");
	
	if(user!=null)
	{
		orders = dao.getOrderByUser(user);
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>My Orders</title>
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body id="user_orders">

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
						   		<li class="active"><a href="UserOrders">My Orders</a></li>
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
    
    	<div class="row" style="margin-bottom: 30px;">
			<div class="col-xs-12">
				<span><a class="color1" href="index.jsp">Home</a></span>
				<span>></span>
				<span>My Orders</span>
			</div>
		</div>
    
    	<%
    		if(orders.size()>0)
    		{
    			for(Order order : orders)
    			{
    	%>
			    	<div class="panel panel-default">
			  			<div class="panel-heading font1" style="font-size: small;">
			  				<div class="row">
			  					<div class="col-sm-5">
			  						<p><a href="Order?oid=<%out.print(order.getOid());%>">Order# <%out.print(order.getOid());%></a></p>
			  						<p>Order placed on <%out.print(new SimpleDateFormat("dd MMMMM, yyyy hh:mm aaa").format(order.getPlacedAt()));%></p>
			  					</div>
			  					<div class="col-sm-3">
			  						<p>Total: <%out.print(order.getAmount());%></p>
			  					</div>
			  					<div class="col-sm-4 center">
			  						<span class="label <%if(order.getStatus().startsWith("cancelled")){%>label-danger<%}else{%>label-success<%}%>" style="font-size: 12px;"><%out.print(order.getStatus().toUpperCase());%></span>
			  						<%if(order.getStatus().equals("delivered")){%>
			  							<a href="Order?oid=<%out.print(order.getOid());%>#rating_section" class="label label-danger">GIVE RATING</a>
			  						<%}else if(!order.getStatus().startsWith("cancelled")){%>
			  							<a id="<%out.print(order.getOid());%>" class="label label-danger cancel_btn">CANCEL ORDER</a>
			  						<%}%>
			  					</div>
			  				</div>
			  			</div>
			  			<div class="panel-body hidden-xs">
			  				<table style="width: 100%;">
			  					<tr>
			  						<td style="width: 100px; height: 100px; border: 0px solid black;">
			  							<img src="FetchImage?id=<%out.print(order.getProduct().getImage());%>" style="width: 100%; height: 100%;">
			  						</td>
			  						<td style="vertical-align: top; padding-left: 20px;">
			  							<span class="font1"><strong><%out.print(order.getProduct().getName());%></strong></span><br>
			  							<span><small>sold by: <%out.print(order.getSeller().getName());%></small></span><br>
			  							<span><small>price: <%out.print(order.getProduct().getPrice());%> (+30 Delivery)</small></span><br>
			  							<span><small>Qty: <%out.print(order.getQuantity());%></small></span>
			  						</td>
			  					</tr>
			  				</table>
			  			</div>
			  			<div class="panel-body hidden-sm hidden-md hidden-lg">
			  				<span><strong><%out.print(order.getProduct().getName());%></strong></span><br>
			  				<div style="margin-top: 10px;">
			  					<img src="FetchImage?id=<%out.print(order.getProduct().getImage());%>" style="width: 100px; height: 100px; float: left; margin-right: 20px;">
			  					<div>
			  						<span><small>sold by: <%out.print(order.getSeller().getName());%></small></span><br>
			  						<span><small>price: <%out.print(order.getProduct().getPrice());%> (+30 Delivery)</small></span><br>
			  						<span><small>Qty: <%out.print(order.getQuantity());%></small></span>
			  					</div>
			  				</div>
			  			</div>
					</div>
		<%
				}
    		}
    		else
    		{
		%>
			<p class="red">No orders found</p>
		<%
			}
		%>
    
    </div>

	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>
    
    <!-- Order Cancellation Modal -->
	<div id="orderCancellationModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">Please choose a reason</h4>
	      </div>
	      <div class="modal-body">
	        <form method="post" action="CancelOrder">
			    <div class="radio">
			      <label><input type="radio" name="reason" value="I mistakenly ordered it" checked>I mistakenly ordered it</label>
			    </div>
			    <div class="radio">
			      <label><input type="radio" name="reason" value="Delivery is too late">Delivery is too late</label>
			    </div>
			    <div class="radio">
			      <label><input type="radio" name="reason" value="Price is too high">Price is too high</label>
			    </div>
			    <div class="radio">
			      <label><input type="radio" name="reason" value="I am not available to collect the order">I am not available to collect the order</label>
			    </div>
			    <div class="radio">
			      <label><input type="radio" name="reason" value="It is not needed anymore">It is not needed anymore</label>
			    </div>
			    <div class="radio">
			      <label><input type="radio" name="reason" value="Some other reason">Some other reason</label>
			    </div>
			    <input name="oid" id="oid_field" type="hidden" value="">
	      </div>
	      <div class="modal-footer">
	        <input type="submit" value="Cancel Order" class="btn btn-primary">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      	</form>
	      </div>
	    </div>
	
	  </div>
	</div><!-- End of Order Cancellation Modal -->
	
	<%request.getRequestDispatcher("registration-and-login-modal.jsp").include(request, response);%>

</body>
</html>
<%}%>