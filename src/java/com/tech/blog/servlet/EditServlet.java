/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.tech.blog.servlet;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
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
public class EditServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            
//Fetch all data
                String name=request.getParameter("user_name");
                String email=request.getParameter("user_email");
                String password=request.getParameter("user_password");
                String about=request.getParameter("user_about");
                Part part=request.getPart("image");
                String imgName=part.getSubmittedFileName();
      
//get the user from the Session
                HttpSession s=request.getSession();
                User user=(User)s.getAttribute("currentUser");
                user.setEmail(email);
                user.setName(name);
                user.setPassword(password);
                user.setAbout(about);
                String oldFile=user.getProfile();
               // user.setProfile(imgName);
                
                
             
               String path = request.getServletContext().getRealPath("/profile-pics/") + File.separator + user.getProfile();
               
 //new photo is not updated while editing               
                if (imgName.equals(""))                           
                {
                    imgName=oldFile;
                } 
//new photo is updated while updating                 
                else
                {   
                    Helper.deleteFile(request.getServletContext().getRealPath("/profile-pics/") + File.separator + oldFile);
                    path= request.getServletContext().getRealPath("/profile-pics/") + File.separator + imgName;
                    Helper.saveFile(part.getInputStream(), path);
                }
                
                
// now we will update new details using updateUser in UserDao

                user.setProfile(imgName);
                UserDao dao=new UserDao(ConnectionProvider.getConnection());
                if(dao.updateUser(user))
                {
                    Message msg=new Message("Profile details updated....","success","alert-success");
                    s.setAttribute("msg", msg);
                    response.sendRedirect("profile.jsp");
                }
                else
                {
                    Message msg=new Message("Something went wrong...","error","alert-danger"); 
                }
                out.println("</body>");
            out.println("</html>");
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
                
            