<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.TaskGet" %>
<%@ page import="com.chengxusheji.po.Task" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<TaskGet> taskGetList = (List<TaskGet>)request.getAttribute("taskGetList");
    //获取所有的taskObj信息
    List<Task> taskList = (List<Task>)request.getAttribute("taskList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Task taskObj = (Task)request.getAttribute("taskObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String getTime = (String)request.getAttribute("getTime"); //领取任务时间查询关键字
    String handleState = (String)request.getAttribute("handleState"); //处理状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>任务领取查询</title>
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
			    	<li role="presentation" class="active"><a href="#taskGetListPanel" aria-controls="taskGetListPanel" role="tab" data-toggle="tab">任务领取列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>TaskGet/taskGet_frontAdd.jsp" style="display:none;">添加任务领取</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="taskGetListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>领取id</td><td>领取的任务</td><td>领取用户</td><td>领取任务时间</td><td>处理状态</td><td>领取任务说明</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<taskGetList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		TaskGet taskGet = taskGetList.get(i); //获取到任务领取对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=taskGet.getTaskGetId() %></td>
 											<td><%=taskGet.getTaskObj().getTaskName() %></td>
 											<td><a href="<%=basePath %>UserInfo/<%=taskGet.getUserObj().getUser_name() %>/frontshow" target="_blank"><%=taskGet.getUserObj().getName() %></a></td>
 											<td><%=taskGet.getGetTime() %></td>
 											<td><%=taskGet.getHandleState() %></td>
 											<td><%=taskGet.getGetTaskMemo() %></td>
 											<td>
 												<a href="<%=basePath  %>TaskGet/<%=taskGet.getTaskGetId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="taskGetEdit('<%=taskGet.getTaskGetId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="taskGetDelete('<%=taskGet.getTaskGetId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>任务领取查询</h1>
		</div>
		<form name="taskGetQueryForm" id="taskGetQueryForm" action="<%=basePath %>TaskGet/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="taskObj_taskId">领取的任务：</label>
                <select id="taskObj_taskId" name="taskObj.taskId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Task taskTemp:taskList) {
	 					String selected = "";
 					if(taskObj!=null && taskObj.getTaskId()!=null && taskObj.getTaskId().intValue()==taskTemp.getTaskId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=taskTemp.getTaskId() %>" <%=selected %>><%=taskTemp.getTaskName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">领取用户：</label>
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
				<label for="getTime">领取任务时间:</label>
				<input type="text" id="getTime" name="getTime" class="form-control"  placeholder="请选择领取任务时间" value="<%=getTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="handleState">处理状态:</label>
				<input type="text" id="handleState" name="handleState" value="<%=handleState %>" class="form-control" placeholder="请输入处理状态">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="taskGetEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;任务领取信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="taskGetEditForm" id="taskGetEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="taskGet_taskGetId_edit" class="col-md-3 text-right">领取id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="taskGet_taskGetId_edit" name="taskGet.taskGetId" class="form-control" placeholder="请输入领取id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="taskGet_taskObj_taskId_edit" class="col-md-3 text-right">领取的任务:</label>
		  	 <div class="col-md-9">
			    <select id="taskGet_taskObj_taskId_edit" name="taskGet.taskObj.taskId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="taskGet_userObj_user_name_edit" class="col-md-3 text-right">领取用户:</label>
		  	 <div class="col-md-9">
			    <select id="taskGet_userObj_user_name_edit" name="taskGet.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="taskGet_getTime_edit" class="col-md-3 text-right">领取任务时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date taskGet_getTime_edit col-md-12" data-link-field="taskGet_getTime_edit">
                    <input class="form-control" id="taskGet_getTime_edit" name="taskGet.getTime" size="16" type="text" value="" placeholder="请选择领取任务时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="taskGet_handleState_edit" class="col-md-3 text-right">处理状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="taskGet_handleState_edit" name="taskGet.handleState" class="form-control" placeholder="请输入处理状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="taskGet_getTaskMemo_edit" class="col-md-3 text-right">领取任务说明:</label>
		  	 <div class="col-md-9">
			    <textarea id="taskGet_getTaskMemo_edit" name="taskGet.getTaskMemo" rows="8" class="form-control" placeholder="请输入领取任务说明"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#taskGetEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxTaskGetModify();">提交</button>
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
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.taskGetQueryForm.currentPage.value = currentPage;
    document.taskGetQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.taskGetQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.taskGetQueryForm.currentPage.value = pageValue;
    documenttaskGetQueryForm.submit();
}

/*弹出修改任务领取界面并初始化数据*/
function taskGetEdit(taskGetId) {
	$.ajax({
		url :  basePath + "TaskGet/" + taskGetId + "/update",
		type : "get",
		dataType: "json",
		success : function (taskGet, response, status) {
			if (taskGet) {
				$("#taskGet_taskGetId_edit").val(taskGet.taskGetId);
				$.ajax({
					url: basePath + "Task/listAll",
					type: "get",
					success: function(tasks,response,status) { 
						$("#taskGet_taskObj_taskId_edit").empty();
						var html="";
		        		$(tasks).each(function(i,task){
		        			html += "<option value='" + task.taskId + "'>" + task.taskName + "</option>";
		        		});
		        		$("#taskGet_taskObj_taskId_edit").html(html);
		        		$("#taskGet_taskObj_taskId_edit").val(taskGet.taskObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#taskGet_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#taskGet_userObj_user_name_edit").html(html);
		        		$("#taskGet_userObj_user_name_edit").val(taskGet.userObjPri);
					}
				});
				$("#taskGet_getTime_edit").val(taskGet.getTime);
				$("#taskGet_handleState_edit").val(taskGet.handleState);
				$("#taskGet_getTaskMemo_edit").val(taskGet.getTaskMemo);
				$('#taskGetEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除任务领取信息*/
function taskGetDelete(taskGetId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "TaskGet/deletes",
			data : {
				taskGetIds : taskGetId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#taskGetQueryForm").submit();
					//location.href= basePath + "TaskGet/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交任务领取信息表单给服务器端修改*/
function ajaxTaskGetModify() {
	$.ajax({
		url :  basePath + "TaskGet/" + $("#taskGet_taskGetId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#taskGetEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#taskGetQueryForm").submit();
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

    /*领取任务时间组件*/
    $('.taskGet_getTime_edit').datetimepicker({
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

