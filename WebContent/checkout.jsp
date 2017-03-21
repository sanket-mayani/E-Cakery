<%@page import="model.User"%>
<%@page import="model.Cart"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<%
	Cart cart = new Cart();
	User user = null;
%>
<%
	if(session.getAttribute("cart") != null)
		cart = (Cart)session.getAttribute("cart");
	else
		session.setAttribute("cart", cart);

	if(session.getAttribute("user") != null)
		user = (User)session.getAttribute("user");
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Checkout</title>

	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>

<body>

	<%if(user != null){%>
	<div class="container">
	    <div class="row">
	        <div class="col-sm-4">
	        </div>
	        <div class="col-sm-4" id="logo"> 
	            <a href="ChangePreference?flavour=null&category=null&page=1"><img src="images/logo.png" alt="logo"></a>
	        </div>      
	        <div class="col-sm-4" id="cart">
	            <a href="Cart" class="btn btn-danger">    
	                <span class="glyphicon glyphicon-shopping-cart"></span><span> Cart: <%out.print(cart.getCount());%> items</span>
	            </a>
	        </div>      
	    </div>
    </div><!-- End of Header Section -->

	<div class="container-fluid" style="border-top: 1px solid black;"></div>
	
	<div class="container">
			
		<form>	
		
		<div class="alert alert-success alert-dismissable" style="margin-top: 10px;">
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
				<input class="form-control" type="text" name="mobile" value="<%out.print(user.getMob());%>" required>
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
				<input class="form-control" type="text" name="city" value="<%if(user.getCity()!=null)out.print(user.getCity().getName());%>" required>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-6" style="margin-top: 5px;">
				<input type="checkbox" name="save" value="true"> Save this address as default address
			</div>
		</div>
		
		<div class="row" style="margin-top: 30px; margin-bottom: 30px;">
			<div class="col-sm-3">
				<a class="btn btn-danger">Continue to Payment</a>
			</div>
		</div>
		
		</form>
	
	</div><!-- End of main container -->
	
	<div id="footer" class="container-fluid">
        
        <div class="row">
            <div class="col-sm-3" id="about">
                <h5>About Us</h5>
                <p><small>We deliver the best cakes in city from stores near you. We ensure that you get your cake on time and at very affordable price. So what are you waiting for? :)</small></p>
            </div>
            <div class="col-sm-3" id="connect">
                <h5>Connect With Us</h5>
                <a href="#"><img src="images/icons/fb_icon.png" alt="Facebook Icon" title="Facebook"></a>
                <a href="#"><img src="images/icons/twitter_icon.png" alt="Twitter Icon" title="Twitter"></a>
                <a href="#"><img src="images/icons/linked_in_icon.png" alt="LinkedIn Icon" title="LinkedIn"></a>
                <a href="#"><img src="images/icons/google_plus_icon.png" alt="Google Plus Icon" title="Google Plus"></a>
            </div>
            <div class="col-sm-3" id="contact">
                <h5>Need Help?</h5>
                <img src="images/icons/call_icon.png" alt="Call Icon" title="Call us">
                <span>+91 - 9033011287</span><br>
                <img src="images/icons/mail_icon.png" alt="Mail Icon" title="Send a mail">
                <span>support @ ecakery.in</span>
            </div>
            <div class="col-sm-3" id="credits">
                <h5>Crafted with <img src="images/icons/heart_icon.png" alt="Heart Icon"> by</h5>
                <p><small>Sanket Mayani<br>
                Vinit Mehta<br>
                Hardik Kanak<br>
                Mahesh Tolani</small></p>
            </div>
        </div>

    </div><!-- End of footer -->
	<%}else{response.sendRedirect("index.jsp");}%>
	
	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>
	
</body>

</html>