<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="model.Seller,model.DAO,model.City,java.util.ArrayList,java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%!
	Seller s;
%>
<%	
	if(session.getAttribute("seller") != null)
		s = (Seller)session.getAttribute("seller");
	else
		response.sendRedirect("seller-index.jsp");
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>My Account</title>

	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
</head>
<body>

	<div class="container">
    	
        <div class="row">
            <div class="col-xs-12" id="logo"> 
                <a href="seller-home.jsp"><img src="images/logo.png" alt="logo"></a>
            </div>      
        </div>
              
    </div><!-- End of Header Section -->
    
    <nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="170">
    
        <div class="container-fluid">
            
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#seller-account-navigation_links">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span> 
            </button>
            
            <div class="collapse navbar-collapse" id="seller-account-navigation_links">
                
                <ul class="nav navbar-nav">
                    <li><a href="seller-home.jsp"><span class="glyphicon glyphicon-briefcase"></span><span> My Orders</span></a></li>
                    <li><a href="catalogue.jsp"><span class="glyphicon glyphicon-list-alt"></span> Catalogue</a></li>
                    <li><a href="payments.jsp"><span class="glyphicon glyphicon-usd"></span> Payments</a></li>
                    <li><a href="returns.jsp"><span class="glyphicon glyphicon-exclamation-sign"></span> Returns</a></li>            
                </ul>
                <ul class="nav navbar-nav navbar-right">                    
                    <li class="active"><a href="seller-account.jsp"><span class="glyphicon glyphicon-user"></span><span> My Account</span></a></li>
                    <li><a href="seller-index.jsp"><span class="glyphicon glyphicon-off"></span><span> Sign Out</span></a></li>
                </ul>
                
            </div>
            
        </div>
        
    </nav><!-- End of Navigation Bar -->
    
    <div class="container">
    
    	<form action="UpdateSellerAddressServlet" class="form-horizontal" method="post">
    		
    		<div class="row">
    		    		
	    		<div class="col-md-6" id="seller_basic_details">
	    			<h3>Basic Details <button type="button" class="btn btn-primary edit"><span class="glyphicon glyphicon-pencil"></span><span> Edit</span></button></h3><hr>
	    			<div class="row">
		    			<div class="col-md-12">
		    				<div class="form-group">
		    					<label class="control-label col-xs-3" for="name">Name:</label>
		    					<div class="col-xs-9">
		    						<input type="text" name="name" class="form-control" id="name" disabled="disabled" value="<%out.print(s.getName());%>" required>    						
		    					</div>
		    				</div>
		    			</div>
	    			</div>
	    			<div class="row">
		    			<div class="col-md-12">
		    				<div class="form-group">
		    					<label class="control-label col-xs-3" for="email">Email:</label>
		    					<div class="col-xs-9">
		    						<input type="email" name="email" class="form-control" id="email" disabled="disabled" value="<%out.print(s.getUn());%>" required>    						
		    					</div>
		    				</div>
		    			</div>
	    			</div>
	    			<div class="row">
		    			<div class="col-md-12">
		    				<div class="form-group">
		    					<label class="control-label col-xs-3" for="mobile">Mobile:</label>
		    					<div class="col-xs-9">
		    						<input type="text" name="mobile" class="form-control" id="mobile" disabled="disabled" value="<%out.print(s.getMobile());%>" required>    						
		    					</div>
		    				</div>
		    			</div>
	    			</div>
	    			<div class="row">
		    			<div class="col-md-12">
		    				<div class="form-group">
		    					<label class="control-label col-xs-3" for="acc">Account No:</label>
		    					<div class="col-xs-9">
		    						<input type="text" name="acc" class="form-control" id="acc" disabled="disabled" value="<%out.print(s.getAccno());%>" required>    						
		    					</div>
		    				</div>
		    			</div>
	    			</div>
	    			<div class="row">
		    			<div class="col-md-12">
		    				<div class="form-group">
		    					<label class="control-label col-xs-3" for="pan">PAN No:</label>
		    					<div class="col-xs-9">
		    						<input type="text" name="pan" class="form-control" id="pan" disabled="disabled" value="<%out.print(s.getPan());%>" required>    						
		    					</div>
		    				</div>
		    			</div>
	    			</div>
	    			<div class="row">
		    			<div class="col-md-12">
		    				<div class="form-group">
		    					<label class="control-label col-xs-3" for="ifsc">IFSC Code:</label>
		    					<div class="col-xs-9">
		    						<input type="text" name="ifsc" class="form-control" id="ifsc" disabled="disabled" value="<%out.print(s.getIfsc());%>" required>    						
		    					</div>
		    				</div>
		    			</div>
	    			</div>
	    			<div class="row">
		    			<div class="col-md-12">
		    				<div class="form-group">
		    					<label class="control-label col-xs-3" for="vat">VAT ID:</label>
		    					<div class="col-xs-9">
		    						<input type="text" name="vat" class="form-control" id="vat" disabled="disabled" value="<%out.print(s.getVatid());%>" required>    						
		    					</div>
		    				</div>
		    			</div>
	    			</div>
	    		</div>
    		
    			<div id="seller_address_details" class="col-md-6">
	    			<h3>Address Details <button type="button" class="btn btn-primary edit"><span class="glyphicon glyphicon-pencil"></span><span> Edit</span></button></h3><hr>
	    			<div class="row">
		    			<div class="col-md-12">
		    				<div class="form-group">
		    					<label class="control-label col-xs-3" for="address">Address:</label>
		    					<div class="col-xs-9">
		    						<textarea class="form-control" name="address" id="address" disabled="disabled" required><%if(s.getAddress()!= null)	out.print(s.getAddress());%></textarea>   						
		    					</div>
		    				</div>
		    			</div>
	    			</div>
	    			<div class="row">
		    			<div class="col-md-12">
		    				<div class="form-group">
		    					<label class="control-label col-xs-3" for="pin">Pincode:</label>
		    					<div class="col-xs-9">
		    						<input type="text" name="pin" class="form-control" id="pin" disabled="disabled" value="<%if(s.getPincode()!= 0) out.print(s.getPincode());%>" required>    						
		    					</div>
		    				</div>
		    			</div>
	    			</div>
	    			<div class="row">
		    			<div class="col-md-12">
		    				<div class="form-group">
		    					<label class="control-label col-xs-3" for="city">City:</label>
		    					<div class="col-xs-9">
		    						<select class="form-control" name="city" id="city" disabled="disabled" required>
		    							<option value="0">--Select City--</option>
		    							<%
		    								DAO dao = new DAO();
		    								List<City> cities = new ArrayList<City>();
		    								cities = dao.getAllCities();
		    								
		    								for(City city:cities)
		    								{
		    							%>
		    									<option value="<%out.print(city.getName());%>"><%out.print(city.getName());%></option>
		    							<%		
		    								}
		    							%>
		    						</select>    						
		    					</div>
		    				</div>
		    			</div>
	    			</div>
				</div>
				    		
    		</div>
    		
    		<div class="row" id="apply_changes_div">
    			<hr>
    			<input type="submit" class="btn btn-primary" value="Apply Changes">
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