package work.eanson.pojo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * team_user
 *
 * @author
 */
public class TeamUser implements Serializable {
    private Integer id;

    private String userId;

    private String teamId;

    /**
     * 是不是队长
     */
    private Boolean isLeader;

    /**
     * 是否已加入队伍
     */
    private Boolean isJoin;

    private Date joinTime;


    /**
     * 是否被拒绝
     */
    private Boolean isRefuse;

    private List<UserInfo> userInfos;

    private List<Team> teams;

    private UserInfo userInfo;

    private Team team;

    private int count;

    /*
    相差天数
     */
    private int dateDiff;


    public int getDateDiff() {
        return dateDiff;
    }

    public void setDateDiff(int dateDiff) {
        this.dateDiff = dateDiff;
    }

    public Team getTeam() {
        return team;
    }

    public void setTeam(Team team) {
        this.team = team;
    }

    public List<UserInfo> getUserInfos() {
        return userInfos;
    }

    public void setUserInfos(List<UserInfo> userInfos) {
        this.userInfos = userInfos;
    }

    public List<Team> getTeams() {
        return teams;
    }

    public void setTeams(List<Team> teams) {
        this.teams = teams;
    }

    public UserInfo getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(UserInfo userInfo) {
        this.userInfo = userInfo;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getTeamId() {
        return teamId;
    }

    public void setTeamId(String teamId) {
        this.teamId = teamId;
    }

    public Boolean getIsLeader() {
        return isLeader;
    }

    public void setIsLeader(Boolean isLeader) {
        this.isLeader = isLeader;
    }

    public Boolean getIsJoin() {
        return isJoin;
    }

    public void setIsJoin(Boolean isJoin) {
        this.isJoin = isJoin;
    }

    public Date getJoinTime() {
        return joinTime;
    }

    public void setJoinTime(Date joinTime) {
        this.joinTime = joinTime;
    }

    public Boolean getIsRefuse() {
        return isRefuse;
    }

    public void setIsRefuse(Boolean isRefuse) {
        this.isRefuse = isRefuse;
    }
}