package work.eanson.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import work.eanson.pojo.UserInfo;
import work.eanson.pojo.UserLogin;
import work.eanson.pojo.back.page.DataTablesBack;
import work.eanson.pojo.back.page.DataTablesIn;
import work.eanson.util.Context;

/**
 * @author eanson
 * @create 2020-03-28 15:00
 */
@Controller
@RequestMapping("admin")
public class AdminController extends BaseController {
    private static final Logger logger = LogManager.getLogger(AdminController.class);

    @RequiresRoles("admin")
    @RequestMapping(value = {"", "index"})
    public ModelAndView index(ModelAndView mv) throws Exception {
        mv.addObject("original", "/admin/index");
        mv.setViewName("admin/index");
        Context context = new Context("get_admin_index");
        csgo.service(context);
        mv.addObject("code", context.get("code"));
        mv.addObject("categories", context.get("categories"));
        return mv;
    }

    /**
     * original用于导航栏active使用
     *
     * @param mv
     * @return
     */
    @RequiresRoles("admin")
    @RequestMapping("user/user_log")
    public ModelAndView userLog(ModelAndView mv) {
        mv.setViewName("admin/user_log");
        mv.addObject("original", "/admin/user/user_log");
        return mv;
    }

    @RequiresRoles("admin")
    @RequestMapping("user/user_info")
    public ModelAndView userInfo(ModelAndView mv) {
        mv.setViewName("admin/user_info");
        mv.addObject("original", "/admin/user/user_info");
        return mv;
    }

    @RequiresRoles("admin")
    @RequestMapping("cheep/cheep_info")
    public ModelAndView trickInfo(ModelAndView mv) {
        mv.setViewName("admin/cheep_info");
        mv.addObject("original", "/admin/cheep/cheep_info");
        return mv;
    }

    @RequiresRoles("admin")
    @RequestMapping("chess/chess_info")
    public ModelAndView chessInfo(ModelAndView mv) {
        mv.setViewName("admin/chess_info");
        mv.addObject("original", "/admin/chess/chess_info");
        return mv;
    }

    @RequiresRoles("admin")
    @PostMapping("/user/user_add")
    public ModelAndView addUser(ModelAndView mv, UserInfo userInfo, UserLogin userLogin) throws Exception {
        Context context = new Context("admin_add_user");
        context.put("user_info", userInfo);
        context.put("user_login", userLogin);
        csgo.service(context);
        mv.addObject("msg", context.get("msg"));
        mv.setViewName("forward:/admin");
        return mv;
    }

    @RequiresRoles("admin")
    @PostMapping("/chess/cb_add")
    public ModelAndView addCb(ModelAndView mv, String code, @RequestParam("category") Byte categoryKey) throws Exception {
        Context context = new Context("admin_add_cb");
        context.put("code", code);
        context.put("category_key", categoryKey);
        csgo.service(context);
        mv.addObject("msg", context.get("msg"));
        mv.setViewName("forward:/admin");
        return mv;
    }

    @RequiresRoles("admin")
    @PostMapping("/user/user_log.json")
    @ResponseBody
    public DataTablesBack getUserLog(@RequestBody DataTablesIn dti) throws Exception {
        Context context = new Context("get_user_log");
        context.put("data_tables_in", dti);
        csgo.service(context);
        return (DataTablesBack) context.getResult().getData();
    }

    @RequiresRoles("admin")
    @PostMapping("/user/user_info.json")
    @ResponseBody
    public DataTablesBack getUserInfo(@RequestBody DataTablesIn dti) {
        Context context = new Context("get_user_info");
        context.put("data_tables_in", dti);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (DataTablesBack) context.getResult().getData();
    }

    @RequiresRoles("admin")
    @PostMapping("/cheep/cheep_info.json")
    @ResponseBody
    public DataTablesBack getCheepInfo(@RequestBody DataTablesIn dti) throws Exception {
        Context context = new Context("get_cheep_info");
        context.put("data_tables_in", dti);
        csgo.service(context);
        return (DataTablesBack) context.getResult().getData();
    }

    @RequiresRoles("admin")
    @PostMapping("/chess/chess_info.json")
    @ResponseBody
    public DataTablesBack getChessInfo(@RequestBody DataTablesIn dti) throws Exception {
        Context context = new Context("get_chess_info");
        context.put("data_tables_in", dti);
        csgo.service(context);
        return (DataTablesBack) context.getResult().getData();
    }


}
