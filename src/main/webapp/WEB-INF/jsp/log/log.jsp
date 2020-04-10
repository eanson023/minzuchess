<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-16
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>#云棋盘日志</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css"/>
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
</head>
<body>
<div>
    <form>
        <div class="input-group">
            <input type="number" min="1" max="1000" class="form-control" placeholder="你可以输入要查询的条数"
                   aria-describedby="button-addon2" required>
            <div class="input-group-append button-addon2">
                <button id="search" class="btn btn-info btn-outline-secondary text-white" type="submit">查询</button>
                <c:if test="${requestScope.isChess}">
                    <button id="reset" class="btn btn-danger btn-outline-secondary text-white" type="button">重置棋盘
                    </button>
                    <button id="clear" class="btn btn-warning btn-outline-secondary text-white" type="button">清空记谱缓存
                    </button>
                </c:if>
            </div>
        </div>
    </form>
    <table class="table table-hover table-sm table-striped table-bordered table-sm">
        <thead class="text-center">
        <tr>
            <th scope="col">#</th>
            <th scope="col">招法</th>
            <th scope="col">颜色</th>
            <th scope="col">时间</th>
            <th scope="col">备注</th>
            <c:if test="${requestScope.isChess}">
                <th scope="col">操作</th>
            </c:if>
        </tr>
        </thead>
        <tfoot class="text-center">
        <tr>
            <th scope="col">#</th>
            <th scope="col">招法</th>
            <th scope="col">颜色</th>
            <th scope="col">时间</th>
            <th scope="col">备注</th>
            <c:if test="${requestScope.isChess}">
                <th scope="col">操作</th>
            </c:if>
        </tr>
        </tfoot>
        <tbody class="font-italic text-dark" style="font-size: 10px">
        <c:forEach items="${requestScope.log}" var="log" varStatus="s">
            <c:choose>
                <c:when test="${log.isFalse}">
                    <tr class="table-danger">
                </c:when>
                <c:otherwise>
                    <tr class="table-info">
                </c:otherwise>
            </c:choose>
            <td>${s.index+1}</td>
            <td>${log.trick}</td>
            <td class="text-center">
                <c:choose>
                    <c:when test="${log.color=='z'}">
                        <img src="/img/r_zu.png" width="20" height="20">
                    </c:when>
                    <c:when test="${log.color=='Z'}">
                        <img src="/img/b_zu.png" width="20" height="20">
                    </c:when>
                </c:choose>
            </td>
            <td>${log.createTime}</td>
            <td>${log.message}</td>
            <c:if test="${requestScope.isChess}">
                <td>
                    <button type="button" target="/chess/go_back/${requestScope.code}/${log.logId}"
                            class="btn btn-link btn-sm" onclick="back(this)">Back
                    </button>
                </td>
            </c:if>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $(function () {
        <c:choose>
        <c:when test="${requestScope.isChess}">
        $('form').submit(function () {
            const num = $('form input').val();
            $('tbody').empty();
            $.get('/chess/log', {code: '${requestScope.code}', num: num}, function (data) {
                parseLog(data);
            }, 'json');
            return false;
        });
        $("#reset").click(function () {
            $.post('/chess/reset', {code: '${requestScope.code}'});
        });
        $("#clear").click(function () {
            $.post('/chess/clear_cache', {code: '${requestScope.code}'});
        });
        </c:when>
        <c:otherwise>
        $('form').submit(function () {
            const num = $('form input').val();
            $('tbody').empty();
            $.get('/chess/log', {alias: '${requestScope.alias}', num: num}, function (data) {
                parseLog(data);
            }, 'json');
            return false;
        });
        </c:otherwise>
        </c:choose>
        initWebSocket();
    });

    function parseLog(log) {
        const $tbody = $('tbody');
        //选择最后个tr 找到索引
        var index = $('table tr').last().children('td')[0];
        var $index = $(index).text();
        if ($index === '')
            $index = 0;
        $.each(log, function (index, data) {
            var content = '';
            if (data.isFalse) {
                content += '<tr class="table-danger">';
            } else {
                content += '<tr class="table-info">';
            }
            content += '<td>' + ++$index + '</td><td>' + data.trick + '</td>';
            if (data.color === 'z') {
                content += '<td class="text-center"><img src="/img/r_zu.png" width="20" height="20"></td>';
            } else if (data.color === 'Z') {
                content += '<td class="text-center"><img src="/img/b_zu.png" width="20" height="20"></td>';
            } else
                content += '<td></td>';
            content += '<td>' + data.createTime + '</td><td>' + data.message + '</td>';
            <c:if test="${requestScope.isChess}">
            content += '<td><button type="button" target="/chess/go_back/${requestScope.code}/' + data.logId + '" class="btn btn-link btn-sm" onclick="back(this)">Back</button></td>';
            </c:if>
            $tbody.append(content);
            $('html, body').animate({
                scrollTop: $('html, body').height()
            }, 5);
        })
    }

    function initWebSocket() {
        if ("WebSocket" in window) {
            // 打开一个 web socket
            var ws;
            <c:choose>
            <c:when test="${requestScope.isChess}">
            ws = new WebSocket("ws://" + location.host + "/jq/log_socket?code=${requestScope.code}");
            </c:when>
            <c:otherwise>
            ws = new WebSocket("ws://" + location.host + "/jq/log_socket?alias=${requestScope.alias}");
            </c:otherwise>
            </c:choose>
            ws.onmessage = function (evt) {
                var received_msg = evt.data;
                var parse = JSON.parse(received_msg);
                parseLog(parse);
            };
            ws.onclose = function () {
                // 关闭 websocket
                alert("连接已关闭...");
            };
            ws.onerror = function () {
                alert('出现错误');
            }
        } else {
            // 浏览器不支持 WebSocket
            alert("您的浏览器不支持 WebSocket!");
        }
    }

    function back(e) {
        var $this = $(e);
        var href = $this.attr('target');
        $.post(href, {})
    }
</script>
</body>
</html>