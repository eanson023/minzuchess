package work.eanson.controller;

import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import work.eanson.pojo.Team;
import work.eanson.util.Context;
import work.eanson.util.MsgCenter;
import work.eanson.util.Result;

import java.io.File;
import java.util.UUID;

/**
 * @author eanson
 */
@Controller
@RequiresAuthentication
@RequestMapping("team")
public class TeamController extends BaseController {
    @RequestMapping("test")
    @ResponseBody
    public String test() {
        return "test";
    }

    /**
     * 更新队伍信息
     */
    @PostMapping("update")
    @ResponseBody
    public Result updateTeamInfo(Team team, @RequestParam(value = "avatar") MultipartFile teamAvatar) throws Exception {
        Context context = new Context("update_team");
        context.put("team", team);
        context.put("file", teamAvatar);
        csgo.service(context);
        return context.getResult();
    }

    /**
     * 查找队伍信息
     */
    @RequestMapping("find/{teamId}")
    @ResponseBody
    public Result find(@PathVariable("teamId") String teamId) throws Exception {
        Context context = new Context("find_team");
        context.put("team_name_num", teamId);
        csgo.service(context);
        return Result.success(context.get("team"));
    }

    /**
     * 新增队伍
     */
    @PostMapping("add")
    @ResponseBody
    public Result addNewTeam(Team team) {
        Context context = new Context("create_team2");
        context.put("team", team);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return context.getResult();
    }

    /**
     * 模糊查找
     */
    @RequestMapping("find/like/{teamId}")
    @ResponseBody
    public Result findLike(@PathVariable("teamId") String teamOrName) {
        Context context = new Context("team_find_like");
        context.put("team_or_name", teamOrName);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail(MsgCenter.ERROR);
        }
        return context.getResult();
    }

    /**
     * \
     * 加入队伍
     */
    @PostMapping("join/{teamId}")
    @ResponseBody
    public Result joinTeam(@PathVariable("teamId") String teamId) {
        Context context = new Context("join_team2");
        context.put("team_id", teamId);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail(MsgCenter.ERROR);
        }
        return context.getResult();
    }

    @RequestMapping("message")
    @ResponseBody
    public Result getWantJoinTeamMessage() {
        Context context = new Context("want_join_message");
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail(MsgCenter.ERROR);
        }
        return context.getResult();
    }

    /**
     * 删除队伍
     */
    @PostMapping("delete")
    public String delTeam(String teamId) {
        Context context = new Context("team_delete");
        context.put("teamId", teamId);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return "forward:/index";
        }
        String referer = super.getHttpServletRequest().getHeader("Referer");
        return "redirect:" + referer;
    }

    /**
     * 退出队伍
     */
    @PostMapping("quit")
    public String quitTeam(String teamId) {
        Context context = new Context("team_quit");
        context.put("teamId", teamId);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return "forward:/index";
        }
        String referer = super.getHttpServletRequest().getHeader("Referer");
        return "redirect:" + referer;
    }

    /**
     * 同意加入队伍
     *
     * @param teamId
     * @param uuid
     * @throws Exception
     */
    @PostMapping("agree")
    @ResponseBody
    public void agreeJoin(String teamId, String uuid) throws Exception {
        Context context = new Context("resolve_join");
        context.put("team_id", teamId);
        context.put("uuid", uuid);
        context.put("is_agree", true);
        csgo.service(context);
    }

    /**
     * 拒绝加入队伍
     *
     * @param teamId
     * @param uuid
     * @throws Exception
     */
    @PostMapping("refuse")
    @ResponseBody
    public void refuseJoin(String teamId, String uuid) throws Exception {
        Context context = new Context("resolve_join");
        context.put("team_id", teamId);
        context.put("uuid", uuid);
        context.put("is_agree", false);
        csgo.service(context);
    }
}
