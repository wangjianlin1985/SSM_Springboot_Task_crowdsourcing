<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Task" %>
<%@ page import="com.chengxusheji.po.TaskClass" %>
<%@ page import="com.chengxusheji.po.TaskState" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Task> taskList = (List<Task>)request.getAttribute("taskList");
    //获取所有的taskClassObj信息
    List<TaskClass> taskClassList = (List<TaskClass>)request.getAttribute("taskClassList");
    //获取所有的taskStateObj信息
    List<TaskState> taskStateList = (List<TaskState>)request.getAttribute("taskStateList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    TaskClass taskClassObj = (TaskClass)request.getAttribute("taskClassObj");
    String taskName = (String)request.getAttribute("taskName"); //任务标题查询关键字
    TaskState taskStateObj = (TaskState)request.getAttribute("taskStateObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String publishTime = (String)request.getAttribute("publishTime"); //任务发布时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>任务查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#taskListPanel" aria-controls="taskListPanel" role="tab" data-toggle="tab">任务列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Task/task_frontAdd.jsp" style="display:none;">添加任务</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="taskListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>任务id</td><td>任务分类</td><td>任务标题</td><td>任务文件</td><td>任务赏金</td><td>任务状态</td><td>任务发布人</td><td>任务发布时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<taskList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Task task = taskList.get(i); //获取到任务对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=task.getTaskId() %></td>
 											<td><%=task.getTaskClassObj().getTaskClassName() %></td>
 											<td><%=task.getTaskName() %></td>
 											<td><%=task.getTaskFile().equals("")?"暂无文件":"<a href='" + basePath + task.getTaskFile() + "' target='_blank'>" + task.getTaskFile() + "</a>"%>
 											<td><%=task.getTaskMoney() %></td>
 											<td><%=task.getTaskStateObj().getTaskStateName() %></td>
 											<td><%=task.getUserObj().getName() %></td>
 											<td><%=task.getPublishTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Task/<%=task.getTaskId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="taskEdit('<%=task.getTaskId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="taskDelete('<%=task.getTaskId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>任务查询</h1>
		</div>
		<form name="taskQueryForm" id="taskQueryForm" action="<%=basePath %>Task/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="taskClassObj_taskClassId">任务分类：</label>
                <select id="taskClassObj_taskClassId" name="taskClassObj.taskClassId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(TaskClass taskClassTemp:taskClassList) {
	 					String selected = "";
 					if(taskClassObj!=null && taskClassObj.getTaskClassId()!=null && taskClassObj.getTaskClassId().intValue()==taskClassTemp.getTaskClassId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=taskClassTemp.getTaskClassId() %>" <%=selected %>><%=taskClassTemp.getTaskClassName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="taskName">任务标题:</label>
				<input type="text" id="taskName" name="taskName" value="<%=taskName %>" class="form-control" placeholder="请输入任务标题">
			</div>






            <div class="form-group">
            	<label for="taskStateObj_taskStateId">任务状态：</label>
                <select id="taskStateObj_taskStateId" name="taskStateObj.taskStateId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(TaskState taskStateTemp:taskStateList) {
	 					String selected = "";
 					if(taskStateObj!=null && taskStateObj.getTaskStateId()!=null && taskStateObj.getTaskStateId().intValue()==taskStateTemp.getTaskStateId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=taskStateTemp.getTaskStateId() %>" <%=selected %>><%=taskStateTemp.getTaskStateName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">任务发布人：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="publishTime">任务发布时间:</label>
				<input type="text" id="publishTime" name="publishTime" class="form-control"  placeholder="请选择任务发布时间" value="<%=publishTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="taskEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;任务信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="taskEditForm" id="taskEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="task_taskId_edit" class="col-md-3 text-right">任务id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="task_taskId_edit" name="task.taskId" class="form-control" placeholder="请输入任务id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="task_taskClassObj_taskClassId_edit" class="col-md-3 text-right">任务分类:</label>
		  	 <div class="col-md-9">
			    <select id="task_taskClassObj_taskClassId_edit" name="task.taskClassObj.taskClassId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="task_taskName_edit" class="col-md-3 text-right">任务标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="task_taskName_edit" name="task.taskName" class="form-control" placeholder="请输入任务标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="task_taskContent_edit" class="col-md-3 text-right">任务内容:</label>
		  	 <div class="col-md-9">
			 	<textarea name="task.taskContent" id="task_taskContent_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="task_taskFile_edit" class="col-md-3 text-right">任务文件:</label>
		  	 <div class="col-md-9">
			    <a id="task_taskFileA" target="_blank"></a><br/>
			    <input type="hidden" id="task_taskFile" name="task.taskFile"/>
			    <input id="taskFileFile" name="taskFileFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="task_taskMoney_edit" class="col-md-3 text-right">任务赏金:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="task_taskMoney_edit" name="task.taskMoney" class="form-control" placeholder="请输入任务赏金">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="task_taskStateObj_taskStateId_edit" class="col-md-3 text-right">任务状态:</label>
		  	 <div class="col-md-9">
			    <select id="task_taskStateObj_taskStateId_edit" name="task.taskStateObj.taskStateId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="task_userObj_user_name_edit" class="col-md-3 text-right">任务发布人:</label>
		  	 <div class="col-md-9">
			    <select id="task_userObj_user_name_edit" name="task.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="task_publishTime_edit" class="col-md-3 text-right">任务发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date task_publishTime_edit col-md-12" data-link-field="task_publishTime_edit">
                    <input class="form-control" id="task_publishTime_edit" name="task.publishTime" size="16" type="text" value="" placeholder="请选择任务发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#taskEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxTaskModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var task_taskContent_edit = UE.getEditor('task_taskContent_edit'); //任务内容编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.taskQueryForm.currentPage.value = currentPage;
    document.taskQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.taskQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.taskQueryForm.currentPage.value = pageValue;
    documenttaskQueryForm.submit();
}

/*弹出修改任务界面并初始化数据*/
function taskEdit(taskId) {
	$.ajax({
		url :  basePath + "Task/" + taskId + "/update",
		type : "get",
		dataType: "json",
		success : function (task, response, status) {
			if (task) {
				$("#task_taskId_edit").val(task.taskId);
				$.ajax({
					url: basePath + "TaskClass/listAll",
					type: "get",
					success: function(taskClasss,response,status) { 
						$("#task_taskClassObj_taskClassId_edit").empty();
						var html="";
		        		$(taskClasss).each(function(i,taskClass){
		        			html += "<option value='" + taskClass.taskClassId + "'>" + taskClass.taskClassName + "</option>";
		        		});
		        		$("#task_taskClassObj_taskClassId_edit").html(html);
		        		$("#task_taskClassObj_taskClassId_edit").val(task.taskClassObjPri);
					}
				});
				$("#task_taskName_edit").val(task.taskName);
				task_taskContent_edit.setContent(task.taskContent, false);
				$("#task_taskFile").val(task.taskFile);
				$("#task_taskFileA").text(task.taskFile);
				$("#task_taskFileA").attr("href", basePath +　task.taskFile);
				$("#task_taskMoney_edit").val(task.taskMoney);
				$.ajax({
					url: basePath + "TaskState/listAll",
					type: "get",
					success: function(taskStates,response,status) { 
						$("#task_taskStateObj_taskStateId_edit").empty();
						var html="";
		        		$(taskStates).each(function(i,taskState){
		        			html += "<option value='" + taskState.taskStateId + "'>" + taskState.taskStateName + "</option>";
		        		});
		        		$("#task_taskStateObj_taskStateId_edit").html(html);
		        		$("#task_taskStateObj_taskStateId_edit").val(task.taskStateObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#task_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#task_userObj_user_name_edit").html(html);
		        		$("#task_userObj_user_name_edit").val(task.userObjPri);
					}
				});
				$("#task_publishTime_edit").val(task.publishTime);
				$('#taskEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除任务信息*/
function taskDelete(taskId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Task/deletes",
			data : {
				taskIds : taskId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#taskQueryForm").submit();
					//location.href= basePath + "Task/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交任务信息表单给服务器端修改*/
function ajaxTaskModify() {
	$.ajax({
		url :  basePath + "Task/" + $("#task_taskId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#taskEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#taskQueryForm").submit();
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

    /*任务发布时间组件*/
    $('.task_publishTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

