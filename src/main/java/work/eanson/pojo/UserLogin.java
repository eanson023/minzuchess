package work.eanson.pojo;

import java.io.Serializable;

/**
 * user_login
 *
 * @author
 */
public class UserLogin implements Serializable {
    private String telephone;

    private String username;

    private String password;

    /**
     * 是否只注册了一半
     */
    private Boolean isRegHalf;

    /**
     * 是否删除 0为 1删除
     */
    private Boolean isDelete;

    private static final long serialVersionUID = 3207880482640325843L;

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getIsRegHalf() {
        return isRegHalf;
    }

    public void setIsRegHalf(Boolean isRegHalf) {
        this.isRegHalf = isRegHalf;
    }

    public Boolean getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Boolean isDelete) {
        this.isDelete = isDelete;
    }

    @Override
    public String toString() {
        return "UserLogin{" +
                "telephone='" + telephone + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", isRegHalf=" + isRegHalf +
                ", isDelete=" + isDelete +
                '}';
    }
}