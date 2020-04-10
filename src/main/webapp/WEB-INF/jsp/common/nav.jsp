<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-08
  Time: 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar fixed-top navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <a class="navbar-brand" href="/index">Minzuchess</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01"
                aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarColor01">
            <ul class="navbar-nav mr-auto">
                <%--                <li class="nav-item">--%>
                <%--                    <a class="nav-link" href="/chess">棋类</a>--%>
                <%--                </li>--%>
                <li class="nav-item">
                    <a class="nav-link" href="/team">团队</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/public_record">记录</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/about">关于</a>
                </li>
            </ul>
            <c:choose>
                <c:when test="${not empty requestScope.user}">
                    <div class="nav-item">
                        <c:choose>
                            <c:when test="${not empty requestScope.user.avatar}">
                                <img class="rounded img-thumbnail" width="30" height="30"
                                     src="/img/avatar/${requestScope.user.avatar}">
                            </c:when>
                            <c:otherwise>
                                <img class="rounded img-thumbnail" width="30" height="30"
                                     src="/img/avatar/default.jpg">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="dropdown nav-item">
                        <a class="btn btn-link dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                ${requestScope.user.realName}
                        </a>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                            <a class="dropdown-item" href="/user_main/home"><img
                                    src="/icons/house.svg" alt="" title="我的主页">&nbsp;我的主页</a>
                            <a class="dropdown-item" href="/cheep"><img
                                    src="/icons/geo.svg" alt="" title="我的日志">&nbsp;我的日志</a>
                            <a class="dropdown-item" href="javascript:void(0);" data-toggle="modal"
                               data-target="#model1"><img
                                    src="/icons/wrench.svg" alt=""
                                    title="账户修改">&nbsp;账户修改</a>
                        </div>
                    </div>
                    <c:if test="${requestScope.user.msgCount gt 0}">
                        <!-- Nav Item - Messages -->
                        <li class="nav-item dropdown no-arrow mx-1 list-unstyled">
                            <a class="nav-item " data-toggle="dropdown"
                                    aria-haspopup="true" aria-expanded="false" style="cursor: pointer">
                                <img src="icons/chat-fill.svg" alt="" title="我的消息"><span
                                    class="badge badge-pill badge-light"><sup
                                    id="msgCount">${requestScope.user.msgCount}</sup></span>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in bg-secondary"
                                 aria-labelledby="messagesDropdown">
                                <h6 class="dropdown-header text-dark">
                                    消息中心
                                </h6>
                                <c:forEach var="message" items="${requestScope.user.messages}">
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <div class="font-weight-bold">
                                            <div class="text-truncate"><span
                                                    class="col-md-6"><u>${message.who}</u>申请加入<strong>${message.teamName}</strong></span>
                                                <form>
                                                    <input type="text" name="uuid" value="${message.uuid}" hidden>
                                                    <input type="text" name="teamId" value="${message.teamId}" hidden>
                                                </form>
                                                <div class="btn-group btn-group-sm float-right">
                                                    <button type="button" class="btn btn-success btn-sm agree-btn">同意
                                                    </button>
                                                    <button type="button" class="btn btn-warning btn-sm refuse-btn">拒绝
                                                    </button>
                                                </div>
                                                <div class="small text-gray-500 align-middle mt-2">${message.createTime}</div>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>
                        </li>
                    </c:if>
                    <a class="nav-item btn btn-sm btn-secondary" data-noajax="true" href="/user/logout">注销</a>
                </c:when>
                <c:otherwise>
                    <a class="btn btn-primary" href="/login">登录</a>
                    <a class="btn btn-secondary" href="/register1">注册</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>
<div class="modal fade" id="model1" role="dialog" aria-labelledby="model1" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">账户信息修改</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form class="container form-upload" id="form-upload" enctype="multipart/form-data">
                    <div id="file-alert" class="alert alert-dismissible small alert-danger " hidden>
                        <strong>请上传2Mb以内的图片</strong>
                    </div>
                    <div class="form-group row">
                        <label for="file" class="col-lg-3 col-form-label">头像</label>
                        <div class="col-lg-9">
                            <input type="file" id="file" name="avatar"
                                   class="form-control form-control-file custom-file-input file"
                                   accept="image/jpeg,image/png" required>
                            <label class="custom-file-label" for="file">选择文件</label>
                            <small class="form-text text-muted">请上传2MB之内的图片</small>
                        </div>
                    </div>
                    <div class="text-center mt-5 mb-1">
                        <button id="upload" type="submit" class="btn btn-primary btn-sm">
                            <span class="px-3">确定</span>
                        </button>
                    </div>
                </form>
                <hr>
                <form class="container form-update" id="form-update">
                    <div id="change-alert" class="alert alert-dismissible small alert-danger " hidden>
                        <strong id="change-msg"></strong>
                    </div>
                    <div class="form-group row p-2">
                        <label for="original" class="col-lg-3 col-form-label">原始密码</label>
                        <div class="col-lg-9">
                            <input type="password" class="form-control" id="original" name="original"
                                   placeholder="请输入原始密码" required autofocus>
                            <div class="invalid-feedback">密码不正确</div>
                        </div>
                    </div>
                    <div class="form-group row p-2">
                        <label for="password" class="col-lg-3 col-form-label">新密码</label>
                        <div class="col-lg-9">
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="请输入新密码"
                                   required>
                            <small class="text-muted form-text">密码为6-20位字母或数字组成(不能包含特殊字符)</small>
                            <div class="invalid-feedback">密码格式错误</div>
                        </div>
                    </div>
                    <div class="form-group row p-2">
                        <label for="repassword" class="col-lg-3 col-form-label">确认密码</label>
                        <div class="col-lg-9">
                            <input type="password" name="repassword" class="form-control" id="repassword"
                                   placeholder="请再次确认密码" required>
                            <div class="invalid-feedback">两次输入密码不一致</div>
                        </div>
                    </div>
                    <div class="text-center mt-5 mb-1">
                        <button id="update-btn" type="button" class="btn btn-primary btn-sm">
                            <span class="px-3">确定</span>
                        </button>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    <%--    动态active--%>
    $(function () {
        $("nav ul li").each(function () {
            let li = $(this);
            let href = location.toString();
            let a = li.children();
            let pageHref = a.prop('href');
            if (href.indexOf(pageHref) >= 0) {
                a.append(' <span class="sr-only">(current)</span>');
                li.addClass('active');
            }
        })
    })
</script>
<script src="/js/validator.min.js"></script>
<script src="/js/common.js"></script>
<script src="/js/nav.js"></script>
