<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-28
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>用户日志</title>
    <!-- Custom fonts for this template-->
    <link href="/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
          rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="/css/dataTables.bootstrap4.min.css" rel="stylesheet">
    <!-- Bootstrap core JavaScript-->
    <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap.bundle.min.js"></script>
</head>
<%@include file="common/prefix.jsp" %>
<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">用户信息</h1>
    <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below. For more
        information about DataTables, please visit the</p>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                    <tr>
                        <th class="text-center">#</th>
                        <th>姓名</th>
                        <th>手机号</th>
                        <th>用户名</th>
                        <th>注册时间</th>
                        <th>后台添加？</th>
                        <th>注册情况</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th class="text-center">头像</th>
                        <th>姓名</th>
                        <th>手机号</th>
                        <th>用户名</th>
                        <th>注册时间</th>
                        <th>后台添加？</th>
                        <th>注册情况</th>
                    </tr>
                    </tfoot>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- /.container-fluid -->
<%@include file="common/suffix.jsp" %>
</body>

<script>
    $(document).ready(function () {
        $('#dataTable').DataTable({
            "searching": true,
            "pagesType": "full_numbers",
            "language": {
                //国际化
                "url": "/js/Chinese.json"
            },
            "serverSide": true,//开启服务器模式，使用服务器端处理配置datatable
            "processing": true,//开启读取服务器数据时显示正在加载中……特别是大数据量的时候，开启此功能比较好
            ajax: function (data, callback, settings) {
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    contentType: 'application/json',
                    url: '/admin/user/user_info.json',
                    data: JSON.stringify(data),
                    success: function (data) {
                        var returnData = {};
                        returnData.recordsTotal = data.recordsTotal;//总记录数
                        returnData.recordsFiltered = data.recordsFiltered;//后台不实现过滤功能，每次查询均视作全部结果
                        returnData.data = data.data;
                        callback(returnData);
                    }
                });
            },
            // ajax: {
            //     'url': '/admin/user/user_log2.json',
            //     'type': 'POST'
            // },
            //默认排序
            "order": [[3, 'desc']],
            "columns": [
                {
                    "sClass":"text-center",
                    "data": "avatar",
                    "orderable": false,
                    "searchable": false,
                    "render": function (data, type, row, meta) {
                        var content = '';
                        if (data == null || data == '') {
                            content = '<img src="/img/avatar/default.jpg" width="20" height="20"/>';
                        } else {
                            content = '<img src="/img/avatar/' + data + ' "width="20" height="20" />';
                        }
                        return content;
                    }
                },
                {"data": "realName"},
                {"data": "telephone"},
                {"data": "username"},
                {"data": "joinDay", "searchable": false},
                {"data": "isAdminAdd", "searchable": false},
                {"data": "isFinishReg", "searchable": false}
            ]
        });
    });

    //封装查询参数
    function getQueryCondition(data) {
        var param = {};
        //组装排序参数
        // param.id = $("#id-search").val();//查询条件
        // param.username = $("#name-search").val();//查询条件
        // param.enable = $("#status-search").val();//查询条件
        //组装分页参数
        param.start = data.start;
        param.length = data.length;
        param.draw = data.draw;
        return param;
    }
</script>
<!-- Core plugin JavaScript-->
<script src="/js/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="/js/jquery.dataTables.min.js"></script>
<script src="/js/dataTables.bootstrap4.min.js"></script>
</html>
