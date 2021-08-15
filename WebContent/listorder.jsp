<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>GME Grocery Order List</title>
<style>
	html{
		background-color: #ffffff;
	}
	head, body{
		width: 90%;
		margin: auto;
		background-color: #ffffff;
	}
	.table{
		width: auto;
		margin: auto;

	}
</style> 
<%@ include file="header.jsp" %>
</head>
<body>


<div class="table">
	<h1 text-align=\"center\">Order List</h1>
<%
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
try (Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) 
{		

// Write query to retrieve all order summary records

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

	PreparedStatement pstmt = con.prepareStatement("SELECT orderId, orderDate, ordersummary.customerId, CONCAT(firstName, ' ', lastName) AS customerName, totalAmount FROM ordersummary JOIN customer ON customer.customerId = ordersummary.customerId");
	
	ResultSet rst1 = pstmt.executeQuery(); 
	ResultSet rst2;
	out.println("\n<table class=\"table\" border=\"0\" cellspacing=\"20\"><tr>"); 
	
		while (rst1.next()) {
		int quantity = 0;
		String total = "$" + rst1.getString(5);
		out.println("<tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
		out.println(
			"<tr><td align=\"right\">" + rst1.getString(1) + "</td><td align=\"right\">" + rst1.getString(2) + "</td><td align=\"right\">" + rst1.getString(3) + "</td><td align=\"right\"> " + rst1.getString(4) + "</td><td align=\"right\">" + total + "</td></tr>" +
			"<tr align=\"right\"><td colspan=\"5\"><table class=\"table\" border=\"1\"><th>Product Name</th><th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>"
		);
	
		rst2 = stmt.executeQuery("SELECT OP.productId, OP.quantity, OP.price, productName FROM orderproduct OP left join product P on OP.productId = P.productId WHERE OP.orderId = " + rst1.getInt(1)); 
	
		while(rst2.next()){
		out.println("<tr><td>"+ rst2.getString(4) + "</td><td>" + rst2.getString(1) + "</td><td>" + rst2.getString(2) + "</td><td>$" + rst2.getString(3) + "</td></tr>");
			quantity += rst2.getInt(2);
		}
		out.print("</table>");
		out.println("<table class=\"table\" border=\"0\" cellspacing=\"15\"><tr><td><td></td><td>Total Quantity: " + quantity + "</td><td> Total Price:" + total + "</td></tr></table></td></tr>");
	}
	
// Close connection
out.println("</table>");
	
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
%>
</div>
</body>
</html>
