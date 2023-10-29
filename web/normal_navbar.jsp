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
                           <a href="profile.jsp" class=" c-link list-group-item list-group-item-action active">
                          All Posts
                        </a>
          <%
                PostDao pd=new PostDao(ConnectionProvider.getConnection());
                ArrayList<Categories> cl=pd.getAllCategories();
                for(Categories x:cl){
          %>
             <a href="profile.jsp" class=" c-link list-group-item list-group-item-action"><%=x.getName()%></a>
           <% }%>
        </div>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="profile.jsp"><span class="fa fa-tags"></span>Check Posts</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="login_page.jsp"><span class="fa fa-user-circle-o"></span>Login</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="register_page.jsp"><span class="fa fa-user-user-plus"></span>Sign up</a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-white my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>