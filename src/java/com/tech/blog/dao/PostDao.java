
package com.tech.blog.dao;
import com.tech.blog.entities.Categories;
import com.tech.blog.entities.Posts;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
//import java.security.Timestamp;


public class PostDao {
    Connection con ;

    public PostDao(Connection con) {
        this.con = con;
    }
     public ArrayList<Categories> getAllCategories(){
         
         ArrayList<Categories> list = new ArrayList<>();
         try{
             String q="select * from categories ";
             Statement st=con.createStatement();
             ResultSet set=st.executeQuery(q);
             while(set.next())
             {
                 int cid=set.getByte("cid");
                 String name=set.getString("name");
                 String description=set.getString("description");
                 Categories c= new Categories(cid,name,description);
                 list.add(c);
                 
             }
             
         }catch(Exception e){
             e.printStackTrace();
         }
         return list;
     }
     
     public boolean savePost(Posts p)
     {
         boolean f=false;
        try{
            String q="Insert into posts(ptitle,pcontent,pcode,ppic,catid,userid) values(?,?,?,?,?,?)";
            PreparedStatement pstmt=con.prepareStatement(q);
            pstmt.setString(1,p.getPtitle());
            pstmt.setString(2, p.getPcontent());
            pstmt.setString(3, p.getPcode());
            pstmt.setString(4, p.getPpic());
            pstmt.setInt(5, p.getCatid());
            pstmt.setInt(6, p.getUserid());
            pstmt.executeUpdate();
            f=true;
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return f;
     }
     
     
//get all posts
     public List<Posts> getAllPosts()
     {
       List<Posts>list=new ArrayList<>();
        //fetch all posts
        try{
            String q="select * from posts order by pid desc";
            PreparedStatement pstmt=this.con.prepareStatement(q);
            ResultSet set=pstmt.executeQuery();
            while(set.next())
            {
                int pid=set.getInt("pid");
                String ptitle=set.getString("ptitle");
                String pcontent=set.getString("pcontent");
                String pcode=set.getString("pcode");
                String ppic=set.getString("ppic");
                Timestamp pdate=set.getTimestamp("pdate");
                int catid=set.getInt("catid");
                int userid=set.getInt("userid");
                
                Posts post=new Posts(pid,ptitle,pcontent,pcode,ppic,pdate,catid,userid);
                list.add(post);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return list;
     }
      
     
     public List<Posts> getPostByCatId(int catid)
     {
         List<Posts>list=new ArrayList<>();
        //fetch all posts by Id
             try{
            String q="select * from posts where catid=?";
            PreparedStatement pstmt=con.prepareStatement(q);
            pstmt.setInt(1, catid);
            ResultSet set=pstmt.executeQuery();
            while(set.next())
            {
                int pid=set.getInt("pid");
                String ptitle=set.getString("ptitle");
                String pcontent=set.getString("pcontent");
                String pcode=set.getString("pcode");
                String ppic=set.getString("ppic");
                Timestamp pdate=set.getTimestamp("pdate");
                int userid=set.getInt("userid");
                
                Posts post=new Posts(pid,ptitle,pcontent,pcode,ppic,pdate,catid,userid);
                list.add(post);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return list;
     }
     
     public Posts getPostByPostId(int postId)
     {
         Posts p=null;
         String q="select* from posts where pid=?";
         try{
             PreparedStatement pstmt=con.prepareStatement(q);
             pstmt.setInt(1, postId);
             ResultSet set=pstmt.executeQuery();
             if(set.next())
             {
                
                int pid=set.getInt("pid");
                String ptitle=set.getString("ptitle");
                String pcontent=set.getString("pcontent");
                String pcode=set.getString("pcode");
                String ppic=set.getString("ppic");
                Timestamp pdate=set.getTimestamp("pdate");
                int userid=set.getInt("userid");
                int catid=set.getInt("catid");
                p=new Posts(pid, ptitle, pcontent, pcode, ppic, pdate,catid, userid);
                
             }
         }
         catch(Exception e){
             e.printStackTrace();
           
         }
         return p;
     }
}
