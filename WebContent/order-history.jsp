<%@page import="model.DAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Order"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="model.Seller"%>
<!DOCTYPE html>
<html>

<%request.getRequestDispatcher("message-on-top.jsp").include(request, response);%>

<%!
	Seller seller = null;
	List<Order> placedOrders = null;
	List<Order> approvedOrders = null;
	List<Order> packedOrders = null;
	List<Order> shippedOrders = null;
	List<Order> deliveredOrders = null;
	List<Order> cancelledOrders = null;
	List<Order> cancelledOrders2 = null;
	DAO dao = new DAO();
%>
<%
	if(session.getAttribute("seller") == null)
		response.sendRedirect("seller-index.jsp");
	else
	{
		seller = (Seller)session.getAttribute("seller");
		
		placedOrders = dao.FetchOrders(seller,null,"placed");
		approvedOrders = dao.FetchOrders(seller,null,"approved");
		packedOrders = dao.FetchOrders(seller,null,"packed");
		shippedOrders = dao.FetchOrders(seller,null,"shipped");
		deliveredOrders = dao.FetchOrders(seller,null,"delivered");
		cancelledOrders = dao.FetchOrders(seller,null,"cancelled by customer");
		cancelledOrders2 = dao.FetchOrders(seller,null,"cancelled by seller");
%>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Order History</title>
    
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>

<body id="seller_home_body">

	<div class="container-fluid" id="heading_section">
		<div class="container">
			
			<div class="row">
				<div class="col-sm-6">
					<h2 id="title"><a href="seller-index.jsp" class="white">E-Cakery</a></h2>
				</div>
				<div class="col-sm-6" id="cart_section">
					<span class="dropdown">
						<button class="dropdown-toggle" data-toggle="dropdown">Hi, <%out.print(seller.getName());%>
						<span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li><a href="SellerHome">My Orders</a></li>
						   	<li><a href="Catalogue">Catalogue</a></li>
						   	<li><a href="Payments">Payments</a></li>
						   	<li><a href="SellerAccount">My Account</a></li>
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
				<span><a class="color1" href="SellerHome">Home</a></span>
				<span>></span>
				<span><a class="color1" href="SellerHome">My Orders</a></span>
				<span>></span>
				<span>Order History</span>
			</div>
		</div>
    	
    	<div class="row orders_div" style="margin-top: 30px;">
    		<div class="col-xs-12">
    			
    			<ul class="nav nav-tabs">
				  <li class="active"><a data-toggle="tab" href="#to_acknowledge">To Acknowledge <span class="badge"><%out.print(placedOrders.size());%></span></a></li>
				  <li><a data-toggle="tab" href="#approved">Approved <span class="badge"><%out.print(approvedOrders.size());%></span></a></li>
				  <li><a data-toggle="tab" href="#packed">Packed <span class="badge"><%out.print(packedOrders.size());%></span></a></li>
				  <li><a data-toggle="tab" href="#shipped">Shipped <span class="badge"><%out.print(shippedOrders.size());%></span></a></li>
				  <li><a data-toggle="tab" href="#delivered">Delivered <span class="badge"><%out.print(deliveredOrders.size());%></span></a></li>
				  <li><a data-toggle="tab" href="#cancelled">Cancelled By Customer <span class="badge"><%out.print(cancelledOrders.size());%></span></a></li>
				  <li><a data-toggle="tab" href="#cancelled2">Cancelled By You <span class="badge"><%out.print(cancelledOrders2.size());%></span></a></li>
				</ul>
				
				<div class="tab-content">
					<div id="to_acknowledge" class="tab-pane fade in active">
						<%
							if(placedOrders.size()>0)
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
									<%for(Order order : placedOrders){%>
									<tr>
										<td>
											<%out.print(new SimpleDateFormat("dd MMMMM, yyyy").format(order.getPlacedAt()));%><br><small><%out.print(new SimpleDateFormat("hh:mm aaa").format(order.getPlacedAt()));%></small>
											<%if(order.getProduct().getIsPhotoCake()){%>
												<br><br><span class="label label-info font1" style="font-size: 12px;"><span class="glyphicon glyphicon-camera"></span> Photo Cake</span>
											<%}%>
										</td>
										<td>
											<a href="ViewOrder?oid=<%out.print(order.getOid());%>">Order# <%out.print(order.getOid());%></a><br>
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
											<a class="text-success" href="ChangeStatus?oid=<%out.print(order.getOid());%>&status=approved"><span class="glyphicon glyphicon-ok"></span> Approve order</a><br><br>
											<a class="text-danger" href="ChangeStatus?oid=<%out.print(order.getOid());%>&status=cancelled by seller"><span class="glyphicon glyphicon-remove"></span> Can not fulfill</a>
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
							if(approvedOrders.size()>0)
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
									<%for(Order order : approvedOrders){%>
									<tr>
										<td>
											<%out.print(new SimpleDateFormat("dd MMMMM, yyyy").format(order.getPlacedAt()));%><br><small><%out.print(new SimpleDateFormat("hh:mm aaa").format(order.getPlacedAt()));%></small>
											<%if(order.getProduct().getIsPhotoCake()){%>
												<br><br><span class="label label-info font1" style="font-size: 12px;"><span class="glyphicon glyphicon-camera"></span> Photo Cake</span>
											<%}%>
										</td>
										<td>
											<a href="ViewOrder?oid=<%out.print(order.getOid());%>">Order# <%out.print(order.getOid());%></a><br>
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
											<a class="text-success" href="ChangeStatus?oid=<%out.print(order.getOid());%>&status=packed"><span class="glyphicon glyphicon-ok"></span> Order is packed</a><br><br>
											<a class="text-primary"><span class="glyphicon glyphicon-print"></span> Print packing slip</a><br><br>
											<%if(order.getProduct().getIsPhotoCake()){%><a class="text-info" href="DownloadUserPhoto?id=<%out.print(order.getUserPhoto());%>"><span class="glyphicon glyphicon-download-alt"></span> Download user photo</a><%}%>
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
							if(packedOrders.size()>0)
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
									<%for(Order order : packedOrders){%>
									<tr>
										<td>
											<%out.print(new SimpleDateFormat("dd MMMMM, yyyy").format(order.getPlacedAt()));%><br><small><%out.print(new SimpleDateFormat("hh:mm aaa").format(order.getPlacedAt()));%></small>
											<%if(order.getProduct().getIsPhotoCake()){%>
												<br><br><span class="label label-info font1" style="font-size: 12px;"><span class="glyphicon glyphicon-camera"></span> Photo Cake</span>
											<%}%>
										</td>
										<td>
											<a href="ViewOrder?oid=<%out.print(order.getOid());%>">Order# <%out.print(order.getOid());%></a><br>
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
											<a class="text-success" href="ChangeStatus?oid=<%out.print(order.getOid());%>&status=shipped"><span class="glyphicon glyphicon-ok"></span> Confirm shipping</a><br><br>
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
							if(shippedOrders.size()>0)
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
									<%for(Order order : shippedOrders){%>
									<tr>
										<td>
											<%out.print(new SimpleDateFormat("dd MMMMM, yyyy").format(order.getPlacedAt()));%><br><small><%out.print(new SimpleDateFormat("hh:mm aaa").format(order.getPlacedAt()));%></small>
											<%if(order.getProduct().getIsPhotoCake()){%>
												<br><br><span class="label label-info font1" style="font-size: 12px;"><span class="glyphicon glyphicon-camera"></span> Photo Cake</span>
											<%}%>
										</td>
										<td>
											<a href="ViewOrder?oid=<%out.print(order.getOid());%>">Order# <%out.print(order.getOid());%></a><br>
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
											<%out.print(new SimpleDateFormat("dd MMMMM, yyyy").format(order.getShippedAt()));%><br><small><%out.print(new SimpleDateFormat("hh:mm aaa").format(order.getShippedAt()));%></small><br>
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
							if(deliveredOrders.size()>0)
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
									<%for(Order order : deliveredOrders){%>
									<tr>
										<td>
											<%out.print(new SimpleDateFormat("dd MMMMM, yyyy").format(order.getPlacedAt()));%><br><small><%out.print(new SimpleDateFormat("hh:mm aaa").format(order.getPlacedAt()));%></small>
											<%if(order.getProduct().getIsPhotoCake()){%>
												<br><br><span class="label label-info font1" style="font-size: 12px;"><span class="glyphicon glyphicon-camera"></span> Photo Cake</span>
											<%}%>
										</td>
										<td>
											<a href="ViewOrder?oid=<%out.print(order.getOid());%>">Order# <%out.print(order.getOid());%></a><br>
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
											<%out.print(new SimpleDateFormat("dd MMMMM, yyyy").format(order.getDeliveredAt()));%><br><small><%out.print(new SimpleDateFormat("hh:mm aaa").format(order.getDeliveredAt()));%></small>
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
							if(cancelledOrders.size()>0)
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
									<%for(Order order : cancelledOrders){%>
									<tr>
										<td>
											<%out.print(new SimpleDateFormat("dd MMMMM, yyyy").format(order.getPlacedAt()));%><br><small><%out.print(new SimpleDateFormat("hh:mm aaa").format(order.getPlacedAt()));%></small>
											<%if(order.getProduct().getIsPhotoCake()){%>
												<br><br><span class="label label-info font1" style="font-size: 12px;"><span class="glyphicon glyphicon-camera"></span> Photo Cake</span>
											<%}%>
										</td>
										<td>
											<a href="ViewOrder?oid=<%out.print(order.getOid());%>">Order# <%out.print(order.getOid());%></a><br>
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
											<span class="text-danger"><%out.print(order.getCancellationReason());%></span>
										</td>
									</tr>
									<%}%>
								</tbody>
							</table>
						</div>
						<%}%>
					</div>
					<div id="cancelled2" class="tab-pane fade in">
						<%
							if(cancelledOrders2.size()>0)
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
									<%for(Order order : cancelledOrders2){%>
									<tr>
										<td>
											<%out.print(new SimpleDateFormat("dd MMMMM, yyyy").format(order.getPlacedAt()));%><br><small><%out.print(new SimpleDateFormat("hh:mm aaa").format(order.getPlacedAt()));%></small>
											<%if(order.getProduct().getIsPhotoCake()){%>
												<br><br><span class="label label-info font1" style="font-size: 12px;"><span class="glyphicon glyphicon-camera"></span> Photo Cake</span>
											<%}%>
										</td>
										<td>
											<a href="ViewOrder?oid=<%out.print(order.getOid());%>">Order# <%out.print(order.getOid());%></a><br>
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
											<span class="text-danger">Can't fulfill</span>
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