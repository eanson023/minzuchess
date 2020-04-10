package work.eanson.controller.websocket;


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import work.eanson.util.CodeHolder;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 避免棋盘日志轮询交互的解决方案
 * @author eanson
 */
@Component
public class LogSocketEndPoint extends TextWebSocketHandler {
    @Autowired
    private CodeHolder codeHolder;

    /**
     * 连接的用户
     */
    public static Map<String, WebSocketSession> clients = new ConcurrentHashMap<>();

    private static final Logger logger = LogManager.getLogger(LogSocketEndPoint.class);


    /**
     * 连接成功
     * 发送10条当前棋盘码日志
     *
     * @param session
     * @throws Exception
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//        String code = codeHolder.getCode();
        //添加 到map中
        clients.put(session.getId(), session);
//        if (session.isOpen()) {
//            String string = objectMapper.writeValueAsString(result);
//            TextMessage textMessage = new TextMessage(string);
//            //发送当前棋盘信息
//            session.sendMessage(textMessage);
//        }
        super.afterConnectionEstablished(session);
    }


    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        logger.error("WebSocket传输错误:", exception);
        super.handleTransportError(session, exception);
    }

    /**
     * 用户断开连接
     *
     * @param session
     * @param status
     * @throws Exception
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        logger.info("断开连接:" + session.getRemoteAddress());
        clients.remove(session.getId());
        codeHolder.remove();
        super.afterConnectionClosed(session, status);
    }

}
