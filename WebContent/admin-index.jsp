<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>E-Cakery Admin Login</title>
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>

	<%if(request.getParameter("msg")!=null){%>
		<div class="container-fluid bg-danger" style="text-align: center;">
			<p><%out.print(request.getParameter("msg"));%></p>
		</div>
	<%}%>

	<div class="container">
	
		<h3>Enter your credentials</h3><hr>
	
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2">
				<form class="form-horizontal" method="post" action="AdminLogin">
					<div class="form-group">
					    <label class="control-label col-sm-3" for="email">Email:</label>
					    <div class="col-sm-9">
					      <input type="email" name="email" class="form-control" id="email" placeholder="Enter email" required>
					    </div>
					  </div>
					  <div class="form-group">
					    <label class="control-label col-sm-3" for="pwd">Password:</label>
					    <div class="col-sm-9"> 
					      <input type="password" name="pw" class="form-control" id="pwd" placeholder="Enter password" required>
					    </div>
					  </div>
					  <div class="form-group"> 
					    <div class="col-sm-offset-3 col-sm-9">
					      <button type="submit" class="btn btn-primary">Login</button>
					    </div>
					  </div>
				</form>
			</div>
		</div>
	
	</div><!-- End of main container -->

	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>

</body>
</html>