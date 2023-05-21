$(function () {
	$.ajax({
		url : "TaskClass/" + $("#taskClass_taskClassId_edit").val() + "/update",
		type : "get",
		data : {
			//taskClassId : $("#taskClass_taskClassId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (taskClass, response, status) {
			$.messager.progress("close");
			if (taskClass) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#taskClassModifyButton").click(function(){ 
		if ($("#taskClassEditForm").form("validate")) {
			$("#taskClassEditForm").form({
			    url:"TaskClass/" +  $("#taskClass_taskClassId_edit").val() + "/update",
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
			$("#taskClassEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
