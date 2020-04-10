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

    <title>棋谱日志</title>

    <!-- Custom fonts for this template-->
    <link href="/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
          rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="/css/dataTables.bootstrap4.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/bootstrap-datepicker3.min.css">
    <link rel="stylesheet" href="/css/bootstrap-clockpicker.min.css">
    <!-- Bootstrap core JavaScript-->
    <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap.bundle.min.js"></script>
    <script src="/js/popper.min.js"></script>

</head>
<%@include file="common/prefix.jsp" %>
<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">棋谱日志</h1>
    <p class="mb-4">消息提示</p>
    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">具体信息</h6>
        </div>
        <div>
            <form id="cheep-form">
                <div class="form-row  my-4 ml-3">
                    <label for="cbcode" class="col-form-label col-form-label-sm">棋盘码:</label>
                    <div class="input-group col col-sm-1" id="cbcode" data-date-end-date="0d">
                        <input type="text" class="input-sm form-control form-control-sm" id="code" name="code"/>
                    </div>
                    <label for="start-date" class="col-form-label col-form-label-sm">起始时间:</label>
                    <div class="input-daterange input-group col col-sm-2" id="begin-date" data-date-end-date="0d">
                        <input type="text" class="input-sm form-control form-control-sm" id="start-date" name="start-date"/>
                    </div>
                    <input class="form-control form-control-sm col col-sm-1 text-center" id="begin-time" name="start-time"
                           value="00:00">
                    <label for="end-date" class="col-form-label col-form-label-sm">结束时间:</label>
                    <div class="input-daterange input-group col col-sm-2" id="finish-date" data-date-end-date="0d">
                        <input type="text" class="input-sm form-control form-control-sm" id="end-date" name="end-date"/>
                    </div>
                    <input class="form-control form-control-sm col col-sm-1 text-center" id="end-time" name="end-time"
                           value="00:00">
                    <button id="output" type="button" class="btn btn-sm btn-info ml-2" data-toggle="popover"
                            data-placement="top" data-trigger="focus" title="错误" data-content="请选择一个时间区间和棋盘码">导出
                    </button>
                    <button id="set-public" type="button" class="btn btn-sm btn-primary ml-2" data-toggle="popover"
                            data-placement="top" data-trigger="focus" title="错误" data-content="请选择一个时间区间和棋盘码">设为公共棋谱
                    </button>
                </div>
            </form>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                    <tr>
                        <th>招数</th>
                        <th>颜色</th>
                        <th>时间</th>
                        <th>使用类型</th>
                        <th>状态</th>
                        <th>消息</th>
                        <th>棋盘码</th>
                        <th>类别</th>
                        <th>所属者</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>招数</th>
                        <th>颜色</th>
                        <th>时间</th>
                        <th>使用类型</th>
                        <th>状态</th>
                        <th>消息</th>
                        <th>棋盘码</th>
                        <th>类别</th>
                        <th>所属者</th>
                    </tr>
                    </tfoot>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="set-public-model" tabindex="-1" role="dialog" aria-labelledby="set-public-model-title"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="set-public-model-title">设为公共棋谱</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="modal-body">
                <div class="form-group">
                    <input type="text" class="form-control" id="cheep-name" name="name" placeholder="请设置棋谱名称" required>
                    <div class="invalid-feedback">
                        请设置2-20字长的名称
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" id="set-public-submit-btn" class="btn btn-primary">确定</button>
            </div>
        </div>
    </div>
</div>
<!-- /.container-fluid -->
<%@include file="common/suffix.jsp" %>
</body>
<script>
</script>
<!-- Core plugin JavaScript-->
<script src="/js/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="/js/jquery.dataTables.min.js"></script>
<script src="/js/dataTables.bootstrap4.min.js"></script>
<script src="/js/bootstrap-datepicker.min.js"></script>
<script src="/js/bootstrap-datepicker.zh-CN.min.js"></script>
<script src="/js/bootstrap-clockpicker.min.js"></script>
<script src="/js/validator.min.js"></script>
<script src="/js/admin/cheep_info.js"></script>
</html>
