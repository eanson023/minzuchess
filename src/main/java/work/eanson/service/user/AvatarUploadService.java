package work.eanson.service.user;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import work.eanson.dao.AvatarDao;
import work.eanson.exception.ParseException;
import work.eanson.pojo.Avatar;
import work.eanson.pojo.back.UserSession;
import work.eanson.service.base.BaseService;
import work.eanson.service.base.Input;
import work.eanson.util.Context;
import work.eanson.util.ShiroUtil;

import java.io.File;
import java.util.UUID;


/**
 * @author eanson
 * 用户头像上传
 * <p>
 * 1.第一次 上传 否则删除久头像
 */
@Service("avatar_upload")
public class AvatarUploadService extends BaseService {
    @Autowired
    private AvatarDao avatarDao;

    @Input(required = {"avatar"})
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void service(Context context) throws Exception {
        MultipartFile multipartFile = (MultipartFile) context.get("avatar");
        if (multipartFile.getSize() > 2 * 1024 * 1024) {
            throw new ParseException("文件过大");
        }
        //上传的位置
        String absolutePath = "/data/minzuchess/static/img/avatar";
        //数据库保存的位置
        String relativelyPath = "/img/avatar";
        //原始名称
        String originalFilename = multipartFile.getOriginalFilename();
        //后缀名
        String suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
        //随机名
        String fileName = UUID.randomUUID().toString().replace("-", "") + suffix;
        //将要传输的文件
        File prepareFile = new File(absolutePath, fileName);
        if (!prepareFile.getParentFile().exists()) {
            prepareFile.mkdirs();
        }
        //获取
        UserSession principal = (UserSession) SecurityUtils.getSubject().getPrincipal();
        String telephone = principal.getTelephone();
        Avatar avatar = avatarDao.selectByForeignKey(telephone);
        if (avatar == null) {
            Avatar avatar1 = new Avatar();
            avatar1.setFileName(fileName);
            avatar1.setTelephone(telephone);
            avatarDao.insert(avatar1);
            //传输文件
            try {
                multipartFile.transferTo(prepareFile);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            String old = avatar.getFileName();
            avatar.setFileName(fileName);
            avatar.setTelephone(null);
            avatarDao.updateByPrimaryKeySelective(avatar);
            //传输文件
            try {
                multipartFile.transferTo(prepareFile);
            } catch (Exception e) {
                e.printStackTrace();
            }
            //删除原文件
            File oldFile = new File(absolutePath, old);
            if (oldFile.exists()) {
                oldFile.delete();
            }
        }
        //更新Session
        UserSession session = (UserSession) SecurityUtils.getSubject().getPrincipal();
        session.setAvatar(fileName);
        ShiroUtil.updateNewSession(session);
        context.put("msg", "更新用户头像");
    }
}
