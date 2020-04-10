package work.eanson.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import work.eanson.util.Context;
import work.eanson.util.MsgCenter;
import work.eanson.util.Result;

/**
 * @author eanson
 * 队伍主页
 */
@Controller
@RequestMapping("team_main")
public class TeamMainController extends BaseController {
    @RequestMapping("{teamId}")
    public ModelAndView goToMyTeam(@PathVariable("teamId") String teamId, ModelAndView mv) throws Exception {
        Context context = new Context("get_team_main");
        context.put("team_id", teamId);
        csgo.service(context);
        mv.addObject("team_main", context.get("team_main"));
        mv.addObject("page_info", context.get("page_info"));
        mv.setViewName("team_info");
        return mv;
    }

    @RequestMapping("get_team_user/{teamId}")
    @ResponseBody
    public Result getTeamInfo(@PathVariable(name = "teamId") String teamId, Integer pageNum, Integer size) {
        Context context = new Context("get_team_user");
        context.put("team_id", teamId);
        context.put("page_num", pageNum);
        context.put("size", size);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail(MsgCenter.ERROR);
        }
        return context.getResult();
    }
}
