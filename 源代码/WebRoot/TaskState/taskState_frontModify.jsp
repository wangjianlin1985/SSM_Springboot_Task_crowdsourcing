<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.TaskState" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    TaskState taskState = (TaskState)request.getAttribute("taskState");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改任务状态信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">任务状态信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="taskStateEditForm" id="taskStateEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="taskState_taskStateId_edit" class="col-md-3 text-right">状态id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="taskState_taskStateId_edit" name="taskState.taskStateId" class="form-control" placeholder="请输入状态id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="taskState_taskStateName_edit" class="col-md-3 text-right">状态名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="taskState_taskStateName_edit" name="taskState.taskStateName" class="form-control" placeholder="请输入状态名称">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxTaskStateModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#taskStateEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改任务状态界面并初始化数据*/
function taskStateEdit(taskStateId) {
	$.ajax({
		url :  basePath + "TaskState/" + taskStateId + "/update",
		type : "get",
		dataType: "json",
		success : function (taskState, response, status) {
			if (taskState) {
				$("#taskState_taskStateId_edit").val(taskState.taskStateId);
				$("#taskState_taskStateName_edit").val(taskState.taskStateName);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交任务状态信息表单给服务器端修改*/
function ajaxTaskStateModify() {
	$.ajax({
		url :  basePath + "TaskState/" + $("#taskState_taskStateId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#taskStateEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "TaskState/frontlist";
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    taskStateEdit("<%=request.getParameter("taskStateId")%>");
 })
 </script> 
</body>
</html>

