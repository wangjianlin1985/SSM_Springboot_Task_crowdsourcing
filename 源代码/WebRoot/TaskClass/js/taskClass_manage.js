var taskClass_manage_tool = null; 
$(function () { 
	initTaskClassManageTool(); //建立TaskClass管理对象
	taskClass_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#taskClass_manage").datagrid({
		url : 'TaskClass/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "taskClassId",
		sortOrder : "desc",
		toolbar : "#taskClass_manage_tool",
		columns : [[
			{
				field : "taskClassId",
				title : "任务分类id",
				width : 70,
			},
			{
				field : "taskClassName",
				title : "任务分类名称",
				width : 140,
			},
		]],
	});

	$("#taskClassEditDiv").dialog({
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
				if ($("#taskClassEditForm").form("validate")) {
					//验证表单 
					if(!$("#taskClassEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#taskClassEditForm").form({
						    url:"TaskClass/" + $("#taskClass_taskClassId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#taskClassEditForm").form("validate"))  {
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
			                        $("#taskClassEditDiv").dialog("close");
			                        taskClass_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#taskClassEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#taskClassEditDiv").dialog("close");
				$("#taskClassEditForm").form("reset"); 
			},
		}],
	});
});

function initTaskClassManageTool() {
	taskClass_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#taskClass_manage").datagrid("reload");
		},
		redo : function () {
			$("#taskClass_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#taskClass_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#taskClassQueryForm").form({
			    url:"TaskClass/OutToExcel",
			});
			//提交表单
			$("#taskClassQueryForm").submit();
		},
		remove : function () {
			var rows = $("#taskClass_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var taskClassIds = [];
						for (var i = 0; i < rows.length; i ++) {
							taskClassIds.push(rows[i].taskClassId);
						}
						$.ajax({
							type : "POST",
							url : "TaskClass/deletes",
							data : {
								taskClassIds : taskClassIds.join(","),
							},
							beforeSend : function () {
								$("#taskClass_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#taskClass_manage").datagrid("loaded");
									$("#taskClass_manage").datagrid("load");
									$("#taskClass_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#taskClass_manage").datagrid("loaded");
									$("#taskClass_manage").datagrid("load");
									$("#taskClass_manage").datagrid("unselectAll");
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
			var rows = $("#taskClass_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "TaskClass/" + rows[0].taskClassId +  "/update",
					type : "get",
					data : {
						//taskClassId : rows[0].taskClassId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (taskClass, response, status) {
						$.messager.progress("close");
						if (taskClass) { 
							$("#taskClassEditDiv").dialog("open");
							$("#taskClass_taskClassId_edit").val(taskClass.taskClassId);
							$("#taskClass_taskClassId_edit").validatebox({
								required : true,
								missingMessage : "请输入任务分类id",
								editable: false
							});
							$("#taskClass_taskClassName_edit").val(taskClass.taskClassName);
							$("#taskClass_taskClassName_edit").validatebox({
								required : true,
								missingMessage : "请输入任务分类名称",
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
