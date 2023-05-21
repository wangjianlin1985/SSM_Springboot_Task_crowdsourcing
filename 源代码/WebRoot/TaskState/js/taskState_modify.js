$(function () {
	$.ajax({
		url : "TaskState/" + $("#taskState_taskStateId_edit").val() + "/update",
		type : "get",
		data : {
			//taskStateId : $("#taskState_taskStateId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (taskState, response, status) {
			$.messager.progress("close");
			if (taskState) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#taskStateModifyButton").click(function(){ 
		if ($("#taskStateEditForm").form("validate")) {
			$("#taskStateEditForm").form({
			    url:"TaskState/" +  $("#taskState_taskStateId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#taskStateEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
