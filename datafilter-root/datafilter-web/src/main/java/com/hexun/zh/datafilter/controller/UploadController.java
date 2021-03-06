package com.hexun.zh.datafilter.controller;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.hexun.zh.datafilter.common.utils.DateUtils;
import com.hexun.zh.datafilter.service.DataFilterService;
import com.hexun.zh.datafilter.service.InventoryStatisticsService;

/**
 * 上传
 * @author zhoudong
 *
 */
@Controller
public class UploadController {
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Resource
	private DataFilterService dataFilterService;
	
	
	@Resource
	private InventoryStatisticsService inventoryStatisticsService;
	
	
	
	/**
	 * 上传图片
	 */
	@RequestMapping(value="upload_file",method=RequestMethod.POST,  produces = "application/json;charset=UTF-8")
	public @ResponseBody Map<String, Object> upload(HttpServletRequest request, HttpServletResponse response, @RequestParam("localFile") MultipartFile attachFile){

		Map<String, Object> jsonMap=new HashMap<String, Object>();
		
        //上传文件后缀名称
		String extendName = attachFile.getOriginalFilename().substring(attachFile.getOriginalFilename().lastIndexOf("."));
		//新文件名称
		String newFileName = UUID.randomUUID().toString() + extendName;

		try
		{
			//应用的真实路径
			String realContextPath = request.getSession().getServletContext().getRealPath("/");
 			String relativePath = "upload/" + DateUtils.getDate(new Date());
			// 新文件所属目录
			File destFile = new File(realContextPath + relativePath);
			
			if (!destFile.exists()){
				destFile.mkdirs();
			}
			
 			// 新文件
			File normalFile = new File(destFile, newFileName);
			attachFile.transferTo(normalFile);
			
			jsonMap.put("req_code", "T");
			jsonMap.put("req_mess", "文件上传成功");
			jsonMap.put("fileURL", normalFile);
			
			jsonMap.put("error", 0);
			jsonMap.put("url", normalFile);

			// 操作excel
			dataFilterService.importExcel(normalFile);

			logger.info("上传成功，返回参数：{}", JSON.toJSONString(jsonMap));
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap.put("req_code", "F");
			jsonMap.put("req_mess", "文件上传失败");
			
			jsonMap.put("error", 1);
			jsonMap.put("message", e.toString());
		}
        
        return jsonMap;
	}
	
	/**
	 * 上传图片
	 */
	@RequestMapping(value="upload_file_chaopi",method=RequestMethod.POST,  produces = "application/json;charset=UTF-8")
	public @ResponseBody Map<String, Object> upload_chaopi(HttpServletRequest request, HttpServletResponse response, @RequestParam("localFile") MultipartFile attachFile){

		Map<String, Object> jsonMap=new HashMap<String, Object>();
        //上传文件后缀名称
        String extendName = attachFile.getOriginalFilename().substring(attachFile.getOriginalFilename().lastIndexOf("."));
        String fileName =  attachFile.getOriginalFilename().substring(0, attachFile.getOriginalFilename().indexOf("."));
        
		//新文件名称
		String newFileName = UUID.randomUUID().toString() + extendName;

		try
		{
			//应用的真实路径
			String realContextPath = request.getSession().getServletContext().getRealPath("/");
 			String relativePath = "upload/" + DateUtils.getDate(new Date());
			// 新文件所属目录
			File destFile = new File(realContextPath + relativePath);
			
			if (!destFile.exists()){
				destFile.mkdirs();
			}
			
 			// 新文件
			File normalFile = new File(destFile, newFileName);
			attachFile.transferTo(normalFile);
			
			jsonMap.put("req_code", "T");
			jsonMap.put("req_mess", "文件上传成功");
			jsonMap.put("fileURL", normalFile);
			
			jsonMap.put("error", 0);
			jsonMap.put("url", normalFile);

			// 操作excel
			inventoryStatisticsService.importChaoPiExcel(normalFile,fileName);

			logger.info("上传成功，返回参数：{}", JSON.toJSONString(jsonMap));
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap.put("req_code", "F");
			jsonMap.put("req_mess", "文件上传失败");
			
			jsonMap.put("error", 1);
			jsonMap.put("message", e.toString());
		}
        
        return jsonMap;
	}
}
