<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-30
  Time: 13:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<div id="create-msg-box"></div>
<div class="alert alert-info" role="alert">
    社会团体,学校栏可以不填写
</div>
<form method="POST" id="create-team-form" class="my-login-validation" novalidate="">
    <div class="form-group">
        <label for="teamName">请输入队伍名</label>
        <input id="teamName" type="text" class="form-control" name="teamName" required autofocus>
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
            <option selected value="-1">请选择学校</option>
        </select>
    </div>
    <div class="form-group input-group">
        <label for="introduction">队伍介绍</label>
        <textarea id="introduction" class="form-control" name="introduction" rows="3" required></textarea>
        <div class="invalid-feedback">
            请输入4-200个文字介绍
        </div>
    </div>
    <div class="form-group m-0">
        <button id="submit" type="button" class="btn btn-primary btn-block">
            注册&nbsp;2/2
        </button>
    </div>
</form>
<script type="text/javascript">
    $(function () {
        loadProvince();
        //加载学校
        $("#provinceId").change(function () {
            loadSchool();
        });
        $("#teamName").keyup(function () {
            validateOne(this, validator);
        });
        $("#introduction").keyup(function () {
            validateOne(this, validator);
        })
        $("#submit").click(function () {
            var val = validator.validate();
            if (!submitValidate(val)) {
                return;
            }
            var load = '<div class="spinner-border" role="status">\n' +
                '                <span class="sr-only">Loading...</span>\n' +
                '            </div>';
            var msgBox = $("#create-msg-box");
            var form = $("#create-team-form");
            var $this = $(this);
            $this.prop('disabled', true);
            const original = $this.html();
            $this.html(load);
            $.post('/user/register2', form.serialize(), function (data) {
                var html;
                if (data.success) {
                    html = '<div class="alert alert-dismissible alert-success">\n' +
                        '  <button type="button" class="close" data-dismiss="alert">&times;</button>\n' +
                        '  <strong>网页跳转中....</strong>\n' +
                        '</div>';
                    msgBox.html(html);
                    location.href = data.data;
                } else {
                    html = '<div class="alert alert-dismissible alert-danger">\n' +
                        '<button type="button" class="close" data-dismiss="alert">&times;</button>\n' +
                        '<strong>' + data.msg + '</strong>\n' +
                        '</div>';
                    msgBox.html(html);
                    if (data.data) {
                        location.href = data.data;
                    } else {
                        $this.html(original);
                        $this.prop('disabled', false);
                    }
                }
            }, 'json');
        })
    });
    var validator = new Validator('create-team-form', [
        {
            name: "teamName",
            rules: 'required|max_length(20)'
        }, {
            name: "provinceId",
            rules: 'required'
        }, {
            name: "introduction",
            rules: "required|min_length(4)|max_length(200)"
        }

    ], function (obj, evt) {
    });
</script>
