<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/taskState.css" />
<div id="taskState_editDiv">
	<form id="taskStateEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">状态id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="taskState_taskStateId_edit" name="taskState.taskStateId" value="<%=request.getParameter("taskStateId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">状态名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="taskState_taskStateName_edit" name="taskState.taskStateName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="taskStateModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/TaskState/js/taskState_modify.js"></script> 
