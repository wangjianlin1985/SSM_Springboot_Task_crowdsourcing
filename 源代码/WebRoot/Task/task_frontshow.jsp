<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Task" %>
<%@ page import="com.chengxusheji.po.TaskClass" %>
<%@ page import="com.chengxusheji.po.TaskState" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的taskClassObj信息
    List<TaskClass> taskClassList = (List<TaskClass>)request.getAttribute("taskClassList");
    //获取所有的taskStateObj信息
    List<TaskState> taskStateList = (List<TaskState>)request.getAttribute("taskStateList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Task task = (Task)request.getAttribute("task");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>查看任务详情</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li><a href="<%=basePath %>Task/frontlist">任务信息</a></li>
  		<li class="active">详情查看</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">任务id:</div>
		<div class="col-md-10 col-xs-6"><%=task.getTaskId()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">任务分类:</div>
		<div class="col-md-10 col-xs-6"><%=task.getTaskClassObj().getTaskClassName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">任务标题:</div>
		<div class="col-md-10 col-xs-6"><%=task.getTaskName()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">任务内容:</div>
		<div class="col-md-10 col-xs-6"><%=task.getTaskContent()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">任务文件:</div>
		<div class="col-md-10 col-xs-6"><a href="<%=basePath%><%=task.getTaskFile()%>" target="_blank"><%=task.getTaskFile().equals("")?"暂无文件":task.getTaskFile() %></a></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">任务赏金:</div>
		<div class="col-md-10 col-xs-6"><%=task.getTaskMoney()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">任务状态:</div>
		<div class="col-md-10 col-xs-6"><%=task.getTaskStateObj().getTaskStateName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">任务发布人:</div>
		<div class="col-md-10 col-xs-6"><%=task.getUserObj().getName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">任务发布时间:</div>
		<div class="col-md-10 col-xs-6"><%=task.getPublishTime()%></div>
	</div>
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="taskGet();" class="btn btn-primary">领取任务</button>
			<button onclick="history.back();" class="btn btn-info">返回</button>
		</div>
	</div>
</div> 
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";


function taskGet() {

	$.ajax({
		url : basePath + "TaskGet/userAdd",
		type : "post",
		dataType: "json",
		data: {
			"taskGet.taskObj.taskId": <%=task.getTaskId() %>,
		},
		success : function (data, response, status) {
			//var obj = jQuery.parseJSON(data);
			if(data.success){
				alert("领取成功~");
				location.reload();
			}else{
				alert(data.message);
			}
		}
	});
}


$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
 })
 </script> 
</body>
</html>

