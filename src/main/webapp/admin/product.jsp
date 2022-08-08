<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <script type="text/javascript">
        if ("${msg}" != "") {
            alert("${msg}");
        }
    </script>

    <c:remove var="msg"></c:remove>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bright.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addBook.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <title></title>
</head>
<script type="text/javascript">
    //全选复选框功能实现
    function allClick() {
        //获得当前点击后全选按钮的状态
        var flag = $("#all").prop("checked");
        //将此状态赋值给下面五个复选框
        $("input[name='ck']").each(function () {
            this.checked = flag;
        });
    }

    //单个复选框点击改变全选复选框功能实现
    function ckClick() {
        //得到下面五个复选框的个数
        var fiveLength = $("input[name='ck']").length;
        //得到下面五个复选框被选中的个数
        var checkedLength = $("input[name='ck']:checked").length;
        //进行对比,改变全选复选框的状态
        if(fiveLength == checkedLength){
            $("#all").prop("checked",true);
        }else{
            $("#all").prop("checked",false);
        }
    }
</script>
<body>
<div id="brall">
    <div id="nav">
        <p>product>list</p>
    </div>
    <div id="condition" style="text-align: center">
        <form id="myform">
            name：<input name="pname" id="pname">&nbsp;&nbsp;&nbsp;
            type：<select name="typeid" id="typeid">
            <option value="-1">choose:</option>
            <c:forEach items="${typeList}" var="pt">
                <option value="${pt.typeId}">${pt.typeName}</option>
            </c:forEach>
        </select>&nbsp;&nbsp;&nbsp;
            price：<input name="lprice" id="lprice">-<input name="hprice" id="hprice">
            <input type="button" value="search" onclick="condition()">
        </form>
    </div>
    <br>
    <div id="table">

        <c:choose>
            <c:when test="${info.list.size()!=0}">

                <div id="top">
                    <input type="checkbox" id="all" onclick="allClick()" style="margin-left: 50px">&nbsp;&nbsp;全选
                    <a href="${pageContext.request.contextPath}/admin/addproduct.jsp">

                        <input type="button" class="btn btn-warning" id="btn1"
                               value="addProduct">
                    </a>
                    <input type="button" class="btn btn-warning" id="btn1"
                           value="deleteMany" onclick="deleteBatch()">
                </div>
                <!--显示分页后的商品-->
                <div id="middle">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th></th>
                            <th>name</th>
                            <th>description</th>
                            <th>price（$）</th>
                            <th>picture</th>
                            <th>count</th>
                            <th>operation</th>
                        </tr>
                        <c:forEach items="${info.list}" var="p">
                            <tr>
                                <td valign="center" align="center">
                                    <input type="checkbox" name="ck" id="ck" value="${p.pId}" onclick="ckClick()"></td>
                                <td>${p.pName}</td>
                                <td>${p.pContent}</td>
                                <td>${p.pPrice}</td>
                                <td><img width="55px" height="45px"
                                         src="${pageContext.request.contextPath}/image_big/${p.pImage}"></td>
                                <td>${p.pNumber}</td>
                                    <%--<td><a href="${pageContext.request.contextPath}/admin/product?flag=delete&pid=${p.pId}" onclick="return confirm('确定删除吗？')">删除</a>--%>
                                    <%--&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/admin/product?flag=one&pid=${p.pId}">修改</a></td>--%>
                                <td>
                                    <button type="button" class="btn btn-info "
                                            onclick="one(${p.pId},${info.pageNum})">edit
                                    </button>
                                    <button type="button" class="btn btn-warning" id="mydel"
                                            onclick="del(${p.pId},${info.pageNum})">delete
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <!--分页栏-->
                    <div id="bottom">
                        <div>
                            <nav aria-label="..." style="text-align:center;">
                                <ul class="pagination">
                                    <li>
                                            <%-- <a href="${pageContext.request.contextPath}/prod/split.action?page=${info.prePage}" aria-label="Previous">--%>
                                        <a href="javascript:ajaxsplit(${info.prePage})" aria-label="Previous">

                                            <span aria-hidden="true">«</span></a>
                                    </li>
                                    <c:forEach begin="1" end="${info.pages}" var="i">
                                        <c:if test="${info.pageNum==i}">
                                            <li>
                                                    <%-- <a href="${pageContext.request.contextPath}/prod/split.action?page=${i}" style="background-color: grey">${i}</a>--%>
                                                <a href="javascript:ajaxsplit(${i})"
                                                   style="background-color: red">${i}</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${info.pageNum!=i}">
                                            <li>
                                                    <%--   <a href="${pageContext.request.contextPath}/prod/split.action?page=${i}">${i}</a>--%>
                                                <a href="javascript:ajaxsplit(${i})">${i}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <li>
                                            <%--  <a href="${pageContext.request.contextPath}/prod/split.action?page=1" aria-label="Next">--%>
                                        <a href="javascript:ajaxsplit(${info.nextPage})" aria-label="Next">
                                            <span aria-hidden="true">»</span></a>
                                    </li>
                                    <li style=" margin-left:150px;color: #0e90d2;height: 35px; line-height: 35px;">Total&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${info.pages}</font>&nbsp;&nbsp;&nbsp;page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <c:if test="${info.pageNum!=0}">
                                            now&nbsp;&nbsp;<font
                                            style="color:orange;">${info.pageNum}</font>&nbsp;&nbsp;&nbsp;page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                        <c:if test="${info.pageNum==0}">
                                            now&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">1</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div>
                    <h2 style="width:1200px; text-align: center;color: orangered;margin-top: 100px">no product for your choice！</h2>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>

<script type="text/javascript">
    function mysubmit() {
        $("#myform").submit();
    }

    //批量删除
    function deleteBatch() {
        //得到所有选中复选框的对象,根据其长度判断是否有选中商品
        var cks = $("input[name='ck']:checked");  //1,4,5
        //如果有选中的商品
        if(cks.length == 0){
            alert("请先选择将要删除的商品!");
        }else{
            var str = "";
            var pid = "";
            if(confirm("do you want to delete "+cks.length+"products?")){
               // alert("可以进行删除!");
                //获取其value的值,进行字符串拼接
                $.each(cks,function () {
                    pid = $(this).val();
                    //进行非空判断,避免出错
                    if(pid != null){
                        str += pid+",";  //145   ===>1,4,5,
                    }
                });

                //发送ajax请求,进行批量删除的提交
                $.ajax({
                    url:"${pageContext.request.contextPath}/prod/deleteBatch.action",
                    data:{"pids":str},
                    type:"post",
                    dataType:"text",
                    success:function (msg) {
                        alert(msg);//批量删除成功!失败!不可删除!
                        //将页面上显示商品数据的容器重新加载
                        $("#table").load("http://localhost:8000/minissm/admin/product.jsp#table");
                    }
                });
            }
        }
    }

    //单个删除
    function del(pid,page) {
        //弹框提示
        if (confirm("Are you sure to delete this item ?")) {
            //发出ajax的请求,进行删除操作
            //取出查询条件
            var pname = $("#pname").val();
            var typeid = $("#typeid").val();
            var lprice = $("#lprice").val();
            var hprice = $("#hprice").val();
            $.ajax({
                url: "${pageContext.request.contextPath}/prod/delete.action",
                data: {"pid": pid,"page": page,"pname":pname,"typeid":typeid,"lprice":lprice,"hprice":hprice},
                // data:{"pid":pid},
                type: "post",
                dataType: "text",
                success: function (msg) {
                    alert(msg);
                    $("#table").load("http://localhost:8000/minissm/admin/product.jsp#table");
                }
            });
        }
    }

    function one(pid,page) {
        //取出查询条件
        var pname = $("#pname").val();
        var typeid = $("#typeid").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();
        //向服务器提交请求,传递商品id  //?key=value&key=value

        <%--location.href = "${pageContext.request.contextPath}/prod/one.action?pid="+pid ;--%>
        var str ="?pid="+pid+"&page="+page+"&pname="+pname+"&typeid="+typeid+"&lprice="+lprice+"&hprice="+hprice;
        location.href = "${pageContext.request.contextPath}/prod/one.action"+str;
        console.log("location.href ",location.href) // location.href  http://localhost:8000/minissm/prod/split.action
    }
</script>
<!--分页的AJAX实现-->
<script type="text/javascript">
    function ajaxsplit(page) {
        //取出查询条件
        var pname = $("#pname").val();
        var typeid = $("#typeid").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();
        //向服务发出ajax请求,请示page页中的所有数据,在当前页面上局部刷新显示
        $.ajax({
            url: "${pageContext.request.contextPath}/prod/ajaxSplit.action",
            data: {"page": page,"pname":pname,"typeid":typeid,"lprice":lprice,"hprice":hprice},
                // "pname":pname,"typeid":typeid,"lprice":lprice,"hprice":hprice},
            type: "post",
            success: function () {
                //重新加载显示分页数据的容器
                $("#table").load("http://localhost:8000/minissm/admin/product.jsp#table");
            }
        });

    }

    function condition() {
        //取出查询条件
        var pname = $("#pname").val();
        var typeid = $("#typeid").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();
        $.ajax({
            type:"post",
           /* url:"${pageContext.request.contextPath}/prod/condition.action",*/
            url:"${pageContext.request.contextPath}/prod/ajaxSplit.action",
            data:{"pname":pname,"typeid":typeid,"lprice":lprice,"hprice":hprice},
            success:function () {
                //刷新显示数据的容器
                $("#table").load("http://localhost:8000/minissm/admin/product.jsp#table");
            }
        });
    }
</script>

</html>
