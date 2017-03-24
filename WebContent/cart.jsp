<%@page import="model.Product"%>
<%@page import="model.Item"%>
<%@page import="java.util.List"%>
<%@page import="model.Cart"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html> 

<% 
	if(session.getAttribute("message")!=null){
%>
		<p class="red container center"><%out.print(session.getAttribute("message"));%></p>
<% 
		session.removeAttribute("message");
	}
%>

<% 
	Cart cart = new Cart();
	List<Item> items = null;
%>
<%
	if(session.getAttribute("cart") != null)
		cart = (Cart)session.getAttribute("cart");
	else
		session.setAttribute("cart", cart);

	items = cart.getItems();
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>My Cart</title>

	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
</head>

<body>

	<div class="container hidden-xs" style="min-height: 500px;">
	
		<div class="row" style="margin-top: 50px; background-color: black; color:white; border-radius: 10px; padding:5px;">
			<h4 class="col-sm-12">Cart: <%out.print(items.size());%> items</h4>
		</div>
	
		<hr style="margin-top: 0px;">
		
		<%if(items.size()!= 0){%>
			<div class="row">
				<table class="col-sm-12" style="border-collapse: separate; border-spacing: 0 10px;">
					<tr style="">
						<th></th>
						<th><small><span style="margin-left: 20px;">Product</span></small></th>
						<th><small><span style="margin-left: 10px;">Seller</span></small></th>
						<th><small>Quantity</small></th>
						<th></th>
						<th><small>Price(&#8377)</small></th>
						<th></th>
						<th><small>Total(&#8377)</small></th>
						<th></th>
					</tr>
					<tr>
						<td colspan="9"><hr></td>
					</tr>
					<%for(Item i:items){%>
						<tr style="">
							<td style="width: 160px; padding: 5px; border-radius:10px 0px 0px 10px;">
								<img alt="" src="FetchImage?id=<%out.print(i.getProduct().getImage());%>" style="width: 100%; border: 1px solid black;">
							</td>
							<td>
								<span style="margin-left: 20px;"><%out.print(i.getProduct().getName());%></span>
							</td>
							<td>
								<span style="margin-left: 10px;"><%out.print(i.getProduct().getSeller().getName());%></span>
							</td>
							<td style="width:50px;">
								<form action="UpdateQuantity">
									<input type="hidden" name="pid" value="<%out.print(i.getProduct().getPid());%>">
									<input type="number" name="quantity" style="width: 40px;" min="1" max="10" value="<%out.print(i.getQuantity());%>">
							</td>
							<td style="width:40px;" class="center">
								*
							</td>
							<td style="width:50px;">
								<span><%out.print(i.getProduct().getPrice());%></span>
							</td>
							<td style="width:40px;" class="center">
								=
							</td>
							<td style="width:80px;">
								<span><%out.print(i.getProduct().getPrice() * i.getQuantity());%></span>
							</td>
							<td style="width:80px; border-radius:0px 10px 10px 0px;">
								<a href="RemoveFromCart?pid=<%out.print(i.getProduct().getPid());%>">Remove</a><br>
								<button type="submit" style="background-color: white; border:0px; padding:0px;"><a>Update Qty</a></button></form>
							</td>
						</tr>
					<%}%>
				</table>
			</div>
			
			<hr>
			
			<div class="row">
				<div class="bg-success" style="width:220px; float:right; text-align: right; border-radius:10px; padding:10px; margin-bottom: 50px">
					<div class="row">
						<h4 class="col-sm-7">Subtotal :</h4>
						<h4 class="col-sm-5"><%out.print(cart.getCartTotal());%></h4>
					</div>
					<div class="row">
						<h4 class="col-sm-7">+ Delivery :</h4>
						<h4 class="col-sm-5"><%out.print((float)cart.getTotalQuantity() * 30);%></h4>
					</div>
					<div class="row">
						<h4 class="col-sm-7">Total :</h4>
						<h4 class="col-sm-5"><%out.print(cart.getTotalQuantity() * 30 + cart.getCartTotal());%></h4>
					</div>
					<div class="row">
						<h4 class="col-sm-5"></h4>
						<h4 class="col-sm-7"><a href="Checkout" class="btn btn-danger">Checkout</a></h4>
					</div>
				</div>
			</div>
		<%}%>
		
	</div><!-- End of main container for larger devices -->	
	
	<div class="container hidden-sm hidden-md hidden-lg">
	
		<div class="row" style="margin-top: 50px; background-color: black; color:white; border-radius: 10px; padding:5px;">
			<h4 class="col-sm-12">Cart: <%out.print(items.size());%> items</h4>
		</div>
		
		<%for(Item i:items){%>
			<div class="row" style="margin-top: 10px;">
				<img src="FetchImage?id=<%out.print(i.getProduct().getImage());%>" style="float:left; width: 100px; border: 1px solid black; margin-left:10px; margin-right: 10px;">
				<p><b><%out.print(i.getProduct().getName());%></b></p>
				<p><small>Sold By: <%out.print(i.getProduct().getSeller().getName());%></small></p>
				<p><small>Price(&#8377): <%out.print(i.getProduct().getPrice());%></small></p>
			</div>
			<div class="row" style="margin-top: 10px; margin-left: 0px;">
				<form action="UpdateQuantity">
					<input type="hidden" name="pid" value="<%out.print(i.getProduct().getPid());%>">
					Quantity: <input type="number" name="quantity" style="width: 30px;" min="1" max="10" value="<%out.print(i.getQuantity());%>">
					<button type="submit" style="background-color: white; border:0px; padding:0px;"><a> Update</a></button>
					or <a href="RemoveFromCart?pid=<%out.print(i.getProduct().getPid());%>">Remove</a>
				</form>
			</div>
			<div class="row" style="margin-top: 10px; margin-left: 0px;">
				<span>Total: <%out.print(i.getProduct().getPrice() * i.getQuantity());%></span>
			</div>
			<hr>
		<%}%>
		
		<%if(!items.isEmpty()){%>
			<div class="row bg-success" style="text-align: right; border-radius:10px; padding:10px; margin-bottom: 50px">
				<div class="row">
					<h4 class="col-xs-7">Subtotal :</h4>
					<h4 class="col-xs-5"><%out.print(cart.getCartTotal());%></h4>
				</div>		
				<div class="row">
					<h4 class="col-xs-7">+ Delivery :</h4>
					<h4 class="col-xs-5"><%out.print((float)cart.getTotalQuantity() * 30);%></h4>
				</div>
				<div class="row">
					<h4 class="col-xs-7">Total :</h4>
					<h4 class="col-xs-5"><%out.print(cart.getTotalQuantity() * 30 + cart.getCartTotal());%></h4>
				</div>
				<div class="row">
					<h4 class="col-xs-5"></h4>
					<h4 class="col-xs-7"><a href="Checkout" class="btn btn-danger">Checkout</a></h4>
				</div>
			</div>
		<%}%>
	
	</div><!-- End of main container for extra small devices -->

	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>

</body>
</html>