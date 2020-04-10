<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-08
  Time: 11:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="author" content="Kodinger">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>忘记密码2-Minzuchess</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/css/my-login.css">
</head>
<body class="my-login-page">
<section class="h-100">
    <div class="container h-100">
        <div class="row justify-content-md-center h-100">
            <div class="card-wrapper">
                <div class="brand">
                    <a href="/"><img src="/img/logo.jpg" alt="bootstrap 4 login page"></a>
                </div>
                <div class="card fat">
                    <div class="card-body">
                        <h4 class="card-title">忘记密码</h4>
                        <form method="POST" id="forget2-form" class="my-login-validation" novalidate="">
                            <div class="form-group">
                                <label for="tel">手机号</label>
                                <input id="tel" type="text" class="form-control" value="${requestScope.telephone}"
                                       disabled>
                            </div>
                            <div class="form-group">
                                <label for="username">用户名</label>
                                <input id="username" type="text" class="form-control" value="${requestScope.username}"
                                       disabled>
                            </div>
                            <div class="form-group">
                                <label for="password">密码</label>
                                <input id="password" type="password" class="form-control" name="password" value="" required
                                       autofocus>
                                <div class="invalid-feedback">
                                    密码格式不正确
                                </div>
                            </div>
                            <div class="form-group form-text text-muted text-center">
                                密码为6-20位字母或数字组成(不能包含特殊字符)
                            </div>
                            <div class="form-group">
                                <label for="repassword">确认密码</label>
                                <input id="repassword" type="password" class="form-control" name="repassword" value=""
                                       required autofocus>
                                <div class="invalid-feedback">
                                    两次输入不一致
                                </div>
                            </div>
                            <div class="form-group m-0">
                                <button type="button" id="submit" class="btn btn-primary btn-block">
                                    重置密码
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                <%@include file="common/footer.jsp" %>
            </div>
        </div>
    </div>
</section>

<script src="/js/jquery.slim.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/validator.min.js"></script>
<script src="/js/common.js"></script>
<script src="/js/forget2.js"></script>
</body>
</html>