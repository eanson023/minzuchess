package work.eanson.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import work.eanson.util.Context;
import work.eanson.util.Result;

import java.util.List;

/**
 * @author eanson
 * 棋盘操作
 */
@Controller
@RequestMapping(value = "chess", produces = "text/plain;charset=utf-8")
public class ChessController extends BaseController {

    /**
     * 前提:非公共棋盘:必须登录并且棋盘是自己的
     *
     * @param code
     * @return
     * @throws Exception
     */
    @RequestMapping
    public String gotoChess(String code) throws Exception {
        //是去棋类页
        if (code == null) {
            return "forward:/chess/go_chess_page";
        }
        Context context = new Context("get_page");
        context.put("code", code);
        csgo.service(context);
        if (!context.getResult().isSuccess()) {
            return "/index";
        } else {
            //转发
            return String.valueOf(context.getResult().getData());
        }
    }

    /**
     * 观战
     *
     * @param alias
     * @return
     */
    @RequestMapping("/watch")
    public String goWatch(String alias) throws Exception {
        if (alias == null) {
            return "redirect:/index";
        }
        Context context = new Context("get_page");
        context.put("alias", alias);
        csgo.service(context);
        if (!context.getResult().isSuccess()) {
            return "/index";
        }
        //转发
        return String.valueOf(context.getResult().getData());
    }

    @RequestMapping("go_chess_page")
    public String goChessPage() {
        return "chess";
    }

    /**
     * 获取全局状态
     *
     * @param code
     * @param html
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "{html}/global")
    @ResponseBody
    public String getStatus(String code, @PathVariable("html") String html) throws Exception {
        Context context = new Context("get_set_chess");
        context.put("html", html);
        context.put("code", code);
        csgo.service(context);
        return (String) context.getResult().getData();
    }

    @RequestMapping(value = "{html}/clock")
    @ResponseBody
    public void setClock(String code, @PathVariable("html") String html, String i) throws Exception {
        Context context = new Context("set_clock");
        context.put("html", html);
        context.put("code", code);
        context.put("clock", i);
        csgo.service(context);
    }

    /**
     * 获取日志
     *
     * @param code
     * @param num
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "log", produces = "application/json;charset=utf-8")
    @ResponseBody
    public List getLog(String code, Integer num, String alias) throws Exception {
        Context context = new Context("get_chess_log");
        context.put("code", code);
        context.put("num", num);
        context.put("alias", alias);
        csgo.service(context);
        return (List) context.getResult().getData();
    }

    @PostMapping(value = "reset")
    @ResponseBody
    public void resetChess(String code) throws Exception {
        Context context = new Context("reset_chess");
        context.put("code", code);
        csgo.service(context);
    }

    @PostMapping(value = "clear_cache")
    @ResponseBody
    public void clearCache(String code) throws Exception {
        Context context = new Context("clear_cache");
        context.put("code", code);
        csgo.service(context);
    }

    @PostMapping(value = "/go_back/{code}/{logId}")
    @ResponseBody
    public void goBack(@PathVariable("code") String code, @PathVariable("logId") String logId) throws Exception {
        Context context = new Context("go_back");
        context.put("code", code);
        context.put("log_id", logId);
        csgo.service(context);
    }

    @PostMapping(value = "/go/chess", produces = "application/json;charset=utf-8")
    @ResponseBody
    public Result goChess(@RequestParam("code_or_alias") String aliasOrCode) {
        Context context = new Context("go_chess");
        context.put("code_or_alias", aliasOrCode);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return context.getResult();
    }
}
