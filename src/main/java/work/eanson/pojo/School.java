package work.eanson.pojo;

import java.io.Serializable;

/**
 * school
 *
 * @author
 */
public class School implements Serializable {
    private Integer schId;

    private String name;

    private String level;

    private Integer proId;

    private static final long serialVersionUID = 1L;

    public Integer getSchId() {
        return schId;
    }

    public void setSchId(Integer schId) {
        this.schId = schId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public Integer getProId() {
        return proId;
    }

    public void setProId(Integer proId) {
        this.proId = proId;
    }

    @Override
    public String toString() {
        return "School{" +
                "schId=" + schId +
                ", name='" + name + '\'' +
                ", level='" + level + '\'' +
                ", proId=" + proId +
                '}';
    }
}