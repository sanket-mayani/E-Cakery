<%@page import="model.City"%>
<%@page import="model.User"%>
<%@page import="model.Cart"%>
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

<body id="checkout">

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
			
		<form action="PlaceOrder" method="post" id="details">	
		
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
				<input class="form-control" type="text" name="city" value="<%if(cart.getCity()!=null)out.print(cart.getCity().getName());%>" disabled required>
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
	<%}else{%>
		<p style="text-align: center; margin-top: 10px;"><a data-toggle="modal" href="#login_modal">Click here to login</a></p>
	<%}%>
	
	<!-- Login Modal -->
    <div id="login_modal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title red">You must login first</h4>
                </div>
                <form class="form-horizontal" action="Login" id="login_form">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="control-label col-sm-3" for="email">Email:</label>
                            <div class="col-sm-9">
                                <input type="email" class="form-control" id="login_email" placeholder="Enter email"  name="email" required="required">
                                <small><span id="login_email_msg" hidden="hidden" class="red">Email Not Registered</span></small>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-3" for="pwd">Password:</label>
                            <div class="col-sm-9"> 
                                <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pw" required="required">
                            </div>
                        </div>
                    </div><!-- End of modal body -->
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary" id="login">Login</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                    </div><!-- End of modal footer -->    
                </form><!-- End of login form -->
            </div><!-- End of modal content -->

        </div><!-- End of modal dialogue -->
    </div><!-- End of login Modal -->
	
	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>
     <%
		if(session.getAttribute("user")==null)
		{
	%>
			<script type="text/javascript">
				$("#login_modal").modal('show');
			</script>
	<%		
		}
    %>
	
</body>

</html>