package work.eanson.service.admin;

import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import work.eanson.dao.TrickDao;
import work.eanson.pojo.back.page.Column;
import work.eanson.pojo.back.page.DataTablesBack;
import work.eanson.pojo.back.page.DataTablesIn;
import work.eanson.pojo.back.page.Search;
import work.eanson.pojo.back.page.dao.Find;
import work.eanson.pojo.back.page.dao.Order;
import work.eanson.pojo.extend.TrickExtend;
import work.eanson.service.base.BaseService;
import work.eanson.service.base.Input;
import work.eanson.util.Context;
import work.eanson.util.Result;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @author eanson
 * @create 2020-03-29 13:38
 */
@Service("get_cheep_info")
public class GetCheepInfoService extends BaseService {
    @Autowired
    private TrickDao trickDao;

    @Input(required = "data_tables_in")
    @Override
    public void service(Context context) throws Exception {
        DataTablesIn dti = (DataTablesIn) context.get("data_tables_in");
        int start = dti.getStart();
        int length = dti.getLength();
        int page = start / length + 1;
        //找排序
        Set<Order> orders = null;
        if (!dti.getOrder().isEmpty()) {
            orders = new HashSet<>(8);
            for (work.eanson.pojo.back.page.Order order : dti.getOrder()) {
                int index = order.getColumn();
                Column column = dti.getColumns().get(index);
                String columnName = column.getData();
                //驼峰转换
                if ("createTime".equals(columnName)) {
                    //这是真正字段名
                    columnName = "exute_time";
                } else {
                    columnName = toLowerCaseAddUnderline(columnName);
                }
                String orderBy = order.getDir();
                //数据库 mybatis动态sql
                work.eanson.pojo.back.page.dao.Order orderD = new work.eanson.pojo.back.page.dao.Order(columnName, orderBy);
                orders.add(orderD);
            }
        }
        //找搜索
        work.eanson.pojo.back.page.dao.Search searchD = null;
        //数据库 mybatis动态sql
        if (!"".equals(dti.getSearch().getValue())) {
            searchD = new work.eanson.pojo.back.page.dao.Search();
            Set<String> columnNames = new HashSet<>(8);
            Search search = dti.getSearch();
            String value = search.getValue();
            searchD.setValue(value);
            List<Column> columns = dti.getColumns();
            for (Column column : columns) {
                if (column.isSearchable()) {
                    String data = column.getData();
                    data = toLowerCaseAddUnderline(data);
                    //转小写
                    columnNames.add(data);
                }
            }
            searchD.setColumnNames(columnNames);
        }
        //组装条件
        Find find = new Find(orders, searchD, null);
        PageHelper.startPage(page, length);
        List<TrickExtend> trickExtends = trickDao.selectAllOrOne(find);
        context.clear();
        context.setResult(Result.success(new DataTablesBack<>(trickExtends)));
        context.put("msg", "管理员获取棋普日志");
    }

    /**
     * 驼峰转下划线
     *
     * @param para
     * @return
     */
    private String toLowerCaseAddUnderline(String para) {
        StringBuilder sb = new StringBuilder(para);
        //定位
        int temp = 0;
        if (!para.contains("_")) {
            for (int i = 0; i < para.length(); i++) {
                if (Character.isUpperCase(para.charAt(i))) {
                    sb.insert(i + temp, "_");
                    temp += 1;
                }
            }
        }
        return sb.toString().toLowerCase();
    }
}
