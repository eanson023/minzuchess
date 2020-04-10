package work.eanson.service.base;


import work.eanson.util.Context;

/**
 * @author eanson
 */
public abstract class BaseService {
    /**
     * 所有controller层调用此抽象service方法然后向下转型
     *
     * @param context 装载数据的工具
     * @throws Exception 无
     */
    public abstract void service(Context context) throws Exception;

}
