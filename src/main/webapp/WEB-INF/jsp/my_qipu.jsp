<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-24
  Time: 09:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>#${requestScope.user.username}-日志页-Minzuchess</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <link rel="stylesheet" href="/css/bootstrap.min.css" media="screen">
    <link rel="stylesheet" href="/css/custom.min.css">
    <link rel="stylesheet" href="/css/bootstrap-datepicker3.min.css">
    <link rel="stylesheet" href="/css/bootstrap-clockpicker.min.css">
    <link href="/css/dataTables.bootstrap4.min.css" rel="stylesheet">
    <script src="/js/jquery.min.js"></script>
    <script src="/js/popper.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/popper.min.js"></script>
</head>
<body>
<%@include file="common/nav.jsp" %>
<div class="container">
    <div class="alert alert-success" role="alert">
        <p>你可以通过设置<strong>时间</strong>再进行<strong><em>查询操作</em></strong>来过滤掉一些你不需要的信息,同时你也可以将该时间段里的有效数据
            <strong><em>导出</em></strong>或者设为<strong><em>公共棋谱</em></strong>供大家参考
        </p>
    </div>
    <form id="time-form">
        <div class="form-row">
            <select name="code" id="code-select" class="col-1 form-control form-control-sm">
                <c:forEach var="chess_info" items="${requestScope.chessInfo}" varStatus="s">
                    <c:choose>
                        <c:when test="${s.index==0}">
                            <option selected value="${chess_info.code}">${chess_info.categoryObj.value}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${chess_info.code}">${chess_info.categoryObj.value}</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select>
            <label for="begin-date" class="col-form-label col-form-label-sm">起始时间:</label>
            <div class="input-daterange input-group col-4 col-sm-2" id="begin-date" data-date-end-date="0d">
                <input type="text" class="input-sm form-control form-control-sm" name="start-date"/>
            </div>
            <input class="form-control form-control-sm col-4 col-sm-1 text-center" id="begin-time" name="start-time"
                   value="00:00">
            <label for="end-date" class="col-form-label col-form-label-sm">结束时间:</label>
            <div class="input-daterange input-group col-4 col-sm-2" id="end-date" data-date-end-date="0d">
                <input type="text" class="input-sm form-control form-control-sm" name="end-date"/>
            </div>
            <input class="form-control form-control-sm col-4 col-sm-1 text-center" id="end-time" name="end-time"
                   value="00:00">
            <button id="search" type="button" class="btn btn-sm btn-success ml-2" data-toggle="popover"
                    data-placement="top" data-trigger="focus" title="错误" data-content="请选择一个时间区间">查询
            </button>
            <button id="output" type="button" class="btn btn-sm btn-info ml-2" data-toggle="popover"
                    data-placement="top" data-trigger="focus" title="错误" data-content="请选择一个时间区间">导出
            </button>
            <button id="set-public" type="button" class="btn btn-sm btn-primary ml-2" data-toggle="popover"
                    data-placement="top" data-trigger="focus" title="错误" data-content="请选择一个时间区间">设为公共棋谱
            </button>
        </div>
    </form>
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">棋谱日志</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                    <tr>
                        <th scope="col">招数</th>
                        <th scope="col">颜色</th>
                        <th scope="col">类型</th>
                        <th scope="col">时间</th>
                        <th scope="col">状态</th>
                        <th scope="col">备注</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th scope="col">招数</th>
                        <th scope="col">颜色</th>
                        <th scope="col">类型</th>
                        <th scope="col">时间</th>
                        <th scope="col">状态</th>
                        <th scope="col">备注</th>
                    </tr>
                    </tfoot>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="output-model" tabindex="-1" role="dialog" aria-labelledby="output-model-title"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="output-model-title">导出棋谱</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary">确定</button>
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
<%@include file="common/footer.jsp" %>
</body>
<script src="/js/bootstrap-datepicker.min.js"></script>
<script src="/js/bootstrap-datepicker.zh-CN.min.js"></script>
<script src="/js/bootstrap-clockpicker.min.js"></script>
<!-- Page level plugins -->
<script src="/js/jquery.dataTables.min.js"></script>
<script src="/js/dataTables.bootstrap4.min.js"></script>
<script src="/js/my_qipu.js"></script>
</html>
