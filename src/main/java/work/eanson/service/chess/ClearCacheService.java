package work.eanson.service.chess;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import work.eanson.controller.websocket.CbSocketEndPoint;
import work.eanson.controller.websocket.LogSocketEndPoint;
import work.eanson.dao.TrickDao;
import work.eanson.pojo.Trick;
import work.eanson.pojo.extend.TrickExtend;
import work.eanson.service.base.BaseService;
import work.eanson.service.base.CheckCbCodeRelation;
import work.eanson.service.base.Input;
import work.eanson.util.CodeHolder;
import work.eanson.util.Context;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @author eanson
 * <p>
 * 清除记谱缓存  不用记到日志里面 仅发送就行了
 */
@Service("clear_cache")
public class ClearCacheService extends BaseService {
    @Autowired
    private JedisPool jedisPool;

    @Autowired
    private CodeHolder codeHolder;

    @Input(required = {"code"})
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void service(Context context) throws Exception {
        String code = context.get("code") + "";
        String key = "qipu_zset_" + code;
        try (Jedis resource = jedisPool.getResource();) {
            resource.del(key);
        }
        TrickExtend trick = new TrickExtend();
        trick.setColor("0");
        trick.setIsFalse(false);
        trick.setMessage("清除人类记谱缓存");
        trick.setTrick("clear");
        trick.setCbCode(code);
        trick.setType((byte) 2);
        trick.setCreateTime(new SimpleDateFormat("MM-dd hh:mm:ss").format(new Date()));
        List<TrickExtend> trickExtends = new ArrayList<>();
        trickExtends.add(trick);
        String logMsg = new ObjectMapper().writeValueAsString(trickExtends);

        //发送日志
        codeHolder.setCode(code);
        codeHolder.sendMsgToAll(LogSocketEndPoint.clients, logMsg);
        codeHolder.remove();
        context.put("msg","清除棋盘缓存");
    }
}
