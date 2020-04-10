<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-11
  Time: 14:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>#记录-Minzuchess</title>
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
    <div class="alert alert-dismissible alert-info">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <h4 class="alert-heading">民族棋大家庭!</h4>
        <p class="mb-0">欢迎来到团队预览,这里有所有团队信息.<c:if
                test="${empty requestScope.user}"> <a href="/register1"
                                                      class="alert-link">还没加入队伍?去注册添加一个吧</a>
        </c:if>
        </p>
    </div>
    <div class="card border-dark mb-3">
        <h3 class="card-header">公开记录</h3>
        <div class="card-body">
            <div class="list-group-flush row">
                <c:forEach items="${requestScope.cheepInfo}" var="cheep">
                    <div class="list-group-item  col-lg-6">
                        <h4 class="card-title">${cheep.name}</h4>
                        <p class="text"><span><img width="17" height="17"
                                                   src="/icons/star-fill.svg">${cheep.category.value}</span>&nbsp;
                            <span class="float-right text-black-50"><img src="/icons/egg-fried.svg" width="17"
                                                                         height="17">
                                        &nbsp;来自:&nbsp;${cheep.userInfo.realName}</span>
                        </p>
                        <p>
                        <div class="float-right">
                            <a class="btn btn-success" href="/cheep/download/${cheep.cheepId}" target="_blank">下载</a>
                            <a class="btn btn-success" href="/cheep/replay/${cheep.cheepId}">回看</a>
                        </div>
                        <span class="text-black-50"><img src="/icons/alarm.svg" width="17"
                                                         height="17">&nbsp;${cheep.createTime}</span>
                        </p>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<%@include file="common/footer.jsp" %>
<script src="/js/custom.js"></script>
</body>
</html>
