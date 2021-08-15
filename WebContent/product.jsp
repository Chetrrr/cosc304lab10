<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Locale" %>
<html>
<head>
<title>GME Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>
	html{
		background-color: #ffffff;
	}
	head, body{
		width: 90%;
		margin: 0 5% 0 5%;
		background-color: #ffffff;
	}
	.imageFix{
		
     max-width:400px;
     height:auto;
		
 }
 .search_bar input[type="text"]{
        position:relative;  
        display: inline;
        width:30%;
		top:5px;
 }
 .valign{
         top:10px;
}
input[type=text] {
	height : 49px;
}

a:hover, a:active {
  background-color: rgb(255, 223, 223);
  text-decoration: none;
}
</style>
<%@ include file="header.jsp" %>
</head>
<body> 

	

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");

String sql = "SELECT productImageURL, productPrice ,productImage, productDesc, productName FROM product WHERE productId = ?";
Locale locale = new Locale("en","US");
NumberFormat currFormat = NumberFormat.getCurrencyInstance(locale);

// TODO: If there is a productImageURL, display using IMG tag
try{
	getConnection();
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(productId));	
	ResultSet rst = pstmt.executeQuery();
			
	if (rst.next())
	{
		out.print("<h1>"+ rst.getString(5)+ "</h1>");
		out.print("<br><tr><img src=\"img\\" + productId + ".jpg\" width=700px height=auto></tr></div>");  
		//out.println("<br><img src=\"displayImage.jsp?id=" + productId + "\" width=10px height=auto>");

		out.println("<br><tr><th>Id: </th><td>" + productId +  "</td></tr>");				
	    out.println("<br><tr><th>Price: </th><td>"  + currFormat.format(rst.getDouble(2)) + "</td></tr>");
		out.println("<br><tr><th>Description: </th></tr><tr><td>" + rst.getString(4) + "</td></tr>");

	}
        // TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
				
        // TODO: Add links to Add to Cart and Continue Shopping
        PreparedStatement pstmt2 = con.prepareStatement("SELECT productName, productPrice FROM product WHERE productId = ?");
        pstmt2.setInt(1, Integer.parseInt(productId));
        ResultSet rst2 = pstmt2.executeQuery();
        String productName, price;

        if(rst2.next())
		{
	    productName = rst2.getString(1);
	    price = rst2.getString(2);
	    out.println("<br><h1><a href=\"addcart.jsp?id=" + productId + "&name=" + productName + "&price=" + price + "\">Add to Cart</a></h1>");
        out.println("<h1><a href=\"listprod.jsp\">Continue Shopping</a></h1>");
		}
} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}

%>

</body>
</html>