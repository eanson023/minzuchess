package work.eanson.util;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.Subject;
import work.eanson.pojo.back.UserSession;

/**
 * @author eanson
 * @create 2020-03-30 21:02
 */
public class ShiroUtil {
    public static final Logger logger = LogManager.getLogger(ShiroUtil.class);

    /**
     * 更新用户session
     *
     * @param userSession
     */
    public static void updateNewSession(UserSession userSession) {
        Subject subject = SecurityUtils.getSubject();
        PrincipalCollection previousPrincipals = subject.getPrincipals();
        String next = previousPrincipals.getRealmNames().iterator().next();
        PrincipalCollection principalCollection = new SimplePrincipalCollection(userSession, next);
        subject.runAs(principalCollection);
    }
}
