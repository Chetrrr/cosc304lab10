<!DOCTYPE html>
<html>

<head>

        <title>GME Main Page</title>
  
        <style>
                html{
                        background-color: #ffffff;
                }
                head, body{
                        width: 100%;
                        margin: 0% 0%;
                        background-color: #ffffff;
                }

                * {box-sizing: border-box;}
                body {font-family: Verdana, sans-serif;}
                .mySlides {display: none;}
            

                /* Slideshow container */
                .slideshow-container {
                max-width: 1000px;
                position: relative;
                 margin: auto;
                }

/* The dots/bullets/indicators */
.dot {
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #bbb;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 0.6s ease;
}

.active {
  background-color: #717171;
}

/* Fading animation */
.fade {
  -webkit-animation-name: fade;
  -webkit-animation-duration: 1.5s;
  animation-name: fade;
  animation-duration: 1.5s;
}

@-webkit-keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

@keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}
div {
    text-align: center;
  }
</style>   
<%@ include file="header.jsp" %>
</head>
<body>
  </br></br></br></br></br>
  <h1 align="center" style="color:rgb(235, 21, 21)">Hot and Trending!</h1>
        <div class="slideshow-container">

                <div class="mySlides fade">
                
                  <img src="img\\1.jpg" style="width:50%;" >
              
                </div>
                
                <div class="mySlides fade">
              
                  <img src="img\\2.jpg" style="width:40%">
               
                </div>
                
                <div class="mySlides fade">
           
                  <img src="img\\3.jpg" style="width:100%">
        
                </div>
                
                </div>
                <br>
                
                <div style="text-align:center">
                  <span class="dot"></span> 
                  <span class="dot"></span> 
                  <span class="dot"></span> 
                </div>

                <script>
                        var slideIndex = 0;
                        showSlides();
                        
                        function showSlides() {
                          var i;
                          var slides = document.getElementsByClassName("mySlides");
                          var dots = document.getElementsByClassName("dot");
                          for (i = 0; i < slides.length; i++) {
                            slides[i].style.display = "none";  
                          }
                          slideIndex++;
                          if (slideIndex > slides.length) {slideIndex = 1}    
                          for (i = 0; i < dots.length; i++) {
                            dots[i].className = dots[i].className.replace(" active", "");
                          }
                          slides[slideIndex-1].style.display = "block";  
                          dots[slideIndex-1].className += " active";
                          setTimeout(showSlides, 6000); // Change image every X seconds
                        }
                 </script>

</body>



