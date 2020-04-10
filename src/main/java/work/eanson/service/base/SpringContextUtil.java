package work.eanson.service.base;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

/**
 * 获取Ioc容器中的bean
 *
 * @author eanson
 * @time:2020/2/13
 */
@Component
@SuppressWarnings("unchecked")
public class SpringContextUtil implements ApplicationContextAware {
    private final Logger logger = LogManager.getLogger(SpringContextUtil.class);
    private static ApplicationContext applicationContext;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        logger.info(this.toString() + "\tsetApplicationContext");
        SpringContextUtil.applicationContext = applicationContext;
    }

    static <T> T getBean(String beanName) {
        return (T) applicationContext.getBean(beanName);
    }
}
