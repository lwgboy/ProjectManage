<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>项目成员列表</title>
    <jsp:include page="/html/default/pub.jsp"/>
    <link href="/js/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="/js/bootstrap/js/bootstrap.min.js"></script>
    <style type="text/css">
        .selectShow{width: 200px;height: 27px;border: 1px solid #ccc;border-radius: 4px;}
    </style>
</head>
<body>
<!-- 搭建显示页面 -->
<div style="width: 1100px;">
    <!-- 标题 -->
    <div class="row">

    </div>
    <!-- 按钮 -->
    <div class="row" onkeyup="keyOnClick()">
        <div class="col-md-10">
            <button class="btn btn-primary" onclick="history.go(-1)">返回</button>
            &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="user-name">
            <button class="btn btn-warning" id="user_search_btn">搜索</button>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <button class="btn btn-primary" id="user_save_btn">保存</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-10">
            <table class="table table-hover" id="users_table">
                <thead>
                <tr>
                    <th>选择</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>手机号</th>
                    <th>项目角色</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <!-- 显示分页信息 -->
    <div class="row">
        <!--分页文字信息  -->
        <div class="col-md-6" id="page_info_area"></div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>

</div>
<script type="text/javascript">
    var projectId = (window.location.search).split("=")[1];
    layer = layui.layer //弹层
    var totalRecord, currentPage;
    var selectRoles = $("<select id='selectRoles' ></select>");
        $(function () {
            //查询角色列表
            getProjectRoles(selectRoles);
        });

    function getProjectRoles(ele) {
        $.ajax({
            url: "/role/getSpecificRoles",
            data: {roleType: "00"},
            type: "POST",
            async: false,
            success: function (result) {
                //显示角色信息在下拉列表中
                $.each(result.extend.roleList, function () {
                    var optionEle = $("<option></option>").append(this.roleName).attr("value", this.roleId);
                    optionEle.appendTo(ele);
                });
                ele.appendTo($("#user_save_btn")).hide();
            }
        });
    }

    //点击搜索，查询用户列表
    $(document).on("click", "#user_search_btn", function () {
        var userName = $("#user-name").val();
        to_page(1, userName);
    });

    function to_page(pn, userName) {
        params = "userName=" + userName + "&pn=" + pn;
        var index = layer.msg('拼命加载中', {
            icon: 16
            ,shade: 0.01
        });
        $.ajax({
            url: "/user/getUserInfoByUserName",
            data: params,
            type: "POST",
            success: function (result) {
                //1、解析并显示项目成员数据
                build_users_table(result);
                //2、解析并显示项目信息
                build_page_info(result);
                //3、解析显示分页条数据
                build_page_nav(result);
                layer.close(index);
            }
        });
    }

    function build_users_table(result) {
        //清空table表格
        $("#users_table tbody").empty();
        var users = result.extend.pageInfo.list;
        $.each(users, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var userName = $("<td></td>").append(item.userName);
            var gender = $("<td></td>").append(item.gender == '1' ? "男" : "女");
            var email = $("<td></td>").append(item.email);
            var mobile = $("<td></td>").append(item.mobile);
            var userId = $("<td></td>").append(item.userId).hide();
            var selectProjectRoles = $("<td></td>").append($("#selectRoles").clone().removeAttr("style").addClass("selectShow"));

            //var delBtn =
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(userName)
                .append(gender)
                .append(email)
                .append(mobile)
                .append(userId)
                .append(selectProjectRoles)
                .appendTo("#users_table tbody");
        });
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum + "页,总" +
            result.extend.pageInfo.pages + "页,总" +
            result.extend.pageInfo.total + "条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析显示分页条，点击分页要能去下一页....
    function build_page_nav(result) {
        //page_nav_area
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素添加点击翻页的事件
            firstPageLi.click(function () {
                to_page(1, $("#user-name").val());
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1, $("#user-name").val());
            });
        }


        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1, $("#user-name").val());
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages, $("#user-name").val());
            });
        }


        //添加首页和前一页 的提示
        ul.append(firstPageLi).append(prePageLi);
        //1,2，3遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item, $("#user-name").val());
            });
            ul.append(numLi);
        });
        //添加下一页和末页 的提示
        ul.append(nextPageLi).append(lastPageLi);

        //把ul加入到nav
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    //清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //保存
    $(document).on("click", "#user_save_btn", function () {
        //1、弹出是否确认保存对话框
        var userNames = "";
        var save_idstr = "";
        var save_roleIds = "";
        $.each($(".check_item:checked"), function () {
            //this
            userNames += $(this).parents("tr").find("td:eq(1)").text() + ",";
            //组装员工id字符串
            save_idstr += $(this).parents("tr").find("td:eq(5)").text() + "-";
            //组装角色类型字符串
            save_roleIds += $(this).parents("tr").find("td:eq(6)").children("select").val() + "-";
        });
        //去除userNames多余的,
        userNames = userNames.substring(0, userNames.length - 1);
        //去除save_idstr多余的-
        save_idstr = save_idstr.substring(0, save_idstr.length - 1);
        //去除save_roleTypes多余的-
        save_roleIds = save_roleIds.substring(0, save_roleIds.length - 1);
        if (userNames.length > 0) {
            layer.confirm('确定添加吗？', {icon: 3, title: '确认信息'}, function (index) {
                //确认，发送ajax请求删除即可
                $.ajax({
                    url: "/project/projectUserSave",
                    type: "GET",
                    data: "ids=" + save_idstr + "&projectId=" + projectId+"&roleIds=" + save_roleIds,
                    success: function (result) {
                        if (result.length > 0) {
                            layer.msg(result[0].currentUserName + " 邮箱:" + result[0].currentUserEmail + "已经在"+result[0].projectName+"！");
                        } else {
                            //回到项目详情页
                            window.history.go(-1);
                        }

                    }
                });
            });
        } else {
            layer.msg("请选择用户！")
        }
    });

    //回车键触发搜索
    function keyOnClick(e) {
        //考虑浏览器兼容性
        var theEvent = window.event || e;
        var code = theEvent.keyCode || theEvent.which;
        if (code == 13) {  //回车键的键值为13
            var userName = $("#user-name").val();
            to_page(1, userName);  //调用搜索方法
        }
    }

</script>
</body>
</html>