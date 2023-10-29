<%@page import="java.util.ArrayList" %>
<%@page import="com.tech.blog.entities.User" %>
<%@page import="com.tech.blog.entities.Message" %>
<%@page import="com.tech.blog.dao.PostDao" %>
<%@page import="com.tech.blog.helper.ConnectionProvider" %>
<%@page import="com.tech.blog.entities.Categories" %>


<%@page errorPage="error_page.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- nav bar -->
        <%@include file="inside_navbar.jsp" %>

<%
    
    User user = (User) session.getAttribute("currentUser");
    if(user==null)
    {
    response.sendRedirect("login_page.jsp");
   }
   %>



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile  Page</title>
        
        <!-- css-style -->
       <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
       <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
       <style>
             body{
               background: url(img/tech_background3.jpeg);
               background-size: cover;
               background-attachment: fixed;
           }
       </style>
    </head>
    <body>
       
        


           <%
                                Message m=(Message)session.getAttribute("msg");
                                if(m!=null)
                                {
                                %>
                                <div class="alert <%= m.getCssClass()%>" role="alert">
                                   <%= m.getContent()%>
                                </div>
                                <%
                                    session.removeAttribute("msg");
                               }
            %>
                            
<!--main body of the page-->
        <main>
            <div class="container">
                <div class="row mt-4">
                    <!--first column-->
                    <div class="col-md-4">      <!--//total grid we have is 12 so md is for medium and 4 id col size out of 12-->
                       <!--categories--> 
                       <div class="list-group">
                           <a href="#" onclick="getPosts(0,this)" id="first-link" class=" c-link list-group-item list-group-item-action active">
                          All Posts
                        </a>
                           <%
                              PostDao d=new PostDao(ConnectionProvider.getConnection());
                              ArrayList<Categories> l=d.getAllCategories();
                              for(Categories x:l){
                            %>
                            <a href="#" onclick="getPosts(<%=x.getCid()%>,this)"  class=" c-link list-group-item list-group-item-action"><%=x.getName()%></a>
                           <% }%>
                       </div>
                    </div>
                    
                    <!--second column-->
                    <div class="col-md-8" id="post-container">
                       <!--posts--> 
                       <div class="container text-center" id="loader">
                           <i class="fa fa-refresh fa-2x fa-spin"></i>
                           <h3 class="mt-2">Loading.....</h3>
                       </div>
                       <div class="container-fluid" id="post-container">
                           
                       </div>
                    </div>
                </div>
            </div>
        </main>
<!--end of main body of the page-->


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
        
        
<!--java Script for edit button-->       
        <script>
            $(document).ready(function(){
                let editStatus=false;
                $('#edit-profile-btn').click(function(){
                   if(editStatus===false){
                        $("#profile-details").hide();
                        $("#profile-edit").show();
                        editStatus=true;
                        $(this).text("back");
                   }
                   else
                   {
                        $("#profile-details").show();
                        $("#profile-edit").hide();
                        editStatus=false;
                        $(this).text("edit");
                   }
 
                });
            });
        </script>
        
<!--add post java script-->
        <script>
            $(document).ready(function(e){
               // alert("loaded");
               $("#add-post-form").on("submit",function(event){
                   event.preventDefault();                          // synchronous behaviour of form is stopped now
                   //console.log("submitted");
                   let form=new FormData(this);                      //all form data get collected to form now
                   $.ajax({
                       url : "AddPostServlet",
                       type :"Post",
                       data:form,
                       
                       success: function (data, textStatus, jqXHR) {
                         
                           if(data.trim()==='done')
                           { 
                             swal("Good job!", "Saved Successfully", "success");
                           }
                           else
                           {
                               swal("Error", "Something went wrong... try Again!", "error");
                           }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            swal("Error", "Something went wrong... try Again!", "error");
                        },
                        processData: false,                          //to send all the pictures also 
                        contentType:false
                   });
               });
            });
        </script>
        
        
<!--java script for loading posts-->       
        <script>
            function getPosts(catid,temp){
                $(".c-link").removeClass('active');
                
                $.ajax({
                   url:"load_post.jsp",
                   data:{cid:catid},
                   success: function (data, textStatus, jqXHR) {
                        //console.log(catid);
                        $("#loader").hide();
                        $("#post-container").html(data);
                        $(temp).addClass('active');
                    }   
                    
               });
            }
            $(document).ready(function(e){
               let allPostRef=$('#first-link')[0];
               getPosts(0,allPostRef);
            });
        </script>
            
    </body>
</html>
