package work.eanson.service.aop;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import work.eanson.dao.ChessInfoDao;
import work.eanson.exception.ParseException;
import work.eanson.pojo.back.UserSession;
import work.eanson.util.Context;
import work.eanson.util.MsgCenter;

/**
 * @author eanson
 * @create 2020-03-30 22:02
 */
@Service
@Aspect
public class CheckChessCodePublicAspect {
    @Autowired
    private ChessInfoDao chessInfoDao;
    private static final Logger logger = LogManager.getLogger(CheckChessCodePublicAspect.class);

    @Around(value = "@annotation(work.eanson.service.base.CheckCbCodeRelation)")
    public Object checkCbCode(ProceedingJoinPoint point) throws Throwable {
        logger.info("检测棋盘关系");
        Object reValue;
        Context context = (Context) point.getArgs()[0];
        String code = String.valueOf(context.get("code"));
        Boolean aBoolean = chessInfoDao.selectIsPublicByPrimaryKey(code);
        if (aBoolean == null) {
            throw new ParseException(MsgCenter.ERROR_CODE_404);
        }
        //如果不是公开状态 检查棋盘码是否属于他
        if (!aBoolean) {
            Subject subject = SecurityUtils.getSubject();
            //未登录
            if (!subject.isAuthenticated()) {
                throw new Exception(MsgCenter.USER_NOT_LOGIN);
            }
            //检查是否属于他
            UserSession userSession = (UserSession) subject.getPrincipal();
            String telephone = userSession.getTelephone();
            int i = chessInfoDao.selectCbCodeIsBeLongToOneUser(code, telephone);
            if (i == 0) {
                throw new ParseException(MsgCenter.ERROR_CODE_NOT_BELONG);
            }
            context.put("is_public", false);
        } else {
            context.put("is_public", true);
        }
        logger.info("棋盘码关系检查完毕");
        reValue = point.proceed();
        return reValue;
    }
}
