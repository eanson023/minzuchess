<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-23
  Time: 13:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>#${requestScope.team_main.team.teamName}-Minzuchess</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <link rel="stylesheet" href="/css/bootstrap.min.css" media="screen">
    <link rel="stylesheet" href="/css/custom.min.css">
    <script src="/js/jquery.min.js"></script>
    <script src="/js/popper.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/jquery.twbsPagination.min.js"></script>
</head>
<body>
<%@include file="common/nav.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-sm-9">
            <c:if test="${not empty requestScope.team_main.useTotalTime}">
                <div id="carouselExampleIndicators" class="carousel slide alert-secondary rounded text-center"
                     style="height: 180px;" data-ride="carousel">
                    <div class="carousel-inner p-5">
                        <div class="carousel-item active">
                            <div class="d-block">
                                <p>该队伍已经创建</p>
                                <h4>${requestScope.team_main.createDayInterval}天了</h4>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <div class="d-block">
                                <p>昨日活跃度排行</p>
                                <h4>${requestScope.team_main.yesterdayActiveRanking}</h4>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <div class="d-block">
                                <p>该队伍使用民族棋总时长</p>
                                <h4>${requestScope.team_main.useTotalTime}</h4>
                            </div>
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
            </c:if>
            <div class="container m-4">
                <h5>基本信息</h5>
                <dl class="row pt-3 pl-3">
                    <dt class="col-sm-3">队伍名</dt>
                    <dd class="col-sm-9">${requestScope.team_main.team.teamName}</dd>

                    <dt class="col-sm-3">队伍编号</dt>
                    <dd class="col-sm-9">
                        ${requestScope.team_main.team.teamId}
                    </dd>
                    <dt class="col-sm-3">创建时间</dt>
                    <dd class="col-sm-9">
                        ${requestScope.team_main.team.joinDate}
                    </dd>
                    <dt class="col-sm-3">总人数</dt>
                    <dd class="col-sm-9">
                        ${requestScope.team_main.total}
                    </dd>
                    <dt class="col-sm-3">类型</dt>
                    <dd class="col-sm-9">
                        <c:choose>
                            <c:when test="${not empty requestScope.team_main.team.province.name}">
                                <c:choose>
                                    <c:when test="${not empty requestScope.team_main.team.school.name}">
                                        高校&nbsp;${requestScope.team_main.team.school.name}
                                    </c:when>
                                    <c:otherwise>
                                        民间&nbsp;${requestScope.team_main.team.province.name}
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                个人
                            </c:otherwise>
                        </c:choose>
                    </dd>
                    <dt class="col-sm-3">队伍介绍</dt>
                    <dd class="col-sm-9">${requestScope.team_main.team.introduction}</dd>
                </dl>
            </div>
            <h5 class="my-3">队员信息</h5>
            <div id="team-user-box" class="card-columns mb-3">
            </div>
            <div class="mx-3 clearfix">
                <div class="float-right">
                    <nav aria-label="Page navigation">
                        <ul class="pagination" id="pagination"></ul>
                    </nav>
                </div>
                <span class="align-bottom">总共${requestScope.page_info.total}位成员&nbsp;共${requestScope.page_info.pages}页</span>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="card">
                <c:choose>
                    <c:when test="${not empty requestScope.team_main.team.teamAvatar.fileName}">
                        <img src="/img/avatar/${requestScope.team_main.team.teamAvatar.fileName}" alt="头像"
                             class="img-thumbnail rounded card-img-top border-dark">
                    </c:when>
                    <c:otherwise>
                        <img src="/img/avatar/default2.jpg" class="img-fluid rounded"
                             width="100%" height="100%">
                    </c:otherwise>
                </c:choose>
                <div class="card-body">
                    <h5 class="card-title text-center">${requestScope.team_main.team.teamName}</h5>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="update-team-avatar" data-backdrop="static" tabindex="-1" role="dialog"
     aria-labelledby="update-team-title"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="update-team-title">头像更改</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form enctype="multipart/form-data" id="change-team-form">
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
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" id="change-team-submit-btn" class="btn btn-primary">上传</button>
            </div>
        </div>
    </div>
</div>
<%@include file="common/footer.jsp" %>
</body>
<script>
    $(function () {
        window.pagObj = $('#pagination').twbsPagination({
            totalPages: ${requestScope.page_info.pages},
            visiblePages: 6,
            onPageClick: function (event, page) {
                $.get('/team_main/get_team_user/${requestScope.team_main.team.teamId}', {pageNum: page}, function (data) {
                    if (data.success) {
                        var $team = $("#team-user-box");
                        $team.empty();
                        $.each(data.data, function (index, team_user) {
                            var content = '<a class="text-decoration-none" href="/user_main/others/' + team_user.userInfo.userLogin.username + '"><div class="card">';
                            if (team_user.userInfo.avatar != null) {
                                content += '<img src="/img/avatar/' + team_user.userInfo.avatar + '" class="card-img-top img-fluid" width="100%" height="100%">';
                            } else {
                                content += '<img src="/img/avatar/default.jpg" class="card-img-top img-fluid" width="100%" height="100%">';
                            }
                            content += '<h5 class="card-title text-dark text-center mt-3">' + team_user.userInfo.realName + '</h5><div class="card-body"> ';
                            if (team_user.isLeader) {
                                content += '<p class="card-text float-right"><small class="text-muted"><strong>队长</strong></small></p>';
                            }
                            content += '<p class="card-text"><small class="text-muted">' + team_user.userInfo.joinDay + '</small></p></div></div></div></a>';
                            $team.append(content);
                        })
                    }
                }, 'json');
            }
        }).on('page', function (event, page) {
        });
    })
    ;
</script>
</html>
