package work.eanson.pojo;

import java.io.Serializable;

/**
 * province
 * @author 
 */
public class Province implements Serializable {
    private Integer proId;

    private String name;

    private static final long serialVersionUID = 1L;

    public Integer getProId() {
        return proId;
    }

    public void setProId(Integer proId) {
        this.proId = proId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Province{" +
                "proId=" + proId +
                ", name='" + name + '\'' +
                '}';
    }
}