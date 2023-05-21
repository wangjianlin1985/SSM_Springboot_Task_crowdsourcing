package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.TaskGet;

public interface TaskGetMapper {
	/*添加任务领取信息*/
	public void addTaskGet(TaskGet taskGet) throws Exception;

	/*按照查询条件分页查询任务领取记录*/
	public ArrayList<TaskGet> queryTaskGet(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有任务领取记录*/
	public ArrayList<TaskGet> queryTaskGetList(@Param("where") String where) throws Exception;

	/*按照查询条件的任务领取记录数*/
	public int queryTaskGetCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条任务领取记录*/
	public TaskGet getTaskGet(int taskGetId) throws Exception;

	/*更新任务领取记录*/
	public void updateTaskGet(TaskGet taskGet) throws Exception;

	/*删除任务领取记录*/
	public void deleteTaskGet(int taskGetId) throws Exception;

}
