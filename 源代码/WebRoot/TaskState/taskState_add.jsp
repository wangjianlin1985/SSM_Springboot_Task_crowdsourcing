<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/taskState.css" />
<div id="taskStateAddDiv">
	<form id="taskStateAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">状态名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="taskState_taskStateName" name="taskState.taskStateName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="taskStateAddButton" class="easyui-linkbutton">添加</a>
			<a id="taskStateClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/TaskState/js/taskState_add.js"></script> 
