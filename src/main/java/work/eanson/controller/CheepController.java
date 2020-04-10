package work.eanson.controller;

import org.apache.commons.io.FileUtils;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import work.eanson.pojo.Cheep;
import work.eanson.pojo.back.page.DataTablesBack;
import work.eanson.pojo.back.page.DataTablesIn;
import work.eanson.util.Context;
import work.eanson.util.MsgCenter;
import work.eanson.util.Result;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author yans
 * 棋谱操作控制层
 */
@Controller
@RequestMapping("cheep")
public class CheepController extends BaseController {
    @RequestMapping()
    public String redirectQipu() {
        Context context = new Context("get_one_code");
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return "/index";
        }
        if (!context.isSuccess()) {
            return "/index";
        }
        return "redirect:" + context.getResult().getData();
    }

    @RequiresAuthentication
    @RequestMapping("/my_log")
    public ModelAndView getQipuLog(ModelAndView mv, @RequestParam(value = "code") String code) {
        Context context = new Context("get_log");
        context.put("code", code);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            mv.setViewName("index");
            return mv;
        }
        if (!context.isSuccess()) {
            String referer = super.getHttpServletRequest().getHeader("Referer");
            if (referer == null) {
                referer = "/";
            }
            mv.setViewName("forward:" + referer);
            return mv;
        }
        //pageInfo
        mv.addObject("pageInfo", context.getResult().getData());
        mv.addObject("chessInfo", context.get("chess_info"));
        mv.setViewName("my_qipu");
        return mv;
    }

    @RequiresAuthentication
    @RequestMapping("pagination/log")
    @ResponseBody
    public Result getPageLog(String code, Integer page) {
        Context context = new Context("get_log");
        context.put("code", code);
        context.put("page", page);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail(MsgCenter.ERROR_SESSION_EXPIRED);
        }
        return context.getResult();
    }

    @RequiresAuthentication
    @PostMapping("/pagination/cheep_info.json/{code}")
    @ResponseBody
    public DataTablesBack getCheep(@RequestBody DataTablesIn dataTablesIn, @PathVariable String code) {
        Context context = new Context("get_cheep_datatable");
        context.put("dti", dataTablesIn);
        context.put("code", code);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (DataTablesBack) context.getResult().getData();
    }

    @RequiresAuthentication
    @RequestMapping("search/{start-date}/{start-time}/{end-date}/{end-time}/{code}")
    @ResponseBody
    public Result generateParam(@PathVariable("start-date") String startDate,
                                @PathVariable("start-time") String startTime,
                                @PathVariable("end-date") String endDate,
                                @PathVariable("end-time") String endTime,
                                @PathVariable("code") String code,
                                @RequestBody DataTablesIn dti) {
        String fromStr = startDate + startTime;
        String toStr = endDate + endTime;
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-ddHH:mm");
        Date from, to;
        try {
            from = sf.parse(fromStr);
            to = sf.parse(toStr);
        } catch (ParseException e) {
            e.printStackTrace();
            return Result.fail(MsgCenter.ERROR_PARSE);
        }
        Context context = new Context("get_log_from_to");
        context.put("from", from);
        context.put("to", to);
        context.put("code", code);
        context.put("dti", dti);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail(MsgCenter.ERROR);
        }
        return context.getResult();
    }


    /**
     * 导出棋谱  日志页下载
     *
     * @return
     */
    @RequiresAuthentication
    @RequestMapping("output")
    public ResponseEntity<byte[]> outputQipu(@RequestParam("start-date") String startDate, @RequestParam("start-time") String startTime,
                                             @RequestParam("end-date") String endDate, @RequestParam("end-time") String endTime,
                                             String code) throws IOException {
        String fromStr = startDate + startTime;
        String toStr = endDate + endTime;
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-ddHH:mm");
        Date from, to;
        try {
            from = sf.parse(fromStr);
            to = sf.parse(toStr);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
        Context context = new Context("output_cheep");
        context.put("from", from);
        context.put("to", to);
        context.put("code", code);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        if (!context.isSuccess()) {
            return null;
        }
        String path = String.valueOf(context.getResult().getData());
        File file = new File(path);
        HttpHeaders headers = new HttpHeaders();
        String realName = String.valueOf(context.get("real_name"));
        //为了解决中文名称乱码问题
        String fileName = new String(realName.getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1);
        headers.setContentDispositionFormData("attachment", fileName);
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<>(FileUtils.readFileToByteArray(file),
                headers, HttpStatus.CREATED);
    }

    /**
     * record页下载
     *
     * @param cheepId
     * @return
     * @throws Exception
     */
    @RequiresAuthentication
    @RequestMapping("download/{cheepId}")
    public ResponseEntity<byte[]> download(@PathVariable("cheepId") String cheepId) throws Exception {
        Context context = new Context("download_cheep");
        context.put("cheep_id", cheepId);
        csgo.service(context);
        if (!context.isSuccess()) {
            return null;
        }
        String path = String.valueOf(context.get("path"));
        String realName = String.valueOf(context.get("real_name"));
        File file = new File(path);
        HttpHeaders headers = new HttpHeaders();
        //为了解决中文名称乱码问题
        String fileName = new String(realName.getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1);
        headers.setContentDispositionFormData("attachment", fileName);
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<>(FileUtils.readFileToByteArray(file),
                headers, HttpStatus.CREATED);
    }

    @RequiresAuthentication
    @PostMapping("set_public")
    @ResponseBody
    public Result setPublic(Cheep cheep,
                            @RequestParam("start-date") String startDate,
                            @RequestParam("start-time") String startTime,
                            @RequestParam("end-date") String endDate, @RequestParam("end-time") String endTime) {
        String fromStr = startDate + startTime;
        String toStr = endDate + endTime;
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-ddHH:mm");
        Date from, to;
        try {
            from = sf.parse(fromStr);
            to = sf.parse(toStr);
        } catch (ParseException e) {
            e.printStackTrace();
            return Result.fail(MsgCenter.ERROR_PARSE);
        }
        Context context = new Context("set_public");
        context.put("from", from);
        context.put("to", to);
        context.put("cheep", cheep);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return context.getResult();
    }

    /**
     * 获取回放页面 在每个path中添加cookie :
     *
     * @param cheepId
     * @param response
     * @return
     */
    @RequestMapping("replay/{cheepId}")
    public String replay(@PathVariable("cheepId") String cheepId, HttpServletResponse response) {
        Context context = new Context("replay_record");
        context.put("cheep_id", cheepId);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return "/index";
        }
        if (!context.isSuccess()) {
            return "/index";
        }
        Cookie[] cookies = super.getHttpServletRequest().getCookies();
        boolean record = false;
        boolean index = false;
        boolean max = false;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                String name = cookie.getName();
                String value = cookie.getValue();
                if ("record".equals(name) && !"null".equals(value)) {
                    record = true;
                    continue;
                }
                if ("index".equals(name) && !"null".equals(value)) {
                    index = true;
                    continue;
                }
                if ("max".equals(name) && !"null".equals(value)) {
                    max = true;
                }
            }
        }
        String path = "/cheep/replay/" + cheepId;
        if (!record) {
            Cookie cpId = new Cookie("record", cheepId);
            cpId.setPath(path);
            cpId.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(cpId);
        }
        if (!index) {
            Cookie cpIndex = new Cookie("index", String.valueOf(0));
            cpIndex.setPath(path);
            cpIndex.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(cpIndex);
        }
        if (!max) {
            Cookie cpMax = new Cookie("max", String.valueOf(context.get("max")));
            cpMax.setPath(path);
            cpMax.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(cpMax);
        }
        return String.valueOf(context.get("html"));
    }

    /**
     * 回写cookie+数据
     *
     * @param cheepId
     * @param step
     * @return
     */
    @RequestMapping("replay/step")
    @ResponseBody
    public Result getOneStep(String cheepId, Integer step) {
        Context context = new Context("get_one_step");
        context.put("cheep_id", cheepId);
        context.put("step", step);
        try {
            csgo.service(context);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail(MsgCenter.ERROR_PARAMS);
        }
        return context.getResult();
    }
}
