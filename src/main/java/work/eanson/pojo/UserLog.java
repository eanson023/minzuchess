package work.eanson.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * user_log
 * @author 
 */
public class UserLog implements Serializable {
    private Integer id;

    private String ip;

    private String message;

    private Date executeTime;

    /**
     * 默认为匿名用户
     */
    private String userId;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Date getExecuteTime() {
        return executeTime;
    }

    public void setExecuteTime(Date executeTime) {
        this.executeTime = executeTime;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
}