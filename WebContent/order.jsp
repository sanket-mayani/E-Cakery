<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Category"%>
<%@page import="model.Product"%>
<%@page import="model.Order"%>
<%@page import="model.DAO"%>
<%@page import="model.Cart"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<%request.getRequestDispatcher("message-on-top.jsp").include(request, response);%>

<%
	User user = null;
	Cart cart = new Cart();
	Order order = null;
	Product product = null;
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
	
	order = dao.getOrderByOid(Integer.parseInt(request.getParameter("oid")));
	product = order.getProduct();
	
	if(user!=null)
	{
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title><%out.print(order.getProduct().getName());%></title>

	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body id="order">

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
	
		<div class="row" style="margin-bottom: 30px;">
			<div class="col-xs-12">
				<span><a class="color1" href="index.jsp">Home</a></span>
				<span>></span>
				<span><a class="color1" href="UserOrders">My Orders</a></span>
				<span>></span>
				<span><%out.print(order.getProduct().getName());%></span>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-4" id="product_image_section">
				<img src="FetchImage?id=<%out.print(order.getProduct().getImage());%>">
			</div>
			<div class="col-sm-8">
				<h3 class="font1"><a href="<%if(!product.getIsPhotoCake()){%>Product<%}else{%>PhotoCake<%}%>?pid=<%out.print(product.getPid());%>"><%out.print(product.getName());%></a></h3>
				<hr>
				<div class="row font1">
					<div class="col-xs-4">
						&#8377 <%out.print(order.getAmount());%>
					</div>
					<div class="col-xs-4">
						<span class="glyphicon glyphicon-hdd"></span> <%out.print(product.getWeight());%> kg
					</div>
					<div class="col-xs-4">
						<%out.print(product.getRating());%> <span class="glyphicon glyphicon-star">/</span> 5.0 <span class="glyphicon glyphicon-star">	</span> (<%out.print(product.getNumOfRatings());%> ratings)
					</div>
				</div>
				<div class="row" style="margin-top: 20px;">
					<div class="col-sm-6">
						<h4 class="font2"><strong>Order Amount</strong></h4>
						<table>
							<tr>
								<td>Price </td>
								<td> : <%out.print(order.getAmount());%> (+30 Delivery)</td>
							</tr>
							<tr>
								<td>Qty </td>
								<td> : <%out.print(order.getQuantity());%></td>
							</tr>
							<tr>
								<td>Total </td>
								<td> : <%out.print((order.getAmount() * order.getQuantity()) + (30 * order.getQuantity()));%></td>
							</tr>
						</table>
					</div>
					<div class="col-sm-6">
						<h4 class="font2"><strong>Details</strong></h4>
						<table>
							<tr>
								<td>Seller </td>
								<td> : <a href="VisitSeller?sid=<%out.print(product.getSeller().getSid());%>"><%out.print(product.getSeller().getName());%></a></td>
							</tr>
							<tr>
								<td>Message </td>
								<td> : <%out.print(order.getMessage());%></td>
							</tr>
							<%if(product.getIsPhotoCake()){%>
								<tr>
									<td>Photo </td>
									<td> : <a href="DownloadUserPhoto?id=<%out.print(order.getUserPhoto());%>"><span class="glyphicon glyphicon-download-alt"></span> Download</a></td>
								</tr>
							<%}%>
						</table>
					</div>
				</div>
				<div class="row" style="margin-top: 20px;">
					<div class="col-sm-6">
						<h4 class="font2"><strong>Shipping Address</strong></h4>
						<p>
							<%out.print(order.getFname());%> <%out.print(order.getLname());%><br>
							<%out.print(order.getAddress());%><br>
							<%out.print(order.getPincode());%><br>
							<%out.print(order.getSeller().getCity().getName());%><br>		
						</p>
					</div>
					<div class="col-sm-6">
						<h4 class="font2"><strong>Contact</strong></h4>
						<span class="text-info"><span class="glyphicon glyphicon-earphone"></span> <%out.print(order.getMobile());%></span><br>
						<span class="text-info"><span class="glyphicon glyphicon-envelope"></span> <%out.print(order.getEmail());%></span><br>
					</div>
				</div>
				<div class="row" style="margin-top: 20px;">
					
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-12">
				<div class="well">
					<h3 class="font1 center">Order Status</h3><hr>
					<div class="font1 center" style="padding: 5px;">
						<span class="text-success">Placed At : <%out.print(new SimpleDateFormat("dd MMMMM, yyyy hh:mm aaa").format(order.getPlacedAt()));%></span><br>
						<%if(order.getShippedAt()!=null){%><span class="text-success">Shipped At : <%out.print(new SimpleDateFormat("dd MMMMM, yyyy hh:mm aaa").format(order.getShippedAt()));}%></span><br>
						<%if(order.getDeliveredAt()!=null){%><span class="text-success">Delivered At : <%out.print(new SimpleDateFormat("dd MMMMM, yyyy hh:mm aaa").format(order.getDeliveredAt()));}%></span><br>
						<%if(order.getCancelledAt()!=null){%><span class="text-danger">Cancelled At : <%out.print(new SimpleDateFormat("dd MMMMM, yyyy hh:mm aaa").format(order.getCancelledAt()));}%></span><br>
						<%if(order.getCancellationReason()!=null){%><span class="text-danger">Reason : <%out.print(order.getCancellationReason());}%></span><br>
						<%if(order.getStatus().equals("delivered")){%>
							<div id="rating_section">
							<%if(order.getUserRating()==0){%>
								<form action="RateProduct" method="post">
									<input type="hidden" name="oid" value="<%out.print(order.getOid());%>">
									Give Rating : <input type="number" name="rating" min="1" max="5" style="width: 40px;" required> <span class="glyphicon glyphicon-star">/</span> 5.0 <span class="glyphicon glyphicon-star">	</span> <input type="submit" value="Submit">
								</form>
							<%}else{%>
								Your Rating : <%out.print(order.getUserRating());%> <span class="glyphicon glyphicon-star">/</span> 5.0 <span class="glyphicon glyphicon-star">	</span>
							<%}%>
							</div>		
				  		<%}else if(!order.getStatus().startsWith("cancelled")){%>
				  			<a id="<%out.print(order.getOid());%>" class="btn btn-danger cancel_btn">CANCEL ORDER</a>
				  		<%}%>
					</div>
				</div>
			</div>
		</div>
	
	</div><!-- End of main container -->

	<%request.getRequestDispatcher("registration-and-login-modal.jsp").include(request, response);%>

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

</body>
<%}%>
</html>