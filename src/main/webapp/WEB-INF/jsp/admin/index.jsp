<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-28
  Time: 11:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>后台管理</title>
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
<body>
<%@include file="common/prefix.jsp" %>
<!-- Begin Page Content -->
<div class="container-fluid my-5">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">基本操作</h1>
    <p class="mb-4">用户添加和棋盘添加，两者不关联，没有联系</p>
    <div class="alert alert-primary my-3" role="alert">
        <h3><strong>${requestScope.msg}</strong></h3>
    </div>
    <div class="card-deck row">
        <div class="col-sm-4">
            <div class="card text-center">
                <div class="card-header">
                    用户添加
                </div>
                <div class="card-body">
                    <form method="POST" id="user-form" action="/admin/user/user_add">
                        <div class="form-group">
                            <label for="username">姓名</label>
                            <input id="username" type="text" class="form-control" name="realName" autofocus>
                            <div class="invalid-feedback">
                                姓名不正确
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="password">密码</label>
                            <input id="password" type="text" class="form-control" name="password" value="123456">
                            <div class="invalid-feedback">
                                密码不正确
                            </div>
                        </div>
                        <div class="form-group form-text text-muted text-center">
                            密码为6-20位字母或数字组成(不能包含特殊字符)
                        </div>
                        <div class="form-group">
                            <label for="telephone">手机号</label>
                            <input id="telephone" type="text" class="form-control" name="telephone" value=""
                            >
                            <div class="invalid-feedback">
                                手机号不合法
                            </div>
                        </div>
                        <div class="form-group m-0">
                            <button type="submit" class="btn btn-primary btn-block">
                                添加
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-sm-2">
            <div class="card text-center">
                <div class="card-header">
                    棋盘添加
                </div>
                <div class="card-body">
                    <form method="POST" id="code-form" action="/admin/chess/cb_add">
                        <div class="form-group">
                            <label for="code">棋盘码</label>
                            <input id="code" type="text" class="form-control" name="code" value="${requestScope.code}">
                            <div class="form-group form-text text-muted text-center">
                                只能是4位字母
                            </div>
                            <div class="invalid-feedback">
                                棋盘码不正确
                            </div>
                        </div>
                        <div class="form-group ">
                            <label for="category">类别</label>
                            <select id="category" class="custom-select province-select" name="category">
                                <c:forEach items="${requestScope.categories}" var="category">
                                    <option value="${category.key}">${category.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group m-0">
                            <button id="submit" type="submit" class="btn btn-success btn-block">
                                添加
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /.container-fluid -->
<%@include file="common/suffix.jsp" %>
</body>
<!-- Core plugin JavaScript-->
<script src="/js/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/js/sb-admin-2.min.js"></script>
<script src="/js/validator.min.js"></script>
<script src="/js/admin/index.js"></script>
</html>
