<%@page import="model.Cart"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!doctype html>
<%@page import="model.User"%>
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
			<div class="alert alert-dismissable <%out.print(class_var);%>" style="text-align: center;">
				<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
				<p style="font-size: 16px;"><%out.print(message);%></p>
			</div>
<% 			
		}	
	}
%>

<%
	User user = null;
	Cart cart = new Cart();
%>

<%
	if(session.getAttribute("user")!=null)
		user = (User)session.getAttribute("user");

	if(session.getAttribute("cart")!=null)
		cart = (Cart)session.getAttribute("cart");
	else
		session.setAttribute("cart", cart);
%>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>E-Cakery</title>
    
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>

<body id="index">
	
	<div id="fit_to_screen">
	
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
		
		<!-- Carousel -->
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
		  
		  <!-- Indicators -->
		  <ol class="carousel-indicators">
		    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		    <li data-target="#myCarousel" data-slide-to="1"></li>
		    <li data-target="#myCarousel" data-slide-to="2"></li>
		    <li data-target="#myCarousel" data-slide-to="3"></li>
		  </ol>
		
		  <!-- Wrapper for slides -->
		  <div class="carousel-inner" role="listbox">
		    <div class="item active">
		      <img src="images/cake1.jpg" alt="Chania">
		      <div class="carousel-caption">
		        <h3>Cake For Every Occasion</h3>
		        <p>we have cakes specially designed for every occasion such as birthday, anniversary, valentine day etc.</p>
		      </div>
		    </div>
		
		    <div class="item">
		      <img src="images/cake2.jpg" alt="Chania">
		      <div class="carousel-caption">
		        <h3>Custom Cakes</h3>
		        <p>upload your photo and we will print it on your cake.</p>
		      </div>
		    </div>
		
		    <div class="item">
		      <img src="images/cake3.jpg" alt="Flower">
		      <div class="carousel-caption">
		        <h3>Your Favourite Shops</h3>
		        <p>buy cakes directly from your favourite cake shops around you.</p>
		      </div>
		    </div>
		
		    <div class="item">
		      <img src="images/cake4.jpg" alt="Flower">
		      <div class="carousel-caption">
		        <h3>Same Day Delivery</h3>
		        <p>we promise you to deliver your cake on the same day if you order before 8 PM.</p>
		      </div>
		    </div>
		  </div>
		
		  <!-- Left and right controls -->
		  <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
		    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
		    <span class="sr-only">Previous</span>
		  </a>
		  <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
		    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		    <span class="sr-only">Next</span>
		  </a>
		
		</div><!-- End of carousel -->
	
	</div><!-- End of fit to screen -->
	
	<div class="container" style="margin-bottom: 50px;">
	
		<h3 class="center font1" style="margin-top: 50px;">Shop By Flavour</h3>
		
		<div class="row">
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">Chocolate</p>
				<a href="CakesByFlavour?flavour=Chocolate"><img src="images/chocolate_cake.jpg"></a>
			</div>
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">Black Forest</p>
				<a href="CakesByFlavour?flavour=Black Forest"><img src="images/black_forest_cake.jpg"></a>
			</div>
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">Butter Scotch</p>
				<a href="CakesByFlavour?flavour=Butterscotch"><img src="images/butterscotch_cake.jpg"></a>
			</div>
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">Pineapple</p>
				<a href="CakesByFlavour?flavour=Pineapple"><img src="images/pineapple_cake.jpg"></a>
			</div>
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">Strawberry</p>
				<a href="CakesByFlavour?flavour=Strawberry"><img src="images/strawberry_cake.jpg"></a>
			</div>
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">Vanilla</p>
				<a href="CakesByFlavour?flavour=Vanilla"><img src="images/vanilla_cake.jpg"></a>
			</div>
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">Mixed Fruits</p>
				<a href="CakesByFlavour?flavour=Mixed Fruit"><img src="images/mixwd_fruit_cake.jpg"></a>
			</div>
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">All Cakes</p>
				<a href="AllCakes"><img src="images/all_cakes.jpg"></a>
			</div>
		</div>
		
		<h3 class="center font1" style="margin-top: 50px;">Shop By Category</h3>
		
		<div class="row">
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">Birthday</p>
				<a href="CakesByCategory?category=Birthday"><img src="images/birthday_cake.jpg"></a>
			</div>
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">Valentine</p>
				<a href="CakesByCategory?category=Valentine"><img src="images/valentine_cake.jpg"></a>
			</div>
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">Anniversary</p>
				<a href="CakesByCategory?category=Anniversary"><img src="images/anniversary_cake.jpg"></a>
			</div>
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">Engagement</p>
				<a href="CakesByCategory?category=Engagement"><img src="images/engagement_cake.jpg"></a>
			</div>
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">Cartoon</p>
				<a href="CakesByCategory?category=Cartoon"><img src="images/cartoon_cake.jpg"></a>
			</div>
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">Eggless</p>
				<a href="CakesByCategory?category=Eggless"><img src="images/eggless_cake.jpg"></a>
			</div>
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">Photo Cake</p>
				<a href=""><img src="images/photo_cake.jpg"></a>
			</div>
			<div class="col-sm-3 col-xs-6 img_section white">
				<p class="center font1">All Cakes</p>
				<a href="AllCakes"><img src="images/all_cakes.jpg"></a>
			</div>
		</div>
	
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
