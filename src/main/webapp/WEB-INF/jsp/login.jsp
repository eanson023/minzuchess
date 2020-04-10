<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-08
  Time: 11:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>#登录-Minzuchess</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/css/my-login.css">
    <script src="/js/jquery.slim.min.js"></script>
    <script src="/js/popper.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/jquery.min.js"></script>
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
                        <h4 class="card-title">登录
                            <a href="javascript:void(0);" id="switch-href" class="float-right">
                                手机号登录
                            </a>
                        </h4>
                        <div id="msg-box"></div>
                        <div id="login_box">

                        </div>
                        <div class="mt-4 text-center">
                            还没有账户? <a href="/register1">去创建一个</a>
                        </div>
                    </div>
                </div>
                <%@include file="common/footer.jsp" %>
            </div>
        </div>
    </div>
</section>
<script src="/js/validator.min.js"></script>
<script src="/js/common.js"></script>
<script src="/js/login.js"></script>
</body>
</html>
