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
import com.chengxusheji.service.TaskClassService;
import com.chengxusheji.po.TaskClass;

//TaskClass管理控制层
@Controller
@RequestMapping("/TaskClass")
public class TaskClassController extends BaseController {

    /*业务层对象*/
    @Resource TaskClassService taskClassService;

	@InitBinder("taskClass")
	public void initBinderTaskClass(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("taskClass.");
	}
	/*跳转到添加TaskClass视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new TaskClass());
		return "TaskClass_add";
	}

	/*客户端ajax方式提交添加任务分类信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated TaskClass taskClass, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        taskClassService.addTaskClass(taskClass);
        message = "任务分类添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询任务分类信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)taskClassService.setRows(rows);
		List<TaskClass> taskClassList = taskClassService.queryTaskClass(page);
	    /*计算总的页数和总的记录数*/
	    taskClassService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = taskClassService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = taskClassService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(TaskClass taskClass:taskClassList) {
			JSONObject jsonTaskClass = taskClass.getJsonObject();
			jsonArray.put(jsonTaskClass);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询任务分类信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<TaskClass> taskClassList = taskClassService.queryAllTaskClass();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(TaskClass taskClass:taskClassList) {
			JSONObject jsonTaskClass = new JSONObject();
			jsonTaskClass.accumulate("taskClassId", taskClass.getTaskClassId());
			jsonTaskClass.accumulate("taskClassName", taskClass.getTaskClassName());
			jsonArray.put(jsonTaskClass);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询任务分类信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<TaskClass> taskClassList = taskClassService.queryTaskClass(currentPage);
	    /*计算总的页数和总的记录数*/
	    taskClassService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = taskClassService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = taskClassService.getRecordNumber();
	    request.setAttribute("taskClassList",  taskClassList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "TaskClass/taskClass_frontquery_result"; 
	}

     /*前台查询TaskClass信息*/
	@RequestMapping(value="/{taskClassId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer taskClassId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键taskClassId获取TaskClass对象*/
        TaskClass taskClass = taskClassService.getTaskClass(taskClassId);

        request.setAttribute("taskClass",  taskClass);
        return "TaskClass/taskClass_frontshow";
	}

	/*ajax方式显示任务分类修改jsp视图页*/
	@RequestMapping(value="/{taskClassId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer taskClassId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键taskClassId获取TaskClass对象*/
        TaskClass taskClass = taskClassService.getTaskClass(taskClassId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonTaskClass = taskClass.getJsonObject();
		out.println(jsonTaskClass.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新任务分类信息*/
	@RequestMapping(value = "/{taskClassId}/update", method = RequestMethod.POST)
	public void update(@Validated TaskClass taskClass, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			taskClassService.updateTaskClass(taskClass);
			message = "任务分类更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "任务分类更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除任务分类信息*/
	@RequestMapping(value="/{taskClassId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer taskClassId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  taskClassService.deleteTaskClass(taskClassId);
	            request.setAttribute("message", "任务分类删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "任务分类删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条任务分类记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String taskClassIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = taskClassService.deleteTaskClasss(taskClassIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出任务分类信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<TaskClass> taskClassList = taskClassService.queryTaskClass();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "TaskClass信息记录"; 
        String[] headers = { "任务分类id","任务分类名称"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<taskClassList.size();i++) {
        	TaskClass taskClass = taskClassList.get(i); 
        	dataset.add(new String[]{taskClass.getTaskClassId() + "",taskClass.getTaskClassName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"TaskClass.xls");//filename是下载的xls的名，建议最好用英文 
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
