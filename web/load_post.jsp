<%@page import="java.util.List" %>
<%@page import="com.tech.blog.entities.User" %>
<%@page import="com.tech.blog.entities.Posts" %>
<%@page import="com.tech.blog.dao.PostDao" %>
<%@page import="com.tech.blog.dao.LikeDao" %>
<%@page import="com.tech.blog.helper.ConnectionProvider" %>
<%@page import="com.tech.blog.entities.Categories" %>
<%@page import="java.util.ArrayList" %>


<div class="row">
      <%
          
            User user = (User) session.getAttribute("currentUser");
            if(user==null)
            {
            response.sendRedirect("login_page.jsp");
           }
            PostDao d=new PostDao(ConnectionProvider.getConnection());
            int cid=Integer.parseInt(request.getParameter("cid")); 
            ArrayList<Categories> l=d.getAllCategories();
             List<Posts>list=null;
            if(cid==0)
            {
              list=d.getAllPosts();
            }
            else
            {
              list=d.getPostByCatId(cid);
            }
            if(list.size()==0)
            {
                out.println("<h3 class='display-5 text-center'>No posts are available for this category...</h3>");
                return;
            }
            for(Posts p : list)
            {
      %> 
      <div class="card-deck col-md-6 mt-2"  style="height: 500px">
          <div class="card" >
              <img class="card-img-top" style="height: 150px" src="post_pics/<%=p.getPpic()%>" alt="Card image cap">
              <div class="card-body" style="height: 300px">
                  <%
                      
                      int cat=p.getCatid();
                      for(Categories c:l)
                      {
                        if(cat==c.getCid())
                        {
                        %>
                        <pre><%=c.getName()%></pre>
                        <%
                        }
                      }
                      %>
                  
                  <b><%=p.getPtitle()%></b>
                  <% 
                    String fullText = p.getPcontent();
                    String partText = fullText.substring(0, 200);
                  %>
                <p><%= partText+"...." %></p>
                  
              </div>
              <div class="card-footer text-center" style="height: 50px">
                <%
                LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                int n = ld.countNumberOfLikes(p.getPid());
                boolean f = ld.isLikedByUser(p.getPid(), user.getId());
                %>
                <a href="#" onclick="doLike(<%=p.getPid()%>, <%=user.getId()%>, this)" class="btn btn-outline-primary btn-sm">
                    <i class="fa fa-thumbs-o-up" id="up_<%=p.getPid()%>" style="<%= f ? "display: none" : "display: inline" %>"></i>
                    <i class="fa fa-thumbs-o-down" id="down_<%=p.getPid()%>" style="<%= f ? "display: inline" : "display: none" %>"></i>
                    <span class="like-counter" id="likeCounter_<%=p.getPid()%>"><%=n%></span>
                </a>
                <a href="show_post_details.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-primary btn-sm">Read more</a>
                <a href="#" class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"></i><span>20</span></a>
            </div>
          </div>
      </div>
       <%
             }
       %>
    
    </div>
       
       
       <!-- java script -->
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        

                                    