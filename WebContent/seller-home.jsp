<%@page import="model.DAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Order"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="model.Seller"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

<%!
	Seller seller = null;
	String date = null;
	List<Order> orders = null;
	DAO dao = new DAO();
%>
<%
	if(session.getAttribute("seller") == null)
		response.sendRedirect("seller-index.jsp");
	else
	{
		seller = (Seller)session.getAttribute("seller");
		
		date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		System.out.println(date);
%>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Seller Home</title>
    
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>

<body id="seller_home_body">

	<div class="container">
    	
        <div class="row">
            <div class="col-xs-12" id="logo"> 
                <a href="seller-home.jsp"><img src="images/logo.png" alt="logo"></a>
            </div>      
        </div>
              
    </div><!-- End of Header Section -->
    
    <nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="170">
    
        <div class="container-fluid">
            
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#seller-home-navigation_links">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span> 
            </button>
            
            <div class="collapse navbar-collapse" id="seller-home-navigation_links">
                
                <ul class="nav navbar-nav">
                    <li class="active"><a href="seller-home.jsp"><span class="glyphicon glyphicon-briefcase"></span><span> My Orders</span></a></li>
                    <li><a href="catalogue.jsp"><span class="glyphicon glyphicon-list-alt"></span> Catalogue</a></li>
                    <li><a href="payments.jsp"><span class="glyphicon glyphicon-usd"></span> Payments</a></li>
                    <li><a href="returns.jsp"><span class="glyphicon glyphicon-exclamation-sign"></span> Returns</a></li>            
                </ul>
                <ul class="nav navbar-nav navbar-right">                    
                    <li><a href="seller-account.jsp"><span class="glyphicon glyphicon-user"></span><span> My Account</span></a></li>
                    <li><a href="seller-index.jsp"><span class="glyphicon glyphicon-off"></span><span> Sign Out</span></a></li>
                </ul>
                
            </div>
            
        </div>
        
    </nav><!-- End of Navigation Bar -->
    
    <div class="container">
    
    	<div class="row">
    		<form class="col-sm-9">
    				<span>Show orders for:</span><br> 
    				<input type="date" value="<%out.print(date);%>"> <input type="submit" value="Go"> 
    		</form>
    		<div class="col-sm-3" id="history">
    			<a class="btn btn-primary">Order History</a>
    		</div>
    	</div><hr><br>
    	
    	<div class="row orders_div">
    		<div class="col-xs-12">
    			
    			<ul class="nav nav-tabs">
				  <li class="active"><a data-toggle="tab" href="#to_acknowledge">To Acknowledge</a></li>
				  <li><a data-toggle="tab" href="#approved">Approved</a></li>
				  <li><a data-toggle="tab" href="#packed">Packed</a></li>
				  <li><a data-toggle="tab" href="#shipped">Shipped</a></li>
				  <li><a data-toggle="tab" href="#delivered">Delivered</a></li>
				  <li><a data-toggle="tab" href="#cancelled">Cancelled</a></li>
				</ul>
				
				<div class="tab-content">
					<div id="to_acknowledge" class="tab-pane fade in active">
						<%
							orders = dao.FetchOrders(seller,"placed");
							if(orders.size()>0)
							{
						%>
						<div class="table-responsive">
							<table class="table">
								<thead>
									<tr>
										<th>Date</th>
										<th>Order Details</th>
										<th colspan="2">Item Details</th>
										<th>Customer Details</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<%for(Order order : orders){%>
									<tr>
										<td><%out.print(new SimpleDateFormat("dd MMMMM, yyyy").format(order.getDateTime()));%><br><small><%out.print(new SimpleDateFormat("hh:mm aaa").format(order.getDateTime()));%></small></td>
										<td>
											Order# <%out.print(order.getOid());%><br>
											status: <span class="text-danger">yet to approve</span>
										</td>
										<td class="image_td">
											<img src="FetchImage?id=<%out.print(order.getProduct().getImage());%>">
										</td>
										<td>
											<strong><%out.print(order.getProduct().getName());%></strong><br>
											<small>PID: <%out.print(order.getProduct().getPid());%></small><br>
											<small>Price: <%out.print(order.getProduct().getPrice());%></small><br>
											<small>Qty: <%out.print(order.getQuantity());%></small>
										</td>
										<td class="address_td">
											<strong><%out.print(order.getFname()+" "+order.getLname());%></strong><br>
											<small><%out.print(order.getAddress());%></small><br>
											<small><%out.print(order.getSeller().getCity().getName());%></small><br>
											<small><%out.print(order.getPincode());%></small>
										</td>
										<td>
											<a class="text-success"><span class="glyphicon glyphicon-ok"></span> Approve order</a><br><br>
											<a class="text-danger"><span class="glyphicon glyphicon-remove"></span> Can not fulfill</a>
										</td>
									</tr>
									<%}%>
								</tbody>
							</table>
						</div>
						<%}%>
					</div>
					<div id="approved" class="tab-pane fade in">
						<%
							orders = dao.FetchOrders(seller,"approved");
							if(orders.size()>0)
							{
						%>
						<div class="table-responsive">
							<table class="table">
								<thead>
									<tr>
										<th>Date</th>
										<th>Order Details</th>
										<th colspan="2">Item Details</th>
										<th>Customer Details</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<%for(Order order : orders){%>
									<tr>
										<td><%out.print(new SimpleDateFormat("dd MMMMM, yyyy").format(order.getDateTime()));%><br><small><%out.print(new SimpleDateFormat("hh:mm aaa").format(order.getDateTime()));%></small></td>
										<td>
											Order# <%out.print(order.getOid());%><br>
											status: <span class="text-danger">yet to pack</span>
										</td>
										<td class="image_td">
											<img src="FetchImage?id=<%out.print(order.getProduct().getImage());%>">
										</td>
										<td>
											<strong><%out.print(order.getProduct().getName());%></strong><br>
											<small>PID: <%out.print(order.getProduct().getPid());%></small><br>
											<small>Price: <%out.print(order.getProduct().getPrice());%></small><br>
											<small>Qty: <%out.print(order.getQuantity());%></small>
										</td>
										<td class="address_td">
											<strong><%out.print(order.getFname()+" "+order.getLname());%></strong><br>
											<small><%out.print(order.getAddress());%></small><br>
											<small><%out.print(order.getSeller().getCity().getName());%></small><br>
											<small><%out.print(order.getPincode());%></small>
										</td>
										<td>
											<a class="text-success"><span class="glyphicon glyphicon-ok"></span> Order is packed</a><br><br>
											<a class="text-primary"><span class="glyphicon glyphicon-print"></span> Print packing slip</a>
										</td>
									</tr>
									<%}%>
								</tbody>
							</table>
						</div>
						<%}%>
					</div>
					<div id="packed" class="tab-pane fade in">
						<%
							orders = dao.FetchOrders(seller,"packed");
							if(orders.size()>0)
							{
						%>
						<div class="table-responsive">
							<table class="table">
								<thead>
									<tr>
										<th>Date</th>
										<th>Order Details</th>
										<th colspan="2">Item Details</th>
										<th>Customer Details</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<%for(Order order : orders){%>
									<tr>
										<td><%out.print(new SimpleDateFormat("dd MMMMM, yyyy").format(order.getDateTime()));%><br><small><%out.print(new SimpleDateFormat("hh:mm aaa").format(order.getDateTime()));%></small></td>
										<td>
											Order# <%out.print(order.getOid());%><br>
											status: <span class="text-success">ready to be shipped</span>
										</td>
										<td class="image_td">
											<img src="FetchImage?id=<%out.print(order.getProduct().getImage());%>">
										</td>
										<td>
											<strong><%out.print(order.getProduct().getName());%></strong><br>
											<small>PID: <%out.print(order.getProduct().getPid());%></small><br>
											<small>Price: <%out.print(order.getProduct().getPrice());%></small><br>
											<small>Qty: <%out.print(order.getQuantity());%></small>
										</td>
										<td class="address_td">
											<strong><%out.print(order.getFname()+" "+order.getLname());%></strong><br>
											<small><%out.print(order.getAddress());%></small><br>
											<small><%out.print(order.getSeller().getCity().getName());%></small><br>
											<small><%out.print(order.getPincode());%></small>
										</td>
										<td>
											<a class="text-success"><span class="glyphicon glyphicon-ok"></span> Confirm shipping</a><br><br>
										</td>
									</tr>
									<%}%>
								</tbody>
							</table>
						</div>
						<%}%>
					</div>
					<div id="shipped" class="tab-pane fade in">
						<%
							orders = dao.FetchOrders(seller,"shipped");
							if(orders.size()>0)
							{
						%>
						<div class="table-responsive">
							<table class="table">
								<thead>
									<tr>
										<th>Date</th>
										<th>Order Details</th>
										<th colspan="2">Item Details</th>
										<th>Customer Details</th>
										<th>Shipped At</th>
									</tr>
								</thead>
								<tbody>
									<%for(Order order : orders){%>
									<tr>
										<td><%out.print(new SimpleDateFormat("dd MMMMM, yyyy").format(order.getDateTime()));%><br><small><%out.print(new SimpleDateFormat("hh:mm aaa").format(order.getDateTime()));%></small></td>
										<td>
											Order# <%out.print(order.getOid());%><br>
											status: <span class="text-success">item is shipped</span>
										</td>
										<td class="image_td">
											<img src="FetchImage?id=<%out.print(order.getProduct().getImage());%>">
										</td>
										<td>
											<strong><%out.print(order.getProduct().getName());%></strong><br>
											<small>PID: <%out.print(order.getProduct().getPid());%></small><br>
											<small>Price: <%out.print(order.getProduct().getPrice());%></small><br>
											<small>Qty: <%out.print(order.getQuantity());%></small>
										</td>
										<td class="address_td">
											<strong><%out.print(order.getFname()+" "+order.getLname());%></strong><br>
											<small><%out.print(order.getAddress());%></small><br>
											<small><%out.print(order.getSeller().getCity().getName());%></small><br>
											<small><%out.print(order.getPincode());%></small>
										</td>
										<td>
											Date<br>
											Time<br>
											<a class="text-success"><span class="glyphicon glyphicon-map-marker"></span> Track item</a><br><br>
										</td>
									</tr>
									<%}%>
								</tbody>
							</table>
						</div>
						<%}%>
					</div>
					<div id="delivered" class="tab-pane fade in">
						<%
							orders = dao.FetchOrders(seller,"delivered");
							if(orders.size()>0)
							{
						%>
						<div class="table-responsive">
							<table class="table">
								<thead>
									<tr>
										<th>Date</th>
										<th>Order Details</th>
										<th colspan="2">Item Details</th>
										<th>Customer Details</th>
										<th>Delivered At</th>
									</tr>
								</thead>
								<tbody>
									<%for(Order order : orders){%>
									<tr>
										<td><%out.print(new SimpleDateFormat("dd MMMMM, yyyy").format(order.getDateTime()));%><br><small><%out.print(new SimpleDateFormat("hh:mm aaa").format(order.getDateTime()));%></small></td>
										<td>
											Order# <%out.print(order.getOid());%><br>
											status: <span class="text-success">successfully delivered</span>
										</td>
										<td class="image_td">
											<img src="FetchImage?id=<%out.print(order.getProduct().getImage());%>">
										</td>
										<td>
											<strong><%out.print(order.getProduct().getName());%></strong><br>
											<small>PID: <%out.print(order.getProduct().getPid());%></small><br>
											<small>Price: <%out.print(order.getProduct().getPrice());%></small><br>
											<small>Qty: <%out.print(order.getQuantity());%></small>
										</td>
										<td class="address_td">
											<strong><%out.print(order.getFname()+" "+order.getLname());%></strong><br>
											<small><%out.print(order.getAddress());%></small><br>
											<small><%out.print(order.getSeller().getCity().getName());%></small><br>
											<small><%out.print(order.getPincode());%></small>
										</td>
										<td>
											Date<br>
											Time<br>
										</td>
									</tr>
									<%}%>
								</tbody>
							</table>
						</div>
						<%}%>
					</div>
					<div id="cancelled" class="tab-pane fade in">
						<%
							orders = dao.FetchOrders(seller,"cancelled");
							if(orders.size()>0)
							{
						%>
						<div class="table-responsive">
							<table class="table">
								<thead>
									<tr>
										<th>Date</th>
										<th>Order Details</th>
										<th colspan="2">Item Details</th>
										<th>Customer Details</th>
										<th>Reason</th>
									</tr>
								</thead>
								<tbody>
									<%for(Order order : orders){%>
									<tr>
										<td><%out.print(new SimpleDateFormat("dd MMMMM, yyyy").format(order.getDateTime()));%><br><small><%out.print(new SimpleDateFormat("hh:mm aaa").format(order.getDateTime()));%></small></td>
										<td>
											Order# <%out.print(order.getOid());%><br>
											status: <span class="text-danger">order cancelled</span>
										</td>
										<td class="image_td">
											<img src="FetchImage?id=<%out.print(order.getProduct().getImage());%>">
										</td>
										<td>
											<strong><%out.print(order.getProduct().getName());%></strong><br>
											<small>PID: <%out.print(order.getProduct().getPid());%></small><br>
											<small>Price: <%out.print(order.getProduct().getPrice());%></small><br>
											<small>Qty: <%out.print(order.getQuantity());%></small>
										</td>
										<td class="address_td">
											<strong><%out.print(order.getFname()+" "+order.getLname());%></strong><br>
											<small><%out.print(order.getAddress());%></small><br>
											<small><%out.print(order.getSeller().getCity().getName());%></small><br>
											<small><%out.print(order.getPincode());%></small>
										</td>
										<td>
											<span class="text-danger">Reason for cancellation</span>
										</td>
									</tr>
									<%}%>
								</tbody>
							</table>
						</div>
						<%}%>
					</div>
				</div>
				
    		</div>
    	</div>
    
    </div><!-- End of main container -->
    
	<!-- Seller home modal -->
    <div id="seller_home_modal" class="modal fade" role="dialog">
        <div class="modal-dialog modal-sm">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Attention Please</h4>
                </div>
                
                <div class="modal-body">
                	<p>You have not entered your address details.<br>
                	Enter your address now to start selling products.<br>
                	Go to <span><a href="seller-account.jsp#seller_address_details">My Account > Address Details</a></span></p>        
                </div><!-- End of modal body -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                </div><!-- End of modal footer -->    
           
            </div><!-- End of modal content -->

        </div><!-- End of modal dialogue -->
    </div><!-- End of Seller home Modal -->
    
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
    <%
		String address = seller.getAddress();
		if(address == null)
		{
	%>
			<script type="text/javascript">
				$("#seller_home_modal").modal('show');
			</script>
	<%		
		}
    %>
    
</body>
<%}%>
</html>