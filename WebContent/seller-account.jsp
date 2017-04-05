<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="model.Seller,model.DAO,model.City,java.util.ArrayList,java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%request.getRequestDispatcher("message-on-top.jsp").include(request, response);%>

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

	<div class="container-fluid" id="heading_section">
			<div class="container">
			
				<div class="row">
					<div class="col-sm-6">
						<h2 id="title"><a href="index.jsp" class="white">E-Cakery</a></h2>
					</div>
					<div class="col-sm-6" id="cart_section">
						<span class="dropdown">
							<button class="dropdown-toggle" data-toggle="dropdown">Hi, <%out.print(s.getName());%>
							<span class="caret"></span></button>
							<ul class="dropdown-menu">
								<li><a href="SellerHome">My Orders</a></li>
							   	<li><a href="Catalogue">Catalogue</a></li>
							   	<li><a href="Payments">Payments</a></li>
							   	<li class="active"><a href="SellerAccount">My Account</a></li>
							   	<li class="divider"></li>
							   	<li><a href="seller-index.jsp">Logout</a></li>
							</ul>	
						</span>
					</div>
				</div>
			
			</div>
	</div><!-- End of heading section -->
    
    <div class="container">
    
    	<div class="row">
			<div class="col-xs-12">
				<span><a class="color1" href="seller-index.jsp">Home</a></span>
				<span>></span>
				<span>My Account</span>
			</div>
		</div>
    
    	<form action="UpdateSellerAddressServlet" class="form-horizontal" method="post">
    		
    		<div class="row" style="margin-top: 30px;">
    		    		
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

	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>

</body>
</html>