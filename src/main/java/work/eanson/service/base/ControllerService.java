package work.eanson.service.base;


import org.springframework.stereotype.Service;
import work.eanson.exception.ParseException;
import work.eanson.util.Context;
import work.eanson.util.MsgCenter;
import work.eanson.util.Result;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/**
 * 控制层和业务层桥梁类
 * <p>
 * 方法名不能重载
 * <p>
 *
 * @author jjy
 */
@SuppressWarnings("unchecked")
@Service
public class ControllerService {

    public void service(Context context) throws Exception {
        BaseService baseService = SpringContextUtil.getBean(context.getServiceName());
        baseService.service(context);
    }
}
