package work.eanson.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * cheep
 * @author 
 */
public class Cheep implements Serializable {
    private String cheepId;

    /**
     * 棋谱名称
     */
    private String name;

    /**
     * 开始时间
     */
    private Date from;

    /**
     * 结束时间
     */
    private Date to;

    /**
     * 路径名
     */
    private String path;

    /**
     * 文件名
     */
    private String realName;

    /**
     * 创建时间
     */
    private Date createDate;

    private String code;

    private static final long serialVersionUID = 1L;

    public String getCheepId() {
        return cheepId;
    }

    public void setCheepId(String cheepId) {
        this.cheepId = cheepId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getFrom() {
        return from;
    }

    public void setFrom(Date from) {
        this.from = from;
    }

    public Date getTo() {
        return to;
    }

    public void setTo(Date to) {
        this.to = to;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}