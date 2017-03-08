<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%

	session.removeAttribute("seller");	

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

    <title>E-Cakery Seller</title>
    
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>

<body>

	<div class="container">
    
    	<div class="row">
        	<div class="col-sm-4" id="logo_section">
            	<a href="seller-index.jsp"><img src="images/logo.png" alt="logo"></a>
            </div><!-- End of logo Section -->
            <div class="col-sm-8" id="login_section">
            	<table>
                	<tr>
                    	<td><span>Login</span></td>
                        <td><span>Forgot Password?</span></td>
                        <td></td>
                    </tr>
              		<form action="SellerLogin" method="post" id="seller_login_form">
                    <tr>
                    	<td><input type="email" placeholder="Email" name="email" required="required" id="seller_login_email"></td>
                        <td><input type="password" placeholder="Password" name="pw" required="required"></td>
                        <td><input type="submit" value="LogIn" class="btn btn-danger" id="seller_login"></td>
                    </tr>
                    <tr>
                    	<td><small><span id="seller_login_email_msg" hidden="hidden" class="red">Email Not Registered</span></small></td>
                        <td></td>
                        <td></td>
                    </tr>
                    </form>
                </table>
            </div><!-- End of login Section -->
        </div>
        
    </div><!-- End of header section -->

	<nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="170">
    
        <div class="container-fluid">
            
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#seller-navigation_links">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span> 
            </button>
            
            <div class="collapse navbar-collapse" id="seller-navigation_links">
                
                <ul class="nav navbar-nav">
                    <li class="active"><a href="seller-index.jsp" title="Home"><span class="glyphicon glyphicon-home"></span></a></li>
                    <li><a href="#"><span class="glyphicon glyphicon-flag"></span> Benefits</a></li>
                    <li><a href="index.jsp"><span class="glyphicon glyphicon-refresh"></span> Switch to customer site</a></li>            
                </ul>
                <ul class="nav navbar-nav navbar-right">                    
                    <li><a data-toggle="modal" href="#login_modal"><span class="glyphicon glyphicon-log-in"> LogIn</span></a></li>
                </ul>
                
            </div>
            
        </div>
        
    </nav><!-- End of Navigation Bar -->
    
    <div class="container-fluid grey">
    	<div class="container">	
    
            <div class="row">
                <div class="col-sm-7" id="registration_msg">
                    <h1>Selling on E-Cakery is <span class="special">easy!</span></h1>
                    <h1>All you <span class="special">need</span> is:</h1><br>
                    <span class="special big glyphicon glyphicon-check"></span><span class="big"> VAT Number</span><br>
                    <span class="special big glyphicon glyphicon-check"></span><span class="big"> PAN Card</span><br>
                    <span class="special big glyphicon glyphicon-check"></span><span class="big"> Account Number</span><br>
                    <span class="special big glyphicon glyphicon-check"></span><span class="big"> IFSC Code</span>
                </div>
                <div class="col-sm-5">
                    <div id="seller_reg_form">
                        <h3>Register Now</h3>
                        <form action="SellerRegistration" method="post">
	                        <div class="row">
	                        	<div class="col-sm-12">
	                            	<span>Name</span><br>
	                        		<input type="text" class="col-sm-12 col-xs-12" name="name" required="required">
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-sm-6">
	                                <span>Mobile</span><br>
	                                <input type="text" class="col-sm-12 col-xs-12" maxlength="10" name="mobile" required="required" id="seller_mobile">
	                                <span id="seller_mobile_msg" hidden="hidden" class="red"><small>Invalid Mobile Number</small></span>
	                            </div>
	                            <div class="col-sm-6">
	                                <span>Email</span><br>
	                                <input type="email" class="col-sm-12 col-xs-12" name="email" required="required" id="seller_reg_email">
	                                <small><span id="seller_reg_email_msg" hidden="hidden" class="red">Email Already Registered</span></small>
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-sm-6">
	                                <span>Password</span><br>
	                                <input id="seller_pwd" type="password" class="col-sm-12 col-xs-12" name="pw" required="required">
	                            </div>
	                            <div class="col-sm-6">
	                                <span>Re-Password</span><br>
	                                <input id="seller_re-pwd" type="password" class="col-sm-12 col-xs-12" name="re-pw" required="required">
	                                <span id="seller_pwd_msg" hidden="hidden" class="red"><small>Password Mismatched</small></span>
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-sm-6">
	                            	<span>Account Number</span><br>
	                        		<input type="text" class="col-sm-12 col-xs-12" name="acc" required="required">
	                            </div>
	                            <div class="col-sm-6">
	                                <span>IFSC Code</span><br>
	                                <input type="text" class="col-sm-12 col-xs-12" name="ifsc" required="required" id="seller_reg_email">
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-sm-6">
	                                <span>PAN Number</span><br>
	                                <input type="text" class="col-sm-12 col-xs-12" name="pan" required="required">
	                            </div>
	                            <div class="col-sm-6">
	                                <span>VAT Number</span><br>
	                                <input type="text" class="col-sm-12 col-xs-12" name="vat" required="required">
	                            </div>
	                        </div>
	                        <div class="row">
	                        	<div class="col-sm-12">
	                        		<input type="submit" class="col-sm- col-xs-12 btn btn-danger submit" value="Start Selling!" id="start_selling">
	                            </div>
	                        </div>
                        </form>
                    </div><!-- End of registration form -->
                </div>
            </div>
        
        </div><!-- End of internal container -->
    </div><!-- End of grey container -->
    
    <br>
    
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
    
    <!-- Login Modal -->
    <div id="login_modal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Login</h4>
                </div>
                <form class="form-horizontal" action="SellerLogin" method="post" id="seller_login_form2">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="control-label col-sm-3" for="email">Email:</label>
                            <div class="col-sm-9">
                                <input type="email" class="form-control" id="seller_login_email2" placeholder="Enter email" name="email" required="required">
                                <small><span id="seller_login_email_msg2" hidden="hidden" class="red">Email Not Registered</span></small>
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
                        <button type="submit" class="btn btn-primary" id="seller_login2">Login</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                    </div><!-- End of modal footer -->    
                </form><!-- End of login form -->
            </div><!-- End of modal content -->

        </div><!-- End of modal dialogue -->
    </div><!-- End of login Modal -->

	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>
	
</body>

</html>