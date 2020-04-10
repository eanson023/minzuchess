package work.eanson.pojo;

import java.io.Serializable;

/**
 * avatar
 * @author 
 */

public class Avatar implements Serializable {
    private Integer avatarId;

    private String fileName;

    private String telephone;

    private static final long serialVersionUID = 1L;

    public Integer getAvatarId() {
        return avatarId;
    }

    public void setAvatarId(Integer avatarId) {
        this.avatarId = avatarId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

}