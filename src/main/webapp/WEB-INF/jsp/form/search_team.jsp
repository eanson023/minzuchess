<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-30
  Time: 13:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<div id="msg-box"></div>
<form method="POST" id="join-team-form" class="my-login-validation" novalidate="">
    <div class="form-group">
        <label for="team_name_num">请输入队伍名或队伍名编号</label>
        <input id="team_name_num" type="text" class="form-control" name="team_name_num" autofocus>
        <div class="invalid-feedback">
            你还没有选择要加入的队伍
        </div>
    </div>
    <div id="search-info-box" class="text-center" style="min-height: 50px">
    </div>
    <div class="form-group m-0">
        <button id="submit" type="button" class="btn btn-primary btn-block">
            注册&nbsp;2/2
        </button>
    </div>
</form>
<script type="text/javascript">
    $(function () {
        var box = $("#search-info-box");
        var load = '<div class="spinner-border" role="status">\n' +
            '                <span class="sr-only">Loading...</span>\n' +
            '            </div>';
        var teamInput = $("#team_name_num");
        var msgBox = $("msg-box");
        teamInput.keyup(function () {
            box.html(load);
            //搜索队伍
            var $this = $(this);
            var val = $this.val().trim();
            if (val.length > 0 && val !== '%') {
                $.get('/team/find/like/' + val, {}, function (data) {
                    box.empty();
                    if (data.success) {
                        $.each(data.data, function (index, item) {
                            var content = '<div class="card my-2">\n' +
                                '                <div class="card-body">\n' +
                                '                    <h5 class="card-title">' + item.teamName + '</h5>\n' +
                                '                    <p class="card-text">' + item.introduction + '</p>\n' +
                                '                    <p class="card-text">\n' +
                                '                        <small class="text-muted">' + item.joinDate + '</small>\n' +
                                '                    </p>\n' +
                                '                    <p class="card-text">\n' +
                                '                    <div class="form-check form-check-inline">\n' +
                                '                        <input class="form-check-input team-radio" type="radio" name="team-num-options" id="team-radio' + index + '"\n' +
                                '                               value="' + item.teamId + '">\n' +
                                '                        <label class="form-check-label" for="team-radio' + index + '">选择</label>\n' +
                                '                    </div>\n' +
                                '                    </p>\n' +
                                '                </div>\n' +
                                '            </div>';
                            box.prepend(content);
                        })
                    } else {
                        box.html(data.msg);
                    }
                }, 'json');
            } else {
                box.empty();
            }
        })
        $("#submit").click(function () {
            var ckd = $(".team-radio:checked");
            if (ckd.val() === undefined) {
                teamInput.addClass('is-invalid');
                teamInput.removeClass('is-valid');
            } else {
                teamInput.addClass('is-valid');
                teamInput.removeClass('is-invalid');
                var $this = $(this);
                $this.prop('disabled', true);
                const original = $this.html();
                $this.html(load);
                $.post('/user/register2', {team_name_num: ckd.val(), join: true}, function (data) {
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
                })
            }
        })
    });

</script>