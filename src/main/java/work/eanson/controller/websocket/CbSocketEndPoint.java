package work.eanson.controller.websocket;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import work.eanson.service.base.ControllerService;
import work.eanson.service.chess.GetSetChessService;
import work.eanson.util.CodeHolder;
import work.eanson.util.Context;
import work.eanson.util.Result;

import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 避免棋盘状态轮询交互的解决方案
 *
 * @author eanson
 */
@Component
public class CbSocketEndPoint extends TextWebSocketHandler {
    @Autowired
    private CodeHolder codeHolder;

    @Autowired
    private ControllerService csgo;

    /**
     * 观看的用户
     */
    public static Map<String, WebSocketSession> usedClients = new ConcurrentHashMap<>();
    /**
     * 使用的用户
     */
    public static Map<String, WebSocketSession> watchClients = new ConcurrentHashMap<>();

    private static final Logger logger = LogManager.getLogger(TextWebSocketHandler.class);


    /**
     * 连接成功
     * <p>
     * 发送当前消息
     *
     * @param session
     * @throws Exception
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String code = codeHolder.getCode();
        //添加新用户
        if (isUser(session)) {
            logger.info("使用者加入：" + session.getRemoteAddress() + "\tid:" + session.getId());
            usedClients.put(session.getId(), session);
        } else {
            logger.info("新观众加入：" + session.getRemoteAddress() + "\tid:" + session.getId());
            watchClients.put(session.getId(), session);
        }
        Context context = new Context("get_set_chess");
        context.put("code", code);
        csgo.service(context);
        if (session.isOpen()) {
            CharSequence charSequence = String.valueOf(context.getResult().getData());
            TextMessage textMessage = new TextMessage(charSequence);
            //发送当前棋盘信息
            session.sendMessage(textMessage);
        }
        codeHolder.remove();
        super.afterConnectionEstablished(session);
    }

    /**
     * 收到消息
     * 跟新缓存数据
     * 利用set集合去重复
     * 更新pos
     * 群发
     *
     * @param session
     * @param message
     * @throws Exception
     */
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        Context context = new Context("update_cache");
        String code = String.valueOf(session.getAttributes().get("CODE"));
        //每次请求线程不一样 不能用这个
//        chess.setCode(codeHolder.getCode());
        context.put("code", code);
        context.put("pos", message.getPayload());
        csgo.service(context);
        context.setNewServiceName("get_set_chess");
        csgo.service(context);
        /*
         * 向观众群发信息
         */
        try {
            codeHolder.setCode(code);
            codeHolder.sendMsgToAll(watchClients, String.valueOf(context.getResult().getData()));
        } finally {
            codeHolder.remove();
        }
        super.handleTextMessage(session, message);
    }


    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        logger.error("WebSocket传输错误:", exception);
        super.handleTransportError(session, exception);
    }

    /**
     * 用户或者观众断开连接
     *
     * @param session
     * @param status
     * @throws Exception
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        if (isUser(session)) {
            logger.info("用户退出:" + session.getRemoteAddress());
            //删除用户
            usedClients.remove(session.getId());
            //如果没有人了 直接清除记谱缓存
            if (usedClients.size() == 0) {
                Context context = new Context("clear_cache");
                String code = String.valueOf(session.getAttributes().get("CODE"));
                context.put("code", code);
                csgo.service(context);
                logger.info("清空记谱缓存");
            }
        } else {
            logger.info("观众退出:" + session.getRemoteAddress());
            //删除观众
            watchClients.remove(session.getId());
        }
        super.afterConnectionClosed(session, status);
    }

    /**
     * 是否是用户
     *
     * @param session websocket session
     * @return
     */
    private boolean isUser(WebSocketSession session) {
        Object isUser = session.getAttributes().get("is_user");
        if (isUser == null) {
            return false;
        }
        return (boolean) isUser;
    }

}
