package work.eanson.service.ai;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import work.eanson.dao.ChessInfoDao;
import work.eanson.service.base.BaseService;
import work.eanson.service.base.Input;
import work.eanson.util.Context;
import work.eanson.util.Result;

/**
 * @author eanson
 */
@Service("get_clock")
public class GetClockService extends BaseService {
    @Autowired
    private ChessInfoDao chessInfoDao;

    @Input(required = "code")
    @Override
    public void service(Context context) throws Exception {
        String code = context.get("code") + "";
        String s = chessInfoDao.selectClockByPrimaryKey(code);
        context.setResult(Result.success(s));
    }
}
