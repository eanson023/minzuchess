<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>
<hr>
<footer id="footer" class="footer">
    <div class="container">
        <p class="float-lg-right"><a href="#top">回到顶部</a></p>
<%--        <div class="row mb-4">--%>
<%--            <a class="col-md-auto" href="">GitHub</a>--%>
<%--            <a class="col-md-auto">使用手册</a>--%>
<%--        </div>--%>
        <div class="row">
            <div class="col-lg-12">
                <p>网站作者: <a href="https://github.com/eanson1999">Eanson</a>.</p>
                <p>版权所有 &copy; <fmt:formatDate value="${now}" pattern="yyyy"/> &mdash; 小袁智育科技北京有限公司.</p>
<%--                <p>京ICP备<a href="http://beian.miit.gov.cn" target="_blank">08005119号-3</a>号.</p>--%>
            </div>
        </div>
    </div>
</footer>
