<%@page import="java.util.ArrayList" %>
<%@page import="com.tech.blog.entities.User" %>
<%@page import="com.tech.blog.entities.Posts" %>
<%@page import="com.tech.blog.dao.PostDao" %>
<%@page import="com.tech.blog.dao.LikeDao" %>
<%@page import="com.tech.blog.dao.UserDao" %>
<%@page import="com.tech.blog.helper.ConnectionProvider" %>
<%@page import="com.tech.blog.entities.Categories" %>
<%@ page import="java.text.DateFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%@include file="inside_navbar.jsp" %>


<%
    
    User user = (User) session.getAttribute("currentUser");
    if(user==null)
    {
    response.sendRedirect("login_page.jsp");
   }
   %>


<%
    int postId=Integer.parseInt(request.getParameter("post_id"));
    PostDao d=new PostDao(ConnectionProvider.getConnection());
    Posts p=d.getPostByPostId(postId);
    %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getPtitle()%></title>
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
               font-weight: 200;
               font-size:  20px;
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
                            <h4 class="post-title"><%=p.getPtitle()%></h4>
                            
                        </div>
                            <div class="card-body">
                            <img class="card-img-top my-2" style="height: 200px" src="post_pics/<%=p.getPpic()%>" alt="Card image cap">
                            <div class="row my-3 row-user">
                                <div class="col-md-8">
                                    <%
                                        UserDao ud = new UserDao(ConnectionProvider.getConnection());
                                        
                                        %>
                                    <p class="post-user-info">
                                        <a href=""><%=ud.getUserByUserId(p.getUserid()).getName()%></a>  has posted 
                                    </p>
                                </div>
                                <div class="col-md-4">
                                    <p class="post-date"><%=DateFormat.getDateTimeInstance().format(p.getPdate())%></p>
                                </div>
                            </div>
                            <p class="post-content"><%=p.getPcontent()%></p>
                            <br>
                            <br>
                            <div class="post-code"><pre><%=p.getPcode()%></pre></div>
                        </div>
                        <div class="card-footer">
                            <%
                                LikeDao ld=new LikeDao(ConnectionProvider.getConnection());
                                int n=ld.countNumberOfLikes(p.getPid());
                            %>
                            <a href="#" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>)" class="btn btn-outline-primary btn-sm">
                                <i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%=n%></span></a>
                            <a href="#" class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"></i><span>20</span></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
<!--end of main content-->


<!--profile modal-->
             
           <div class="modal fade" id="ProfileModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
             <div class="modal-dialog" role="document">
               <div class="modal-content">
                 <div class="modal-header primary-background text-white text-center">
                   <h4 class="modal-title" id="exampleModalLabel">Tech Blog</h4>
                   <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                     <span aria-hidden="true">&times;</span>
                   </button>
                 </div>
                 <div class="modal-body">
                     <div class="container text-center">
                         <img src="profile-pics/<%=user.getProfile()%>" class="img-fluid" style="border-radius: 50% ;max-width: 100px;;">
                         <br>
                          <h4 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h4>
                          
                          <!--details-->
                          <div id="profile-details">
                                <table class="table">
                               
                                   <tbody>
                                        <tr>
                                          <th scope="row">ID :</th>
                                          <td><%=user.getId()%></td>
                                        </tr>
                                        <tr>
                                          <th scope="row">Email :</th>
                                          <td><%=user.getEmail()%></td>
                                        </tr>
                                        <tr>
                                          <th scope="row">Gender :</th>
                                          <td><%=user.getGender()%></td>
                                        </tr>
                                        <tr>
                                          <th scope="row">Status :</th>
                                          <td><%=user.getAbout()%></td>
                                        </tr>
                                        <tr>
                                          <th scope="row">Registered Date :</th>
                                          <td><%=user.getDateTime().toString()%></td>
                                        </tr>
                                    </tbody>
                                 </table>
                          </div> 
                                        
                           <!--profile edit-->             
                           <div id="profile-edit" style="display: none" >
                             <!-- <h5 class="mt-2">Please Edit Carefully</h5>  -->
                             <form action="EditServlet" method="POST" enctype="multipart/form-data">
                                 <!--enctype="multipart/form-data" is used because this form contains a image type data also-->
                                  <table class="table">
                                      
                                      <tr>
                                          <td>ID :</td>
                                          <td><%=user.getId()%></td>
                                      </tr>
                                      <tr>
                                          <td>Name :</td>
                                          <td><input type="text" class="form-control" name="user_name" value="<%=user.getName()%>"></td>
                                      </tr>
                                      <tr>
                                          <td>Email :</td>
                                          <td><input type="email" class="form-control" name="user_email" value="<%=user.getEmail()%>"></td>
                                      </tr>
                                      <tr>
                                          <td>Password :</td>
                                          <td><input type="password" class="form-control" name="user_password" value="<%=user.getPassword()%>"></td>
                                      </tr>
                                      
                                      <tr>
                                          <td>Gender :</td>
                                          <td><%=user.getGender().toUpperCase()%></td>
                                      </tr>
                                      <tr>
                                          <td>About :</td>
                                          <td><textarea  class="form-control" name="user_about" rows="3"><%=user.getAbout()%></textarea></td>
                                      </tr>
                                      <tr>
                                          <td>New Profile :</td>
                                          <td><input type="file" name="image" class="form-control"></td>
                                      </tr>
                                  </table>
                                      <div class="container">
                                          <button type="submit" class="btn-outline-primary">Save</button>
                                      </div>
                              </form>
                          </div>              
                        
                     </div>
                 </div>
                 <div class="modal-footer">
                   <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                   <button id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>
                 </div>
               </div>
             </div>
           </div>

 <!--end of profile modal-->
 
 
 <!--add post modal-->
          
            <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Provide the post details...</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
                      <form id="add-post-form" action="AddPostServlet" method="POST">
                          <div class="form-group">
                              <select class="form-control" name="cid">
                                  <option selected disabled>---Select Categories---</option>
                                  <%
                                      PostDao postd=new PostDao(ConnectionProvider.getConnection());
                                      ArrayList<Categories> list=postd.getAllCategories();
                                      for(Categories c:list){
                                   %>
                                   <option value="<%=c.getCid()%>"><%=c.getName()%></option>
                                   <%
                                       }
                                    %>   
                             </select> 
                          </div>
                          
                          <div class="form-group">
                              <input name="ptitle" type="text" placeholder="enter post title" class="form-control"/>
                          </div>
                          <div class="form-group">
                              <textarea name="pcontent" placeholder="enter your content" style="height: 150px" class="form-control"></textarea>
                          </div>
                          <div class="form-group">
                              <textarea name="pcode" placeholder="enter your program if any" style="height: 150px" class="form-control"></textarea>
                          </div>
                          <div class="form-control">
                              <label>
                                  Select your picture     :
                              </label>
                              <input name="ppic" type="file">
                          </div>
                             <div class="container text-center mt-3">
                                 <button type="submit" class="btn btn-outline-primary">POST</button>
                             </div>
                      </form>
                  </div>
                  
                </div>
              </div>
            </div>    
 <!--end of post modal-->
 
<!-- java-script -->
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
         
        
    </body>
</html>
