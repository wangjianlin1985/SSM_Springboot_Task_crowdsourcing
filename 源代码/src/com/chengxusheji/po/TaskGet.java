package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class TaskGet {
    /*领取id*/
    private Integer taskGetId;
    public Integer getTaskGetId(){
        return taskGetId;
    }
    public void setTaskGetId(Integer taskGetId){
        this.taskGetId = taskGetId;
    }

    /*领取的任务*/
    private Task taskObj;
    public Task getTaskObj() {
        return taskObj;
    }
    public void setTaskObj(Task taskObj) {
        this.taskObj = taskObj;
    }

    /*领取用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*领取任务时间*/
    @NotEmpty(message="领取任务时间不能为空")
    private String getTime;
    public String getGetTime() {
        return getTime;
    }
    public void setGetTime(String getTime) {
        this.getTime = getTime;
    }

    /*处理状态*/
    @NotEmpty(message="处理状态不能为空")
    private String handleState;
    public String getHandleState() {
        return handleState;
    }
    public void setHandleState(String handleState) {
        this.handleState = handleState;
    }

    /*领取任务说明*/
    @NotEmpty(message="领取任务说明不能为空")
    private String getTaskMemo;
    public String getGetTaskMemo() {
        return getTaskMemo;
    }
    public void setGetTaskMemo(String getTaskMemo) {
        this.getTaskMemo = getTaskMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonTaskGet=new JSONObject(); 
		jsonTaskGet.accumulate("taskGetId", this.getTaskGetId());
		jsonTaskGet.accumulate("taskObj", this.getTaskObj().getTaskName());
		jsonTaskGet.accumulate("taskObjPri", this.getTaskObj().getTaskId());
		jsonTaskGet.accumulate("userObj", this.getUserObj().getName());
		jsonTaskGet.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonTaskGet.accumulate("getTime", this.getGetTime().length()>19?this.getGetTime().substring(0,19):this.getGetTime());
		jsonTaskGet.accumulate("handleState", this.getHandleState());
		jsonTaskGet.accumulate("getTaskMemo", this.getGetTaskMemo());
		return jsonTaskGet;
    }}