<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<hr>
<div class="form-group form-row">
    <div class="form-check form-check-inline col">
        <input class="form-check-input" type="radio" name="join" id="radio4" value="1" checked>
        <label class="form-check-label" for="radio4">加入队伍</label>
    </div>
    <div class="form-check form-check-inline col">
        <input class="form-check-input" type="radio" name="join" id="radio5" value="0">
        <label class="form-check-label" for="radio5">创建队伍</label>
    </div>
</div>
<div id="join-team">
    <div class="form-group">
        <label for="team-name">请输入队伍名或队伍名编号</label>
        <input id="team-name" type="text" class="form-control" name="team_name_num" required autofocus>
        <div class="invalid-feedback">
            队伍名或编号不存在
        </div>
    </div>
</div>
<div id="create-team" style="display: none">
    <div class="form-group">
        <label for="new-team-name">请输入队伍名</label>
        <input id="new-team-name" type="text" class="form-control" name="teamName" required autofocus>
        <div class="invalid-feedback">
            队伍名或编号不存在
        </div>
    </div>
    <div class="form-group">
        <label for="province">请选择省份</label>
        <select id="province" class="custom-select province-select" name="provinceId">
            <option value="0" selected disabled>请选择省份</option>
        </select>
        <div class="invalid-feedback">
            请选择省份
        </div>
    </div>
    <div class="form-group">
        <label for="province">请选择队伍规模</label>
        <select class="custom-select province-select" name="numbers">
            <option selected value="5">5</option>
            <option value="10">10</option>
            <option value="20">20</option>
        </select>
    </div>
    <div class="form-group input-group">
        <label for="introduction">队伍介绍</label>
        <textarea id="introduction" class="form-control" name="introduction" rows="3"  required></textarea>
        <div class="invalid-feedback">
            请输入4-200个文字介绍
        </div>
    </div>
</div>

<script src="/js/my-register3.js"></script>
