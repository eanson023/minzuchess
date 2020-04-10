package work.eanson.service.user;

import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import work.eanson.dao.CategoryDao;
import work.eanson.dao.ChessInfoDao;
import work.eanson.dao.UserLoginDao;
import work.eanson.pojo.Category;
import work.eanson.pojo.ChessInfo;
import work.eanson.pojo.UserLogin;
import work.eanson.service.base.BaseService;
import work.eanson.service.base.Common;
import work.eanson.service.base.Input;
import work.eanson.util.Context;

import java.util.Date;
import java.util.List;
import java.util.Random;


/**
 * @author eanson
 * <p>
 * 完成注册最后一步
 * 1.生成用户名
 * 2.生成棋盘别名
 */
@Service("finish_register")
public class FinishRegisterService extends BaseService {
    @Autowired
    private ChessInfoDao chessInfoDao;
    @Autowired
    private CategoryDao categoryDao;
    @Autowired
    private UserLoginDao userLoginDao;


    @Autowired
    private Common common;

    @Input(required = "userLogin")
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public void service(Context context) throws Exception {
        UserLogin userLogin = (UserLogin) context.get("userLogin");
        String telephone = userLogin.getTelephone();
//        获取别名
        long alias = common.generateAliasCode();
        String username = String.valueOf(alias);
        String password = userLogin.getPassword();
        //生成密码
        //2.2密码加密 用户名作为盐值
        password = new Md5Hash(password, username).toHex();
        userLogin.setUsername(username);
        userLogin.setPassword(password);
        userLogin.setIsRegHalf(false);
        userLoginDao.updateByPrimaryKeySelective(userLogin);
        //保证第一张棋盘与用户编码相同
        List<Category> categories = categoryDao.selectAll();
        ChessInfo chessInfo = new ChessInfo();
        chessInfo.setUserId(telephone);
        chessInfo.setCode(common.getRandomCode());
        chessInfo.setIsPublic(false);
        chessInfo.setClock("0Z:" + System.currentTimeMillis());
        chessInfo.setUserId(userLogin.getTelephone());
        //生成棋盘表信息
        for (Category category : categories) {
            chessInfo.setPos(category.getInitPos());
            chessInfo.setCategory(category.getKey());
            chessInfo.setAlias(alias);
            chessInfo.setCode(common.getRandomCode());
            chessInfo.setAlias(alias);
            alias++;
            chessInfoDao.insert(chessInfo);
        }
        context.put("msg", "生成棋盘码");
    }

}
