<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>GME Grocery</title>
<style>
	html{
		background-color: #edeee1;
	}
	head, body{
		width: 90%;
		margin: 0 5% 0 5%;
		background-color: #bdf5b8;
	}
</style>
</head>
<body>
	<%@ include file="header.jsp" %>
<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
String sql = "SELECT productId, productName, productPrice FROM product JOIN category ON product.categoryId = category.categoryId";

// Make the connection

try (Connection con = DriverManager.getConnection(url, uid, pw);
    Statement stmt = con.createStatement();) 

{
	PreparedStatement pstmt = con.prepareStatement("SELECT productId, productName, productPrice FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE ?");
	ResultSet rst;
	if(name==null)
	name = "";
	if(name.equals("")){
		rst = stmt.executeQuery(sql);

	}else{
		pstmt.setString(1, "%" + name + "%");
		rst = pstmt.executeQuery();
	}
	out.println("<h2>All Products</h2>");
	out.println("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		
		while (rst.next()) 
		{
			out.print("<tr><td><a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2) + "&price=" + rst.getDouble(3) + "\">Add to Cart</a></td>");
			out.println("<td><a href=\"product.jsp?id=" + rst.getInt(1) + "\">" + rst.getString(2)  + "</a></td>");
			out.print("<td>" + currFormat.format(rst.getDouble(3)) + "</td></tr>");
		}
	out.println("</table>");
}

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

catch (SQLException ex) 
{ 	out.println(ex); 
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>