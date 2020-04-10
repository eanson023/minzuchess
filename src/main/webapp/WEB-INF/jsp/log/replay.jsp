<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-26
  Time: 21:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>#云棋盘回放</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css"/>
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/jquery.cookie.js"></script>
</head>
<body>
<div>
    <input id="bridge-cheep-id" hidden>
    <input id="bridge-index" hidden>
    <input id="bridge-max" hidden>
    <table class="table table-hover table-sm table-bordered table-sm" style="margin-bottom: 20%">
        <thead class="text-center">
        <tr>
            <th scope="col">步数</th>
            <th scope="col">招法</th>
            <th scope="col">颜色</th>
            <th scope="col">备注</th>
        </tr>
        </thead>
        <tfoot class="text-center">
        <tr>
            <th scope="col">步数</th>
            <th scope="col">招法</th>
            <th scope="col">颜色</th>
            <th scope="col">备注</th>
        </tr>
        </tfoot>
        <tbody class="font-italic text-dark" style="font-size: 10px">
        </tbody>
    </table>
    <div class="btn-group btn-group-sm fixed-bottom " role="group">
        <button id="first" class="btn btn-primary" type="button">回到第一步</button>
        <button id="prev" class="btn btn-primary" type="button">上一步
        </button>
        <button id="next" class="btn btn-primary" type="button">下一步
        </button>
    </div>
</div>
</body>
<script>
    var step, size;
    var prev = $("#prev");
    var next = $("#next");
    $(function () {
        step = Number($("#bridge-index").val());
        size = Number($("#bridge-max").val());
        //加载之后
        ajax(step);
        $("#first").click(function () {
            step = 0;
            ajax(0);
            checkFirst(step, size);
        });
        checkFirst(step, size);
        prev.click(function () {
            ajax(--step);
            var $this = $(this);
            if (step - 1 < 0) {
                $this.prop('disabled', true);
            } else {
                $this.prop('disabled', false);
                next.prop('disabled', false);
            }
        });
        next.click(function () {
            ajax(++step);
            var $this = $(this);
            if (step + 1 > size) {
                $this.prop('disabled', true);
            } else {
                $this.prop('disabled', false);
                prev.prop('disabled', false);
            }
        })
    });

    function parseLog(data) {
        //给父层传值
        var bridge = parent.$("#bridge")
        bridge.val(data.before);
        bridge.trigger('change');
        const $tbody = $('tbody');
        var content = '';
        if (data.isFalse) {
            content += '<tr class="table-danger">';
        } else {
            content += '<tr>';
        }
        content += '<td>' + (Number(step) + 1) + '</td><td>' + data.trick + '</td>';
        if (data.color === 'z') {
            content += '<td class="text-center"><img src="/img/r_zu.png" width="20" height="20"></td>';
        } else if (data.color === 'Z') {
            content += '<td class="text-center"><img src="/img/b_zu.png" width="20" height="20"></td>';
        } else
            content += '<td></td>';
        content += '<td>' + data.message + '</td>';
        $tbody.append(content);
        $('html, body').animate({
            scrollTop: $('html, body').height()
        }, 5);
    }

    function ajax(step) {
        var cheepId = $("#bridge-cheep-id").val();
        $.get('/cheep/replay/step', {cheepId: cheepId, step: step}, function (data) {
            parseLog(data.data);
            //回传参数 坐标
        }, 'json');
        var path = '/cheep/replay/' + cheepId;
        //设置cookie
        $.cookie('index', step, {expires: 7, path: path})
    }

    function checkFirst(step, size) {
        if (step - 1 < 0) {
            prev.prop('disabled', true);
        }
        if (step + 1 > size) {
            next.prop('disabled', true)
        }
    }
</script>
</html>
