<%@page import="model.Seller"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<%request.getRequestDispatcher("message-on-top.jsp").include(request, response);%>

<%!
	Seller s;
%>
<%	
	if(session.getAttribute("seller") != null)
		s = (Seller)session.getAttribute("seller");
	else
		response.sendRedirect("seller-index.jsp");
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Store Location</title>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
</head>
<body>

	<div class="container-fluid" id="heading_section">
		<div class="container">

			<div class="row">
				<div class="col-sm-6">
					<h2 id="title">
						<a href="seller-index.jsp" class="white">E-Cakery</a>
					</h2>
				</div>
				<div class="col-sm-6" id="cart_section">
					<span class="dropdown">
						<button class="dropdown-toggle" data-toggle="dropdown">
							Hi,
							<%out.print(s.getName());%>
							<span class="caret"></span>
						</button>
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
	</div>
	<!-- End of heading section -->

	<div class="container">

		<div class="row">
			<div class="col-xs-12">
				<span><a class="color1" href="SellerHome">Home</a></span> <span>></span>
				<span><a class="color1" href="SellerAccount">My Account</a></span> <span>></span>
				<span>Store Location</span>
			</div>
		</div>

		<div class="row">

			<h3 class="center font1">Select Store Location</h3>

			<div class="col-xs-12" id="map"
				style="height: 400px; border: 1px solid black; margin-bottom: 30px;">
			</div>

			<div class="row">
				<form action="ChangeStoreLocation" class="form-horizontal col-sm-8">
					<div class="form-group">
						<label class="control-label col-sm-2" for="lat">Latitude:</label>
						<div class="col-sm-10">
							<input type="text" id="lat" name="lat" class="form-control" readonly>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="lng">Longitude:</label>
						<div class="col-sm-10">
							<input type="text" id="lng" name="lng" class="form-control" readonly>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-danger">Save</button>
						</div>
					</div>
				</form>
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
              map: map
            });
          
          markerLocation();

          //Listen for any clicks on the map.
          google.maps.event.addListener(map, 'click', function(event) {                
              //Get the location that the user clicked.
              var clickedLocation = event.latLng;
              marker.setPosition(clickedLocation);
             
              //Get the marker's location.
              markerLocation();
          });
      }
              
      //This function will get the marker's current location and then add the lat/long
      //values to our textfields so that we can save the location.
      function markerLocation(){
          //Get location.
          var currentLocation = marker.getPosition();
          //Add lat and lng values to a field that we can save.
          document.getElementById('lat').value = currentLocation.lat(); //latitude
          document.getElementById('lng').value = currentLocation.lng(); //longitude
      }
             
    </script>
	<script type="text/javascript"
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD6--CBgkGVNJ_rIM1DLChPCSEpgeO_4Ac&callback=getLocation"></script>

</body>
</html>