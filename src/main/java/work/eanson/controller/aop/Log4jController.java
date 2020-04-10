package work.eanson.controller.aop;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * 控制层日志
 *
 * @author eanson
 */
@Component
@Aspect
public class Log4jController {

    private static final Logger logger = LogManager.getLogger(Log4jController.class);

    @Pointcut("execution(* work.eanson.controller.*.*(..)) " +
            "&&!execution(* work.eanson.controller.BaseController.*(..))" +
            "&&!execution(* work.eanson.controller.aop.*.*(..))")
    public void point() {
    }

    @Before(value = "point()")
    public void logAccess(JoinPoint joinPoint) {
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("ip:").append(request.getRemotePort()).append("\tmethod:").append(request.getMethod()).append("\turl:").append(request.getRequestURL()).append("\tparams:");
        for (Object arg : joinPoint.getArgs()) {
            if (arg != null) {
                stringBuilder.append("\t").append(arg.getClass().getSimpleName()).append(" ").append(arg.toString());
            }
        }
        logger.info(stringBuilder.toString());
    }
}
