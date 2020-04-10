package work.eanson.util;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ThreadPoolExecutor;

/**
 * 绑定当线程的棋盘码
 *
 * @author eanson
 */
@Component
public class CodeHolder {

    /**
     * 采用线程池来发送消息 避免上下文频繁切换
     */
    @Autowired
    private ThreadPoolTaskExecutor threadPoolTaskExecutor;

    private static ThreadLocal<String> codeThreadLocal = new ThreadLocal<>();

    public void setCode(String code) {
        codeThreadLocal.set(code);
    }

    public String getCode() {
        return codeThreadLocal.get();
    }

    /**
     * 必须回收自定义的ThreadLocal变量，尤其在线程池场景下，线程经常会被复用，如果不清理自定义的 ThreadLocal变量，
     * 可能会影响后续业务逻辑和造成内存泄露等问题。尽量在代理中使用try-finally块进行回收。
     */
    public synchronized void remove() {
        codeThreadLocal.remove();

    }

    public static final Logger logger = LogManager.getLogger(CodeHolder.class);

    /**
     * 群发消息
     *
     * @param message
     */
    public void sendMsgToAll(Map<String, WebSocketSession> clients, String message) {
        TextMessage textMessage = new TextMessage(message);
        Set<Map.Entry<String, WebSocketSession>> entries = clients.entrySet();
        //获取当前线程的code
        String code = codeThreadLocal.get();
        for (Map.Entry<String, WebSocketSession> entry : entries) {
            threadPoolTaskExecutor.execute(() -> {
                WebSocketSession value = entry.getValue();
                Map<String, Object> attributes = value.getAttributes();
                //判断棋盘码是否相同
                if (attributes.get("CODE").equals(code)) {
                    if (value.isOpen()) {
                        try {
                            logger.info("向ip:" + value.getRemoteAddress() + "发送消息:" + message);
                            value.sendMessage(textMessage);
                        } catch (IOException e) {
                            e.printStackTrace();
                            logger.error("发送信息错误：" + value.getRemoteAddress());
                        }
                    }
                }
            });
        }
    }
}
