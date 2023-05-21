package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class TaskState {
    /*状态id*/
    private Integer taskStateId;
    public Integer getTaskStateId(){
        return taskStateId;
    }
    public void setTaskStateId(Integer taskStateId){
        this.taskStateId = taskStateId;
    }

    /*状态名称*/
    @NotEmpty(message="状态名称不能为空")
    private String taskStateName;
    public String getTaskStateName() {
        return taskStateName;
    }
    public void setTaskStateName(String taskStateName) {
        this.taskStateName = taskStateName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonTaskState=new JSONObject(); 
		jsonTaskState.accumulate("taskStateId", this.getTaskStateId());
		jsonTaskState.accumulate("taskStateName", this.getTaskStateName());
		return jsonTaskState;
    }}