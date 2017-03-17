<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="model.Product" %>
<%@ page import="model.DAO" %>
<%@ page import="java.util.*" %>
    
<%@ taglib prefix="m" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Shopping cart</title>
</head>
<body>
	<% Product p =new Product(); %>
	
		<table cellpadding="2"  cellspacing="2" border="2">
			<tr>
				<th>id</th>
				<th>Name</th>
				<th>Description</th>
				<th>Tier</th>
				<th>Flavour</th>
				<th>Price</th>
				<th></th>
				<th>Seller</th>
			</tr>
			
			<% DAO da=new DAO();
			List<Product> products =da.getProduct();
			int i=products.size();
			out.println(i);
		
			for(int z=0; z<=(i-1);z++)
			{
				out.println("<tr>");
				out.println("<td>"+ products.get(z).getPid() + "</td>");
				out.println("<td>"+ products.get(z).getName() + "</td>");
				out.println("<td>"+ products.get(z).getDescription() + "</td>");
				out.println("<td>"+ products.get(z).getTier() + "</td>");
				out.println("<td>"+ products.get(z).getFlavour() + "</td>");
				out.println("<td>"+ products.get(z).getPrice() + "</td>");
				out.println("<td> <a href='CartServlet?productid="+products.get(z).getPid()+"'> Add to Cart </a>");        // URL REWRITING concept is used here to send pid
				//out.println("<td>"+ products.get(z).getSeller() + "</td>");
				//lazy intializationException problem to be solved	
			}
			
			%>
			
														<%-- 
	 		
													<m:forEach var="g" begin="0" end="i-1"  items="<%=products%>" >
														<tr>
															<td><% products.get(i).getPid(); %></td>
															<td><% products.get(i).getName(); %></td>
															<td><% products.get(i).getDescription(); %></td>
															<td><% products.get(i).getTier(); %></td>
															<td><% products.get(i).getFlavour(); %></td>
															<td><% products.get(i).getSeller(); %></td>
															<td><% products.get(i).getPrice(); %></td>
															
															
													</m:forEach>
														--%>
			
			
			</tr>
			
		</table>
	
</body>
</html>