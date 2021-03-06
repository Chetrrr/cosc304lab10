<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>


    <!DOCTYPE html>
    <html>
    <head>
    <title>Administrator Page</title>
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
 <%@ include file="header.jsp" %>
    </head>
    <body>
     
    <%@ include file="../auth.jsp"%>
    <%@ page import="java.text.NumberFormat" %>
    <%@ include file="jdbc.jsp" %>
    <%@ page import="java.util.Locale" %>
    
   
    
    <%
    
    // Print out total order amount by day
    String sql = "select year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM OrderSummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";
    Locale locale = new Locale("en","US");
		NumberFormat currFormat = NumberFormat.getCurrencyInstance(locale);
    
    try 
    {	
        out.println("<h3 text-align:center>Daily Sales Report </h3>");
        
        getConnection();
        ResultSet rst = con.createStatement().executeQuery(sql);		
        out.println("<table class=\"table\" border=\"1\">");
        out.println("<tr><th>Date</th><th>Order Amount</th>");	
    
        while (rst.next())
        {
            out.println("<tr><td>"+rst.getString(1)+"-"+rst.getString(2)+"-"+rst.getString(3)+"</td><td>"+currFormat.format(rst.getDouble(4))+"</td></tr>");
        }
        out.println("</table>");		
    }
    catch (SQLException ex) 
    { 	out.println(ex); 
    }
    finally
    {	
        closeConnection();	
    }
    %>
    </div>
    </body>
    </html>
