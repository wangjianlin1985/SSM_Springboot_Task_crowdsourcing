package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.TaskState;

import com.chengxusheji.mapper.TaskStateMapper;
@Service
public class TaskStateService {

	@Resource TaskStateMapper taskStateMapper;
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

    /*添加任务状态记录*/
    public void addTaskState(TaskState taskState) throws Exception {
    	taskStateMapper.addTaskState(taskState);
    }

    /*按照查询条件分页查询任务状态记录*/
    public ArrayList<TaskState> queryTaskState(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return taskStateMapper.queryTaskState(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<TaskState> queryTaskState() throws Exception  { 
     	String where = "where 1=1";
    	return taskStateMapper.queryTaskStateList(where);
    }

    /*查询所有任务状态记录*/
    public ArrayList<TaskState> queryAllTaskState()  throws Exception {
        return taskStateMapper.queryTaskStateList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = taskStateMapper.queryTaskStateCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取任务状态记录*/
    public TaskState getTaskState(int taskStateId) throws Exception  {
        TaskState taskState = taskStateMapper.getTaskState(taskStateId);
        return taskState;
    }

    /*更新任务状态记录*/
    public void updateTaskState(TaskState taskState) throws Exception {
        taskStateMapper.updateTaskState(taskState);
    }

    /*删除一条任务状态记录*/
    public void deleteTaskState (int taskStateId) throws Exception {
        taskStateMapper.deleteTaskState(taskStateId);
    }

    /*删除多条任务状态信息*/
    public int deleteTaskStates (String taskStateIds) throws Exception {
    	String _taskStateIds[] = taskStateIds.split(",");
    	for(String _taskStateId: _taskStateIds) {
    		taskStateMapper.deleteTaskState(Integer.parseInt(_taskStateId));
    	}
    	return _taskStateIds.length;
    }
}
