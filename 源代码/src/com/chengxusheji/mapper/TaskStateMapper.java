package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.TaskState;

public interface TaskStateMapper {
	/*添加任务状态信息*/
	public void addTaskState(TaskState taskState) throws Exception;

	/*按照查询条件分页查询任务状态记录*/
	public ArrayList<TaskState> queryTaskState(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有任务状态记录*/
	public ArrayList<TaskState> queryTaskStateList(@Param("where") String where) throws Exception;

	/*按照查询条件的任务状态记录数*/
	public int queryTaskStateCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条任务状态记录*/
	public TaskState getTaskState(int taskStateId) throws Exception;

	/*更新任务状态记录*/
	public void updateTaskState(TaskState taskState) throws Exception;

	/*删除任务状态记录*/
	public void deleteTaskState(int taskStateId) throws Exception;

}
