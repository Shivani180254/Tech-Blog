package com.tech.blog.dao;
import java.sql.*;

public class LikeDao {
    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }
    
    
    public boolean insertLike(int pid,int uid){
        boolean f=false;
        try{
            String q="insert into liked (pid,uid) values(?,?)";
            PreparedStatement pstmt=con.prepareStatement(q);
            pstmt.setInt(1, pid);
            pstmt.setInt(2, uid);
            pstmt.executeUpdate();
            f=true;
            
        }
        catch(Exception e){
            e.printStackTrace();
        }
      return f;
    }
    
    
    public int countNumberOfLikes(int pid)
    {
        int count=0;
        String q="select count(*) from liked where pid=?";
        try{
            PreparedStatement pstmt=con.prepareStatement(q);
            pstmt.setInt(1, pid);
            ResultSet set= pstmt.executeQuery(); 
            if(set.next())
            {
                count =set.getInt(1);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return count;
    }
      public boolean isLikedByUser(int pid,int uid){
          boolean f=false;
          try
          {
             PreparedStatement pstmt=con.prepareStatement("select * from liked where pid=? and uid=?");
             pstmt.setInt(1, pid);
             pstmt.setInt(2, uid);
             ResultSet set= pstmt.executeQuery();
             if(set.next())
             {
                 f=true;
             }
          }
          catch(Exception e)
          {
              e.printStackTrace();
          }
          return f;
                  
      }
    
      public boolean deleteLiked(int pid,int uid){
          boolean f=false;
          try{
              PreparedStatement pstmt=con.prepareStatement("delete from liked where pid=? and uid=?");
              pstmt.setInt(1, pid);
              pstmt.setInt(2, uid);
              pstmt.executeUpdate();
              f=true;
          }
          catch(Exception e)
          {
              e.printStackTrace();
          }
          
          return false;
      }
}
