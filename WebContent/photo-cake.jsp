<%@page import="model.Category"%>
<%@page import="model.DAO"%>
<%@page import="model.Product"%>
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
	DAO dao = new DAO();
	int pid;
	Product product = null;
%>

<%
	if(session.getAttribute("user")!=null)
		user = (User)session.getAttribute("user");

	if(session.getAttribute("cart")!=null)
		cart = (Cart)session.getAttribute("cart");
	else
		session.setAttribute("cart", cart);
	
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
	
		<div class="row">
			<div class="col-xs-12">
				<span><a class="color1" href="index.jsp">Home</a></span>
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
								<td>Sold By </td>
								<td> : <a href="VisitSeller?sid=<%out.print(product.getSeller().getSid());%>"><%out.print(product.getSeller().getName());%></a></td>
							</tr>
						</table>
					</div>
				</div>
				<%if(user==null){%>
					<div class="row" style="margin-top: 20px;">
						<hr>
						<div class="col-xs-12" id="add_to_cart_section">
							<a data-toggle="modal" href="#login_modal" style="margin-top: 5px;" class="btn btn-success"><span style="font-size: 18px;" class="font1">Login and Place order</span></a>
						</div>
					</div>
				<%}%>
			</div>
		</div>
		
		<%if(user!=null){%>
			<div class="row" style="margin-top: 30px;">
				<div class="col-xs-12 font1 center">
					<h3>Place order for this cake</h3><hr>
				</div>
			</div>
			
			<form action="PlacePhotoCakeOrder" method="post" enctype="multipart/form-data" id="details">
			
			<input type="hidden" name="pid" value="<%out.print(product.getPid());%>">
			
			<div class="alert alert-success alert-dismissable" style="margin-top: 10px;">
		  		<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
		 		<p><strong>What you want to write on your cake?</strong></p>
			</div>
				
			<div class="row">
				<div class="col-xs-12">
					<h3>Upload your photo and Write your wish</h3><hr>
				</div>
			</div>
			
			<div class="row" style="margin-bottom: 10px;">
				<div class="col-xs-12">
					<table>
						<tr>
							<td rowspan="2"><img id="uploadedPhoto" src="" style="width: 100px; height: 80px; margin-right: 10px;"></td>
							<td><h3 style="margin: 0px;" class="font1"><%out.print(product.getName());%></h3></td>
						</tr>
						<tr>
							<td><input type="text" name="msg" class="form-control" placeholder="eg.Happy Birthday Sanket" required></td>
						</tr>
						<tr>
							<td colspan="2"><br><input type="file" name="userPhoto" id="userPhoto" accept="image/gif, image/jpeg, image/png" required></td>
						</tr>
					</table>
				</div>
			</div>
			
			<div class="alert alert-success alert-dismissable" style="margin-top: 30px;">
	  			<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
	  			<p><strong>Please confirm delivery details.</strong></p>
			</div>
			
			<div class="row">
				<div class="col-xs-12">
					<h3>Personal Details</h3><hr>
				</div>
			</div>
			
			<div class="row">
				<div class="col-sm-3" style="margin-top: 5px;">
					<small>First Name</small>
					<input class="form-control" type="text" name="fn" value="<%out.print(user.getFn());%>" required>
				</div>
				<div class="col-sm-3" style="margin-top: 5px;">
					<small>Last Name</small>
					<input class="form-control" type="text" name="ln" value="<%out.print(user.getLn());%>" required>
				</div>
				<div class="col-sm-3" style="margin-top: 5px;">
					<small>Email</small>
					<input class="form-control" type="email" name="email" value="<%out.print(user.getUn());%>" required>
				</div>
				<div class="col-sm-3" style="margin-top: 5px;">
					<small>Mobile</small>
					<input class="form-control" type="text" name="mobile" id="mobile" value="<%out.print(user.getMob());%>" maxlength="10" required>
					<span id="mobile_msg" class="red" hidden>Invalid Mobile Number</span>
				</div>
			</div>
			
			<div class="row" style="margin-top: 30px;">
				<div class="col-xs-12">
					<h3>Delivery Address</h3><hr>
				</div>
			</div>
			
			<div class="row">
				<div class="col-sm-6" style="margin-top: 5px;">
					<small>Address</small>
					<textarea class="form-control" name="address" required><%if(user.getAddress()!=null)out.print(user.getAddress());%></textarea>
				</div>
				<div class="col-sm-3" style="margin-top: 5px;">
					<small>Pincode</small>
					<input class="form-control" type="text" name="pin" value="<%if(user.getPincode()!=0)out.print(user.getPincode());%>" required>
				</div>
				<div class="col-sm-3" style="margin-top: 5px;">
					<small>City</small>
					<input class="form-control" type="text" name="city" value="<%out.print(product.getSeller().getCity().getName());%>" disabled required>
				</div>
			</div>
			
			<div class="row">
				<div class="col-sm-6" style="margin-top: 5px;">
					<input type="checkbox" name="SaveAsDefault"> Save this address as default address
				</div>
			</div>
			
			<div class="row" style="margin-top: 30px; margin-bottom: 30px;">
				<div class="col-sm-3">
					<input type="submit" class="btn btn-danger" value="Place Order"/>
				</div>
			</div>
			
			</form>
		<%}%>
	
	</div><!-- End of main container -->
	
	<%request.getRequestDispatcher("registration-and-login-modal.jsp").include(request, response);%>

	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>
    
</body>
</html>