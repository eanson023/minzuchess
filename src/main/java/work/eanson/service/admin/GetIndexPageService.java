package work.eanson.service.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import work.eanson.dao.CategoryDao;
import work.eanson.dao.ChessInfoDao;
import work.eanson.pojo.Category;
import work.eanson.pojo.ChessInfo;
import work.eanson.service.base.BaseService;
import work.eanson.util.Context;

import java.util.List;
import java.util.Random;

/**
 * @author eanson
 * @create 2020-03-29 17:44
 */
@Service("get_admin_index")
public class GetIndexPageService extends BaseService {
    @Autowired
    private ChessInfoDao chessInfoDao;
    @Autowired
    private CategoryDao categoryDao;

    @Override
    public void service(Context context) throws Exception {
        String randomCode = getRandomCode();
        context.put("code", randomCode);
        List<Category> categories = categoryDao.selectLetter();
        context.put("categories", categories);
    }

    /**
     * 生成4位随机棋盘码
     *
     * @return
     */
    private String getRandomCode() {
        String str = "QWERTYUIOPLKJHGFSAZXCVBNMqwertyuioplkjhgfdsazxcvb";
        Random random = new Random();
        StringBuilder proCode = new StringBuilder();
        for (int i = 0; i < 4; i++) {
            int i1 = random.nextInt(str.length());
            proCode.append(str.charAt(i1));
        }
        ChessInfo chess = chessInfoDao.selectByPrimaryKey(proCode.toString());
        if (chess != null) {
            proCode = new StringBuilder(this.getRandomCode());
        }
        return proCode.toString();
    }
}
