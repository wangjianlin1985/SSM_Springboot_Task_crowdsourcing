package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.TaskClass;

import com.chengxusheji.mapper.TaskClassMapper;
@Service
public class TaskClassService {

	@Resource TaskClassMapper taskClassMapper;
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

    /*添加任务分类记录*/
    public void addTaskClass(TaskClass taskClass) throws Exception {
    	taskClassMapper.addTaskClass(taskClass);
    }

    /*按照查询条件分页查询任务分类记录*/
    public ArrayList<TaskClass> queryTaskClass(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return taskClassMapper.queryTaskClass(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<TaskClass> queryTaskClass() throws Exception  { 
     	String where = "where 1=1";
    	return taskClassMapper.queryTaskClassList(where);
    }

    /*查询所有任务分类记录*/
    public ArrayList<TaskClass> queryAllTaskClass()  throws Exception {
        return taskClassMapper.queryTaskClassList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = taskClassMapper.queryTaskClassCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取任务分类记录*/
    public TaskClass getTaskClass(int taskClassId) throws Exception  {
        TaskClass taskClass = taskClassMapper.getTaskClass(taskClassId);
        return taskClass;
    }

    /*更新任务分类记录*/
    public void updateTaskClass(TaskClass taskClass) throws Exception {
        taskClassMapper.updateTaskClass(taskClass);
    }

    /*删除一条任务分类记录*/
    public void deleteTaskClass (int taskClassId) throws Exception {
        taskClassMapper.deleteTaskClass(taskClassId);
    }

    /*删除多条任务分类信息*/
    public int deleteTaskClasss (String taskClassIds) throws Exception {
    	String _taskClassIds[] = taskClassIds.split(",");
    	for(String _taskClassId: _taskClassIds) {
    		taskClassMapper.deleteTaskClass(Integer.parseInt(_taskClassId));
    	}
    	return _taskClassIds.length;
    }
}
