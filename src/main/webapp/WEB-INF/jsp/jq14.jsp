<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-15
  Time: 19:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>#火焰棋云棋盘3.0</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css"/>
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/layer.js"></script>
    <style>
        body {
            margin: 10px;
            text-align: center;
        }

        #board {
            margin: 0px auto;
            position: relative;
            text-align: center;
            width: 960px;
            height: 600px;
        }

        .chess {
            transition: all 1s;
        }

        #ju1 {
            position: absolute;
            top: 30px;
            left: 30px;
        }

        #ju2 {
            position: absolute;
            top: 30px;
            left: 90px;
        }

        #ju3 {
            position: absolute;
            top: 30px;
            left: 180px;
        }

        .div-a {
            position: absolute;
            left: 20px;
            top: 20px;
            width: 100px;
            height: 720px;
        }

        .div-d {
            position: absolute;
            left: 20px;
            bottom: 20px;
            width: 100px;
            height: 100px;
        }

        .div-e {
            position: absolute;
            left: 140px;
            bottom: 20px;
            width: 300px;
            height: 50px;
            background: none;
            border: 0;
            font-size: 8px;
            text-align: left;
            line-height: 1.36;
            color: #fff;
        }


        .div-x {
            position: absolute;
            right: 0px;
            bottom: 0px;
            width: 80px;
            height: 100px;
        }

        .div-b {
            position: absolute;
            right: 0px;
            top: 0px;
            background-image: url(/img/xiaoyuan/flamemind.png);
            width: 138px;
            height: 408px;
        }

        .div-c {
            position: absolute;
            right: 46px;
            top: 350px;
            background-image: url(/img/xiaoyuan/flamemind2.png);
            width: 71px;
            height: 312px;
            font-family: 楷体_GB2312;
            font-size: 36px;
        }


    </style>
</head>
<body id="bd" background="/img/xiaoyuan/wangelement.gif">

<div id="diva" class="div-a">
</div>

<script type="text/javascript">
    var diva = document.getElementById("diva");
    diva.style.height = window.innerHeight - 20 + "px";
</script>

<div id="divd" class="div-d">
</div>
<div id="dive" class="div-e">
    alert msg
</div>

<div class="div-b"><img src="/img/xiaoyuan/target.png" boarder=0></div>
<div id="divc" class="div-c" style="color:#ff5812; text-align:center"></div>

<script type="text/javascript">
    var divc = document.getElementById("divc");
    divc.innerText = "" //nm;
    divc.style.height = window.innerHeight - 350 + "px";
</script>

<div id="divx" class="div-x">
</div>
<div id="board"></div>
<div id="size" style="width: 64px;height: 236px;top: 24px;right: 156px;position: absolute;"></div>
<div id="pc" style="width: 79px;height: 81px;top:420px;left: 150px;position: absolute"></div>

<script src="/js/script.js"></script>
<script src="/js/fcscript.js"></script>
<script src="/js/jscript.js"></script>
<script src="/js/main.js"></script>
</body>
</html>
