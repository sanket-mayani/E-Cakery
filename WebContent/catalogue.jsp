<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Session"%>
<%@page import="model.DAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="model.Seller,java.util.List,model.Product,model.DAO,java.util.Set,model.Category"%>
<!DOCTYPE html>
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
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Catalogue</title>

	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
</head>
<body id="catalogue">

	<div class="container">
    	
        <div class="row">
            <div class="col-xs-12" id="logo"> 
                <a href="seller-home.jsp"><img src="images/logo.png" alt="logo"></a>
            </div>      
        </div>
              
    </div><!-- End of Header Section -->
    
    <nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="170">
    
        <div class="container-fluid">
            
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#catalogue-navigation_links">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span> 
            </button>
            
            <div class="collapse navbar-collapse" id="catalogue-navigation_links">
                
                <ul class="nav navbar-nav">
                    <li><a href="seller-home.jsp"><span class="glyphicon glyphicon-briefcase"></span><span> My Orders</span></a></li>
                    <li class="active"><a href="catalogue.jsp"><span class="glyphicon glyphicon-list-alt"></span> Catalogue</a></li>
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
    
    	<%
    		DAO dao = new DAO();
    		List<Product> products =  dao.getProducts(seller);
    		
    		if(products.isEmpty())
    		{
    	%>
    			<p class="red">You haven't added any item. To add a new item <a href="add-product.jsp">Click Here</a></p>
    	<%		
    		}
    		else
    		{
    	%>
    			<p>Following are the products you have put for sale. To add a new item <a href="add-product.jsp">Click Here</a></p>

    	<%
    			for(Product product : products)
    			{
    				Set<Category> categories = product.getCategories();
    	%>
    				<hr>
	    			<div class="row product">  		
			    		<div class="col-xs-12">
			    			<h3 style="margin-top: 0px; margin-bottom: 15px;"><%out.print(product.getName());%></h3>
			    		</div>  		
		    			<div class="col-sm-4">
		    				<div class="row">
		    					<div class="col-xs-12" style="text-align: center;"><img src="FetchImage?id=<%out.print(product.getImage());%>" class="image"></div>
		    				</div>
		    			</div>	
		    			<div class="col-sm-8">
		    				<p><b>Product id:</b> <small><%out.print(product.getPid());%></small></p>
		    				<p><b>Description:</b> <small><%out.print(product.getDescription());%></small></p>
				   			<p><b>Flavour:</b> <small><%out.print(product.getFlavour().getName());%></small></p>
				   			<p><b>category:</b> <small><%
				   										for(Category category:categories)
				   										{
				   											out.print(category.getName()+" ");
				   										}
				   										%></small></p>
				   			<p><b>Floors(Tiers):</b> <small><%out.print(product.getTier());%></small></p>
				   			<p><b>Price:</b> <small><%out.print(product.getPrice());%> (in rupees)</small> <a style="margin-left: 10px;">Update Price</a></p>
				   			<p><b>Quantity:</b> <small><%out.print(product.getQuantity());%></small> <a style="margin-left: 10px;">Update Quantity</a></p>
		    			</div>
	    			</div><!-- End of product -->
	    	
    	<%
    			}//end of for each loop
    		}//end of else block
    	%>
    
    	<hr>
    
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