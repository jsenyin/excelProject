<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>表格页</title>

    <!-- Bootstrap core CSS -->
    <link href="${request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${request.contextPath}/bootstrap/table/bootstrap-table.min.css" rel="stylesheet">

    <script src="${request.contextPath}/js/jquery/jquery-1.11.1.min.js"></script>

    <script src="${request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <script src="${request.contextPath}/bootstrap/js/dateformat.js"></script>
    <script src="${request.contextPath}/bootstrap/table/bootstrap-table.min.js"></script>
    <script src="${request.contextPath}/bootstrap/table/bootstrap-table-zh-CN.min.js"></script>



      <script>

          $(function () {
              initMainTable ();
          });

          //初始化bootstrap-table的内容
          function initMainTable () {
              //记录页面bootstrap-table全局变量$table，方便应用
              var queryUrl = 'load';
              $('#table').bootstrapTable({
                  url: queryUrl,                      //请求后台的URL（*）
                  method: 'GET',                      //请求方式（*）
                  //dataType:"json",
                  //toolbar: '#toolbar',              //工具按钮用哪个容器
                  striped: true,                      //是否显示行间隔色
                  cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                  pagination: true,                   //是否显示分页（*）
                  sortable: true,                     //是否启用排序
                  sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                  queryParamsType:'undefined',          //查询参数组织方式
                  pageNumber: 1,                      //初始化加载第一页，默认第一页,并记录
                  pageSize: 5,                     //每页的记录行数（*）
                  pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
                  search: false,                      //是否显示表格搜索
                  strictSearch: true,
                  showColumns: true,                  //是否显示所有的列（选择显示的列）
                  showRefresh: true,                  //是否显示刷新按钮
                  minimumCountColumns: 2,             //最少允许的列数
                  clickToSelect: true,                //是否启用点击选中行
                  //height: 500,                      //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                  uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
                  showToggle: true,                   //是否显示详细视图和列表视图的切换按钮
                  cardView: false,                    //是否显示详细视图
                  detailView: false,                  //是否显示父子表
                  responseHandler: function(resultStr){
                      return {
                          "rows": resultStr.list,
                          "total": resultStr.totalCount
                      };
                  },//请求数据成功后，渲染表格前的方法
                  //得到查询的参数
                  queryParams : function (params) {
                      var temp = {
                          "pageSize": params.pageSize,                         //页面大小
                          "pageNo": params.pageNumber   //页码
                      };
                      return temp;
                  },
                  columns: [{
                      field: 'feedbackTime',
                      title: '时间',
                      sortable: true,
                      formatter: function (value, row, index) {
                          if (value == null) {
                              return "";
                          }
                          var offlineTimeStr = new Date(value).format("yyyy-MM-dd");
                          return offlineTimeStr;
                      }
                  },{
                      field: 'deviceName',
                      title: '设备名称',
                      sortable: true
                  },{
                      field: 'platform',
                      title: '平台',
                      sortable: true
                  },{
                      field: 'clientVersion',
                      title: '客户端版本号',
                      sortable: true
                  },{
                      field: 'email',
                      title: '邮箱',
                      sortable: true
                  },{
                      field: 'phone',
                      title: '电话',
                      sortable: true
                  },{
                      field: 'feedbackType',
                      title: '类型',
                      sortable: true
                  },{
                      field: 'memo',
                      title: '备注'
                  },{
                      field: 'answerType',
                      title: '答复口径',
                      sortable: true
                  },{
                      field: 'message',
                      title: 'Msg'
                  },{
                      field: 'ip',
                      title: 'ip'
                  },{
                      field: 'ua',
                      title: 'ua'
                  },{
                      field: 'province',
                      title: '省份',
                      sortable: true
                  },{
                      field: 'phoneOperator',
                      title: '运行商',
                      sortable: true
                  },{
                      field: 'installCannel',
                      title: '安装渠道',
                      sortable: true
                  },{
                      field: 'isHandle',
                      title: '是否处理',
                      sortable: true
                  },{
                      field: 'operator',
                      title: '处理人',
                      sortable: true
                  }],
                  onLoadSuccess: function () {
                  },
                  onLoadError: function () {
                      alert("数据加载失败！");
                  },
                  onDblClickRow: function (row, $element) {
                      var id = row.ID;
                      EditViewById(id, 'view');
                  },
              });
          };


      </script>

  </head>

  <body>
      <!-- nav -->
      <ul class="nav nav-tabs">
          <li role="presentation" class="active"><a href="#">首页</a></li>
          <li role="presentation"><a href="${request.contextPath}/to_upload">数据导入</a></li>
          <li role="presentation"><a href="${request.contextPath}/to_upload_chaopi">朝批效期数据导入</a></li>
          <li role="presentation"><a href="${request.contextPath}/to_upload_query">朝批效期数据</a></li>
          <li role="presentation"><a href="${request.contextPath}/bi">BI</a></li>
      </ul>
      <!-- table -->
      <table id="table"></table>
  </body>
</html>
