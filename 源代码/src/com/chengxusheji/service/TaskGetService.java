package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Task;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.TaskGet;

import com.chengxusheji.mapper.TaskGetMapper;
@Service
public class TaskGetService {

	@Resource TaskGetMapper taskGetMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加任务领取记录*/
    public void addTaskGet(TaskGet taskGet) throws Exception {
    	taskGetMapper.addTaskGet(taskGet);
    }

    /*按照查询条件分页查询任务领取记录*/
    public ArrayList<TaskGet> queryTaskGet(Task taskObj,UserInfo userObj,String getTime,String handleState,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != taskObj && taskObj.getTaskId()!= null && taskObj.getTaskId()!= 0)  where += " and t_taskGet.taskObj=" + taskObj.getTaskId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_taskGet.userObj='" + userObj.getUser_name() + "'";
    	if(!getTime.equals("")) where = where + " and t_taskGet.getTime like '%" + getTime + "%'";
    	if(!handleState.equals("")) where = where + " and t_taskGet.handleState like '%" + handleState + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return taskGetMapper.queryTaskGet(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<TaskGet> queryTaskGet(Task taskObj,UserInfo userObj,String getTime,String handleState) throws Exception  { 
     	String where = "where 1=1";
    	if(null != taskObj && taskObj.getTaskId()!= null && taskObj.getTaskId()!= 0)  where += " and t_taskGet.taskObj=" + taskObj.getTaskId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_taskGet.userObj='" + userObj.getUser_name() + "'";
    	if(!getTime.equals("")) where = where + " and t_taskGet.getTime like '%" + getTime + "%'";
    	if(!handleState.equals("")) where = where + " and t_taskGet.handleState like '%" + handleState + "%'";
    	return taskGetMapper.queryTaskGetList(where);
    }

    /*查询所有任务领取记录*/
    public ArrayList<TaskGet> queryAllTaskGet()  throws Exception {
        return taskGetMapper.queryTaskGetList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Task taskObj,UserInfo userObj,String getTime,String handleState) throws Exception {
     	String where = "where 1=1";
    	if(null != taskObj && taskObj.getTaskId()!= null && taskObj.getTaskId()!= 0)  where += " and t_taskGet.taskObj=" + taskObj.getTaskId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_taskGet.userObj='" + userObj.getUser_name() + "'";
    	if(!getTime.equals("")) where = where + " and t_taskGet.getTime like '%" + getTime + "%'";
    	if(!handleState.equals("")) where = where + " and t_taskGet.handleState like '%" + handleState + "%'";
        recordNumber = taskGetMapper.queryTaskGetCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取任务领取记录*/
    public TaskGet getTaskGet(int taskGetId) throws Exception  {
        TaskGet taskGet = taskGetMapper.getTaskGet(taskGetId);
        return taskGet;
    }

    /*更新任务领取记录*/
    public void updateTaskGet(TaskGet taskGet) throws Exception {
        taskGetMapper.updateTaskGet(taskGet);
    }

    /*删除一条任务领取记录*/
    public void deleteTaskGet (int taskGetId) throws Exception {
        taskGetMapper.deleteTaskGet(taskGetId);
    }

    /*删除多条任务领取信息*/
    public int deleteTaskGets (String taskGetIds) throws Exception {
    	String _taskGetIds[] = taskGetIds.split(",");
    	for(String _taskGetId: _taskGetIds) {
    		taskGetMapper.deleteTaskGet(Integer.parseInt(_taskGetId));
    	}
    	return _taskGetIds.length;
    }
}
