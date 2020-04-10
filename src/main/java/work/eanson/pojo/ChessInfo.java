package work.eanson.pojo;

import java.io.Serializable;

/**
 * chess_info
 * @author 
 */
public class ChessInfo implements Serializable {
    /**
     * 随机码
     */
    private String code;

    private String clock;

    /**
     * 别名
     */
    private Long alias;

    /**
     * 棋盘是否开放为公共棋盘
     */
    private Boolean isPublic;

    /**
     * 1:久棋 2:蒙古棋
     */
    private Byte category;

    private String userId;

    private String pos;


    private static final long serialVersionUID = 1L;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getClock() {
        return clock;
    }

    public void setClock(String clock) {
        this.clock = clock;
    }

    public Long getAlias() {
        return alias;
    }

    public void setAlias(Long alias) {
        this.alias = alias;
    }

    public Boolean getIsPublic() {
        return isPublic;
    }

    public void setIsPublic(Boolean isPublic) {
        this.isPublic = isPublic;
    }

    public Byte getCategory() {
        return category;
    }

    public void setCategory(Byte category) {
        this.category = category;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPos() {
        return pos;
    }

    public void setPos(String pos) {
        this.pos = pos;
    }
}