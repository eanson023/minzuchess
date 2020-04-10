<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-08
  Time: 12:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<form id="login-pwd-form">
    <input type="text" value="0" name="is_phone_login" hidden>
    <div class="form-group input-group">
        <label for="username">用户编号(注册后获得的一串数字)</label>
        <input id="username" type="text" class="form-control" name="username" value="${requestScope.username}" required
               autofocus>
        <div class="invalid-feedback">
            用户编号不正确
        </div>
    </div>
    <div class="form-group">
        <label for="password">密码
            <a href="/forget1" class="float-right">
                忘记密码?
            </a>
        </label>
        <input id="password" type="password" class="form-control" name="password" required data-eye>
        <div class="invalid-feedback">
            密码不正确
        </div>
    </div>
    <div class="form-group">
        <div class="custom-checkbox custom-control">
            <input type="checkbox" name="remember" id="remember" class="custom-control-input">
            <label for="remember" class="custom-control-label">记住我</label>
        </div>
    </div>

    <div class="form-group m-0">
        <button id="submit" type="button" class="btn btn-primary btn-block">
            登录
        </button>
    </div>
</form>
<script type="text/javascript">
    $(function () {
        $("#username").keyup(function () {
            validateOne(this, loginValidator);
        });
        $("#password").keyup(function () {
            validateOne(this, loginValidator);
        });
        $("#submit").click(function () {
            if (!submitValidate(loginValidator.validate())) {
                return;
            }
            var msgBox = $("#msg-box");
            const form = $("#login-pwd-form");
            const loading = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>';
            const submit = $(this);
            submit.prop('disabled', true);
            const original = submit.html();
            submit.html(loading);
            $.post('/user/login', form.serialize() + '&is_phone_login=false', function (data) {
                let html;
                if (!data.success) {
                    html = '<div class="alert alert-dismissible alert-danger">\n' +
                        '<button type="button" class="close" data-dismiss="alert">&times;</button>\n' +
                        '<strong>' + data.msg + '</strong>\n' +
                        '</div>';
                    msgBox.html(html);
                    submit.html(original);
                    submit.prop('disabled', false);
                } else {
                    html = '<div class="alert alert-dismissible alert-success">\n' +
                        '  <button type="button" class="close" data-dismiss="alert">&times;</button>\n' +
                        '  <strong>网页跳转中....</strong>\n' +
                        '</div>';
                    msgBox.before(html);
                    location.href = data.data;
                }
            }, 'json');
        })
    });
    var loginValidator = new Validator('login-pwd-form', [
        {
            name: "username",
            rules: "required|min_length(5)|max_length(21)"
        }, {
            name: "password",
            rules: "required"
        }
    ])
</script>

