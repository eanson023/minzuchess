<%--
  Created by IntelliJ IDEA.
  User: yans
  Date: 2020-03-19
  Time: 20:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<hr>
<div id="create-team" class="container px-5">
    <div class="form-group row ">
        <label for="new-team-name2">请输入队伍名</label>
        <input id="new-team-name2" type="text" class="form-control" name="teamName" required autofocus>
        <div class="invalid-feedback">
            队伍名不正确
        </div>
    </div>
    <div class="form-group row ">
        <label for="province2">请选择省份</label>
        <select id="province2" class="custom-select province-select" name="provinceId">
            <option value="0" selected disabled>请选择省份</option>
        </select>
    </div>
    <div class="form-group row ">
        <label for="school2">请选择学校</label>
        <select id="school2" class="custom-select province-select" name="schoolId">
            <option selected disabled>请选择学校</option>
        </select>
    </div>
    <div class="form-group row ">
        <label for="number">请选择队伍规模</label>
        <select id="number" class="custom-select province-select" name="numbers">
            <option selected value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
        </select>
    </div>
    <div class="form-group row ">
        <label for="introduction2">队伍介绍</label>
        <textarea id="introduction2" class="form-control" name="introduction" rows="3" required></textarea>
        <div class="invalid-feedback">
            请输入4-200个文字介绍
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $.get('/get_province', {}, function (data) {
            $.each(data.data, function (i, e) {
                var content = '<option  value="' + e.proId + '">' + e.name + '</option>';
                $('#province2').append(content);
            });
        }, 'json');
        //加载学校
        $("#province2").change(function () {
            const pro_id = $("#province2 option:selected").val();
            $.get('/get_school', {pro_id: pro_id}, function (data) {
                $('#school2').empty();
                $.each(data.data, function (i, e) {
                    let content = '<option value="' + e.schId + '">' + e.name + '</option>';
                    $('#school2').append(content);
                })
            }, 'json');
        });

    })
</script>