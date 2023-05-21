var taskState_manage_tool = null; 
$(function () { 
	initTaskStateManageTool(); //建立TaskState管理对象
	taskState_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#taskState_manage").datagrid({
		url : 'TaskState/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "taskStateId",
		sortOrder : "desc",
		toolbar : "#taskState_manage_tool",
		columns : [[
			{
				field : "taskStateId",
				title : "状态id",
				width : 70,
			},
			{
				field : "taskStateName",
				title : "状态名称",
				width : 140,
			},
		]],
	});

	$("#taskStateEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#taskStateEditForm").form("validate")) {
					//验证表单 
					if(!$("#taskStateEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#taskStateEditForm").form({
						    url:"TaskState/" + $("#taskState_taskStateId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#taskStateEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#taskStateEditDiv").dialog("close");
			                        taskState_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#taskStateEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#taskStateEditDiv").dialog("close");
				$("#taskStateEditForm").form("reset"); 
			},
		}],
	});
});

function initTaskStateManageTool() {
	taskState_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#taskState_manage").datagrid("reload");
		},
		redo : function () {
			$("#taskState_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#taskState_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#taskStateQueryForm").form({
			    url:"TaskState/OutToExcel",
			});
			//提交表单
			$("#taskStateQueryForm").submit();
		},
		remove : function () {
			var rows = $("#taskState_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var taskStateIds = [];
						for (var i = 0; i < rows.length; i ++) {
							taskStateIds.push(rows[i].taskStateId);
						}
						$.ajax({
							type : "POST",
							url : "TaskState/deletes",
							data : {
								taskStateIds : taskStateIds.join(","),
							},
							beforeSend : function () {
								$("#taskState_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#taskState_manage").datagrid("loaded");
									$("#taskState_manage").datagrid("load");
									$("#taskState_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#taskState_manage").datagrid("loaded");
									$("#taskState_manage").datagrid("load");
									$("#taskState_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#taskState_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "TaskState/" + rows[0].taskStateId +  "/update",
					type : "get",
					data : {
						//taskStateId : rows[0].taskStateId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (taskState, response, status) {
						$.messager.progress("close");
						if (taskState) { 
							$("#taskStateEditDiv").dialog("open");
							$("#taskState_taskStateId_edit").val(taskState.taskStateId);
							$("#taskState_taskStateId_edit").validatebox({
								required : true,
								missingMessage : "请输入状态id",
								editable: false
							});
							$("#taskState_taskStateName_edit").val(taskState.taskStateName);
							$("#taskState_taskStateName_edit").validatebox({
								required : true,
								missingMessage : "请输入状态名称",
							});
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
