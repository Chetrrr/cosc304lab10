<style>
    /* Style The Dropdown Button */
    .dropbtn {
      background-color: #ffffff;
      color: rgb(0, 0, 0);
      padding: 16px;
      font-size: 16px;
      border: none;
      cursor: pointer;
    }
    
    /* The container <div> - needed to position the dropdown content */
    .dropdown {
      position: relative;
      display: inline-block;
    }
    
    /* Dropdown Content (Hidden by Default) */
    .dropdown-content {
      display: none;
      position: absolute;
      background-color: #f6f6f6;
      min-width: 160px;
      box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
      z-index: 1;
    }
    
    /* Links inside the dropdown */
    .dropdown-content a {
        font-family: monospace;
      color: black;
      padding: 12px 16px;
      text-decoration: none;
      display: block;
    }
    
    /* Change color of dropdown links on hover */
    .dropdown-content a:hover {background-color: #f1f1f1}
    
    /* Show the dropdown menu on hover */
    .dropdown:hover .dropdown-content {
      display: block;
    }
    
    /* Change the background color of the dropdown button when the dropdown content is shown */
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
  height : 45px;
  position: relative;
  top:-16px;
        }
    </style>


<H1 align="center">    

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
    &nbsp;&nbsp;
    
    <input type="text" name="productName" placeholder="  Search Here Now!" size="70" height="45">
    <input type="submit" value="Search">
    </form>
</H1>      

