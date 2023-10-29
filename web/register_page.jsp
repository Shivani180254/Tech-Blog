<%-- 
    Document   : register_page
    Created on : 10-Oct-2023, 2:40:40 am
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration Page</title>
        
         <!-- CSS -->
       <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
       <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
       
   
    </head>
    <body>
        <%@include file="normal_navbar.jsp" %>
        <main class="primary-background p-3 ">
            <div class="container">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header  primary-background text-white text-center ">
                            <span class="fa fa-user-plus fa-2x"></span>
                            Register Here
                        </div>
                        <div class="card-body">
                            <form action="RegisterServlet" method="POST" id="reg-form" >
                                
                                        <div class="form-group">
                                          <label for="user-name">User Name </label>
                                          <input name="user-name" type="text" class="form-control" id="user-name" placeholder="Enter username" >
                                        </div>
                                   
                                        <div class="form-group">
                                          <label for="user-email">Email address</label>
                                          <input name="user-email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                          <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                        </div>
                                   
                                        <div class="form-group">
                                          <label for="exampleInputPassword1">Password</label>
                                          <input name="user-password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                        </div>
                                   
                                        <div class="form-group">
                                          <label for="user-gender">Select Gender </label>
                                          <br>
                                          <input type="radio" id="gender" name="gender" value="male">Male
                                          <input type="radio" id="gender" name="gender" value="female">Female
                                        </div>
                                        
                                   <div class="form-group">
                                       <textarea name="about" class="form-control" rows="4" placeholder="enter something about yourself"></textarea>
                                   </div>
                                   
                                   
                                       <div class="form-check">
                                          <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                          <label class="form-check-label" for="exampleCheck1">agree terms and condition</label>
                                        </div>
                                   
                                   <div class="form-group">
                                       <label class="form-check-label" for="exampleCheck1">Already a user click <a href="login_page.jsp">here</a></label>
                                        </div>
                                   
                                   <div class="container text-center" id="loader" style="display:none">
                                       <span class="fa fa-refresh fa-spin fa-2x"></span>
                                       <h5>Please Wait...</h5>
                                   </div>
                                   
                                   <button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
                                </form> 
                        </div>
                        
                    </div>
                </div>
            </div>
        </main>
        
        <!-- javascript -->
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        
        
        <script>
            $(document).ready(function(){
                console.log("loaded............")
                $('#reg-form').on('submit',function(event){
                    event.preventDefault();
                    let form=new FormData(this);
                    $("#submit-btn").hide();
                    $("#loader").show();
                    $.ajax({
                        url:"RegisterServlet",
                        type:"POST",
                        data:form,
                        success:function (data,textStatus,jqXHR){
                            console.log(data)
                           $("#submit-btn").show();
                           $("#loader").hide(); 
                           if(data.trim()==='done')
                           {
                           swal("Registered Successfully...")
                            .then((value) => {
                              window.location="login_page.jsp"
                            });
                          }
                          else
                          {
                              swal(data);
                          }
                           
                        },
                        error:function(jqXHR,textStatus,errorThrown){
                            $("#submit-btn").show();
                            $("#loader").hide(); 
                            swal("Something went wrong try again.");
                                
                        },
                        processData:false,
                        contentType:false
                    });
                });
              
            });
        </script>
        
    </body>
</html>
