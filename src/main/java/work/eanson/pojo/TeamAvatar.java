package work.eanson.pojo;

import java.io.Serializable;

/**
 * team_avatar
 * @author eanson
 */
public class TeamAvatar implements Serializable {
    private Integer avatarId;

    private String teamId;

    private String fileName;

    private static final long serialVersionUID = 1L;

    public Integer getAvatarId() {
        return avatarId;
    }

    public void setAvatarId(Integer avatarId) {
        this.avatarId = avatarId;
    }

    public String getTeamId() {
        return teamId;
    }

    public void setTeamId(String teamId) {
        this.teamId = teamId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
}