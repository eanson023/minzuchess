<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<hr>
<div class="container px-5">
    <div class="form-group row p-2">
        <label for="new-team-name2">用以下名称做队伍名</label>
        <input id="new-team-name2" type="text" class="form-control" name="teamName"
               required
               autofocus>
        <div class="invalid-feedback">
            队伍名格式不正确
        </div>
    </div>
    <div class="form-group row p-2">
        <label for="introduction2">队伍介绍</label>
        <textarea id="introduction2" class="form-control" name="introduction" rows="3" required></textarea>
        <div class="invalid-feedback">
            请输入4-200个文字介绍
        </div>
    </div>
</div>