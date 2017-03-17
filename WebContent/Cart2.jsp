<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="model.Cart" %>
<%@ page import="model.Item" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Product" %> 
<%@ page import="model.DAO" %>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<% 
		HttpSession sessn = request.getSession();
		Cart cartt = (Cart)sessn.getAttribute("cart");
		ArrayList <Item> itemss =new ArrayList<Item>();
		
		itemss = cartt.getItems();
	%>
	
	<table border='1'>
		<tr>
			<th>Product Name</th>
			<th>Quantity</th>
			<th>Description</th>
			<th>Price</th>
			<th>Total Amount</th>
			<th>Remove item from Cart</th>
		</tr>
		
		
	<%-- we ve used hidden form filed to send pid and quantity --%>	
		
		
		<%
			DAO daoo = new DAO();
			out.println(daoo.fetchProductName(1));
		
			for(int i=0; i<itemss.size(); i++)
			{
		out.println("<tr>");         
		//1st column is name		
		out.println("<td>" + daoo.fetchProductName(itemss.get(i).getProduct().getPid()) + "</td>");		
		// 2nd col					// now we will use hidden form field to pass pid and quantity to CartSErvlet
		out.println("<td> <form action='CartServlet' method='post'> <input type='hidden' name='productid' value='"+itemss.get(i).getProduct().getPid()+"'>");
		
		out.println("<input type='text' size='2' name='quantity' value='"+itemss.get(i).getQuantity()+"'>");
		
		out.println("<input type='submit' name='UpdateButton' value='Update quantity' > </form> </td> ");
		// 3rd col
		out.println("<td>" + daoo.fetchProductDescription(itemss.get(i).getProduct().getPid()) + "</td>");
		//4th
		out.println("<td>" + "BUG here : daoo.fetchProductPrice(itemss.get(i).getProduct().getPid())" + "</td>");
		//5th
		out.println("<td>" + itemss.get(i).getTotalPriceOfProduct() + "</td>");
		//6th
		out.println("<td align='center'> <form action='CartServlet' method='post'> <input type='hidden' name='productid' value='"+itemss.get(i).getProduct().getPid()+"'>");
		
		out.println("<input type='hidden' name='quantity' value='0' >");     // to remove item we will send quantity val as 0 frm hidden form field to CartServlet
		
		out.println("<input type='submit' name='RemoveButton' value='Remove item' > </form> </td>");
	
		
		out.println("</tr>");
				
			}
		%>
	
	</table>
	
	
	<%
	
	out.println("<br> <br>  <form action='ShoppingCart.jsp' method='post' > <input type='submit' name='continue' value='Continue Shopping'> </form>");
	
	%>
	
	
	
	

</body>
</html>