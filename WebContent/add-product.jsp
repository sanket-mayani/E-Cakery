<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Seller Home</title>
    
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>

<body id="add-product_body">

	<div class="container">
    	
        <div class="row">
            <div class="col-xs-12" id="logo"> 
                <a href="seller-home.html"><img src="images/logo.png" alt="logo"></a>
            </div>      
        </div>
              
    </div><!-- End of Header Section -->
    
    <nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="170">
    
        <div class="container-fluid">
            
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#seller-navigation_links">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span> 
            </button>
            
            <div class="collapse navbar-collapse" id="seller-home-navigation_links">
                
                <ul class="nav navbar-nav">
                    <li><a href="seller-home.jsp"><span class="glyphicon glyphicon-briefcase"></span><span> My Orders</span></a></li>
                    <li><a href="#"><span class="glyphicon glyphicon-eye-open"></span> View Products</a></li>
                    <li class="active"><a href="add-product.jsp"><span class="glyphicon glyphicon-plus"></span> Add Product</a></li>             
                </ul>
                <ul class="nav navbar-nav navbar-right">                    
                    <li><a data-toggle="modal" href="#"><span class="glyphicon glyphicon-user"></span><span> My Account</span></a></li>
                    <li><a data-toggle="modal" href="#"><span class="glyphicon glyphicon-off"></span><span> Sign Out</span></a></li>
                </ul>
                
            </div>
            
        </div>
        
    </nav><!-- End of Navigation Bar -->
	<form id="add-product" action="AddProduct" method="post">
	Name:<input type="text" name="name" required="required"><br>
	Description:<input type="text" name="description" required="required"><br>
	Price:<input type="text" name="price" required="required"><br>
	Tier:<input type="text" name="tier" required="required"><br>
	Image_Id:<input type="text" name="imageid" required="required"><br>
	Flavour:<div id="flavour"></div>
	<input type="submit" value="Add">
	</form>
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>
    
</body>

</html>