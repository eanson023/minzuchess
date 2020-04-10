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

    <title>棋盘信息</title>

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
    <h1 class="h3 mb-2 text-gray-800">棋盘信息</h1>
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
                        <th>棋盘码</th>
                        <th>棋钟</th>
                        <th>棋盘编码</th>
                        <th>是否公开</th>
                        <th>类别</th>
                        <th>手机号</th>
                        <th>姓名</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>棋盘码</th>
                        <th>棋钟</th>
                        <th>棋盘编码</th>
                        <th>是否公开</th>
                        <th>类别</th>
                        <th>手机号</th>
                        <th>姓名</th>
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
                    url: '/admin/chess/chess_info.json',
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
            //默认排序
            "order": [[2, 'desc']],
            "columns": [
                {"data": "code"},
                {"data": "clock", "orderable": false, "searchable": false},
                {"data": "alias"},
                {"data": "isPublicStr", "searchable": false},
                {"data": "value", "searchable": false},
                {"data": "userId", "orderable": false},
                {"data": "realName"}
            ]
        });
    });
</script>

<!-- Core plugin JavaScript-->
<script src="/js/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="/js/jquery.dataTables.min.js"></script>
<script src="/js/dataTables.bootstrap4.min.js"></script>
</html>
