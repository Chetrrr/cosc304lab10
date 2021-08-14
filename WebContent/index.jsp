<!DOCTYPE html>
<html>
<head>
        <title>GME Main Page</title>
        <style>
                html{
                        background-color: #ffffff;
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


<h2 align="center"><a href="login.jsp">Login</a></h2>


<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)
String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h3 align=\"center\">Logged in as:  "+userName+"</h3>");	
%>
</body>
</head>


