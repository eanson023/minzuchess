package work.eanson.util;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

/**
 * Created by RojerAlone on 2017/6/2.
 * 邮件工具
 */
public class MailUtil {

    private final static String USERNAME = "37742432@qq.com";
    // 需要打开SMTP并使用此授权码登录
    private final static String PASSWORD = "evoxbgexcgmdbhbh";

    /**
     * 发送邮件给指定人，需要主题和内容
     *
     * @param user
     * @param title
     * @param content
     */
    public static void sendMail(String user, String title, String content) {
        SimpleEmail email = new SimpleEmail();
        email.setCharset("UTF8");
        email.setHostName("smtp.qq.com");
        email.setAuthentication(USERNAME, PASSWORD);
        try {
            email.setFrom(USERNAME);
            email.addTo(user);
            email.setSubject(title);
            email.setMsg(content);
            email.send();
        } catch (EmailException e) {
            e.printStackTrace();
        }
    }
}
