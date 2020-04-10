<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-18
  Time: 11:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>#${requestScope.user_main.userInfoExtend.userLogin.username}-Minzuchess</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <link rel="stylesheet" href="/css/bootstrap.min.css" media="screen">
    <link rel="stylesheet" href="/css/custom.min.css">
    <script src="/js/jquery.min.js"></script>
    <script src="/js/popper.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="common/nav.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-md-3">
            <div class="card">
                <c:choose>
                    <c:when test="${not empty requestScope.user_main.userInfoExtend.avatar}">
                        <img src="/img/avatar/${requestScope.user_main.userInfoExtend.avatar}" alt="头像"
                             class="img-thumbnail rounded card-img-top border-dark">
                    </c:when>
                    <c:otherwise>
                        <img src="/img/avatar/default.jpg" alt="默认头像"
                             class="img-thumbnail rounded card-img-top border-dark">
                    </c:otherwise>
                </c:choose>
                <div class="card-body">
                    <h5 class="card-title">${requestScope.user_main.userInfoExtend.realName}</h5>
                    <p class="card-text">创建于:${requestScope.user_main.userInfoExtend.joinDay}</p>
                </div>
            </div>
        </div>
        <div class="col-md-9">
            <div id="carouselExampleIndicators" class="carousel slide alert-secondary rounded text-center"
                 style="height: 180px;" data-ride="carousel">
                <div class="carousel-inner p-5">
                    <div class="carousel-item active">
                        <p>${requestScope.person}加入民族棋已经</p>
                        <h4>${requestScope.user_main.userInfoExtend.dateDiff}天了</h4>
                    </div>
                    <div class="carousel-item">
                        <p>近一个月</p>
                        <h4>${requestScope.person}几乎${requestScope.user_main.avgComeDay}天来一次</h4>
                    </div>
                    <div class="carousel-item">
                        <p>近一个月月${requestScope.person}平均每天使用云棋盘的时间</p>
                        <h4>${requestScope.user_main.avgUseTime}</h4>
                    </div>
                    <div class="carousel-item">
                        <p>近一个月${requestScope.person}最喜欢使用云棋盘的时间段</p>
                        <h4>${requestScope.user_main.mostComePeriod}</h4>
                    </div>
                </div>
                <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
            <div class="m-4">
                <h5>基本信息</h5>
                <dl class="row pt-3 pl-3">
                    <dt class="col-md-3">用户名</dt>
                    <dd class="col-md-9">${requestScope.user_main.userInfoExtend.userLogin.username}</dd>

                    <dt class="col-md-3">真实姓名</dt>
                    <dd class="col-md-9">
                        ${requestScope.user_main.userInfoExtend.realName}
                    </dd>

                    <dt class="col-md-3">手机号</dt>
                    <dd class="col-md-9">${requestScope.user_main.userInfoExtend.userLogin.telephone}</dd>

                </dl>
            </div>
            <div class="m-4">
                <h5 class="">${requestScope.person}的棋盘</h5>
                <div class="row pt-3">
                    <c:forEach items="${requestScope.user_main.userInfoExtend.chessInfoExtend2s}" var="chessInfo"
                               varStatus="s">
                        <div class="col-md-4">
                            <div class="card mb-4 shadow-sm">
                                <img src="/img/${chessInfo.categoryObj.icon}" class="card-img-top img-thumbnail border"
                                     alt="${chessInfo.categoryObj.value}">
                                <div class="card-header">
                                    <h5 class="text-center">${chessInfo.categoryObj.value}</h5>
                                </div>
                                <ul class="list-group list-group-flush">
                                    <c:if test="${requestScope.who=='me'}">
                                        <li class="list-group-item">棋盘码:<span class="float-right"><a
                                                href="/chess?code=${chessInfo.code}">${chessInfo.code}</a></span></li>
                                    </c:if>
                                    <li class="list-group-item">棋盘编号:<span class="float-right"><a
                                            href="/chess/watch?alias=${chessInfo.alias}">${chessInfo.alias}</a></span>
                                    </li>
                                    <c:if test="${requestScope.who=='me'}">
                                        <li class="list-group-item">
                                            <a href="#/" class="float-right" data-toggle="popover"
                                               data-placement="bottom"
                                               title="提示" data-content="将棋盘设为公开状态之后每次进入云棋盘可以不用再登录,同时AI接口调用也不用再输入密码">
                                                <span>提示</span><img src="/icons/alert-circle-fill.svg" width="20"
                                                                    height="20">
                                            </a>
                                            <form class="form-inline">
                                                <span class="mr-2">状态:</span>
                                                <div class="custom-control custom-switch">
                                                    <c:choose>
                                                        <c:when test="${chessInfo.isPublic}">
                                                            <input type="checkbox" class="custom-control-input switch"
                                                                   id="switch${s.index}"
                                                                   target="${chessInfo.code}"
                                                                   checked>
                                                            <label class="custom-control-label"
                                                                   for="switch${s.index}">已公开</label>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input type="checkbox" class="custom-control-input switch"
                                                                   id="switch${s.index}"
                                                                   target="${chessInfo.code}">
                                                            <label class="custom-control-label"
                                                                   for="switch${s.index}">未公开</label>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </form>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="m-4">
                <c:if test="${requestScope.who=='me'}">
                    <button type="button" class="btn btn-link float-right" data-toggle="modal"
                            data-target="#add-new-team">新建队伍
                    </button>
                </c:if>
                <h5 class="mb-3">${requestScope.person}的队伍</h5>
                <table class="table table-secondary text-dark rounded">
                    <thead>
                    <tr>
                        <th scope="row">#</th>
                        <th>队伍名</th>
                        <th>人数</th>
                        <th>创建日期</th>
                        <th>类型</th>
                        <c:if test="${requestScope.who=='me'}">
                            <th>操作</th>
                        </c:if>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${requestScope.user_main.myTeams}" var="team" varStatus="s">
                        <tr class="">
                            <th scope="row">${s.index+1}</th>
                            <td><a href="/team_main/${team.teamId}">${team.team.teamName}</a></td>
                            <td>${team.count}</td>
                            <td>${team.team.joinDate}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty team.team.provinceId}">
                                        <c:choose>
                                            <c:when test="${not empty team.team.schoolId}">
                                                高校
                                            </c:when>
                                            <c:otherwise>
                                                民间
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        个人
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <c:if test="${requestScope.who=='me'}">
                                <td>
                                    <button type="button" class="btn btn-link btn-sm change-team-btn"
                                            data-toggle="modal"
                                            data-target="#change-team-modal" data="${team.teamId}">编辑
                                    </button>
                                    <button class="btn btn-outline-danger btn-sm del-team" data-toggle="modal"
                                            data-target="#del-team" data="${team.teamId}">删除
                                    </button>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="m-4">
                <c:if test="${requestScope.who=='me'}">
                    <button type="button" class="btn btn-link float-right" data-toggle="modal"
                            data-target="#join-new-team">加入队伍
                    </button>
                </c:if>
                <h5 class="mb-3">${requestScope.person}加入的队伍</h5>
                <table class="table table-secondary text-dark rounded">
                    <thead>
                    <tr>
                        <th scope="row">#</th>
                        <th>队伍名</th>
                        <th>人数</th>
                        <th>类型</th>
                        <th>状态</th>
                        <c:if test="${requestScope.who=='me'}">
                            <th>操作</th>
                        </c:if>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${requestScope.user_main.joinTeams}" var="team" varStatus="s">
                        <tr class="">
                            <th scope="row">${s.index+1}</th>
                            <td><a href="/team_main/${team.teamId}">${team.team.teamName}</a></td>
                            <td>${team.count}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty team.team.provinceId}">
                                        <c:choose>
                                            <c:when test="${not empty team.team.schoolId}">
                                                高校
                                            </c:when>
                                            <c:otherwise>
                                                民间
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        个人
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><c:choose>
                                <c:when test="${team.isJoin}">
                                    已加入
                                </c:when>
                                <c:otherwise>
                                    待同意
                                </c:otherwise>
                            </c:choose></td>
                            <c:if test="${requestScope.who=='me'}">
                                <td>
                                    <c:if test="${team.isJoin}">
                                        <button class="btn btn-outline-danger btn-sm quit-team" data-toggle="modal"
                                                data-target="#quit-team" data="${team.teamId}">退出
                                        </button>
                                    </c:if>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@include file="common/footer.jsp" %>
<!-- Modal -->
<div class="modal fade" id="change-team-modal" data-backdrop="static" tabindex="-1" role="dialog"
     aria-labelledby="changTeamTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="changTeamTitle">队伍信息修改</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form enctype="multipart/form-data" id="change-team-form">
                    <input type="text" name="teamId" id="teamId" hidden>
                    <div id="file-alert2" class="alert alert-dismissible small alert-danger " hidden>
                        <strong>请上传2Mb以内的图片</strong>
                    </div>
                    <div class="form-group row">
                        <label for="avatar" class="col-sm-2 col-form-label">头像</label>
                        <div class="col-sm-10">
                            <div class="input-group mb-3">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input file" id="avatar" name="avatar"
                                           accept="image/jpeg,image/png">
                                    <label class="custom-file-label" for="avatar">选择文件</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="team-name" class="col-sm-2 col-form-label">队伍名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="team-name" name="teamName" autofocus>
                            <div class="invalid-feedback">
                                队伍名格式不正确
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="introduction" class="col-sm-2 col-form-label">队伍介绍</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" name="introduction" id="introduction" rows="3"></textarea>
                            <div class="invalid-feedback">
                                请输入4-200个文字介绍
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                <button type="button" id="change-team-submit-btn" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="add-new-team" data-backdrop="static" tabindex="-1" role="dialog"
     aria-labelledby="new-team-title" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="new-team-title">新增队伍</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="team-type-box">
                    <%@include file="form/create_team_my_page.jsp" %>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="join-new-team" data-backdrop="static" tabindex="-1" role="dialog"
     aria-labelledby="new-team-title" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="join-team-title">加入队伍</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <%@include file="form/search_team_my_page.jsp" %>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="del-team" data-backdrop="static" tabindex="-1" role="dialog"
     aria-labelledby="new-team-title" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-body">
                你确定要删除吗?
            </div>
            <div class="modal-footer">
                <form action="/team/delete" method="POST">
                    <input type="text" name="teamId" id="del-input" value="" hidden>
                    <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-danger btn-sm">删除</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="quit-team" data-backdrop="static" tabindex="-1" role="dialog"
     aria-labelledby="quit-team-title" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-body">
                你确定要退出吗?
            </div>
            <div class="modal-footer">
                <form action="/team/quit" method="POST">
                    <input type="text" name="teamId" id="quit-input" value="" hidden>
                    <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-danger btn-sm">退出</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script src="/js/user_info.js"></script>
</html>
