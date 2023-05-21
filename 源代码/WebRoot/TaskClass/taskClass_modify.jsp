<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/taskClass.css" />
<div id="taskClass_editDiv">
	<form id="taskClassEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">任务分类id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="taskClass_taskClassId_edit" name="taskClass.taskClassId" value="<%=request.getParameter("taskClassId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">任务分类名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="taskClass_taskClassName_edit" name="taskClass.taskClassName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="taskClassModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/TaskClass/js/taskClass_modify.js"></script> 
