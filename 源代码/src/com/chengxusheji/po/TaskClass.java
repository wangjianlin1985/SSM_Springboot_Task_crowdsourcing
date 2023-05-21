package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class TaskClass {
    /*任务分类id*/
    private Integer taskClassId;
    public Integer getTaskClassId(){
        return taskClassId;
    }
    public void setTaskClassId(Integer taskClassId){
        this.taskClassId = taskClassId;
    }

    /*任务分类名称*/
    @NotEmpty(message="任务分类名称不能为空")
    private String taskClassName;
    public String getTaskClassName() {
        return taskClassName;
    }
    public void setTaskClassName(String taskClassName) {
        this.taskClassName = taskClassName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonTaskClass=new JSONObject(); 
		jsonTaskClass.accumulate("taskClassId", this.getTaskClassId());
		jsonTaskClass.accumulate("taskClassName", this.getTaskClassName());
		return jsonTaskClass;
    }}