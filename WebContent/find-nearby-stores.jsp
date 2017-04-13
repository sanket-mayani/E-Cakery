<%@page import="model.DAO"%>
<%@page import="java.util.List"%>
<%@page import="model.Cart"%>
<%@page import="model.User"%>
<%@page import="model.Seller"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<%request.getRequestDispatcher("message-on-top.jsp").include(request, response);%>

<%
	User user = null;
	Cart cart = new Cart();
	List<Seller> sellers;
	DAO dao = new DAO();
%>

<%
	if(session.getAttribute("user")!=null)
		user = (User)session.getAttribute("user");

	if(session.getAttribute("cart")!=null)
		cart = (Cart)session.getAttribute("cart");
	else
		session.setAttribute("cart", cart);
	
	sellers = dao.getAllSellers();
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Find Nearby Stores</title>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
</head>
<body>

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

	<div class="container">

		<div class="row">
			<div class="col-xs-12">
				<span><a class="color1" href="index.jsp">Home</a></span> <span>></span>
				<span>Nearby Stores</span>
			</div>
		</div>

		<div class="row">

			<h3 class="center font1">You Are Here</h3>

			<div class="col-xs-12" id="map"
				style="height: 400px; border: 1px solid black; margin-bottom: 30px;">
			</div>

		</div>

	</div>

	<script src="js/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/script.js"></script>

	<script type="text/javascript">
      
	function getLocation() 
    {
    	if (navigator.geolocation) {
    		navigator.geolocation.getCurrentPosition(initMap);
    	} 
    	else 
    	{
        	x.innerHTML = "Geolocation is not supported by this browser.";
     	}
	}

      //Set up some of our variables.
      var map; //Will contain map object.
      var marker = false; ////Has the user plotted their location marker? 
              
      //Function called to initialize / create the map.
      //This is called when the page has loaded.
      function initMap(position) {

          //The center location of our map.
          var centerOfMap = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

          //Map options.
          var options = {
            center: centerOfMap, //Set center.
            zoom: 16 //The zoom value.
          };
          
          //Create the map object.
          map = new google.maps.Map(document.getElementById('map'), options);
          
          marker = new google.maps.Marker({
              position: centerOfMap,
              map: map,
              title : 'You are here'
            });
          
          var infowindow = new google.maps.InfoWindow({
        	  maxWidth : 200
          });
          
          <%for(Seller seller : sellers){%>
          		<%if(seller.getLatitude()!=0 || seller.getLongitude()!=0){%>
	          		centerOfMap = new google.maps.LatLng(<%out.print(seller.getLatitude());%>,<%out.print(seller.getLongitude());%>);
	          		marker = new google.maps.Marker({
	                    position: centerOfMap,
	                    map: map,
	                    icon : 'images/icons/store.png',
	                    title : '<%out.print(seller.getName());%>'
	                  });	
	          		
	          		 marker.addListener('click', function() {
	          			var name = '<strong><a href="VisitSeller?sid=<%out.print(seller.getSid());%>">'+'<%out.print(seller.getName());%>'+'</a></strong>';
	          			var address = '<small>'+'<%out.print(seller.getAddress());%>'+'</small>';
	          			var pin = '<small>'+'<%out.print(seller.getPincode());%>'+'</small>';
	          			var city = '<small>'+'<%out.print(seller.getCity().getName());%>'+'</small>';
	          			var distance = getDistanceFromLatLonInKm(position.coords.latitude, position.coords.longitude, <%out.print(seller.getLatitude());%>, <%out.print(seller.getLongitude());%>)
	          			var contentString = name+'<br>'+address+'<br>'+pin+'<br>'+city+'<br>'+'Distance: '+distance+' km';
	          			infowindow.setContent(contentString);
	            	    infowindow.open(map, this);
	            	  });
          		 <%}%>
          <%}%>
              
      }
      
      function getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
    	  var R = 6371; // Radius of the earth in km
    	  var dLat = deg2rad(lat2-lat1);  // deg2rad below
    	  var dLon = deg2rad(lon2-lon1); 
    	  var a = 
    	    Math.sin(dLat/2) * Math.sin(dLat/2) +
    	    Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * 
    	    Math.sin(dLon/2) * Math.sin(dLon/2)
    	    ; 
    	  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
    	  var d = R * c; // Distance in km
    	  return d.toFixed(3);
    	}

    	function deg2rad(deg) {
    	  return deg * (Math.PI/180)
    	}
             
    </script>
	<script type="text/javascript"
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD6--CBgkGVNJ_rIM1DLChPCSEpgeO_4Ac&callback=getLocation"></script>
		
	<%request.getRequestDispatcher("registration-and-login-modal.jsp").include(request, response);%>	

</body>
</html>