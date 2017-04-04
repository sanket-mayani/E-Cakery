<%@page import="model.Cart"%>
<%@page import="java.util.List"%>
<%@page import="model.City"%>
<%@page import="model.DAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<%
	if(session.getAttribute("message") != null)
	{
		String message = session.getAttribute("message").toString();
		String class_var = session.getAttribute("class").toString();
		session.removeAttribute("message");
		session.removeAttribute("class");
		if(message != null)	
		{
%>
			<div class="alert alert-dismissable <%out.print(class_var);%>" style="text-align: center">
				<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
				<p style="font-size: 18px"><%out.print(message);%></p>
			</div>
<% 			
		}	
	}
%>

<%
	User user = null;
	Cart cart = new Cart();
	DAO dao = new DAO();
	List<City> cities = new ArrayList<City>();
%>

<%
	if(session.getAttribute("cart")!=null)
		cart = (Cart)session.getAttribute("cart");
	else
		session.setAttribute("cart", cart);
	
	if(session.getAttribute("user") == null)
		response.sendRedirect("index.jsp");
	else
	{
		user = (User)session.getAttribute("user");	
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>My Profile</title>
	
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
						   		<li class="active"><a href="UserProfile">My Profile</a></li>
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
				<span>My Profile</span>
			</div>
		</div>
    	
    	<div class="row font1">
    		<div class="col-xs-12">
    			<h3>Basic Details</h3><hr>
    		</div>
    	</div>
    	
    	<form class="form-horizontal" method="post" action="UpdateUserDetails?action=PersonalDetails">
    		<div class="form-group">
    			<label class="control-label col-sm-2" for="fname">First Name: </label>
    			<div class="col-sm-4">
    				<input type="text" name="fname" id="fname" value="<%out.print(user.getFn());%>" class="form-control" required>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="control-label col-sm-2" for="lname">Last Name: </label>
    			<div class="col-sm-4">
    				<input type="text" name="lname" id="lname" value="<%out.print(user.getLn());%>" class="form-control" required>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="control-label col-sm-2" for="email">Email: </label>
    			<div class="col-sm-4">
    				<input type="email" name="email" id="email" value="<%out.print(user.getUn());%>" class="form-control" disabled>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="control-label col-sm-2" for="mobile">Mobile: </label>
    			<div class="col-sm-4">
    				<input type="text" name="mobile" id="mobile" value="<%out.print(user.getMob());%>" class="form-control" required>
    			</div>
    		</div>
    		<div class="row font1">
    			<div class="col-sm-4 col-xs-12 col-xs-offset-0 col-sm-offset-2 row">
    				<input type="submit" class="btn btn-success col-xs-12 col-md-7" value="Apply Changes">
    			</div>
    		</div>
    	</form>
    	
    	<div class="row font1" style="margin-top: 20px;">
    		<div class="col-xs-12">
    			<h3 style="display: inline;">Address </h3>
    			<%if(user.getAddress() == null){%>
    				<span class="red"> (You haven't added your address.)</span>
    			<%}%><hr>
    		</div>
    	</div>
    	
    	<form class="form-horizontal" method="post" action="UpdateUserDetails?action=AddressDetails">
    		<div class="form-group">
    			<label class="control-label col-sm-2" for="address">Address: </label>
    			<div class="col-sm-4">
    				<textarea name="address" id="address" class="form-control" required><%if(user.getAddress() != null)out.print(user.getAddress());%></textarea>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="control-label col-sm-2" for="pincode">Pincode: </label>
    			<div class="col-sm-4">
    				<input type="text" name="pincode" id="pincode" value="<%if(user.getPincode()!=0)out.print(user.getPincode());%>" class="form-control" required>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="control-label col-sm-2" for="city">City: </label>
    			<div class="col-sm-4">
    				<select name="city" id="city" class="form-control" required>
    					<% 
    						cities = dao.getAllCities();
    						for(City c:cities)
    						{	
    					%>
    							<option value="<%out.print(c.getName());%>" <%if(user.getCity()!=null && user.getCity().getCid() == c.getCid()){%>selected<%}%>><%out.print(c.getName());%></option>
    					<%	
    						}
    					%>
    				</select>
    			</div>
    		</div>
    		<div class="row font1">
    			<div class="col-sm-4 col-xs-12 col-xs-offset-0 col-sm-offset-2 row">
    				<input type="submit" class="btn btn-success col-xs-12 col-md-7" value="<%if(user.getAddress()!=null){%>Apply Changes<%}else{%>Add Now<%}%>">
    			</div>
    		</div>
    	</form>
    	
    	<div class="row font1" style="margin-top: 20px;">
    		<div class="col-xs-12">
    			<h3>Change Password</h3><hr>
    		</div>
    	</div>
    	
    	<form class="form-horizontal" method="post" action="UpdateUserDetails?action=PasswordChange">
    		<div class="form-group">
    			<label class="control-label col-sm-2" for="current">Current Password: </label>
    			<div class="col-sm-4">
    				<input type="password" name="currentpassword" id="current" class="form-control" required/>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="control-label col-sm-2" for="new">New Password: </label>
    			<div class="col-sm-4">
    				<input type="password" name="newpassword" id="new" class="form-control" required/>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="control-label col-sm-2" for="re-pwd">Re-Enter Password: </label>
    			<div class="col-sm-4">
    				<input type="password" name="newpassword2" id="re-pwd" class="form-control" required/>
    			</div>
    		</div>
    		<div class="row font1">
    			<div class="col-sm-4 col-xs-12 col-xs-offset-0 col-sm-offset-2 row">
    				<input type="submit" class="btn btn-success col-xs-12 col-md-7" value="Change Password">
    			</div>
    		</div>
    	</form>
    	
    </div><!-- End of main container -->

	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>

</body>
<%}%>
</html>
