package work.eanson.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * user_info
 * @author 
 */
public class UserInfo implements Serializable {
    private String telephone;

    private String realName;

    /**
     * 用户类别:1为个人用户 2为社会团体  3为学校团体 
     */
    private Byte stat;

    private Date joinTime;

    /**
     * 是否是后台添加
     */
    private Boolean isAdd;

    /**
     * 是否是管理员
     */
    private Boolean isAdmin;

    /**
     * UUID
     */
    private String uuid;


    private static final long serialVersionUID = 1L;

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public Byte getStat() {
        return stat;
    }

    public void setStat(Byte stat) {
        this.stat = stat;
    }

    public Date getJoinTime() {
        return joinTime;
    }

    public void setJoinTime(Date joinTime) {
        this.joinTime = joinTime;
    }

    public Boolean getIsAdd() {
        return isAdd;
    }

    public void setIsAdd(Boolean isAdd) {
        this.isAdd = isAdd;
    }

    public Boolean getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(Boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }
}