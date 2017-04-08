<%@page import="model.Seller"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Category"%>
<%@page import="model.Product"%>
<%@page import="model.Order"%>
<%@page import="model.DAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<%request.getRequestDispatcher("message-on-top.jsp").include(request, response);%>

<%
	Seller seller = null;
	Order order = null;
	Product product = null;
	DAO dao = new DAO();
%>

<%
	if(session.getAttribute("seller")!=null)
		seller = (Seller)session.getAttribute("seller");
	else
		response.sendRedirect("seller-index.jsp");
	
	order = dao.getOrderByOid(Integer.parseInt(request.getParameter("oid")));
	product = order.getProduct();
	
	if(seller!=null)
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
	
	<div class="container">
	
		<div class="row" style="margin-bottom: 30px;">
			<div class="col-xs-12">
				<span><a class="color1" href="SellerHome">Home</a></span>
				<span>></span>
				<span><a class="color1" href="SellerHome">My Orders</a></span>
				<span>></span>
				<span><%out.print(order.getProduct().getName());%></span>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-4" id="product_image_section">
				<img src="FetchImage?id=<%out.print(order.getProduct().getImage());%>">
			</div>
			<div class="col-sm-8">
				<h3 class="font1"><a href="<%if(!product.getIsPhotoCake()){%>ViewCake<%}else{%>ViewPhotoCake<%}%>?pid=<%out.print(product.getPid());%>"><%out.print(product.getName());%></a></h3>
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
								<td>Packing slip </td>
								<td> : <a class="text-primary"><span class="glyphicon glyphicon-print"></span> Print</a></td>
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
					</div>
				</div>
			</div>
		</div>
	
	</div><!-- End of main container -->

	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>
    
</body>
<%}%>
</html>