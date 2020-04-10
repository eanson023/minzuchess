package work.eanson.exception;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;
import work.eanson.util.MailUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;

/**
 * 出现异常处理
 *
 * @author eanson
 */
@Component
public class ParseExceptionResolver implements HandlerExceptionResolver {
    @Override
    public ModelAndView resolveException(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {
        String content = "";
        //发邮件给系统管理员
        try (StringWriter writer = new StringWriter();
             PrintWriter printWriter = new PrintWriter(writer)) {
            e.printStackTrace(printWriter);
            e.printStackTrace();
            content = writer.toString();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        MailUtil.sendMail("37742432@qq.com", "【500】系统错误", content);
        //跳转至错误页面
        return new ModelAndView("error/ErrorCode500");
    }
}
