<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.DAO"%>
<%@page import="model.Order"%>
<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<%
	User user = null;
	List<Order> orders = null;
	DAO dao = new DAO();
%>

<%
	if(session.getAttribute("user")!=null)
		user = (User)session.getAttribute("user");
	else
		response.sendRedirect("index.jsp");
	
	if(user!=null)
	{
		orders = dao.getOrderByUser(user);
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>My Orders</title>
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body id="user_orders">

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
                    <li><a href="UserProfile">My Profile</a></li>
                    <li class="active"><a href="MyOrders">My Orders</a></li>           
                </ul>
                <ul class="nav navbar-nav navbar-right">              
                    <li><a href="LogOut"><span class="glyphicon glyphicon-off"></span> <span>Sign Out</span></a></li>
                </ul>
                
            </div>
            
        </div>
        
    </nav><!-- End of Navigation Bar -->
    
    <div class="container">
    
    	<%
    		if(orders.size()>0)
    		{
    			for(Order order : orders)
    			{
    	%>
			    	<div class="panel <%if(order.getStatus().startsWith("cancelled")){%>panel-danger<%}else{%>panel-success<%}%>">
			  			<div class="panel-heading" style="font-size: small;">
			  				<div class="row">
			  					<div class="col-sm-5">
			  						<p>Order# <%out.print(order.getOid());%></p>
			  						<p>Order placed on <%out.print(new SimpleDateFormat("dd MMMMM, yyyy hh:mm aaa").format(order.getPlacedAt()));%></p>
			  					</div>
			  					<div class="col-sm-3">
			  						<p>Total: <%out.print(order.getAmount());%></p>
			  					</div>
			  					<div class="col-sm-4">
			  						<p>Status: <%out.print(order.getStatus());%></p>
			  					</div>
			  				</div>
			  			</div>
			  			<div class="panel-body hidden-xs">
			  				<table style="width: 100%;">
			  					<tr>
			  						<td style="width: 100px; height: 100px; border: 0px solid black;">
			  							<img src="FetchImage?id=<%out.print(order.getProduct().getImage());%>" style="width: 100%; height: 100%;">
			  						</td>
			  						<td style="vertical-align: top; padding-left: 20px;">
			  							<span><strong><%out.print(order.getProduct().getName());%></strong></span><br>
			  							<span><small>sold by: <%out.print(order.getSeller().getName());%></small></span><br>
			  							<span><small>price: <%out.print(order.getProduct().getPrice());%> (+30 Delivery)</small></span><br>
			  							<span><small>Qty: <%out.print(order.getQuantity());%></small></span>
			  						</td>
			  						<td style="width: 20%; vertical-align: top; padding-left: 10px;">
			  							<%if(order.getStatus().startsWith("cancelled")){%>
			  							<%}else if(order.getStatus().equals("delivered")){%>
			  								<a id="<%out.print(order.getOid());%>" class="btn btn-danger return_btn">Return Order</a>
			  							<%}else{%>
			  								<a id="<%out.print(order.getOid());%>" class="btn btn-danger cancel_btn">Cancel Order</a>
			  							<%}%>
			  						</td>
			  					</tr>
			  				</table>
			  			</div>
			  			<div class="panel-body hidden-sm hidden-md hidden-lg">
			  				<span><strong><%out.print(order.getProduct().getName());%></strong></span><br>
			  				<div style="margin-top: 10px;">
			  					<img src="FetchImage?id=<%out.print(order.getProduct().getImage());%>" style="width: 100px; height: 100px; float: left; margin-right: 20px;">
			  					<div>
			  						<span><small>sold by: <%out.print(order.getSeller().getName());%></small></span><br>
			  						<span><small>price: <%out.print(order.getProduct().getPrice());%> (+30 Delivery)</small></span><br>
			  						<span><small>Qty: <%out.print(order.getQuantity());%></small></span><br>
			  							<%if(order.getStatus().startsWith("cancelled")){%>
			  							<%}else if(order.getStatus().equals("delivered")){%>
			  								<a id="<%out.print(order.getOid());%>" class="return_btn">Return Order</a>
			  							<%}else{%>
			  								<a id="<%out.print(order.getOid());%>" class="cancel_btn">Cancel Order</a>
			  							<%}%>
			  					</div>
			  				</div>
			  			</div>
					</div>
		<%
				}
    		}
    		else
    		{
		%>
			<p class="red">No orders found</p>
		<%}%>
    
    </div>
    
    <!-- Order Cancellation Modal -->
	<div id="orderCancellationModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">Please choose a reason</h4>
	      </div>
	      <div class="modal-body">
	        <form method="post" action="CancelOrder">
			    <div class="radio">
			      <label><input type="radio" name="reason" value="I mistakenly ordered it" checked>I mistakenly ordered it</label>
			    </div>
			    <div class="radio">
			      <label><input type="radio" name="reason" value="Delivery is too late">Delivery is too late</label>
			    </div>
			    <div class="radio">
			      <label><input type="radio" name="reason" value="Price is too high">Price is too high</label>
			    </div>
			    <div class="radio">
			      <label><input type="radio" name="reason" value="I am not available to collect the order">I am not available to collect the order</label>
			    </div>
			    <div class="radio">
			      <label><input type="radio" name="reason" value="It is not needed anymore">It is not needed anymore</label>
			    </div>
			    <div class="radio">
			      <label><input type="radio" name="reason" value="Some other reason">Some other reason</label>
			    </div>
			    <input name="oid" id="oid_field" type="hidden" value="">
	      </div>
	      <div class="modal-footer">
	        <input type="submit" value="Cancel Order" class="btn btn-primary">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      	</form>
	      </div>
	    </div>
	
	  </div>
	</div><!-- End of Order Cancellation Modal -->

	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>

</body>
</html>
<%}%>