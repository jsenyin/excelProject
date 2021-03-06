package com.hexun.zh.datafilter.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;

import com.hexun.zh.datafilter.common.utils.BaseResponse;

public interface InventoryStatisticsService {
	
	  /**
     * chaop_excel数据导入数据库
     * @param normalFile
     */
    void importChaoPiExcel(File normalFile,String realFileName) throws Exception;
//    /**
//     * 分组统计查询
//     * @param startTime
//     * @param endTime
//     * @return
//     */
//    List<Map<String,Object>> findInventoryStatisticsGroupBy(@Param("startTime") String startTime,@Param("endTime") String endTime);
    
    
    /**
     * 根据时间段查询查询 不重样的文件名称
     * @param startTime
     * @param endTime
     * @return
     */
    BaseResponse findInventoryStatisticsDistinctFileName(HttpServletRequest req);
    
    

    /**
     * 根据文件名查询，不重复sheet名称
     * @param startTime
     * @param endTime
     * @param fileName
     * @return
     */
    BaseResponse findInventoryStatisticsDistinctSheetName(HttpServletRequest req);
    
    

    /**
     * 根据文件名，sheet名称，名查询产品序列号名称
     * @param startTime
     * @param endTime
     * @param fileName
     * @param sheetName
     * @return
     */
    BaseResponse findInventoryStatisticsDistinctSerialNumber(HttpServletRequest req);
    
    
    /**
     * 根据文件名，sheet名称，产品序列号 查询产品有效产品列表
     * @param startTime
     * @param endTime
     * @param fileName
     * @param sheetName
     * @return
     */
    BaseResponse findInventoryStatisticsBySeri(HttpServletRequest req);
    
    /**
     * 清除所有
     * @return
     */
    int deleteAll();
    
    /**
     * 查询excel导出数据
     */
    List queryExportExcelData(HttpServletRequest req);
    
}
