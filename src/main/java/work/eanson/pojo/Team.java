package work.eanson.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * team
 *
 * @author
 */
public class Team implements Serializable {
    private String teamId;

    private String teamName;

    private Integer numbers;

    /**
     * 简介
     */
    private String introduction;

    private Date createTime;

    /**
     * 身份主键
     */
    private Integer provinceId;

    /**
     * 学校id 不太满足范式
     */
    private Integer schoolId;
    /**
     * 一对一映射
     */
    private Province province;

    private School school;

    private String joinDate;

    private TeamAvatar teamAvatar;

    public TeamAvatar getTeamAvatar() {
        return teamAvatar;
    }

    public void setTeamAvatar(TeamAvatar teamAvatar) {
        this.teamAvatar = teamAvatar;
    }

    public String getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(String joinDate) {
        this.joinDate = joinDate;
    }

    private static final long serialVersionUID = 1L;

    public String getTeamId() {
        return teamId;
    }

    public void setTeamId(String teamId) {
        this.teamId = teamId;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public Integer getNumbers() {
        return numbers;
    }

    public void setNumbers(Integer numbers) {
        this.numbers = numbers;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(Integer provinceId) {
        this.provinceId = provinceId;
    }

    public Integer getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(Integer schoolId) {
        this.schoolId = schoolId;
    }

    public Province getProvince() {
        return province;
    }

    public void setProvince(Province province) {
        this.province = province;
    }

    public School getSchool() {
        return school;
    }

    public void setSchool(School school) {
        this.school = school;
    }

    @Override
    public String toString() {
        return "Team{" +
                "teamId='" + teamId + '\'' +
                ", teamName='" + teamName + '\'' +
                ", numbers=" + numbers +
                ", introduction='" + introduction + '\'' +
                ", createTime=" + createTime +
                ", provinceId=" + provinceId +
                ", schoolId=" + schoolId +
                ", province=" + province +
                ", school=" + school +
                '}';
    }
}