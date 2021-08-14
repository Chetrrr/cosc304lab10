
<style>

    .dropbtn {
      background-color: #ffffff;
      color: rgb(0, 0, 0);
      padding: 16px;
      font-size: 16px;
      border: none;
      cursor: pointer;
    }

    .dropdown {
      position: relative;
      display: inline-block;
    }
    
    .dropdown-content {
      display: none;
      position: absolute;
      background-color: #f6f6f6;
      min-width: 160px;
      box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
      z-index: 1;
    }
    
    .dropdown-content a {
        font-family: monospace;
      color: black;
      padding: 12px 16px;
      text-decoration: none;
      display: inline-block;
    }
    
    .dropdown-content a:hover {background-color: #f1f1f1}
    
    .dropdown:hover .dropdown-content {
      display: block;
    }
    
    .dropdown:hover .dropbtn {
      background-color: #ffffff;
    }

    input[type=text] {
         background-color: #eeeeee;
         color: rgb(97, 97, 97);
            border-top-style: hidden;
         border-right-style: hidden;
         border-left-style: hidden;
          border-bottom-style: hidden;
          border: 0px;
 
         position: relative;
         top:-16px;
        }
        button[type=submit]{
          border: 0px;
          height:50px;
        }
        a:visited { color: #444444; text-decoration:none;}
        a:hover { color: #ec1e1e;}
        a { color: #444444;  text-decoration:none;  font-family: monospace;}
.valign{
    white-space: normal;
    
         top:-16px;
}
        h2{
            
            white-space: normal;
            text-align: center;
            font: caption;
            letter-spacing:3px;
            color: #f6f6f6;
            background-color: rgb(65, 65, 65);
        }
        .search_bar input[type="text"]{
        position:relative;      
        height : 50px;
        display: inline;
        width:30%;
    </style>

<h2>
    FREE shipping on orders above $45
</h2>
<H1 align="center">    


    <div class="search_bar">
      <form method="get" action="listprod.jsp">
       <div class="dropdown">
        <button class="dropbtn"><img src="img\\menu.jpg" alt="menu menu" height="45"></button>
        <div class="dropdown-content">
          <a href="listprod.jsp">Shop Now</a>
          <a href="listorder.jsp">List All Orders</a>
          <a href="customer.jsp">Customer Info</a>
          <a href="admin.jsp">Administrators</a>
        </div>
        </div>
        &nbsp;&nbsp;
 
    <a href="index.jsp"><img src="img\\logo.jpg" alt="GME Logo" height="45"></a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="text" name="productName" placeholder="  Search Here Now!" size="70" height="45"><button type="submit" >
        <img src="img\\search.jpg" alt="searchme" height="45" >
        </button>
        &nbsp;&nbsp;
    <img class="valign" src="img\\user.jpg" alt="user icon" height="45" >


<a class="valign" href="login.jsp">Login</a>&nbsp;
<a class="valign" href="logout.jsp">Log out</a>

&nbsp;&nbsp;
<a href="addcart.jsp"><img src="img\\cart.jpg" alt="vroom" height="45"></a>
    </div>
    </form>




</H1>      

<%

String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h3 align=\"right\">Logged in as:  "+userName+"  &nbsp; </h3>");	
%>