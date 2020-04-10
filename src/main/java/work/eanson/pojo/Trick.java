package work.eanson.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * trick
 *
 * @author
 */
public class Trick implements Serializable {
    private String logId;

    /**
     * 招法
     */
    private String trick;

    private String color;

    /**
     * 插入时间
     */
    private Date exuteTime;

    /**
     * 是否错误提交
     */
    private Boolean isFalse;

    /**
     * 表示当前招数是谁行棋 1.AI 2.人类
     */
    private Byte type;

    /**
     * 0.错误 1.布子,2.行棋3.飞子 4.提子
     */
    private Byte status;

    /**
     * 错误信息
     */
    private String message;

    /**
     * 该步骤之前的棋盘
     */
    private String before;

    /**
     * 棋盘id
     */
    private String cbCode;

    private static final long serialVersionUID = 1L;

    public String getLogId() {
        return logId;
    }

    public void setLogId(String logId) {
        this.logId = logId;
    }

    public String getTrick() {
        return trick;
    }

    public void setTrick(String trick) {
        this.trick = trick;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Date getExuteTime() {
        return exuteTime;
    }

    public void setExuteTime(Date exuteTime) {
        this.exuteTime = exuteTime;
    }

    public Boolean getIsFalse() {
        return isFalse;
    }

    public void setIsFalse(Boolean isFalse) {
        this.isFalse = isFalse;
    }

    public Byte getType() {
        return type;
    }

    public void setType(Byte type) {
        this.type = type;
    }

    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getBefore() {
        return before;
    }

    public void setBefore(String before) {
        this.before = before;
    }

    public String getCbCode() {
        return cbCode;
    }

    public void setCbCode(String cbCode) {
        this.cbCode = cbCode;
    }

    @Override
    public String toString() {
        return "Trick{" +
                "logId='" + logId + '\'' +
                ", trick='" + trick + '\'' +
                ", color='" + color + '\'' +
                ", exuteTime=" + exuteTime +
                ", isFalse=" + isFalse +
                ", type=" + type +
                ", status=" + status +
                ", message='" + message + '\'' +
                ", before='" + before + '\'' +
                ", cbCode='" + cbCode + '\'' +
                '}';
    }
}