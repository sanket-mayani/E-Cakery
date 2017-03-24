<%@page import="model.User"%>
<%@page import="model.Cart"%>
<%@page import="model.Product"%>
<%@page import="model.City"%>
<%@page import="model.Category"%>
<%@page import="model.Flavour"%>
<%@page import="java.util.List"%>
<%@page import="model.DAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!doctype html>
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
	DAO dao = new DAO();
	City city = null;
	List<Product> products = null;
	Flavour flavour = null;
	Category category = null;
	int currentPage = 1;
	long maxPages = 0;
	int start = 0;
	int count = 0;
	Cart cart = new Cart();
	User user = null;
%>
<%
	if(session.getAttribute("cart") != null)
		cart = (Cart)session.getAttribute("cart");
	else
		session.setAttribute("cart", cart);
	
	if(session.getAttribute("city") == null)
		city = dao.getAllCities().get(0);
	else
		city = (City)session.getAttribute("city");
	
	session.setAttribute("city", city);
	
	if(session.getAttribute("flavour") != null)
		flavour = (Flavour)session.getAttribute("flavour");
	
	if(session.getAttribute("category") != null)
		category = (Category)session.getAttribute("category");

	if(session.getAttribute("page") != null)
		currentPage = (Integer)session.getAttribute("page");

	start = currentPage*8-8;

	products = dao.fetchCakes(city,flavour,category,start);
	maxPages = dao.getMaxPages(city,flavour,category);
	count = products.size();
	
	if(session.getAttribute("user") != null)
		user = (User)session.getAttribute("user");
%>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>E-Cakery</title>
    
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
	        <div class="col-sm-4" id="cart">
	            <a href="Cart" class="btn btn-danger">    
	                <span class="glyphicon glyphicon-shopping-cart"></span><span> Cart: <%out.print(cart.getCount());%> items</span>
	            </a>
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
                    <li class="active"><a href="ChangePreference?flavour=null&category=null&page=1" title="Home"><span class="glyphicon glyphicon-home"></span></a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" >Cakes by Flavour <span class="caret"></span></a>
                        <ul class="dropdown-menu" id="cake_flavours">
                        <%
                        	List<Flavour> flavours = dao.getAllFlavours();
                        	
                        	for(Flavour f : flavours)
                        	{
                        %>
                        		<li><a href="ChangePreference?flavour=<%out.print(f.getName());%>&category=null&page=1" <%if(flavour!=null && flavour.getFid() == f.getFid()){%>class="active_link"<%}%>><%out.print(f.getName());%> Cakes</a></li>
                        <%		
                        	}
                        %>
                            <!-- Chocolate Black Forest Butterscotch Pineapple Strawberry Vanilla Mixed Fruit -->
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" >Cake Categories <span class="caret"></span></a>
                        <ul class="dropdown-menu" id="categories">
                        <%
                        	List<Category> categories = dao.getAllCategories();
                        	
                        	for(Category c : categories)
                        	{
                        %>
                        		<li><a href="ChangePreference?category=<%out.print(c.getName());%>&flavour=null&page=1" <%if(category!=null && category.getCid() == c.getCid()){%>class="active_link"<%}%> ><%out.print(c.getName());%> Cakes</a></li>
                        <%		
                        	}
                        %>
                            <!-- Birthday Anniversary Valentine Celebration Cartoon Eggless -->
                        </ul>
                    </li>
                    <li><a href="#">Photo Cakes</a></li>            
                </ul>
                <ul class="nav navbar-nav navbar-right">
                	<%if(user == null){%>
                    <li><a data-toggle="modal" href="#registration_modal"><span class="glyphicon glyphicon-user"> SignUp</span></a></li>                    
                    <li><a data-toggle="modal" href="#login_modal"><span class="glyphicon glyphicon-log-in"> LogIn</span></a></li>
                	<%}else{%>
                	<li><a href="MyAccount"><span class="glyphicon glyphicon-user"></span> <span>My Account</span></a></li>                    
                    <li><a href="LogOut"><span class="glyphicon glyphicon-off"></span> <span>Sign Out</span></a></li>
                	<%}%>
                </ul>
                
            </div>
            
        </div>
        
    </nav><!-- End of Navigation Bar -->

    <div class="container">
    
        <br>

        <div class="row">
            <form class="form-horizontal col-sm-4 pull-right" id="city_selector">
                <div class="form-group">
                    <label for="city_options"><span class="glyphicon glyphicon-globe"></span> Select Location</label>
                    <select id="city_options" onchange="location = this.value">
                    <%
                    	List<City> cities = dao.getAllCities();
                    		
                    	for(City c : cities)
                    	{
                    %>
                    		<option value="ChangePreference?city=<%out.print(c.getName());%>&flavour=null&category=null&page=1" <%if(city.getCid() == c.getCid()){%>selected<%}%> ><%out.print(c.getName());%></option>
                    <%
                    	}
                    %>
                    </select>
                </div>
            </form>            
        </div><!-- End of City Selector row -->
        
        <div class="row grey">
            
            <h3 class="col-sm-3">Top Brands</h3>
            
        </div><!-- End of Top Brands title row -->

        <div class="row grey">
            <div class="col-sm-3 col-xs-12">
                <a href="#"><img src="images/monginis.jpg" class="thumbnail" alt="monginis" width="100%" height="150"></a>
            </div>
            <div class="col-sm-3 col-xs-12">
                <a href="#"><img src="images/tgb.jpg" class="thumbnail" alt="tgb" width="100%" height="150"></a>
            </div>
            <div class="col-sm-3 col-xs-12">
                <a href="#"><img src="images/dangee_dums.jpg" class="thumbnail" alt="dangee dums" width="100%" height="150"></a>
            </div>
            <div class="col-sm-3 col-xs-12">
                <a href="#"><img src="images/kabhi_b.jpg" class="thumbnail" alt="kabhi b" width="100%" height="150"></a>
            </div>
        </div><!-- End of Top Brands images row -->
        
        <br><br>
        
        
        <%if(count>0){%>
        <div class="row">
        
        	<%if(flavour != null && category != null){%><h3 class="col-sm-6"><%out.print(flavour.getName()+" + "+category.getName());%> Cakes</h3>
            <%}else if(flavour != null){%><h3 class="col-sm-6"><%out.print(flavour.getName());%> Cakes</h3>
            <%}else if(category != null){%><h3 class="col-sm-6"><%out.print(category.getName());%> Cakes</h3>
            <%}else{%><h3 class="col-sm-6">All Cakes</h3><%}%>
            <div class="col-sm-6 " id="sort_filter">
                <span class="dropdown">
                    <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-sort"></span> Sort By <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#sort_filter">Popularity</a></li>
                        <li><a href="#">Rating</a></li>
                        <li><a href="#">Price (Low to High)</a></li>
                        <li><a href="#">Price (High to Low)</a></li>
                    </ul>
                </span>
                <a href="#filterModal" class="btn btn-primary" data-toggle="modal"><span class="glyphicon glyphicon-filter"></span> Filter</a>            
            </div>

        </div><!-- End of All Cakes title row -->
             
        <br>
             
        <div class="row">
        	<%
        		int i = 0;
        		for(Product product : products)
        		{
        	%>
        			<div class="col-sm-3 col-xs-12">
		                <div class="thumbnail cake_image">
		                    <a href=""><img src="FetchImage?id=<%out.print(product.getImage());%>" alt="" width="100%" style="height:200px"></a>
		                    <div class="caption">
		                        <h4><%out.print(product.getName());%></h4>
		                        <p><small>Sold by: <%out.print(product.getSeller().getName());%></small></p>
		                        <div class="row">
		                        	<%if(product.getQuantity() == 0){%>
		                        		<a href="" class="btn btn-danger col-xs-10 col-xs-offset-1" disabled>Out of Stock</a>
		            				<%}else if(cart.contains(product)){%>
		                            	<a href="" class="btn btn-success col-xs-10 col-xs-offset-1" disabled><span class="glyphicon glyphicon-ok"></span> Added to cart</a>
		                        	<%}else{%>
		                        		<a href="AddToCart?pid=<%out.print(product.getPid());%>" class="btn btn-success col-xs-10 col-xs-offset-1"><span class="glyphicon glyphicon-circle-arrow-down"></span> Add to cart</a>
		                        	<%}%>
		                        </div>
		                    </div>
		                    <div class="btn-danger price_tag"><span class="glyphicon glyphicon-tag"></span> &#8377 <%out.print(product.getPrice());%></div>
		                </div>
		            </div>		
        	<%	
        			i++;
        			if(i == 4) break;
        		}
        	%>
        </div><!-- End of First row of cake images -->    

        <br>
                
        <div class="row">
        	<%
        		if(count > 4)
        		{
        			List<Product> products2 = products.subList(i,count);
        			for(Product product : products2)
        			{
        	%>
	        			<div class="col-sm-3 col-xs-12">
			                <div class="thumbnail cake_image">
			                    <a href="#"><img src="FetchImage?id=<%out.print(product.getImage());%>" alt="" width="100%" style="height:200px"></a>
			                    <div class="caption">
			                        <h4><%out.print(product.getName());%></h4>
			                        <p><small>Sold by: <%out.print(product.getSeller().getName());%></small></p>
			                        <div class="row">
			                        	<%if(product.getQuantity() == 0){%>
		                        			<a href="" class="btn btn-danger col-xs-10 col-xs-offset-1" disabled>Out of Stock</a>
			                            <%}else if(cart.contains(product)){%>
		                            		<a href="" class="btn btn-success col-xs-10 col-xs-offset-1" disabled><span class="glyphicon glyphicon-ok"></span> Added to cart</a>
		                        		<%}else{%>
		                        			<a href="AddToCart?pid=<%out.print(product.getPid());%>" class="btn btn-success col-xs-10 col-xs-offset-1"><span class="glyphicon glyphicon-circle-arrow-down"></span> Add to cart</a>
		                        		<%}%>
			                        </div>
			                    </div>
			                    <div class="btn-danger price_tag"><span class="glyphicon glyphicon-tag"></span> &#8377 <%out.print(product.getPrice());%></div>
			                </div>
			            </div>		
        	<%	
        			}
        		} 			       
        	%>
        </div><!-- End of Second row of cake images -->

        <div class="row container">
            <ul class="pager col-xs-4 col-sm-4">
                <li class="previous" <%if(currentPage<=1){%> style="display:none;" <%}%>><a href="ChangePreference?page=<%out.print(currentPage-1);if(flavour!=null){%>&flavour=<%out.print(flavour.getName());}if(category!=null){%>&category=<%out.print(category.getName());}%>"><span class="glyphicon glyphicon-hand-left "></span> Previous</a></li>
            </ul>
            <ul class="pager col-xs-4 col-sm-4 pull-right">
                <li class="next" <%if(currentPage>=maxPages){%> style="display:none;" <%}%>><a href="ChangePreference?page=<%out.print(currentPage+1);if(flavour!=null){%>&flavour=<%out.print(flavour.getName());}if(category!=null){%>&category=<%out.print(category.getName());}%>">Next <span class="glyphicon glyphicon-hand-right"></span></a></li>
            </ul>
            <div id="page_nums" class="col-sm-4"> 
                <ul class="pagination">
                    <li><form action="ChangePreference">Page<input name="page" type="number" style="width: 40px;" min="1" max="<%out.print(maxPages);%>" value="<%out.print(currentPage);%>"> of <%out.print(maxPages);%> <input type="submit" value="Go"></form></li>
                </ul>
            </div>
        </div>
        <%}else{%><h1 class="red" style="margin-bottom: 30px;">No cakes Found</h1><%}%>

    </div><!-- End of main container -->

    <!-- Registration Modal -->
    <div id="registration_modal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Registration</h4>
                </div>
                <form class="form-horizontal" action="Register" method="post" id="reg_form">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="control-label col-sm-3" for="fname">First Name:</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="fname" placeholder="Enter first name" name="fn" required="required">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-3" for="lname">Last Name:</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="lname" placeholder="Enter last name" name="ln" required="required">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-3" for="email">Email:</label>
                            <div class="col-sm-9">
                                <input type="email" class="form-control" id="reg_email" placeholder="Enter email" name="email" required="required">
                                <small><span id="reg_email_msg" hidden="hidden" class="red">Email Already Registered</span></small>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-3" for="pwd">Password:</label>
                            <div class="col-sm-9"> 
                                <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pw" required="required">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-3" for="re-pwd">Re-enter Password:</label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control" id="re-pwd" placeholder="Enter password again" required="required">
                                <span id="pwd_msg" hidden="hidden" class="red"><small>Password Mismatched</small></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-3" for="mobile">Mobile:</label>
                            <div class="col-sm-9">
                                <input type="text" maxlength="10" class="form-control" id="mobile" placeholder="Enter mobile number" name="mobile" required="required">
                                <span id="mobile_msg" hidden="hidden" class="red"><small>Invalid Mobile Number</small></span>
                            </div>
                        </div>
                    </div><!-- End of modal body -->
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary" id="submit">Create Account</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                    </div><!-- End of modal footer -->    
                </form><!-- End of registration form -->
            </div><!-- End of modal content -->

        </div><!-- End of modal dialogue -->
    </div><!-- End of Registration Modal -->

    <!-- Login Modal -->
    <div id="login_modal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Login</h4>
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

    <!-- Filter Modal -->
    <div id="filterModal" class="modal fade" role="dialog">
        <div class="modal-dialog modal-sm">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Modal Header</h4>
                </div>
                <div class="modal-body">
                    <p>Some text in the modal.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div><!-- End of Filter modal -->

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