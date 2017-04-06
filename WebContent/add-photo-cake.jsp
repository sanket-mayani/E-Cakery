<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="model.DAO,java.util.List,java.util.ArrayList,model.Flavour,model.Category,model.Seller"%>
<!DOCTYPE html>
<html>

<%request.getRequestDispatcher("message-on-top.jsp").include(request, response);%>

<%!
	Seller seller;
%>
<%	
	if(session.getAttribute("seller") != null)
		seller = (Seller)session.getAttribute("seller");
	else
		response.sendRedirect("seller-index.jsp");
%>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Add Photo Cake</title>
    
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>

<body>

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
				<span><a class="color1" href="seller-index.jsp">Home</a></span>
				<span>></span>
				<span><a class="color1" href="Catalogue">Catalogue</a></span>
				<span>></span>
				<span>Add Photo Cake</span>
			</div>
		</div>
		
		<form action="AddProduct" class="form-horizontal" method="post" enctype="multipart/form-data" id="add_product_form">
			<div class="row" style="margin-top: 50px;">
				<div class="col-sm-3 col-md-2">
					<div class=""  id="product_img_div">
						<img alt="" src="" >
					</div>
					<div class="">
						<input type="file" name="image" accept="image/gif, image/jpeg, image/png" id="choose_file" required>
					</div>
				</div>
				<div class="col-sm-9 col-md-10">
					<div class="row">
						<div class="form-group col-xs-12">
							<label class="control-label col-xs-4 col-sm-3" for="pname">Product Name:</label>
							<div class="col-xs-8 col-sm-9">
								<input type="text" class="form-control" id="pname" name="name" placeholder="Enter Name of your product" required>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-xs-12">
							<label class="control-label col-xs-4 col-sm-3" for="desc">Description:</label>
							<div class="col-xs-8 col-sm-9">
								<textarea class="form-control" id="desc" name="desc" placeholder="Give description of your product" required></textarea>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-xs-12">
							<label class="control-label col-xs-4 col-sm-3" for="flavour">Flavour:</label>
							<div class="col-xs-8 col-sm-3">
								<select class="form-control" name="flavour" id="flavour" required>
									<option value="0">-- Choose a flavour --</option>
									<%
										DAO dao = new DAO();
										List<Flavour> list = new ArrayList<Flavour>();
										list = dao.getAllFlavours();
										
										if(!list.isEmpty())
										{
											for(Flavour flavour:list)
											{
									%>
												<option><%out.print(flavour.getName());%></option>
									<%
											}
										}
									%>
								</select>
								<p id="flavour_msg" class="red" hidden>Please select a flavour</p>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-xs-12">
							<label class="control-label col-xs-4 col-sm-3" for="category">Category:</label>
							<div class="col-xs-8 col-sm-3">
								<select class="form-control" name="occassion" id="category" required multiple="multiple">
									<%
										List<Category> list2 = new ArrayList<Category>();
										list2 = dao.getAllCategories();
										
										if(!list2.isEmpty())
										{
											for(Category category:list2)
											{
									%>
												<option value="<%out.print(category.getName());%>"><%out.print(category.getName());%></option>
									<%
											}
										}
									%>
								</select>
								<p id="category_msg" class="red" hidden>Please select a Category</p>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-xs-12">
							<label class="control-label col-xs-4 col-sm-3" for="weight">Weight:</label>
							<div class="col-xs-8 col-sm-3">
								<select class="form-control" name="weight" id="weight" required>
									<option value="0">-- Select Weight --</option>
									<option value="0.5">0.5 kg</option>
									<option value="1.0">1.0 kg</option>
									<option value="1.5">1.5 kg</option>
									<option value="2.0">2.0 kg</option>
									<option value="3.0">3.0 kg</option>
								</select>
								<p id="weight_msg" class="red" hidden>Please select weight</p>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-xs-12">
							<label class="control-label col-xs-4 col-sm-3" for="floor">Floor (Tier):</label>
							<div class="col-xs-8 col-sm-3">
								<select class="form-control" name="floor" id="floor" required>
									<option value="0">-- Choose no. of floors --</option>
									<option>1</option>
									<option>2</option>
									<option>3</option>
									<option>4</option>
									<option>5</option>
								</select>
								<p id="floor_msg" class="red" hidden>Please select no. of floors</p>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-xs-12">
							<label class="control-label col-xs-4 col-sm-3" for="price">Price (in rupees):</label>
							<div class="col-xs-8 col-sm-3">
								<input type="text" class="form-control" name="price" placeholder="Enter selling price" id="price" required>
								<p id="price_msg" class="red" hidden>Invalid Price</p>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-xs-12">
							<div class="col-xs-8 col-sm-3">
								<input type="hidden" class="form-control" name="photo_cake" value="true">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<input type="submit" class="btn btn-success col-sm-2 col-xs-12 col-sm-offset-5" value="Add Product" id="add_product_btn">
			</div>
		</form>
		
	</div><!-- End of main container -->
	
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>
    
</body>

</html>