<%@page import="java.util.List"%>
<%@page import="model.City"%>
<%@page import="model.DAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<%
	User user = null;
	DAO dao = new DAO();
	List<City> cities = new ArrayList<City>();
%>

<%
	if(session.getAttribute("user") != null)
		user = (User)session.getAttribute("user");
	else
		response.sendRedirect(request.getHeader("referer"));
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>My Profile</title>
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>

	<div class="container">
	    <div class="row">
	        <div class="col-sm-4">
	        </div>
	        <div class="col-sm-4" id="logo"> 
	            <a href="ChangePreference?flavour=null&category=null&page=1"><img src="images/logo.png" alt="logo"></a>
	        </div>      
	        <div class="col-sm-4">
	        </div>      
	    </div>
    </div><!-- End of Header Section -->

    <nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="170">
    
        <div class="container-fluid">
            
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation_links">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span> 
            </button>
            
            <div class="collapse navbar-collapse" id="navigation_links">
                
                <ul class="nav navbar-nav">
                    <li><a href="ChangePreference?flavour=null&category=null&page=1" title="Home"><span class="glyphicon glyphicon-home"></span></a></li>
                    <li class="active"><a href="UserProfile">My Profile</a></li>
                    <li><a href="MyOrders">My Orders</a></li>           
                </ul>
                <ul class="nav navbar-nav navbar-right">              
                    <li><a href="LogOut"><span class="glyphicon glyphicon-off"></span> <span>Sign Out</span></a></li>
                </ul>
                
            </div>
            
        </div>
        
    </nav><!-- End of Navigation Bar -->
    
    <div class="container" style="margin-bottom: 30px;">
    	
    	<div class="row">
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
    		<div class="row">
    			<div class="col-sm-4 col-xs-12 col-xs-offset-0 col-sm-offset-2 row">
    				<input type="submit" class="btn btn-success col-xs-12 col-md-7" value="Apply Changes">
    			</div>
    		</div>
    	</form>
    	
    	<div class="row" style="margin-top: 20px;">
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
    		<div class="row">
    			<div class="col-sm-4 col-xs-12 col-xs-offset-0 col-sm-offset-2 row">
    				<input type="submit" class="btn btn-success col-xs-12 col-md-7" value="<%if(user.getAddress()!=null){%>Apply Changes<%}else{%>Add Now<%}%>">
    			</div>
    		</div>
    	</form>
    	
    	<div class="row" style="margin-top: 20px;">
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
    		<div class="row">
    			<div class="col-sm-4 col-xs-12 col-xs-offset-0 col-sm-offset-2 row">
    				<input type="submit" class="btn btn-success col-xs-12 col-md-7" value="Change Password">
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

	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>

</body>
</html>