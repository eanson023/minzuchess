package work.eanson.controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import work.eanson.pojo.Trick;
import work.eanson.util.Context;
import work.eanson.util.Result;

/**
 * ai API分析接口
 *
 * @author eanson
 */
@RestController
@RequestMapping("ai")
public class AiController extends BaseController {
    /**
     * @param code     棋盘码
     * @param password 密码
     * @param trick    招法信息
     *                 color:z或者Z
     *                 trick:棋谱
     * @return json数据
     */
    @RequestMapping(value = "{code}/{pwd}", produces = "application/json;charset=utf-8")
    public Result aiDo(@PathVariable(value = "code", required = true) String code, @PathVariable(value = "pwd", required = true) String password, Trick trick) {
        trick.setCbCode(code);
        Context context = new Context("ai_trick");
        context.put("trick", trick);
        context.put("password", password);
        context.put("code", code);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail(e.getMessage());
        }
        return context.getResult();
    }

    /**
     * g公共棋盘用
     *
     * @param code  棋盘码
     * @param trick 招法信息
     * @return json数据
     */
    @RequestMapping(value = "{code}", produces = "application/json;charset=utf-8")
    public Result aiDoNoPwd(@PathVariable("code") String code, Trick trick) {
        trick.setCbCode(code);
        Context context = new Context("ai_trick");
        context.put("trick", trick);
        context.put("code", code);
        //占位符
        context.put("password", "none");
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail(e.getMessage());
        }
        return context.getResult();
    }

    @RequestMapping(value = "global/{code}", produces = "text/plain;charset=utf-8")
    public String getGlobalStatus(@PathVariable(value = "code") String code) {
        Context context = new Context("get_global_status");
        context.put("code", code);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
        return (String) context.getResult().getData();
    }

    @RequestMapping(value = "clock/{code}", produces = "text/plain;charset=utf-8")
    public String getClock(@PathVariable("code") String code) {
        Context context = new Context("get_clock");
        context.put("code", code);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return "null,缺少参数";
        }
        return (String) context.getResult().getData();
    }

}
