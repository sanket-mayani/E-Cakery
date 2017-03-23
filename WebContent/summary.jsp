<%@page import="model.Item"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE>
<html>

<%
	ArrayList<Item> successList = null;
	ArrayList<Item> failureList = null;
%>

<%
	successList = (ArrayList<Item>)session.getAttribute("successList");
	failureList = (ArrayList<Item>)session.getAttribute("failureList");
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Summary</title>

	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>

	<p>items in successlist:
	<%
		for(Item i:successList)
			out.print(i.getProduct().getPid());
	%>	
	</p>
	<p>items in failurelist:
	<%	
		for(Item i:failureList)
			out.print(i.getProduct().getPid());
	%>
	</p>

	<script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>

</body>
</html>