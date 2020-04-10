<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-28
  Time: 14:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body id="page-top">
<div id="wrapper">
    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

        <!-- Sidebar - Brand -->
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
            <div class="sidebar-brand-icon rotate-n-15">
                <i class="fas fa-laugh-wink"></i>
            </div>
            <div class="sidebar-brand-text mx-3">民族棋后台管理</div>
        </a>
        <!-- Divider -->
        <hr class="sidebar-divider my-0">

        <!-- Nav Item - Dashboard -->
        <li class="nav-item">
            <a class="nav-link" href="/admin/index">
                <i class="fas fa-fw fa-rocket"></i>
                <span>常用操作</span></a>
        </li>
        <!-- Divider -->
        <hr class="sidebar-divider">

        <!-- Heading -->
        <div class="sidebar-heading">
            操作
        </div>

        <!-- Nav Item - Pages Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUsers"
               aria-expanded="true" aria-controls="collapsePages">
                <i class="fas fa-fw fa-folder"></i>
                <span>用户</span>
            </a>
            <div id="collapseUsers" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <a class="collapse-item" href="/admin/user/user_log">用户日志</a>
                    <a class="collapse-item" href="/admin/user/user_info">用户信息</a>
                </div>
            </div>
        </li>

        <!-- Nav Item - Pages Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
               aria-expanded="true" aria-controls="collapsePages">
                <i class="fas fa-fw fa-archway"></i>
                <span>棋盘</span>
            </a>
            <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">棋盘操作</h6>
                    <a class="collapse-item" href="/admin/chess/chess_info">查看棋盘</a>
                    <a class="collapse-item" href="/admin/chess/chess_delete">删除棋盘</a>
                </div>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseCheeps"
               aria-expanded="true" aria-controls="collapsePages">
                <i class="fas fa-fw fa-ship"></i>
                <span>棋谱</span>
            </a>
            <div id="collapseCheeps" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">日志</h6>
                    <a class="collapse-item" href="/admin/cheep/cheep_info">查看日志</a>
                    <div class="collapse-divider"></div>
                </div>
            </div>
        </li>
        <!-- Divider -->
        <hr class="sidebar-divider d-none d-md-block">

        <!-- Sidebar Toggler (Sidebar) -->
        <div class="text-center d-none d-md-inline">
            <button class="rounded-circle border-0" id="sidebarToggle"></button>
        </div>
    </ul>
    <!-- End of Sidebar -->
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Topbar -->
            <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                <!-- Sidebar Toggle (Topbar) -->
                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>
                <!-- Topbar Navbar -->
                <ul class="navbar-nav ml-auto">
                    <div class="topbar-divider d-none d-sm-block"></div>

                    <!-- Nav Item - User Information -->
                    <li class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="mr-2 d-none d-lg-inline text-gray-600 small">${requestScope.user.realName}</span>
                            <c:choose>
                                <c:when test="${not empty requestScope.user.avatar}">
                                    <img class="img-profile rounded-circle" width="30" height="30"
                                         src="/img/avatar/${requestScope.user.avatar}">
                                </c:when>
                                <c:otherwise>
                                    <img class="img-profile rounded-circle" width="30" height="30"
                                         src="/img/avatar/default.jpg">
                                </c:otherwise>
                            </c:choose>
                        </a>
                        <!-- Dropdown - User Information -->
                        <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                             aria-labelledby="userDropdown">
                            <a class="dropdown-item" href="/index">
                                <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                去客户端主页
                            </a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="/user/logout">
                                <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                退出
                            </a>
                        </div>
                    </li>
                </ul>
            </nav>
            <!-- End of Topbar -->
<script type="text/javascript">
    $(function () {
        var href=location.protocol+'//'+location.host+'${requestScope.original}';
        $("#accordionSidebar>li").each(function () {
            var $this=$(this);
            $this.find('a').each(function () {
                var $a=$(this);
                var aHref=$a.prop('href');
                if(href==aHref){
                    $a.addClass('active');
                    $this.addClass('active');
                    $this.children('div').addClass('show');
                }
            })
        });
    })
</script>