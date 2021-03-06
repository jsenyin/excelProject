<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>BI 图表</title>

    <!-- Bootstrap -->
    <link href="${request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${request.contextPath}/bootstrap/css/bootstrap-select.min.css" rel="stylesheet">
    <link href="${request.contextPath}/bootstrap/timer/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${request.contextPath}/static/bi/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="${request.contextPath}/static/bi/css/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="${request.contextPath}/static/bi/css/green.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="${request.contextPath}/static/bi/css/custom.min.css" rel="stylesheet">
  </head>

  <body>

  <!-- nav -->
  <ul class="nav nav-tabs">
      <li role="presentation"><a href="${request.contextPath}/index">首页</a></li>
      <li role="presentation"><a href="${request.contextPath}/to_upload">数据导入</a></li>
      <li role="presentation"><a href="${request.contextPath}/to_upload_chaopi">朝批效期数据导入</a></li>
       <li role="presentation" class="active"><a href="${request.contextPath}/to_upload_query">朝批效期数据</a></li>
      <li role="presentation" ><a href="${request.contextPath}/bi">BI</a></li>
  </ul>

    <!-- page content -->
    <div class="right_col" role="main" style="margin-top: 30px;">
      <div class="">

        <div class="row">

            <!-- line graph -->
            <div class="col-md-12 col-sm-12">
                <div class="x_panel">

                    <!-- 日历start -->
                    <div class="form-inline">
                        开始时间：
                        <div class="input-group date col-xs-3" id="time">
                            <input type="text" class="form-control timer" value="2014-06-27"  id="line_datetimepicker_start">
                                <span class="input-group-addon">
                              <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                        &nbsp;&nbsp;结束时间：
                        <div class="input-group date col-xs-3" id="time">
                            <input type="text" class="form-control timer" value="2023-07-03" id="line_datetimepicker_end">
                            <span class="input-group-addon">
                              <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                        <select class="selectpicker" data-style="btn-info" id="fileNameSelect">
                        </select>
                        &nbsp;
                        <button type="button" class="btn btn-success" onclick="queryChaopi();">加载</button>
                        &nbsp;
                        <button type="button" class="btn btn-success" onclick="exportExcelChaopi();">下载excel</button>
                    </div>
                    <!-- 日历end -->

                    <div class="x_content2">
                        <div id="graph_line" style="width:100%; height:300px;"></div>
                    </div>
                </div>
            </div>
            
            <form id="exportExcel" action="${request.contextPath}/export_chaopi_data" method="post">
	            <input type="hidden" name="startTime" id="startTime"/>
	            <input type="hidden" name="endTime" id="endTime"/>
	            <input type="hidden" name="fileName" id="fileName"/>
            </form>
            <!-- /line graph -->



    <!-- jQuery -->
    <script src="${request.contextPath}/js/jquery/jquery-1.11.1.min.js"></script>
    <!-- Bootstrap -->
    <script src="${request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <script src="${request.contextPath}/bootstrap/js/bootstrap-select.min.js"></script>
    <script src="${request.contextPath}/bootstrap/timer/bootstrap-datetimepicker.min.js"></script>
    <script src="${request.contextPath}/bootstrap/timer/bootstrap-datetimepicker.zh-CN.js"></script>
    <!-- FastClick -->
    <script src="${request.contextPath}/static/bi/js/fastclick.js"></script>
    <!-- NProgress -->
    <script src="${request.contextPath}/static/bi/js/nprogress.js"></script>
    <!-- morris.js -->
    <script src="${request.contextPath}/static/bi/js/raphael.min.js"></script>
    <script src="${request.contextPath}/static/bi/js/morris.min.js"></script>


  <script>

      $(function () {
          init_timer();
          loadSelect();
        //  loadBarChat();
        //  loadPieChat();

          setTimeout(function(){$("button[data-id='feedbackType']").css("margin-top","-8px");},100);

      })

      /**
       * 初始化时间
       */
      function init_timer(){
          $('.timer').datetimepicker({
              language:  'zh-CN',
              format: 'yyyy-mm-dd',
              autoclose: true,
              minView: "month" //选择日期后，不会再跳转去选择时分秒
          });
      }

      /**
       * 加载查询数据
       */
       function queryChaopi(){
           var startTime = $("#line_datetimepicker_start").val().replace(/-/g,"");
           var endTime = $("#line_datetimepicker_end").val().replace(/-/g,"");
          // $.get("${request.contextPath}/load_chaopi_data",{
           
        $.get("${request.contextPath}/export_chaopi_data",{
               "startTime": startTime,
               "endTime": endTime
           },function (data) {
               if(data.respCode == 'T'){
//             	   $.each(data.result, function(index,val) {
//             		   console.log('index='+index);
//             		   alert(val.fileName);
               }
//                alert();
                  // fillLineChat(data.result);
           })
       }
          
       /**
        * 加载查询select数据
        */
        function loadSelect(){
            var startTime = $("#line_datetimepicker_start").val().replace(/-/g,"");
            var endTime = $("#line_datetimepicker_end").val().replace(/-/g,"");
         $.get("${request.contextPath}/select_chaopi_data",function (data) {
                if(data.respCode == 'T'){
                   $("#fileNameSelect").find("option").remove(); 
                   $("#fileNameSelect").append("<option value=''>"+"请选择"+"</option>");
             	   $.each(data.result, function(index,val) {
             		  $("#fileNameSelect").append("<option value='"+val.fileName+"'>"+val.fileName+"</option>");
             		 $('#fileNameSelect').selectpicker('refresh');
             	  })
                }
            })
        }
          
          
       function exportExcelChaopi(){
           var startTime = $("#line_datetimepicker_start").val().replace(/-/g,"");
           var endTime = $("#line_datetimepicker_end").val().replace(/-/g,"");
           
           var fileName = $("#fileNameSelect").val();
           
           $("#startTime").val(startTime);
           $("#endTime").val(endTime);
           $("#fileName").val(fileName);
           
           if(null == fileName || $.trim(fileName).length<1){
        	   alert("请先选择要导出的文件!");
        	   return ;
           }
           $("#exportExcel").submit();
          // $.get("${request.contextPath}/load_chaopi_data",{
           
       }

     

  </script>

  </body>
</html>