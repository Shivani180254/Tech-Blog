
package com.tech.blog.dao;

import com.tech.blog.entities.IndexCard;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class IndexDao {
    Connection con ;

    public IndexDao(Connection con) {
        this.con = con;
    }
    
    public IndexCard getIndexCardsByIndexId(int indexId)
     {
         
         IndexCard i=null;
         String q="select * from indexcard where iid=?";
         try{
             PreparedStatement pstmt=con.prepareStatement(q);
             pstmt.setInt(1, indexId);
             ResultSet set=pstmt.executeQuery();
             if(set.next())
             {
                
                int iid=set.getInt("iid");
                String ititle=set.getString("ititle");
                String icontent=set.getString("icontent");
                String icode=set.getString("icode");
                String ipic=set.getString("ipic");
                String ioverview=set.getString("ioverview");
                
                i=new IndexCard(iid,ititle,icontent,icode,ipic,ioverview);
                
             }
         }
         catch(Exception e){
             e.printStackTrace();
           
         }
         return i;
     }
    
    
    public List<IndexCard> getAllIndexCard()
     {
       List<IndexCard>list=new ArrayList<>();
        //fetch all posts
        try{
            String q="select * from indexcard order by iid";
            PreparedStatement pstmt=this.con.prepareStatement(q);
            ResultSet set=pstmt.executeQuery();
            while(set.next())
            {
                int iid=set.getInt("iid");
                String ititle=set.getString("ititle");
                String icontent=set.getString("icontent");
                String icode=set.getString("icode");
                String ipic=set.getString("ipic");
                String ioverview=set.getString("ioverview");
                
                IndexCard i=new IndexCard(iid,ititle,icontent,icode,ipic,ioverview);
                
                
                
                list.add(i);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return list;
     }
      
    
}
