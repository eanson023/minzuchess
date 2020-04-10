<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-08
  Time: 12:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<form id="login-phone-form">
    <div class="form-group input-group">
        <label for="telephone">手机号</label>
        <input id="telephone" type="text" class="form-control" name="telephone" value="${requestScope.telephone}"
               required autofocus>
        <div class="invalid-feedback">
            手机号不合法
        </div>
    </div>
    <div class="form-group input-group mb-3">
        <label for="code">验证码</label>
        <input id="code" name="code" type="text" class="form-control" placeholder="请输入验证码"
               aria-describedby="get-code" required>
        <div class="input-group-append">
            <button class="btn btn-outline-secondary btn-sm" type="button" id="get-code">获取验证码</button>
            <button class="btn btn-outline-secondary btn-sm" style="display:none" type="button" id="reset-code"><span
                    id="code-second">60</span>秒后重发
            </button>
        </div>
        <div class="invalid-feedback">
            验证码错误
        </div>
    </div>
    <div class="form-group">
        <div class="custom-checkbox custom-control">
            <input type="checkbox" name="remember" id="remember" class="custom-control-input">
            <label for="remember" class="custom-control-label">记住我</label>
        </div>
    </div>
    <div class="form-group m-0">
        <button id="submit" type="submit" class="btn btn-primary btn-block">
            登录
        </button>
    </div>
</form>
<script type="text/javascript">
    $(function () {
        $("#get-code").click(function () {
            getCode(loginValidator, false);
        })
        $("#telephone").keyup(function () {
            validateOne(this, loginValidator);
        });
        $("#code").keyup(function () {
            validateOne(this, loginValidator);
        });
        $("#submit").click(function () {
            if (!submitValidate(loginValidator.validate())) {
                return;
            }
            var msgBox = $("#msg-box");
            const form = $("#login-phone-form");
            const loading = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>';
            const submit = $(this);
            submit.prop('disabled', true);
            const original = submit.html();
            submit.html(loading);
            $.post('/user/login', form.serialize() + '&is_phone_login=true', function (data) {
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
                    msgBox.html(html);
                    location.href = data.data;
                }
            }, 'json');
        })
    });
    var loginValidator = new Validator('login-phone-form', [
        {
            name: "telephone",
            rules: "required|is_phone"
        }, {
            name: "code",
            rules: "required"
        }
    ])

    function getCode(validator, is_new) {
        var tel = $('#telephone');
        var telJs = tel[0];
        //验证手机号码
        if (validateOne(telJs, validator)) {
            resetCode(); //倒计时
            let phone = tel.val();
            $.post('/get_code', {telephone: phone, now_time: new Date().getTime(), is_new: is_new}, function (data) {
                var form = $("#login-phone-form");
                let html;
                if (!data.success) {
                    html = '<div class="alert alert-dismissible alert-danger">\n' +
                        '<button type="button" class="close" data-dismiss="alert">&times;</button>\n' +
                        '<strong>' + data.msg + '</strong>\n' +
                        '</div>';
                    form.before(html);
                } else {
                    html = '<div class="alert alert-dismissible alert-success">\n' +
                        '  <button type="button" class="close" data-dismiss="alert">&times;</button>\n' +
                        '  <strong>' + data.msg + '</strong>\n' +
                        '</div>';
                    form.before(html);
                }
            });
        } else {
            tel.focus();
        }
    }
</script>

