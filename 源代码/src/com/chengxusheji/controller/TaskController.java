package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.TaskService;
import com.chengxusheji.po.Task;
import com.chengxusheji.service.TaskClassService;
import com.chengxusheji.po.TaskClass;
import com.chengxusheji.service.TaskStateService;
import com.chengxusheji.po.TaskState;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Task管理控制层
@Controller
@RequestMapping("/Task")
public class TaskController extends BaseController {

    /*业务层对象*/
    @Resource TaskService taskService;

    @Resource TaskClassService taskClassService;
    @Resource TaskStateService taskStateService;
    @Resource UserInfoService userInfoService;
	@InitBinder("taskClassObj")
	public void initBindertaskClassObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("taskClassObj.");
	}
	@InitBinder("taskStateObj")
	public void initBindertaskStateObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("taskStateObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("task")
	public void initBinderTask(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("task.");
	}
	/*跳转到添加Task视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Task());
		/*查询所有的TaskClass信息*/
		List<TaskClass> taskClassList = taskClassService.queryAllTaskClass();
		request.setAttribute("taskClassList", taskClassList);
		/*查询所有的TaskState信息*/
		List<TaskState> taskStateList = taskStateService.queryAllTaskState();
		request.setAttribute("taskStateList", taskStateList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Task_add";
	}

	/*客户端ajax方式提交添加任务信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Task task, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		task.setTaskFile(this.handleFileUpload(request, "taskFileFile"));
        taskService.addTask(task);
        message = "任务添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*客户端ajax方式提交添加任务信息*/
	@RequestMapping(value = "/userAdd", method = RequestMethod.POST)
	public void userAdd(Task task, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		 
		task.setTaskFile(this.handleFileUpload(request, "taskFileFile"));
		
		String user_name = (String) session.getAttribute("user_name");
		UserInfo userObj = new UserInfo();
		userObj.setUser_name(user_name);
		task.setUserObj(userObj);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		task.setPublishTime(sdf.format(new java.util.Date()));
		
		
        taskService.addTask(task);
        message = "任务添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	
	/*ajax方式按照查询条件分页查询任务信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("taskClassObj") TaskClass taskClassObj,String taskName,@ModelAttribute("taskStateObj") TaskState taskStateObj,@ModelAttribute("userObj") UserInfo userObj,String publishTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (taskName == null) taskName = "";
		if (publishTime == null) publishTime = "";
		if(rows != 0)taskService.setRows(rows);
		List<Task> taskList = taskService.queryTask(taskClassObj, taskName, taskStateObj, userObj, publishTime, page);
	    /*计算总的页数和总的记录数*/
	    taskService.queryTotalPageAndRecordNumber(taskClassObj, taskName, taskStateObj, userObj, publishTime);
	    /*获取到总的页码数目*/
	    int totalPage = taskService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = taskService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Task task:taskList) {
			JSONObject jsonTask = task.getJsonObject();
			jsonArray.put(jsonTask);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询任务信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Task> taskList = taskService.queryAllTask();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Task task:taskList) {
			JSONObject jsonTask = new JSONObject();
			jsonTask.accumulate("taskId", task.getTaskId());
			jsonTask.accumulate("taskName", task.getTaskName());
			jsonArray.put(jsonTask);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询任务信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("taskClassObj") TaskClass taskClassObj,String taskName,@ModelAttribute("taskStateObj") TaskState taskStateObj,@ModelAttribute("userObj") UserInfo userObj,String publishTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (taskName == null) taskName = "";
		if (publishTime == null) publishTime = "";
		List<Task> taskList = taskService.queryTask(taskClassObj, taskName, taskStateObj, userObj, publishTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    taskService.queryTotalPageAndRecordNumber(taskClassObj, taskName, taskStateObj, userObj, publishTime);
	    /*获取到总的页码数目*/
	    int totalPage = taskService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = taskService.getRecordNumber();
	    request.setAttribute("taskList",  taskList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("taskClassObj", taskClassObj);
	    request.setAttribute("taskName", taskName);
	    request.setAttribute("taskStateObj", taskStateObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("publishTime", publishTime);
	    List<TaskClass> taskClassList = taskClassService.queryAllTaskClass();
	    request.setAttribute("taskClassList", taskClassList);
	    List<TaskState> taskStateList = taskStateService.queryAllTaskState();
	    request.setAttribute("taskStateList", taskStateList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Task/task_frontquery_result"; 
	}
	
	
	/*前台按照查询条件分页查询任务信息*/
	@RequestMapping(value = { "/userFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String userFrontlist(@ModelAttribute("taskClassObj") TaskClass taskClassObj,String taskName,@ModelAttribute("taskStateObj") TaskState taskStateObj,@ModelAttribute("userObj") UserInfo userObj,String publishTime,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (taskName == null) taskName = "";
		if (publishTime == null) publishTime = "";
		String user_name = (String) session.getAttribute("user_name");
		userObj = new UserInfo();
		userObj.setUser_name(user_name);
		List<Task> taskList = taskService.queryTask(taskClassObj, taskName, taskStateObj, userObj, publishTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    taskService.queryTotalPageAndRecordNumber(taskClassObj, taskName, taskStateObj, userObj, publishTime);
	    /*获取到总的页码数目*/
	    int totalPage = taskService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = taskService.getRecordNumber();
	    request.setAttribute("taskList",  taskList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("taskClassObj", taskClassObj);
	    request.setAttribute("taskName", taskName);
	    request.setAttribute("taskStateObj", taskStateObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("publishTime", publishTime);
	    List<TaskClass> taskClassList = taskClassService.queryAllTaskClass();
	    request.setAttribute("taskClassList", taskClassList);
	    List<TaskState> taskStateList = taskStateService.queryAllTaskState();
	    request.setAttribute("taskStateList", taskStateList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Task/task_userFrontquery_result"; 
	}
	

     /*前台查询Task信息*/
	@RequestMapping(value="/{taskId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer taskId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键taskId获取Task对象*/
        Task task = taskService.getTask(taskId);

        List<TaskClass> taskClassList = taskClassService.queryAllTaskClass();
        request.setAttribute("taskClassList", taskClassList);
        List<TaskState> taskStateList = taskStateService.queryAllTaskState();
        request.setAttribute("taskStateList", taskStateList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("task",  task);
        return "Task/task_frontshow";
	}

	/*ajax方式显示任务修改jsp视图页*/
	@RequestMapping(value="/{taskId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer taskId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键taskId获取Task对象*/
        Task task = taskService.getTask(taskId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonTask = task.getJsonObject();
		out.println(jsonTask.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新任务信息*/
	@RequestMapping(value = "/{taskId}/update", method = RequestMethod.POST)
	public void update(@Validated Task task, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String taskFileFileName = this.handleFileUpload(request, "taskFileFile");
		if(!taskFileFileName.equals(""))task.setTaskFile(taskFileFileName);
		try {
			taskService.updateTask(task);
			message = "任务更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "任务更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除任务信息*/
	@RequestMapping(value="/{taskId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer taskId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  taskService.deleteTask(taskId);
	            request.setAttribute("message", "任务删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "任务删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条任务记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String taskIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = taskService.deleteTasks(taskIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出任务信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("taskClassObj") TaskClass taskClassObj,String taskName,@ModelAttribute("taskStateObj") TaskState taskStateObj,@ModelAttribute("userObj") UserInfo userObj,String publishTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(taskName == null) taskName = "";
        if(publishTime == null) publishTime = "";
        List<Task> taskList = taskService.queryTask(taskClassObj,taskName,taskStateObj,userObj,publishTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Task信息记录"; 
        String[] headers = { "任务id","任务分类","任务标题","任务赏金","任务状态","任务发布人","任务发布时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<taskList.size();i++) {
        	Task task = taskList.get(i); 
        	dataset.add(new String[]{task.getTaskId() + "",task.getTaskClassObj().getTaskClassName(),task.getTaskName(),task.getTaskMoney() + "",task.getTaskStateObj().getTaskStateName(),task.getUserObj().getName(),task.getPublishTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Task.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
