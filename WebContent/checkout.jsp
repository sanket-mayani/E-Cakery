<%@page import="model.Item"%>
<%@page import="java.util.List"%>
<%@page import="model.City"%>
<%@page import="model.User"%>
<%@page import="model.Cart"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<%request.getRequestDispatcher("message-on-top.jsp").include(request, response);%>

<%
	Cart cart = new Cart();
	User user = null;
	List<Item> items = null;
%>
<%
	if(session.getAttribute("cart") != null)
		cart = (Cart)session.getAttribute("cart");
	else
		session.setAttribute("cart", cart);

	if(session.getAttribute("user") != null)
		user = (User)session.getAttribute("user");
	
	items = cart.getItems();
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Checkout</title>

	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>

<body id="checkout">

	<%if(user != null){%>
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
	
		<div class="row" style="margin-bottom: 20px;">
			<div class="col-xs-12">
				<span><a class="color1" href="index.jsp">Home</a></span>
				<span>></span>
				<span><a class="color1" href="Cart">Cart (<%out.print(cart.getCount());%> items)</a></span>
				<span>></span>
				<span>Checkout</span>
			</div>
		</div>
			
		<form action="PlaceOrder" method="post" id="details">	
		
		<%if(cart.getCount() > 0){%>
			<div class="alert alert-success alert-dismissable" style="margin-top: 10px;">
	  			<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
	  			<p><strong>What you want to write on your cake?</strong></p>
			</div>
			
			<div class="row">
				<div class="col-xs-12">
					<h3>Write Your Wish</h3><hr>
				</div>
			</div>
		<%}%>
		
		<%for(Item item : items){%>
			<div class="row" style="margin-bottom: 10px;">
				<div class="col-xs-12">
					<table>
						<tr>
							<td rowspan="2"><img src="FetchImage?id=<%out.print(item.getProduct().getImage());%>" style="width: 100px; height: 80px; margin-right: 10px;"></td>
							<td><h3 style="margin: 0px;" class="font1"><%out.print(item.getProduct().getName());%></h3></td>
						</tr>
						<tr>
							<td><input type="text" name="msg<%out.print(item.getProduct().getPid());%>" class="form-control" placeholder="eg.Happy Birthday Sanket" required></td>
						</tr>
					</table>
				</div>
			</div>
		<%}%>
		
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
    
    <%request.getRequestDispatcher("registration-and-login-modal.jsp").include(request, response);%>
	
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