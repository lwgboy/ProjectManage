<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户列表</title>
    <jsp:include page="/html/default/pub.jsp" />
    <script type="text/javascript" src="/js/common/inputSuggest.js" charset="utf-8"></script>
    <link href="/js/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="/js/bootstrap/js/bootstrap.min.js"></script>
    <style type="text/css">
        .suggest-container {border: 1px solid #C1C1C1;font-size: 12px;color: #333;background: #FFFFFF;visibility: hidden;}
        .suggest-item {padding: 3px 5px;}
        .suggest-active {background: #33CCFF;font-size: 16px;color: #050406;padding: 3px 5px;}
    </style>
    <script src="https://cdn.bootcss.com/jsencrypt/2.3.1/jsencrypt.min.js"></script>
</head>
<body>
<!-- 员工修改的模态框 -->
<div class="modal fade" id="userUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">用户修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="userName" class="form-control" id="userName_update_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">身份证</label>
                        <div class="col-sm-10">
                            <input type="text" name="identityNo" class="form-control" id="identity_update_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="1" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="0"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@adtec.com.cn">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">公司</label>
                        <div class="col-sm-4">
                            <select id="companySelectUpdate" class="form-control" name="companyId">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select id="deptSelectUpdate" class="form-control" name="deptId">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">角色</label>
                        <div class="col-sm-4">
                            <!-- 角色提交角色id即可 -->
                            <select id="roleSelectUpdate" class="form-control" name="roleId">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">手机号</label>
                        <div class="col-sm-10">
                            <input type="text" name="mobile" class="form-control" id="mobile_update_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="user_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>


<!-- 员工添加的模态框 -->
<div class="modal fade" id="userAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">用户添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="userName" class="form-control" id="userName_add_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">身份证</label>
                        <div class="col-sm-10">
                            <input type="text" name="idCard" class="form-control" id="idCard_add_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="1" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="0"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@adtec.com.cn">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">公司</label>
                        <div class="col-sm-4">
                            <select id="companySelectAdd" class="form-control" name="companyId">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select id="deptSelectAdd" class="form-control" name="deptId">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">角色</label>
                        <div class="col-sm-4">
                            <!-- 角色提交角色id即可 -->
                            <select id="roleSelectAdd" class="form-control" name="roleId">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">手机号</label>
                        <div class="col-sm-10">
                            <input type="text" name="mobile" class="form-control" id="mobile_add_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="password" name="originalPassword" class="form-control" id="password_add_input" onkeydown="return noBlank(event)">
                            <span class="help-block" id="lastBlock"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="user_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<!-- 搭建显示页面 -->
<div style="width: 1100px;">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">

        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-1">
            <button class="btn btn-primary" id="user_add_modal_btn" privilege-id="2">新增</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="users_table">
                <thead>
                <tr>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>部门角色</th>
                    <th>手机号</th>
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
    layer = layui.layer //弹层
    //获取当前用户的权限列表
    var privilegeList = ${user.privilegeList};
    //根据权限列表判断是否显示
    if (privilegeList.indexOf(2) == -1) {
        $("#user_add_modal_btn").hide();
    }
    var totalRecord, currentPage;

    function getEmilEnd() {
        var sinaSuggest = new InputSuggest({
            opacity: 1,
            input: document.getElementById('email_add_input'),
            data: ['adtec.com.cn']
        });
    }

    //1、页面加载完成以后，直接去发送ajax请求,要到分页数据
    $(function () {
        //去首页
        to_page(1);
    });

    function to_page(pn) {
        var index = layer.msg('拼命加载中', {
            icon: 16
            ,shade: 0.01
        });
        $.ajax({
            url: "/user/getUsers",
            data: "pn=" + pn+"&roleType=01",
            type: "GET",
            success: function (result) {
                //1、解析并显示员工数据
                build_users_table(result);
                //2、解析并显示分页信息
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
            var userName = $("<td></td>").append(item.userName);
            var gender = $("<td></td>").append(item.gender == '1' ? "男" : "女");
            var email = $("<td></td>").append(item.email);
            var mobile = $("<td></td>").append(item.mobile);
            var roleName = $("<td></td>").append(item.roleName);
            var userId = $("<td></td>").append(item.userId).hide().attr("userRoleId",item.userRoleId);
            /**
             <button class="">
             <span class="" aria-hidden="true"></span>
             编辑
             </button>
             */
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前用户id
            editBtn.attr("edit-id", item.userId);
            //添加属性权限ID
            editBtn.attr("privilege-id",3);
            //根据权限列表判断是否显示
            if (privilegeList.indexOf(3) == -1) {
                editBtn.hide();
            }
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性来表示当前删除的用户id
            delBtn.attr("del-id", item.userId);
            //添加属性权限ID
            delBtn.attr("privilege-id",4);
            //根据权限列表判断是否显示
            if (privilegeList.indexOf(4) == -1) {
                delBtn.hide();
            }
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //var delBtn =
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>")
                .append(userName)
                .append(gender)
                .append(email)
                .append(roleName)
                .append(mobile)
                .append(userId)
                .append(btnTd)
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
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }


        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
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
                to_page(item);
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

    //点击新增按钮弹出模态框。
    $("#user_add_modal_btn").click(function () {
        //清除表单数据（表单完整重置（表单的数据，表单的样式））
        reset_form("#userAddModal form");
        //s$("")[0].reset();
        getEmilEnd();
        //发送ajax请求，查出角色信息，显示在下拉列表中
        getRoles("#userAddModal #roleSelectAdd");
        //发送ajax请求，查出公司信息，显示在下拉列表中
        getCompanys("#userAddModal #companySelectAdd");
        //根据公司信息，查询出部门信息显示在下拉列表中
        getDepts("#userAddModal #deptSelectAdd");
        //弹出模态框
        $("#userAddModal").modal({
            backdrop: "static"
        });
    });


    //查出所有的角色信息并显示在下拉列表中
    function getRoles(ele) {
        //清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url: "/role/getSpecificRoles",
            data:{roleType:"01"},
            type: "POST",
            async: false,
            success: function (result) {
                //显示角色信息在下拉列表中
                $.each(result.extend.roleList, function () {
                    var optionEle = $("<option></option>").append(this.roleName).attr("value", this.roleId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //查出所有的公司信息并显示在下拉列表中
    function getCompanys(ele) {
        //清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url: "/company/getAllCompany",
            type: "POST",
            async: false,
            success: function (result) {
                //显示角色信息在下拉列表中
                $.each(result.extend.AllCompany, function () {
                    var optionEle = $("<option></option>").append(this.companyName).attr("value", this.companyId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //查出所属公司的所有部门信息并显示在下拉列表中
    function getDepts(ele) {
        //清空之前下拉列表的值
        $(ele).empty();
        if(ele.toString().indexOf("SelectAdd")>0) {
            var companyId = $("#companySelectAdd").val();
        }else{
            var companyId = $("#companySelectUpdate").val();
        }
        $.ajax({
            url: "/department/getDepartmentsByCompanyId",
            data:{companyId:companyId},
            type: "POST",
            async: false,
            success: function (result) {
                //显示部门信息在下拉列表中
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //部门根据公司改变而改变
    $("#companySelectAdd").change(function () {
        $("#deptSelectAdd").empty();
        var companyId = $("#companySelectAdd").val();
        $.ajax({
            url: "/department/getDepartmentsByCompanyId",
            data:{companyId:companyId},
            type: "POST",
            async: false,
            success: function (result) {
                //显示部门信息在下拉列表中
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo($("#deptSelectAdd"));
                });
            }
        });
    })


    //校验表单数据
    function validate_add_form() {
        //1、拿到要校验的数据，使用正则表达式
        var userName = $("#userName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,10}$)|(^[\u2E80-\u9FFF]{2,10})/;
        if (!regName.test(userName)) {
            show_validate_msg("#userName_add_input", "error", "用户名可以是2-10位中文或者6-10位英文和数字的组合");
            return false;
        } else {
            show_validate_msg("#userName_add_input", "success", "");
        }
        ;

        //2、校验邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }

        //3、校验密码
        var password = $("#password_add_input").val();
        var regPassword = /^[A-Za-z]+[0-9]+[A-Za-z0-9]*|[0-9]+[A-Za-z]+[A-Za-z0-9]*$/g;
        if (!regPassword.test(password)) {
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#password_add_input", "error", "密码必须由6-16位英文字母和数字的字符串组成!");
            return false;
        } else {
            show_validate_msg("#password_add_input", "success", "");
        }

        return true;
    }

    //显示校验结果的提示信息
    function show_validate_msg(ele, status, msg) {
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验邮箱是否可用
    $("#email_add_input").change(function () {
        //发送ajax请求校验邮箱是否可用
        var email = this.value;
        $.ajax({
            url: "/user/userCheck",
            data: "email=" + email,
            type: "POST",
            success: function (result) {
                if (result.code == "100") {
                    show_validate_msg("#email_add_input", "success", "邮箱可用");
                    $("#user_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#email_add_input", "error", result.extend.va_msg);
                    $("#user_save_btn").attr("ajax-va", "error");
                    return false;
                }
            }
        });
    });

    //点击保存，保存员工。
    $("#user_save_btn").click(function () {

        if (!validate_add_form()) {
            return false;
        }
        ;
        //1、判断之前的ajax邮箱校验是否成功。如果成功。
        if ($(this).attr("ajax-va") == "error") {
            show_validate_msg("#email_add_input", "error", "邮箱不可用");
            return false;
        }
        var originalPassword = $("#password_add_input").val();
        //2、发送ajax请求保存员工
        $.ajax({
            url: "/user/save",
            type: "POST",
            data: $("#userAddModal form").serialize()+"&password="+originalPassword,
            success: function (result) {
                //alert(result.msg);
                if (result.code == "100") {
                    //用户保存成功；
                    //1、关闭模态框
                    $("#userAddModal").modal('hide');


                    //2、来到最后一页，显示刚才保存的数据
                    //发送ajax请求显示最后一页数据即可
                    to_page(totalRecord);
                } else {
                    //有哪个字段的错误信息就显示哪个字段的；
                    if (undefined != result.extend.errorFields.email) {
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if (undefined != result.extend.errorFields.empName) {
                        //显示用户名字的错误信息
                        show_validate_msg("#userName_add_input", "error", result.extend.errorFields.userName);
                    }
                }
            }
        });
    });

    //jquery新版没有live，使用on进行替代
    $(document).on("click", ".edit_btn", function () {

        //清空表单样式
        $('#userUpdateModal form').find("*").removeClass("has-error has-success");
        $('#userUpdateModal form').find(".help-block").text("");

        //1、查出角色信息，并显示项目列表
        getRoles("#userUpdateModal #roleSelectUpdate");
        //发送ajax请求，查出公司信息，显示在下拉列表中
        getCompanys("#userUpdateModal #companySelectUpdate");
        //查出用户信息，显示用户信息
        getUser($(this).attr("edit-id"));


        //3、把员工的id传递给模态框的更新按钮
        $("#user_update_btn").attr("edit-id", $(this).attr("edit-id"));
        $("#userUpdateModal").modal({
            backdrop: "static"
        });
    });

    function getUser(id) {
        $.ajax({
            url: "/user/selectUserById",
            data:{id:id,roleType:"01"},
            type: "POST",
            success: function (result) {
                var userData = result.extend.user
                var hideEmail = result.extend.user.email
                $("#userName_update_input").val(userData.userName);
                $("#email_update_input").val(userData.email);
                $("#hideEmail").remove();
                $("#roleSelectUpdate").after($("<span></span>").attr("id","hideEmail").html(hideEmail));
                $("#hideEmail").hide();
                $("#userUpdateModal input[name=identityNo]").val([userData.identityNo]);
                $("#userUpdateModal input[name=gender]").val([userData.gender]);
                $("#userUpdateModal input[name=mobile]").val([userData.mobile]);
                $("#userUpdateModal input[name=password]").val([userData.password]);
                $("#userUpdateModal #roleSelectUpdate").val([userData.roleId]).attr("userRoleId",userData.userRoleId);
                $("#userUpdateModal #companySelectUpdate").val([userData.companyId]);
                //根据公司信息，查询出部门信息显示在下拉列表中
                getDepts("#userUpdateModal #deptSelectUpdate");
                $("#userUpdateModal #deptSelectUpdate").val([userData.deptId]);
            }
        });
    }

    //修改的部门根据公司改变而改变
    $("#companySelectUpdate").change(function () {
        $("#deptSelectUpdate").empty();
        var companyId = $("#companySelectUpdate").val();
        var email = $("#hideEmail").html();
        $.ajax({
            url: "/department/getDepartmentsByCompanyId",
            data:{companyId:companyId},
            type: "POST",
            async: false,
            success: function (result) {
                //显示部门信息在下拉列表中
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo($("#deptSelectUpdate"));
                });
            }
        });
    })

    //校验邮箱是否可用
    $("#email_update_input").change(function () {
        //发送ajax请求校验邮箱是否可用
        var email = this.value;
        var hideEmail = $("#hideEmail").html();
        $.ajax({
            url: "/user/userCheck",
            data: "email=" + email,
            type: "POST",
            success: function (result) {
                if (result.code == "100") {
                    show_validate_msg("#email_update_input", "success", "邮箱可用");
                    $("#user_update_btn").attr("ajax-va", "success");
                } else {
                    if(hideEmail == email){
                        show_validate_msg("#email_update_input", "success", "邮箱可用");
                        $("#user_update_btn").attr("ajax-va", "success");
                    }else {
                        show_validate_msg("#email_update_input", "error", result.extend.va_msg);
                        $("#user_update_btn").attr("ajax-va", "error");
                    }
                }
            }
        });
    });

    //点击更新，更新员工信息
    $("#user_update_btn").click(function () {
        //1、拿到要校验的数据，使用正则表达式
        var userName = $("#userName_update_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(userName)) {
            //alert("用户名可以是2-10位中文或者6-10位英文和数字的组合");
            show_validate_msg("#userName_update_input", "error", "用户名可以是2-10位中文或者6-10位英文和数字的组合");
            return false;
        } else {
            show_validate_msg("#userName_update_input", "success", "");
        }
        ;

        //2、校验邮箱信息
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }


        //1、判断之前的ajax邮箱校验是否成功。如果成功。
        if ($(this).attr("ajax-va") == "error") {
            show_validate_msg("#email_update_input", "error", "邮箱不可用");
            return false;
        }
        //2、发送ajax请求保存更新的员工数据
        $.ajax({
            url: "/user/update/" + $(this).attr("edit-id")+"/"+ $("#roleSelectUpdate").attr("userRoleId"),
            type: "PUT",
            data: $("#userUpdateModal form").serialize(),
            success: function (result) {
                //1、关闭对话框
                $("#userUpdateModal").modal("hide");
                //2、回到本页面
                to_page(currentPage);
            }
        });
    });

    //单个删除
    $(document).on("click", ".delete_btn", function () {
        //1、弹出是否确认删除对话框
        var userName = $(this).parents("tr").find("td:eq(0)").text();
        var userId = $(this).attr("del-id");
        var userRoleId = $(this).parents("tr").find("td:eq(5)").attr("userRoleId");
        layer.confirm("确认删除【" + userName + "】吗？", {icon: 3, title: '确认信息'}, function (index) {
            //确认，发送ajax请求删除即可
            $.ajax({
                url: "/user/delete/" + userId+"/"+userRoleId ,
                type: "DELETE",
                success: function (result) {
                    layer.msg(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            });
        })
    });

    //输入框密码不能输入空格
    function noBlank(e) {
        var keynum;
        var keychar;
        var numcheck;

        if(window.event) // IE
        {
            keynum = e.keyCode
        }
        else if(e.which) // Netscape/Firefox/Opera
        {
            keynum = e.which
        }
        keychar = String.fromCharCode(keynum);
        numcheck = /\s+/g;
        return !numcheck.test(keychar);
    }

</script>
</body>
</html>