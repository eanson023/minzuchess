package work.eanson.service.base;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import work.eanson.dao.*;
import work.eanson.exception.ParseException;
import work.eanson.pojo.ChessInfo;
import work.eanson.pojo.UserLogin;

import java.util.*;
import java.util.regex.Pattern;

/**
 * 有关项目的通用类
 *
 * @author eanson
 */
@Component
public class Common {
    @Autowired
    private CategoryDao categoryDao;
    @Autowired
    private ChessInfoDao chessInfoDao;
    @Autowired
    private UserLoginDao userLoginDao;

    private static Pattern INTRODUCTION_PATTERN = Pattern.compile("^.{4,200}$");
    private static Pattern PASSWORD_PATTERN = Pattern.compile("^[a-zA-Z0-9]{6,20}$");
    private static Pattern TEAMNAME_PATTERN = Pattern.compile("^.{2,10}$");
    private static Pattern NUMBER_PATTERN = Pattern.compile("^-?\\d+(\\.\\d+)?$");
    private static Pattern MOBILE_PATTERN = Pattern.compile("^[1](([3|5|8][\\d])|([4][4,5,6,7,8,9])|([6][2,5,6,7])|([7][^9])|([9][1,8,9]))[\\d]{8}$");
    private static Pattern CHINESENAME_PATTERN = Pattern.compile("^[\\u4e00-\\u9fa5.·\\u36c3\\u4DAE]{2,20}$");


    /**
     * 获取棋盘的初始坐标
     *
     * @return
     */
    public String getInitChessPos(int width) {
        width = width * (width + 1);
        return categoryDao.selectInitPos(width);
    }

    /**
     * 检测棋盘是否已满
     *
     * @param pos
     * @return
     */
    public boolean isCbFull(String pos, int width) {
        for (int i = 0; i < pos.length() - width; i++) {
            if (pos.charAt(i) == '0') {
                return false;
            }
        }
        return true;
    }

    /**
     * 提子
     *
     * @param pos
     * @return
     */
    public String getAfterFcCenterChess(String pos, int width) {
        StringBuilder sb = new StringBuilder(pos);
        int pos1, pos2;
        pos1 = (width - 1) / 2 * width + (width - 1) / 2;
        pos2 = width / 2 * width + width / 2;
        //提子
        sb.replace(pos1, pos1 + 1, "0");
        sb.replace(pos2, pos2 + 1, "0");
        return sb.toString();
    }


    public boolean isNumber(String string) {
        if (string == null) {
            return false;
        }
        return NUMBER_PATTERN.matcher(string).matches();
    }


    /**
     * 手机号验证
     * <br>　　　　　2019年1月16日已知
     * 中国电信号段
     * 133,149,153,173,174,177,180,181,189,199
     * 中国联通号段
     * 130,131,132,145,146,155,156,166,175,176,185,186
     * 中国移动号段
     * 134(0-8),135,136,137,138,139,147,148,150,151,152,157,158,159,165,178,182,183,184,187,188,198
     * 上网卡专属号段（用于上网和收发短信，不能打电话）
     * 如中国联通的是145
     * 虚拟运营商
     * 电信：1700,1701,1702
     * 移动：1703,1705,1706
     * 联通：1704,1707,1708,1709,171
     * 卫星通信： 1349 <br>　　　　　未知号段：141、142、143、144、154
     */
    public boolean isMobile(String str) {
        return MOBILE_PATTERN.matcher(str).matches();
    }

    public boolean isChineseName(String str) {
        return CHINESENAME_PATTERN.matcher(str).matches();
    }

    /**
     * \
     * <p>
     * 6,20位字母或数字
     * <p>
     * <p>
     * 密码规则是：           1、长度8~20
     * <p>
     *                      2、必须包含字母（大写或者小写）或数字
     * <p>
     * <p>
     *                      4、包含特殊字符 ~!@#$%^&*()[]{}<>?\+.    不能包含空格
     * <p>
     *                      5、只能包含以上特殊字符以及大小字母和数字的密码。
     * "^(?=.*[\\da-zA-Z])(?=.*[\\~\\!\\@\\#\\$\\%\\^\\&\\*\\(\\)\\[\\]\\{\\}\\<\\>\\?\\\\\\+\\.])[a-zA-Z0-9\\~\\!\\@\\#\\$\\%\\^\\&\\*\\(\\)\\[\\]\\{\\}\\<\\>\\?\\\\\\+\\.]{8,20}$";
     *
     * @param pwd
     * @return
     */
    public boolean isPassword(String pwd) {
        return PASSWORD_PATTERN.matcher(pwd).matches();
    }

    public String getUUID() {
        return UUID.randomUUID().toString().replace("-", "");
    }


    public boolean isTeamName(String teamName) {
        return TEAMNAME_PATTERN.matcher(teamName).matches();
    }


    public boolean isIntroduction(String introduction) {
        return INTRODUCTION_PATTERN.matcher(introduction).matches();
    }

    /**
     * 最大的号码+1映射为用户名
     * 棋盘别名的第一张 映射用户名....
     * 同时留间隔当前棋盘数量
     *
     * @return
     * @throws ParseException
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public synchronized long generateAliasCode() throws ParseException {
        int min = 99;
        int max = 600;
        int year = Calendar.getInstance().get(Calendar.YEAR);
        Integer uInt = userLoginDao.selectMaxUserName();
        //生成最初别名
        long initLongStr = Long.parseLong(year + String.valueOf(1100));
        if (uInt == null) {
            return initLongStr;
        }
        Integer cInt = chessInfoDao.selectMaxAlias();
        int maxUsername = Math.max(uInt, cInt);
        //更换年份
        if (maxUsername < initLongStr) {
            return initLongStr;
        }
        for (int i = 1; i < 10; i++) {
            int suffix = i * 1000 + min;
            String query = year + String.valueOf(suffix);
            //最大最小区间
            int intervalMin = Integer.parseInt(query);
            int intervalMax = intervalMin + max - min;
            if (maxUsername + 1 > intervalMin && maxUsername + 1 < intervalMax) {
                return maxUsername + 1;
            }
            //不在则加1000进入下一次判断
            maxUsername = intervalMin + i * 1000;
        }
        throw new ParseException("别名满了");
    }

    /**
     * 生成4位随机棋盘码
     *
     * @return
     */
    public String getRandomCode() {
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
