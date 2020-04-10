package work.eanson.service.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import work.eanson.exception.ParseException;
import work.eanson.util.MsgCenter;

import java.lang.reflect.InvocationTargetException;
import java.util.Arrays;

/**
 * @author eanson
 */
@Component
@Aspect
public class ChessServiceAspect {
//    @Autowired
//    private ChessDao dao;
//
//    private static final Logger logger = Logger.getLogger(ChessServiceAOP.class);
//
//    /**
//     * chessService层切面 检测code是否存在
//     *
//     * @param joinPoint
//     * @throws NoSuchMethodException
//     * @throws InvocationTargetException
//     * @throws IllegalAccessException
//     * @throws ParseException
//     */
//    @Before("execution(* work.eanson.service.impl.ChessServiceImpl.*(..))")
//    public void checkCodeExists(JoinPoint joinPoint) throws NoSuchMethodException, InvocationTargetException, IllegalAccessException, ParseException {
//        Object[] args = joinPoint.getArgs();
//        Class<?> mouClass = args[0].getClass();
//        String name = mouClass.getName();
//        String code;
//        //bean
//        if (name.startsWith("work.eanson.pojo")) {
//            Object getCode = mouClass.getMethod("getCode").invoke(args[0]);
//            if (getCode == null) {
//                throw new ParseException(MsgCenter.ERROR_PARAMS);
//            }
//            code = String.valueOf(getCode);
//        } else {
//            //String
//            if (args[0] == null) {
//                throw new ParseException(MsgCenter.ERROR_PARAMS);
//            } else
//                code = String.valueOf(args[0]);
//        }
//        Chess chess = dao.selectByPrimaryKey(code);
//        if (chess == null) {
//            logger.error("查询失败：没有该棋盘码:" + code);
//            throw new ParseException(MsgCenter.ERROR_CODE_404);
//        }
//        logger.info("调用:" + joinPoint.getSignature().toString() + "\t参数:" + Arrays.toString(args));
//    }
}
