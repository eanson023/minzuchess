package work.eanson.pojo;

import java.io.Serializable;

/**
 * category
 * @author 
 */
public class Category implements Serializable {
    /**
     * 索引值
     */
    private Byte key;

    /**
     * 具体名称
     */
    private String value;

    /**
     * 棋盘英文名__与html对应
     */
    private String html;

    /**
     * 棋盘初始化坐标
     */
    private String initPos;

    /**
     * 图片资源
     */
    private String icon;

    private static final long serialVersionUID = 1L;

    public Byte getKey() {
        return key;
    }

    public void setKey(Byte key) {
        this.key = key;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getHtml() {
        return html;
    }

    public void setHtml(String html) {
        this.html = html;
    }

    public String getInitPos() {
        return initPos;
    }

    public void setInitPos(String initPos) {
        this.initPos = initPos;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }
}