<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-08
  Time: 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>#注册2-Minzuchess</title>
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
                        <h4 class="card-title">注册</h4>
                        <div class="form-group">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input one-radio" type="radio" name="stat"
                                       id="search-team-radio" value="1">
                                <label class="form-check-label" for="search-team-radio">搜索现有队伍</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input one-radio" type="radio" name="stat"
                                       id="create-team-radio" value="2" checked>
                                <label class="form-check-label" for="create-team-radio">创建队伍</label>
                            </div>
                        </div>
                        <div id="login-box2">

                        </div>
                        <div class="mt-4 text-center">
                            已有账户? <a href="/login">去登陆</a>
                        </div>
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
<script src="/js/register2.js"></script>
</body>
</html>
