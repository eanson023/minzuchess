<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-30
  Time: 16:43
  To change this template use File | Settings | File Templates.
  我的主页加载页
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<div id="add-msg-box"></div>
<div class="alert alert-info" role="alert">
    社会团体,学校栏可以不填写
</div>
<form method="post" id="addForm" novalidate="">
    <div class="form-group">
        <label for="teamNameC">请输入队伍名</label>
        <input id="teamNameC" type="text" class="form-control" name="teamName" required autofocus>
        <div class="invalid-feedback">
            队伍名不正确
        </div>
    </div>
    <div class="form-group">
        <label for="provinceId">请选择省份</label>
        <select id="provinceId" class="custom-select province-select" name="provinceId">
            <option selected disabled>请选择省份</option>
        </select>
    </div>
    <div class="form-group">
        <label for="school">请选择学校</label>
        <select id="school" class="custom-select province-select" name="schoolId">
            <option selected disabled>请选择学校</option>
        </select>
    </div>
    <div class="form-group input-group">
        <label for="introductionC">队伍介绍</label>
        <textarea id="introductionC" class="form-control" name="introduction" rows="3" required></textarea>
        <div class="invalid-feedback">
            请输入4-200个文字介绍
        </div>
    </div>
    <div class="form-group m-0">
        <button id="submitC" type="button" class="btn btn-primary btn-block">
            添加
        </button>
    </div>
</form>
<script src="/js/create_team_my_page.js"></script>