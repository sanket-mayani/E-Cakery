<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="model.DAO,java.util.List,java.util.ArrayList,model.Flavour,model.Category,model.Seller"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%!
	Seller seller;
%>
<%	
	if(session.getAttribute("seller") != null)
		seller = (Seller)session.getAttribute("seller");
	else
		response.sendRedirect("seller-index.jsp");
%>

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

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Add a product</title>
    
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
            
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#add-product-navigation_links">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span> 
            </button>
            
            <div class="collapse navbar-collapse" id="add-product-navigation_links">
                
                <ul class="nav navbar-nav">
                    <li><a href="seller-home.jsp"><span class="glyphicon glyphicon-briefcase"></span><span> My Orders</span></a></li>
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
		
		<form action="AddProduct" class="form-horizontal" method="post" enctype="multipart/form-data" id="add_product_form">
			<div class="row">
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
							<label class="control-label col-xs-4 col-sm-3" for="quantity">Quantity:</label>
							<div class="col-xs-8 col-sm-3">
								<input type="text" class="form-control" name="quantity" placeholder="How many do you have?" id="quantity" required>
								<p id="quantity_msg" class="red" hidden>Invalid Quantity</p>
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