<%-- 
    Document   : index
    Created on : 09-Oct-2023, 5:28:45 pm
    Author     : hp
--%>

<%@page import="com.tech.blog.entities.IndexCard" %>
<%@page import="com.tech.blog.entities.User" %>
<%@page import="com.tech.blog.dao.IndexDao" %>
<%@page import="com.tech.blog.helper.ConnectionProvider" %>
<%@page import="java.util.List" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection, java.sql.DriverManager, java.sql.SQLException" %>
<%@page import="com.tech.blog.helper.ConnectionProvider" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tech Blog</title>
        <!-- CSS -->
       <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
       <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
       <style>
 
  .for-index-card{
      background-color:  #2196f3;
      font-family: sans-serif;
      text-align: center;
  }
</style>
    </head>
    <body>
        
        
        <!-- nav bar -->
        <%@include file="normal_navbar.jsp" %>
        
        <!-- Banner -->
        <div class="container-fluid p-0 m-0">
            <div class="jumbotron primary-background">
                <div class="container">
                    
                    <h3 class="display-3 text-white">Welcome to Tech Blog</h3>
                    <p style="font-size: 15px" >Welcome to Technical Blog , The World of Technology. Blogs have become a popular medium for sharing information, expressing ideas, building communities, and even for marketing and business purposes. This Blog offer a flexible and accessible way for individuals and organizations to communicate with a global audience. Get ready to embrace the future, where machines not only learn but also inspire us to innovate, create, and explore new frontiers. The possibilities are limitless, and we invite you to embark on this adventure with us and share your Technical ideas and experiences on this Blog so that people get some help and inspired by your posts.Programming languages are essential for instructing computers. Python is known for its simplicity and versatility, Java for cross-platform applications, JavaScript for web development, C++ for performance and low-level control, Ruby for elegant code, PHP for web scripting, C# for various applications, Swift for iOS, and Kotlin for Android. Each language serves specific purposes.
                    Frameworks, like Django for Python, Angular for JavaScript, and .NET for C#, provide pre-built structures to streamline software development.</p>
                <a href="register_page.jsp" class="btn btn-outline-light btn-lg"><span class="fa fa-user-plus"></span>Start !its Free</a>
                <a href="login_page.jsp" class="btn btn-outline-light btn-lg"><span class="fa fa-user-circle-o"></span>Login</a>
                </div>
            </div>
        </div>
<!--index cards-->

<div class="row">
<%
    IndexDao d=new IndexDao(ConnectionProvider.getConnection());
    List<IndexCard> l=d.getAllIndexCard();
    for(IndexCard i:l){
    %>
    <div class="card-group col-md-4 mt-3x" >
        <div class="card">
              <img class="card-img-top" style="height: 300px" src="post_pics/<%=i.getIpic()%>" alt="Card image cap">
              <div class="card-body" >
                  
                  <b><%=i.getItitle()%></b>
                  <p><%=i.getIoverview()%></p>
              </div>
             <div class="card-footer text-center" style="height: 50px">
                  <a href="show_index_card_details.jsp?index_id=<%=i.getIid()%>" class="btn btn-outline-primary btn-sm">Read more</a>
             </div>
          </div>
      </div>
       <%
             }
       %>
    
</div>
<!--end of index cards-->
        
        <!-- java script -->
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        
        
     
    </body>
</html>
