package work.eanson.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;
import work.eanson.service.base.ControllerService;
import work.eanson.util.Context;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 * @author eanson
 */
public abstract class BaseController {
    @Autowired
    public ControllerService csgo;

    /**
     * 必须回收自定义的ThreadLocal变量，尤其在线程池场景下，线程经常会被复用，如果不清理自定义的 ThreadLocal变量，
     * 可能会影响后续业务逻辑和造成内存泄露等问题。尽量在代理中使用try-finally块进行回收
     */
    private ThreadLocal<HttpServletRequest> httpServletRequestThreadLocal = new ThreadLocal<>();

    @ModelAttribute
    public void bind(HttpServletRequest request) {
        httpServletRequestThreadLocal.set(request);
    }

    String getTokenCookie(String key) {
        Cookie[] cookies = httpServletRequestThreadLocal.get().getCookies();
        String cookie = null;
        if (cookies != null) {
            for (Cookie cookie1 : cookies) {
                if (key.equals(cookie1.getName())) {
                    cookie = cookie1.getValue();
                }
            }
        }
        return cookie;
    }

    HttpServletRequest getHttpServletRequest() {
        return httpServletRequestThreadLocal.get();
    }

    String getIpAddress() {
        HttpServletRequest request = httpServletRequestThreadLocal.get();
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    /**
     * 获取用户session
     */
    @ModelAttribute
    public ModelAndView getSession() throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        Context context = new Context("get_session");
        csgo.service(context);
        modelAndView.addObject("user", context.get("user"));
        return modelAndView;
    }
}
