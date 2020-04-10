package work.eanson.service.user;


import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import work.eanson.dao.SchoolDao;
import work.eanson.pojo.School;
import work.eanson.service.base.BaseService;
import work.eanson.service.base.Input;
import work.eanson.util.Context;
import work.eanson.util.Result;

import java.util.List;

/**
 * @author eanson
 */
@Service("get_school")
public class GetSchoolListService extends BaseService {
    @Autowired
    private SchoolDao schoolDao;
    @Autowired
    private JedisPool jedisPool;

    private static final Logger logger = LogManager.getLogger(GetSchoolListService.class);

    @Input(required = "province_id")
    @Override
    public void service(Context context) throws Exception {
        Integer proId = (Integer) context.get("province_id");
        context.clear();
        String key = "school_" + proId;
        try (Jedis jedis = jedisPool.getResource();) {
            ObjectMapper objectMapper = new ObjectMapper();
            if (!jedis.exists(key)) {
                List<School> schools = schoolDao.selectByForeignKey(proId);
                String value = objectMapper.writeValueAsString(schools);
                jedis.set(key, value);
                context.setResult(Result.success(schools));
                logger.info("school from db");
            } else {
                String json = jedis.get(key);
                List<School> schools = objectMapper.readValue(json, new TypeReference<List<School>>() {
                });
                context.setResult(Result.success(schools));
                logger.info("school from jedis");
            }
        }
    }
}
