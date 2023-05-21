package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Task {
    /*任务id*/
    private Integer taskId;
    public Integer getTaskId(){
        return taskId;
    }
    public void setTaskId(Integer taskId){
        this.taskId = taskId;
    }

    /*任务分类*/
    private TaskClass taskClassObj;
    public TaskClass getTaskClassObj() {
        return taskClassObj;
    }
    public void setTaskClassObj(TaskClass taskClassObj) {
        this.taskClassObj = taskClassObj;
    }

    /*任务标题*/
    @NotEmpty(message="任务标题不能为空")
    private String taskName;
    public String getTaskName() {
        return taskName;
    }
    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    /*任务内容*/
    @NotEmpty(message="任务内容不能为空")
    private String taskContent;
    public String getTaskContent() {
        return taskContent;
    }
    public void setTaskContent(String taskContent) {
        this.taskContent = taskContent;
    }

    /*任务文件*/
    private String taskFile;
    public String getTaskFile() {
        return taskFile;
    }
    public void setTaskFile(String taskFile) {
        this.taskFile = taskFile;
    }

    /*任务赏金*/
    @NotNull(message="必须输入任务赏金")
    private Float taskMoney;
    public Float getTaskMoney() {
        return taskMoney;
    }
    public void setTaskMoney(Float taskMoney) {
        this.taskMoney = taskMoney;
    }

    /*任务状态*/
    private TaskState taskStateObj;
    public TaskState getTaskStateObj() {
        return taskStateObj;
    }
    public void setTaskStateObj(TaskState taskStateObj) {
        this.taskStateObj = taskStateObj;
    }

    /*任务发布人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*任务发布时间*/
    @NotEmpty(message="任务发布时间不能为空")
    private String publishTime;
    public String getPublishTime() {
        return publishTime;
    }
    public void setPublishTime(String publishTime) {
        this.publishTime = publishTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonTask=new JSONObject(); 
		jsonTask.accumulate("taskId", this.getTaskId());
		jsonTask.accumulate("taskClassObj", this.getTaskClassObj().getTaskClassName());
		jsonTask.accumulate("taskClassObjPri", this.getTaskClassObj().getTaskClassId());
		jsonTask.accumulate("taskName", this.getTaskName());
		jsonTask.accumulate("taskContent", this.getTaskContent());
		jsonTask.accumulate("taskFile", this.getTaskFile());
		jsonTask.accumulate("taskMoney", this.getTaskMoney());
		jsonTask.accumulate("taskStateObj", this.getTaskStateObj().getTaskStateName());
		jsonTask.accumulate("taskStateObjPri", this.getTaskStateObj().getTaskStateId());
		jsonTask.accumulate("userObj", this.getUserObj().getName());
		jsonTask.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonTask.accumulate("publishTime", this.getPublishTime().length()>19?this.getPublishTime().substring(0,19):this.getPublishTime());
		return jsonTask;
    }}