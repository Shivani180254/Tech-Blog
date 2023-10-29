
package com.tech.blog.servlet;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Posts;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author hp
 */
@MultipartConfig
public class AddPostServlet extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            
            int cId=Integer.parseInt(request.getParameter("cid"));
            String pTitle=request.getParameter("ptitle");
            String pContent=request.getParameter("pcontent");
            String pCode=request.getParameter("pcode");
            Part part=request.getPart("ppic");
            String pPic=part.getSubmittedFileName();
            
            
            //to get current user id means the user who posted on tech blog
            HttpSession session =request.getSession();
            User user=(User)session.getAttribute("currentUser");
          
            Posts p=new Posts(pTitle,pContent,pCode,pPic,null,cId,user.getId());
            PostDao dao=new PostDao(ConnectionProvider.getConnection());
          
            
            if(dao.savePost(p)){
                String Path=request.getServletContext().getRealPath("/post_pics/") + File.separator + pPic;
                Helper.saveFile(part.getInputStream(), Path);
                out.println("done");
            }
            else
            {
                out.println("error");
            }
            
           
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
