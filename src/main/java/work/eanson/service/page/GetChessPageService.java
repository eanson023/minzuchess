package work.eanson.service.page;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import work.eanson.dao.CategoryDao;
import work.eanson.dao.ChessInfoDao;
import work.eanson.pojo.back.UserSession;
import work.eanson.service.base.BaseService;
import work.eanson.service.base.Input;
import work.eanson.service.chess.GoChessService;
import work.eanson.util.Context;
import work.eanson.util.MsgCenter;
import work.eanson.util.Result;

/**
 * @author eanson
 */
@Service("get_page")
public class GetChessPageService extends BaseService {
    @Autowired
    private CategoryDao categoryDao;
    @Autowired
    private ChessInfoDao chessInfoDao;

    private static final Logger logger = LogManager.getLogger(GetChessPageService.class);

    @Input(optional = {"code", "alias"})
    @Override
    public void service(Context context) throws Exception {
        Object codeObj = context.get("code");
        Object aliasObj = context.get("alias");
        context.clear();
        boolean isAlias = false;
        String code = null;
        if (codeObj != null) {
            code = String.valueOf(codeObj);
        } else if (aliasObj != null) {
            String alias = String.valueOf(aliasObj);
            code = chessInfoDao.selectCodeByAlias(alias);
            isAlias = true;
        }
        if (code == null) {
            context.setResult(Result.fail(MsgCenter.ERROR_PARAMS));
            return;
        }
        int i1 = chessInfoDao.selectIsExistByPrimaryKey(code);
        if (i1 == 0) {
            context.setResult(Result.fail(MsgCenter.ERROR_CODE_404));
            return;
        }
        Boolean aBoolean = chessInfoDao.selectIsPublicByPrimaryKey(code);
        String html = categoryDao.selectHtmlByCode(code);
        //设置html 用于转发
        context.setResult(Result.success(html));
        if (isAlias) {
            return;
        }
        //公共棋盘
        if (aBoolean) {
            return;
        }
        Subject subject = SecurityUtils.getSubject();
        UserSession userSession = (UserSession) subject.getPrincipal();
        String telephone = userSession.getTelephone();
        int i = chessInfoDao.selectCbCodeIsBeLongToOneUser(code, telephone);
        if (i == 0) {
            context.setResult(Result.fail(MsgCenter.ERROR_CODE_NOT_BELONG));
        }
    }
}
