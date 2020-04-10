package work.eanson.controller;

import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import work.eanson.exception.ParseException;
import work.eanson.util.Context;
import work.eanson.util.MsgCenter;
import work.eanson.util.Result;

import javax.servlet.http.Cookie;
import java.io.File;
import java.util.UUID;


/**
 * @author eanson
 */
@Controller
@RequestMapping("/user_info")
public class UserInfoController extends BaseController {
    /**
     * 头像上传
     * <p>
     * 换至service层存储
     *
     * @param file
     * @return
     * @throws Exception
     */
    @RequestMapping("upload")
    @RequiresAuthentication
    @ResponseBody
    public Result uploadAvatar(@RequestParam("avatar") MultipartFile file) throws Exception {
        Context context = new Context("avatar_upload");
        context.put("avatar", file);
        try {
            csgo.service(context);
        } catch (ParseException e) {
            return Result.fail(MsgCenter.ERROR);
        }
        return Result.success();
    }

    @RequestMapping("update_pwd")
    @RequiresAuthentication
    @ResponseBody
    public Result updatePwd(String original, String password) {
        Context context = new Context("update_pwd");
        context.put("original", original);
        context.put("password", password);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail(MsgCenter.ERROR_SESSION_EXPIRED);
        }
        return context.getResult();
    }

}
