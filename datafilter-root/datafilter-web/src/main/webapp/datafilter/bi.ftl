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
      <li role="presentation"><a href="${request.contextPath}/to_upload_query">朝批效期数据</a></li>
      <li role="presentation" class="active"><a href="${request.contextPath}/bi">BI</a></li>
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
                            <input type="text" class="form-control timer" value="2014-06-27" id="line_datetimepicker_start">
                                <span class="input-group-addon">
                              <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                        &nbsp;&nbsp;结束时间：
                        <div class="input-group date col-xs-3" id="time">
                            <input type="text" class="form-control timer" value="2014-07-03" id="line_datetimepicker_end">
                            <span class="input-group-addon">
                              <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                        <select class="selectpicker" data-style="btn-info" id="feedbackType">
                            <option value="问题反馈">问题反馈</option>
                            <option value="新手咨询">新手咨询</option>
                            <option value="改善建议">改善建议</option>
                            <option value="内容需求">内容需求</option>
                        </select>
                        &nbsp;
                        <button type="button" class="btn btn-success" onclick="loadLineChat();">加载</button>
                    </div>
                    <!-- 日历end -->

                    <div class="x_content2">
                        <div id="graph_line" style="width:100%; height:300px;"></div>
                    </div>
                </div>
            </div>
            <!-- /line graph -->


            <!-- bar charts group -->
            <div class="col-md-12 col-sm-12" style="margin-top:50px;">
                <div class="x_panel">

                    <!-- 日历start -->
                    <div class="form-inline">
                        开始时间：
                        <div class="input-group date col-xs-3" id="time">
                            <input type="text" class="form-control timer" value="2014-06-27" id="bar_datetimepicker_start">
                            <span class="input-group-addon">
                              <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                        &nbsp;&nbsp;结束时间：
                        <div class="input-group date col-xs-3" id="time">
                            <input type="text" class="form-control timer" value="2014-07-03" id="bar_datetimepicker_end">
                            <span class="input-group-addon">
                              <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                        &nbsp;
                        <button type="button" class="btn btn-success" onclick="loadBarChat();">加载</button>
                    </div>
                    <!-- 日历end -->

                    <div class="x_content2">
                        <div id="graphx" style="width:100%; height:300px;" ></div>
                    </div>
                </div>
            </div>
            <!-- /bar charts group -->


            <!-- pie chart -->
            <div class="col-md-12 col-sm-12" style="margin-top:50px;">
                <div class="x_panel">

                    <!-- 日历start -->
                    <div class="form-inline">
                        开始时间：
                        <div class="input-group date col-xs-3" id="time">
                            <input type="text" class="form-control timer" value="2014-06-27" id="pie_datetimepicker_start">
                            <span class="input-group-addon">
                              <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                        &nbsp;&nbsp;结束时间：
                        <div class="input-group date col-xs-3" id="time">
                            <input type="text" class="form-control timer" value="2014-07-03" id="pie_datetimepicker_end">
                            <span class="input-group-addon">
                              <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                        &nbsp;
                        <button type="button" class="btn btn-success" onclick="loadPieChat();">加载</button>
                    </div>
                    <!-- 日历end -->

                    <div class="x_content2">
                        <div id="graph_donut" style="width:100%; height:300px;"></div>
                    </div>
                </div>
            </div>
            <!-- /Pie chart -->

        </div>
      </div>
    </div>
    <!-- /page content -->

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
          loadLineChat();
          loadBarChat();
          loadPieChat();

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
       * 加载线图
       */
      function loadLineChat(){
          var feedbackType = $("#feedbackType").val();
          var startTime = $("#line_datetimepicker_start").val();
          var endTime = $("#line_datetimepicker_end").val();
          $.get("${request.contextPath}/load_line_chat",{
              "feedbackType": feedbackType,
              "startTime": startTime,
              "endTime": endTime
          },function (data) {
              if(data.respCode == 'T'){
                  fillLineChat(data.result);
              }
          })
      }

      // 填充图形
      function fillLineChat(data){
          $("#graph_line").empty();
          $(window).resize();

          Morris.Line({
              element: 'graph_line',
              xkey: 'feedbackTime',
              ykeys: ['count'],
              labels: ['数量'],
              hideHover: 'auto',
              lineColors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
              data: data,
              resize: true
          });
      }

      // 加载条形图数据
      function loadBarChat(){
          var startTime = $("#bar_datetimepicker_start").val();
          var endTime = $("#bar_datetimepicker_end").val();
          $.get("${request.contextPath}/load_bar_chat",{
              "startTime": startTime,
              "endTime": endTime
          },function (data) {
              if(data.respCode == 'T'){
                  fillBarChat(data.result);
              }
          })
      }

      // 填充图形
      function fillBarChat(data){
          $("#graphx").empty();
          $(window).resize();

          Morris.Bar({
              element: 'graphx',
              data: data,
              xkey: 'feedbackTime',
              ykeys: ['新手咨询', '问题反馈', '内容需求','改善建议'],
              barColors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
              hideHover: 'auto',
              labels: ['新手咨询', '问题反馈', '内容需求','改善建议'],
              resize: true
          }).on('click', function (i, row) {
              console.log(i, row);
          });
      }

      // 加载饼图数据
      function loadPieChat(){
          var startTime = $("#pie_datetimepicker_start").val();
          var endTime = $("#pie_datetimepicker_end").val();
          $.get("${request.contextPath}/load_pie_chat",{
              "startTime": startTime,
              "endTime": endTime
          },function (data) {
              if(data.respCode == 'T'){
                  fillPieChat(data.result);
              }
          })
      }

      // 填充图形
      function fillPieChat(data){
          $("#graph_donut").empty();
          $(window).resize();

          Morris.Donut({
              element: 'graph_donut',
              data: data,
              colors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
              formatter: function (y) {
                  return y + "%";
              },
              resize: true
          });
      }

  </script>

  </body>
</html>