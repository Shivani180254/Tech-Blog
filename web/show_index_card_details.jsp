
<%@page import="com.tech.blog.entities.IndexCard" %>
<%@page import="com.tech.blog.entities.User" %>
<%@page import="com.tech.blog.dao.IndexDao" %>
<%@page import="com.tech.blog.helper.ConnectionProvider" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>


<!-- nav bar -->
<%@include file="normal_navbar.jsp" %>




<%
    String s=request.getParameter("index_id");
    int indexId=Integer.parseInt(request.getParameter("index_id"));
    IndexDao d=new IndexDao(ConnectionProvider.getConnection());
    IndexCard i=d.getIndexCardsByIndexId(indexId);
    %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= i.getItitle()%></title>
<!-- CSS -->
       <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
       <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
       <style>
           .post-title{
               font-weight: 100;
               font-size:  30px;
           }
           .post-content{
               font-weight: 100;
               font-size:  22px;
           }
           .post-date{
               font-style: italic;
           }
           .post-user-info{
               font-size: 18px;
               font-weight: 100;
           }
           .row-user{
               border: 1px solid #e2e2e2;
               padding-top: 5px;
           }
           body{
               background: url(img/tech_background3.jpeg);
               background-size: cover;
               background-attachment: fixed;
           }
       </style>
       
    </head>
    <body>
   

<!--main content of the body-->
        <div class="container">
            <div class="row my-4">
                <div class="col-md-10 offset-md-1">
                    <div class="card">
                        <div class="card-header text-center primary-background text-white">
                            <h4 class="post-title"><%=i.getItitle()%></h4>
                            
                        </div>
                            <div class="card-body">
                            <img class="card-img-top my-2" style="height: 300px" src="post_pics/<%=i.getIpic()%>" alt="Card image cap">
                        
                            <p class="post-content"><%=i.getIcontent()%></p>
                            <br>
                            <br>
                            <div class="post-code"><pre><%=i.getIcode()%></pre></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
<!--end of main content-->

 
<!-- java-script -->
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
         
        
        
        
        
        </script>
    </body>
</html>
