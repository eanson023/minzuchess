<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-09
  Time: 14:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>#民族棋-Minzuchess</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <link rel="stylesheet" href="/css/bootstrap.min.css" media="screen">
    <link rel="stylesheet" href="/css/custom.min.css">
    <link rel="stylesheet" href="/css/index.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="common/nav.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-sm-9">
            <div class="alert alert-dismissible alert-info">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <strong>
                    欢迎来到民族棋网,您可以注册一个账户获得云棋盘码<br>
                    让好友一起来对弈吧
                </strong>
            </div>
            <div class="alert alert-dismissible alert-success">
                <strong>
                    输入棋盘码回车进入云棋盘|输入棋盘编号回车去观战
                </strong>
            </div>
            <form class="form-group mt-4" id="enter-form">
                <input type="text" class="form-control form-control-lg rounded p-5 text-center "
                       style="font-size:80px;color:#037;"
                       placeholder="x" name="code_or_alias">
            </form>
            <div class="jumbotron  text-white rounded bg-dark">
                <a href="#"><img src="/img/tibetchess.png" class="img-fluid rounded"></a>
            </div>
            <div class="row mb-2">
                <div class="col-md-6">
                    <div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                        <div class="col p-4 d-flex flex-column position-static">
                            <strong class="d-inline-block mb-2 text-primary">#1</strong>
                            <h3 class="mb-0">藏久棋</h3>
                            <div class="mb-1 text-muted">Nov 12</div>
                            <p class="card-text mb-auto">介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍</p>
                            <a href="#" class="stretched-link">Continue reading</a>
                        </div>
                        <div class="col-auto d-none d-lg-block">
                            <svg class="bd-placeholder-img" width="200" height="250" xmlns="http://www.w3.org/2000/svg"
                                 preserveAspectRatio="xMidYMid slice" focusable="false" role="img"
                                 aria-label="Placeholder: Thumbnail"><title>Placeholder</title>
                                <rect width="100%" height="100%" fill="#55595c"></rect>
                                <text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text>
                            </svg>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                        <div class="col p-4 d-flex flex-column position-static">
                            <strong class="d-inline-block mb-2 text-success">#2</strong>
                            <h3 class="mb-0">蒙古久棋</h3>
                            <div class="mb-1 text-muted">Nov 11</div>
                            <p class="mb-auto">介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍</p>
                            <a href="#" class="stretched-link">Continue reading</a>
                        </div>
                        <div class="col-auto d-none d-lg-block">
                            <svg class="bd-placeholder-img" width="200" height="250" xmlns="http://www.w3.org/2000/svg"
                                 preserveAspectRatio="xMidYMid slice" focusable="false" role="img"
                                 aria-label="Placeholder: Thumbnail"><title>Placeholder</title>
                                <rect width="100%" height="100%" fill="#55595c"></rect>
                                <text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="card border-primary mb-3">
                <div class="card-header">使用手册</div>
                <div class="card-body">
                    <a class="page-link btn mb-1" href="/pages/api.html">云棋盘AI使用API说明</a>
                    <a class="page-link btn mb-1" href="/pages/introduction.html">云棋盘使用说明</a>
                    <a class="page-link btn mb-1" href="/md/久棋规则及棋谱简介.pdf">久棋规则及棋谱简介</a>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="common/footer.jsp" %>
</body>
<script src="js/custom.js"></script>
<script>
    $(function () {
        $("#enter-form").submit(function () {
            var $this = $(this);
            $.post('/chess/go/chess', $this.serialize(), function (data) {
                if (!data.success) {
                    var html = '<div class="alert alert-dismissible alert-danger">\n' +
                        '<button type="button" class="close" data-dismiss="alert">&times;</button>\n' +
                        '<strong>' + data.msg + '</strong>\n' +
                        '</div>';
                    $this.before(html);
                } else {
                    location.href = data.data;
                }
            }, 'json');
            return false;
        })
    })
</script>
</body>
</html>
