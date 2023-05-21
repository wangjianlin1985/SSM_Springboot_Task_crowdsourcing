<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/taskClass.css" />
<div id="taskClassAddDiv">
	<form id="taskClassAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">任务分类名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="taskClass_taskClassName" name="taskClass.taskClassName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="taskClassAddButton" class="easyui-linkbutton">添加</a>
			<a id="taskClassClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/TaskClass/js/taskClass_add.js"></script> 
