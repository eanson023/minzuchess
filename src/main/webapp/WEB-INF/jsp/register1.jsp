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
    <title>#注册-Minzuchess</title>
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
                        <form method="POST" id="register1-form" class="my-login-validation" novalidate="">
                            <div class="form-group">
                                <label for="realName">姓名</label>
                                <input id="realName" type="text" class="form-control" name="realName" required
                                       autofocus>
                                <div class="invalid-feedback">
                                    姓名不正确
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="password">密码</label>
                                <input id="password" type="password" class="form-control" name="password" required data-eye>
                                <div class="invalid-feedback">
                                    密码不正确
                                </div>
                            </div>
                            <div class="form-group form-text text-muted text-center">
                                密码为6-20位字母或数字组成(不能包含特殊字符)
                            </div>
                            <div class="form-group">
                                <label for="repassword">确认密码</label>
                                <input id="repassword" type="password" class="form-control" name="repassword" required data-eye>
                                <div class="invalid-feedback">
                                    两次密码不一致
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="telephone">手机号</label>
                                <input id="telephone" type="text" class="form-control" name="telephone" value=""
                                       required autofocus>
                                <div class="invalid-feedback">
                                    手机号不合法
                                </div>
                            </div>

                            <div class="form-group input-group mb-3">
                                <label for="check-code">验证码</label>
                                <input id="check-code" type="text" class="form-control" name="code" placeholder="请输入验证码"
                                       aria-describedby="get-code" required autofocus>
                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary btn-sm" type="button" id="get-code">获取验证码
                                    </button>
                                    <button class="btn btn-outline-secondary btn-sm" style="display:none" type="button"
                                            id="reset-code"><span id="code-second">60</span>秒后重发
                                    </button>
                                </div>
                                <div class="invalid-feedback">
                                    验证码错误
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="custom-checkbox custom-control">
                                    <input type="checkbox" name="agree" id="agree" class="custom-control-input"
                                           required>
                                    <label for="agree" class="custom-control-label">我同意 <a
                                            href="#">《民族棋云棋盘使用条例》</a></label>
                                    <div class="invalid-feedback">
                                        你必须阅读条约并打勾
                                    </div>
                                </div>
                            </div>
                            <div class="form-group m-0">
                                <button id="submit" type="button" class="btn btn-primary btn-block">
                                    注册&nbsp;1/2
                                </button>
                            </div>
                            <div class="mt-4 text-center">
                                已有账户? <a href="/login">去登陆</a>
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
<script src="/js/register1.js"></script>
</body>
</html>
