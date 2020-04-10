<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-09
  Time: 16:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>#队伍-Minzuchess</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <link rel="stylesheet" href="/css/bootstrap.min.css" media="screen">
    <link rel="stylesheet" href="/css/custom.min.css">
    <link rel="stylesheet" href="/css/team.css">
    <script src="/js/jquery.min.js"></script>
    <script src="/js/popper.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="common/nav.jsp" %>
<div class="bg-diy">
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
            <h3 class="card-header">团队</h3>
            <div class="card-body">
                <div class="list-group-flush row">
                    <c:forEach items="${requestScope.teamPages}" var="teamPage">
                        <div class="list-group-item  col-lg-6">
                            <a href="/team_main/${teamPage.teamUser.teamId}" class="text-decoration-none">
                                <h4 class="card-title">${teamPage.teamUser.team.teamName}</h4>
                                <div class="text-dark">
                                    <p class="text"><span><img width="17" height="17" src="/icons/star-fill.svg"></span>&nbsp;
                                        <c:choose>
                                            <c:when test="${teamPage.teamUser.userInfo.stat==1}">
                                                个人
                                            </c:when>
                                            <c:when test="${teamPage.teamUser.userInfo.stat==2}">
                                                民间&nbsp;<c:out value="${teamPage.teamUser.team.province.name}"/>
                                            </c:when>
                                            <c:otherwise>
                                                高校&nbsp;<c:out value="${teamPage.teamUser.team.school.name}"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="float-right text-black-50"><img src="/icons/egg-fried.svg"
                                                                                     width="17"
                                                                                     height="17">
                                        &nbsp;队长:&nbsp;<c:out
                                                    value="${teamPage.teamUser.userInfo.realName}"/></span>
                                    </p>
                                    <p class="text-over-hide"><span><img width="17" height="17" src="/icons/bookmark-fill.svg"></span>&nbsp;<c:out
                                            value="${teamPage.teamUser.team.introduction}"/>
                                    <span class="float-right text-black-50"><img src="/icons/people.svg" width="17"
                                                                                 height="17">&nbsp;<c:out
                                            value="${teamPage.counts}"/></span></p>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="common/footer.jsp" %>

<script src="/js/custom.js"></script>
</body>
</html>

