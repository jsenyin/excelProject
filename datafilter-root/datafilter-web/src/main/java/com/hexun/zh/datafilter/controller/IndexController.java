package com.hexun.zh.datafilter.controller;

import com.hexun.zh.datafilter.common.controller.DefaultBaseController;
import com.hexun.zh.datafilter.common.page.Page;
import com.hexun.zh.datafilter.common.utils.BaseResponse;
import com.hexun.zh.datafilter.common.utils.ExcelCPUtils;
import com.hexun.zh.datafilter.common.utils.StringUtils;
import com.hexun.zh.datafilter.entity.Feedback;
import com.hexun.zh.datafilter.service.DataFilterService;
import com.hexun.zh.datafilter.service.InventoryStatisticsService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 页面
 * @author zhoudong
 *
 */
@Scope("prototype")
@Controller
public class IndexController extends DefaultBaseController {
	private Logger log = LoggerFactory.getLogger(getClass());

	@Resource
	private DataFilterService dataFilterService;
	
	@Resource
	private InventoryStatisticsService inventoryStatisticsService;

	/**
	 * 首页
	 * @param req
	 * @return
	 * @throws Exception
     */
	@RequestMapping(value="index",method={RequestMethod.GET,RequestMethod.POST})
	public 	ModelAndView index(HttpServletRequest req) throws Exception {
		return getModelAndView("index");
	}

	/**
	 * 导入页面
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="to_upload",method={RequestMethod.GET,RequestMethod.POST})
	public 	ModelAndView toUpload(HttpServletRequest req) {
		return getModelAndView("upload_excel");
	}
	
	/**
	 * 导入页面
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="to_upload_chaopi",method={RequestMethod.GET,RequestMethod.POST})
	public 	ModelAndView to_upload_chaopi(HttpServletRequest req) {
		return getModelAndView("to_upload_chaopi");
	}
	
	
	
	
	/**
	 * 查询页面
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="to_upload_query",method={RequestMethod.GET,RequestMethod.POST})
	public 	ModelAndView to_upload_query(HttpServletRequest req) {
		return getModelAndView("chaopiquery");
	}
	
	/**
	 * 加载cp数据
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="load_chaopi_data",method={RequestMethod.GET,RequestMethod.POST})
	public 	@ResponseBody BaseResponse loadCPData(HttpServletRequest req){
		return inventoryStatisticsService.findInventoryStatisticsDistinctFileName(req);
	}
	
	/**
	 * 加载cp数据
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="select_chaopi_data",method={RequestMethod.GET,RequestMethod.POST})
	public 	@ResponseBody BaseResponse loadCPSelectData(HttpServletRequest req){
		return inventoryStatisticsService.findInventoryStatisticsDistinctFileName(req);
	}
	
	
	
	/**
	 * 导出excel
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="export_chaopi_data",method={RequestMethod.GET,RequestMethod.POST})
	public void exportChaoPiData(HttpServletRequest req,HttpServletResponse response) throws Exception{
		 ServletOutputStream out = response.getOutputStream();
		List<Map<String,Object>> datelist = inventoryStatisticsService.queryExportExcelData(req);
//		System.out.println("datelist.get(0):"+datelist.get(0).toString());
//		System.out.println("datelist.get(0).sheetName:"+datelist.get(0).get("sheetName"));
//		System.out.println("datelist.get(0).titleName:"+datelist.get(0).get("titleName"));
//		System.out.println("datelist.get(0).dataList:"+datelist.get(0).get("dataList"));
//		System.out.println("datelist.get(0).get(0):"+datelist.get(0).get(0).toString());
//		String fileName = "daochumingzi";
		String fileName = req.getParameter("fileName");
		if(StringUtils.isBlank(fileName)) {
			return ;
		}
		 String fileNewName = fileName+"_结果_"+new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
//		ExcelCPUtils.export(req,response, fileName, datelist.get(0).get("sheetName").toString(), (List)datelist.get(0).get("titleName"),(List<List>)datelist.get(0).get("dataList"));
		ExcelCPUtils.export(req,response, fileNewName,datelist);
		System.out.println("datelist:"+datelist.toString());
//		return null;
	}
	
	/**
	 * 导入页面
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="bi",method={RequestMethod.GET,RequestMethod.POST})
	public 	ModelAndView bi(HttpServletRequest req) {
		return getModelAndView("bi");
	}

	/**
	 * 加载全部数据
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="load",method={RequestMethod.GET,RequestMethod.POST})
	public 	@ResponseBody Page<Feedback> load(HttpServletRequest req) {

		int pageNo = StringUtils.isBlank(req.getParameter("pageNo")) ? 1 : Integer.parseInt(req.getParameter("pageNo"));
		int pageSize = StringUtils.isBlank(req.getParameter("pageSize")) ? 10 : Integer.parseInt(req.getParameter("pageSize"));

		Page<Feedback> page = dataFilterService.findDataByPage("findDataByPage",new HashMap<>(),pageNo,pageSize);

		return page;
	}

	/**
	 * 加载线图数据
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="load_line_chat",method={RequestMethod.GET,RequestMethod.POST})
	public 	@ResponseBody BaseResponse loadLineChat(HttpServletRequest req){
		return dataFilterService.loadLineChat(req);
	}

	/**
	 * 加载条形数据
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="load_bar_chat",method={RequestMethod.GET,RequestMethod.POST})
	public 	@ResponseBody BaseResponse loadBarChat(HttpServletRequest req) {
		return dataFilterService.loadBarChat(req);
	}

	/**
	 * 加载饼图数据
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="load_pie_chat",method={RequestMethod.GET,RequestMethod.POST})
	public 	@ResponseBody BaseResponse loadPieChat(HttpServletRequest req) {
		return dataFilterService.loadPieChat(req);
	}
}
