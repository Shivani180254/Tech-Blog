<%@page import="com.tech.blog.entities.User" %>
<%@page import="java.util.ArrayList" %>
<%@page import="com.tech.blog.dao.PostDao" %>
<%@page import="com.tech.blog.helper.ConnectionProvider" %>
<%@page import="com.tech.blog.entities.Categories" %>

<style>
    .category-drop{
        width: 250px;
        opacity: 0.8;
    }
</style>



<%
    
    User u = (User) session.getAttribute("currentUser");
    if(u==null)
    {
    response.sendRedirect("login_page.jsp");
   }
   %>

<!-- nav-bar -->
          <nav class="navbar navbar-expand-lg navbar-dark bg-dark primary-background">
                <a class="navbar-brand" href="index.jsp"> <span class="fa fa-desktop"></span>Tech Blog</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                   <span class="navbar-toggler-icon"></span>
                </button>

              <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                            <li class="nav-item dropdown">
                              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                  <span class="fa fa-check-square-o"></span> 
                                Categories
                              </a>
                              <div class="dropdown-menu category-drop" aria-labelledby="navbarDropdown">
                                    <div class="list-group">
                                        <a href="profile.jsp" class="list-group-item list-group-item-action active">
                                       All Posts
                                     </a>
                                    <%
                                          PostDao pd=new PostDao(ConnectionProvider.getConnection());
                                          ArrayList<Categories> cl=pd.getAllCategories();
                                          for(Categories x:cl){
                                    %>
                                    <a href="profile.jsp" class="list-group-item list-group-item-action"><%=x.getName()%></a>
                                  <% }%>
                               </div>
                              </div>
                            </li>
                            <li class="nav-item">
                              <a data-toggle="modal" data-target="#add-post-modal" class="nav-link" href="#"><span class="fa fa-commenting"></span>Do Post</a>
                            </li>
                    </ul>

                    <ul class="navbar-nav mr-right">
                          <a class="nav-link" href="#!" data-toggle="modal" data-target="#ProfileModal"><span class="fa fa-user-circle"></span><%=u.getName()%></a>
                    </ul>

                    <ul class="navbar-nav mr-right">
                          <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-plus"></span>Logout</a>
                    </ul>
              </div>
         </nav>
        
<!-- end of nav-bar -->