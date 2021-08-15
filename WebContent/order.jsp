<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>  
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>GME Grocery Order Processing</title>
<style>
	html{
		background-color: #ffffff;
	}
	head, body{
		width: 90%;
		margin: 0 5% 0 5%;
		background-color: #ffffff;
	}
        </style>

</head> 
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
String password = request.getParameter("password");

@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
// If either are not true, display an error message

// Make connection

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";



try(Connection con = DriverManager.getConnection(url, uid, pw);Statement stmt = con.createStatement())
{
	if(custId==null || custId.equals(""))
	{
		out.println("<h3>Customer ID or password cannot be null!</h3><h3><a href=\"checkout.jsp\">Try again</a></h3>");
		//throw new Exception();
	}
	if(productList==null || productList.isEmpty())
	{
		out.println("<h2>Your shopping cart is empty.</h2>");
		//throw new Exception();
	}
	String query = "select customerId from customer";
	PreparedStatement pstmt = con.prepareStatement(query);
	ResultSet rst = pstmt.executeQuery();
	boolean v = false;
	while(rst.next()){
		if(rst.getString(1).equals(custId)){
			v = true;
			break;
		}
	}
	if(!v)
	{
		out.println("<h2>Invalid customer</h2><h2><a href=\"checkout.jsp\">Try again</a></h2>");
		//throw new Exception();
	}
	else if(!productList.isEmpty())
	{
		Locale locale = new Locale("en","US");
		NumberFormat currFormat = NumberFormat.getCurrencyInstance(locale);
		out.println("<h1>Your Order Summary</h1>");
		out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
		out.println("<th>Price</th><th>Subtotal</th></tr>");

		double total =0;

		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
		while (iterator.hasNext()) 
		{	
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			if (product.size() < 4)
				{
					out.println("Expected product with four entries. Got: "+product);
					continue;
				}
				out.print("<tr><td>"+product.get(0)+"</td>");
					out.print("<td>"+product.get(1)+"</td>");
		
					out.print("<td >"+product.get(3)+"</td>");
					Object price = product.get(2);
					Object itemqty = product.get(3);
					double pr = 0;
					int qty = 0;
					try
					{
						pr = Double.parseDouble(price.toString());
					}
					catch (Exception e)
					{
						out.println("Invalid price: "+product.get(0)+" price: "+price);
					}	
					try
				{
					qty = Integer.parseInt(itemqty.toString());
				}
				catch (Exception e)
				{
					out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
				}	
			out.print("<td>"+currFormat.format(pr)+"</td>");
			out.print("<td >"+currFormat.format(pr*qty)+"</td></tr>");
			out.println("</tr>");
			total = total +pr*qty;	
		}	
		// Print out order summary
		out.println("<tr><td><b>Order Total</b></td>"
			+"<td >"+currFormat.format(total)+"</td></tr>");
		out.println("</table>");
		DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime now = LocalDateTime.now();
			String time = fmt.format(now);  
			
			java.sql.Timestamp sqldate = java.sql.Timestamp.valueOf(time);
			String input = "DECLARE @orderId int; INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (?,?,?); SELECT @orderId = @@IDENTITY; ";
			out.println("<h2>Your order time is: " + time + "</h2>");

			Iterator<Map.Entry<String, ArrayList<Object>>> i = productList.entrySet().iterator();
				while(i.hasNext()){
					Map.Entry<String, ArrayList<Object>> entry = i.next();
						input += "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, ?,?,?);";
				}
				pstmt = con.prepareStatement(input);
				pstmt.setString(1, custId);
				pstmt.setObject(2, sqldate);
				pstmt.setDouble(3, total);
				int count = 3;
				i = productList.entrySet().iterator();
				while (i.hasNext())
				{
					
					Map.Entry<String, ArrayList<Object>> entry = i.next();
						ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
						String productId = (String) product.get(0);
						String price = (String) product.get(2);
							
						
						
						double pr = Double.parseDouble(price);
						

						int qty = ( (Integer)product.get(3)).intValue();
						
						//input += "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, "+productId+","+qty+","+pr + ");";
						pstmt.setString(++count,productId);
						pstmt.setInt(++count, qty);
						pstmt.setDouble(++count, pr);
				}
				pstmt.executeUpdate();
				out.println("<h2>Order completed.</h2>");
				PreparedStatement pstmt1 = con.prepareStatement("select orderId from ordersummary order by orderId desc");
		ResultSet rst1 = pstmt1.executeQuery();
		rst1.next();
		int currOrderNum = rst1.getInt(1);
		out.println("Your reference number is " + Integer.toString(currOrderNum));


// Clear cart if order placed successfully
		productList.clear();
		out.println("<h2><a href=\"shop.html\">Back to Shopping</a></h2>");
	}
	else if(productList.isEmpty() || productList == null){
		out.println("<h2>Please go back to shopping</h2></br><h2><a href=\"shop.html\">Back to shopping</a></h2>");
	}

}
/*
catch(Exception e){
	out.print("<h2>Error</h2>");
}*/








%>
</BODY>
</HTML>

