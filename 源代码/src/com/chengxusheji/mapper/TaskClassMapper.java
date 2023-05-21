package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.TaskClass;

public interface TaskClassMapper {
	/*添加任务分类信息*/
	public void addTaskClass(TaskClass taskClass) throws Exception;

	/*按照查询条件分页查询任务分类记录*/
	public ArrayList<TaskClass> queryTaskClass(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有任务分类记录*/
	public ArrayList<TaskClass> queryTaskClassList(@Param("where") String where) throws Exception;

	/*按照查询条件的任务分类记录数*/
	public int queryTaskClassCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条任务分类记录*/
	public TaskClass getTaskClass(int taskClassId) throws Exception;

	/*更新任务分类记录*/
	public void updateTaskClass(TaskClass taskClass) throws Exception;

	/*删除任务分类记录*/
	public void deleteTaskClass(int taskClassId) throws Exception;

}
