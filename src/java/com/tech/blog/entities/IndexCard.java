
package com.tech.blog.entities;

public class IndexCard {
    int iid;
    String ititle;
    String icontent;
    String icode;
    String ipic;
    String ioverview;

    public IndexCard() {
    }

    public IndexCard(int iid, String ititle, String icontent, String icode, String ipic , String ioverview) {
        this.iid = iid;
        this.ititle = ititle;
        this.icontent = icontent;
        this.icode = icode;
        this.ipic = ipic;
        this.ioverview=ioverview;
    }

    public IndexCard(String ititle, String icontent, String icode, String ipic, String ioverview) {
        this.ititle = ititle;
        this.icontent = icontent;
        this.icode = icode;
        this.ipic = ipic;
        this.ioverview=ioverview;
    }

    public int getIid() {
        return iid;
    }

    public void setIid(int iid) {
        this.iid = iid;
    }

    public String getItitle() {
        return ititle;
    }

    public void setItitle(String ititle) {
        this.ititle = ititle;
    }

    public String getIcontent() {
        return icontent;
    }

    public void setIcontent(String icontent) {
        this.icontent = icontent;
    }

    public String getIcode() {
        return icode;
    }

    public void setIcode(String icode) {
        this.icode = icode;
    }

    public String getIpic() {
        return ipic;
    }

    public void setIpic(String ipic) {
        this.ipic = ipic;
    }

    public String getIoverview() {
        return ioverview;
    }

    public void setIoverview(String ioverview) {
        this.ioverview = ioverview;
    }
    
    
}
