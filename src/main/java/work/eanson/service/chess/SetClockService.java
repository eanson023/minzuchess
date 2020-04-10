package work.eanson.service.chess;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import work.eanson.controller.websocket.LogSocketEndPoint;
import work.eanson.dao.ChessInfoDao;
import work.eanson.dao.TrickDao;
import work.eanson.pojo.ChessInfo;
import work.eanson.pojo.Trick;
import work.eanson.pojo.extend.TrickExtend;
import work.eanson.service.base.BaseService;
import work.eanson.service.base.Input;
import work.eanson.service.jq.HumanAnalyzer;
import work.eanson.service.jq.TrickAnalyzer;
import work.eanson.util.CodeHolder;
import work.eanson.util.Context;

import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 设置棋钟并且 更新棋谱 更新日志
 *
 * @author eanson
 */
@Service("set_clock")
public class SetClockService extends BaseService {
    @Autowired
    private ChessInfoDao chessInfoDao;

    @Autowired
    private TrickDao trickDao;

    @Autowired
    private HumanAnalyzer humanAnalyzer;

    @Autowired
    private CodeHolder codeHolder;

    private final static Logger logger = LogManager.getLogger(SetClockService.class);

    @Input(required = {"clock", "code"})
    @Transactional(propagation = Propagation.SUPPORTS, rollbackFor = Exception.class)
    @Override
    public void service(Context context) throws Exception {
        String code = context.get("code") + "";
        String clock = context.get("clock") + "";
        int i = chessInfoDao.selectIsExistByPrimaryKey(code);
        if (i == 0) {
            return;
        }
        codeHolder.setCode(code);
        //提交棋钟
        if (clock.charAt(0) == '0') {
            //得到分析结果
            try {
                Trick analyze = humanAnalyzer.analyze(code);
                //before要变化 适应AI分析 回调提子
                String before = analyze.getBefore();
                String key = UUID.randomUUID().toString().replace("-", "");
                analyze.setLogId(key);
                if (analyze.getIsFalse()) {
                    clock = "-" + analyze.getColor() + System.currentTimeMillis();
                } else {
                    TrickAnalyzer trickAnalyzer = new TrickAnalyzer();
                    trickAnalyzer.analyze(analyze);
                    if (analyze.getIsFalse()) {
                        clock = "-" + analyze.getColor() + System.currentTimeMillis();
                    }
                }
                //设置回来
                analyze.setBefore(before);
                trickDao.insertSelective(analyze);
                logger.info(analyze);
                int i1 = trickDao.selectCountByForeignKey(code);
                List<TrickExtend> trickExtends = trickDao.selectInfoLimit(code, i1 - 1, i1);
                String logMsg = new ObjectMapper().writeValueAsString(trickExtends);
                //向日志页发送日志
                codeHolder.sendMsgToAll(LogSocketEndPoint.clients, logMsg);
            } catch (Exception e) {
                e.printStackTrace();
                clock = "--" + System.currentTimeMillis();
            }
        }
        ChessInfo chessInfo = new ChessInfo();
        chessInfo.setClock(clock);
        chessInfo.setCode(code);
        chessInfoDao.updateByPrimaryKeySelective(chessInfo);
        context.put("msg","设置棋钟");
    }
}
