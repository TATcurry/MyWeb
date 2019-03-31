<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
     <%
		pageContext.setAttribute("APP_PATH",request.getContextPath());
		//path = request.getContextPath();
		//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		%>
		
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件上传与下载</title>

<!-- 引入jquery -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.11.1.min.js"></script>
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link  rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" >
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<!-- header -->
<link href="${APP_PATH}/static/header/style.css" rel="stylesheet">
<link href="${APP_PATH}/static/header/custom.css" rel="stylesheet">
<link href="${APP_PATH}/static/header/animate.css" rel="stylesheet">
<link href="${APP_PATH}/static/header/css/font-awesome.css" rel="stylesheet">
<!--aplayer  -->
<script src="${APP_PATH}/static/js/APlayer.min.js"></script> 
<link  rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/APlayer.min.css" >
<style type="text/css">
	html,body{
		  height:100%;
		  font-family: "微软雅黑";
		  background:url("/MyWeb/imgs/bg.png");
		  
	}
	
	#myCan{
		background-color:white;
		border: 1px solid grey;
		border-radius:5px;
		padding-top:20px;
		
		
	}
	.AplayerOfMy{
		width:500px;
		position: absolute;
		bottom:20px;
		left:10px;
		
	}
	
</style>
</head>
<body>
	
	<!--更新模态框 -->
		<div class="modal fade" id="uploadMusicModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" >相关信息</h4>
		      </div>
		      <div class="modal-body">
			      <form class="form-horizontal" id="uploadMusicForm" enctype="multipart/form-data" method="post">
			      
					  <div class="form-group">
					    <label for="inputEmail3" class="col-sm-2 control-label">文件</label>
					    <div class="col-sm-10">
					      <input type="file" name="file"  onchange="filechange(this)" id="tempFile" class="form-control" >
					    </div>
					  </div>
					 
					  <div class="form-group">
					    <label for="inputPassword3" class="col-sm-2 control-label">歌手</label>
					    <div class="col-sm-10">
					    
					      <input type="text" name="singer"  id="tempSinger" class="form-control" >
					    </div>
					    </div>
					  <div class="form-group" style="display:none;" id="uploadProgress">
					    <label for="inputPassword3" class="col-sm-2 control-label">进度</label>
					    <div class="col-sm-10">
					    <div class="progress">
					      <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="1" aria-valuemin="0" aria-valuemax="100" style="width: 1%">
						  </div>
						  </div>
					    </div>
					    </div>
					 
				  </form>
		        	
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" id="cancleBtn" >取消</button>
		        <button type="button" class="btn btn-primary" id="uploadMusicBtn">上传</button>
		      </div>
		    </div>
		  </div>
		</div>
	
	<%@ include file="header.jsp" %>
	<!-- end  header -->
		
	<div class="container">
		<!-- 标题 -->
		<div class="row">
		  <div class="col-md-12"><h1>文件资源</h1></div>
		  
		</div>
		
		<div class="row">
		<div class="col-md-4 col-md-offset-2">
			<!-- <button type="button" id="preMusicBtn" class="btn btn-success btn-primary" ><span class="glyphicon glyphicon-backward"></span></button>
		  	<button type="button" id="pauseMusicBtn" class="btn btn-success btn-primary" onclick="playPause()"><span class="glyphicon glyphicon-play"></span></button>
		  	<button type="button" id="nextMusicBtn" class="btn btn-success btn-primary" ><span class="glyphicon glyphicon-forward"></span></button> -->	
		  	
		</div>
		
		  <div class="col-md-6 ">
		  	
		  		<video id="player" autoplay="autoplay"  style="height:50px;margin-right:300px; display: none;"></video>
		  		
		  		<button type="button" id="addMusicBtn" class="btn btn-primary" >上传文件</button>
		  		
		  		<button type="button"  class="btn btn-danger" href="#">视频资源</button>
		  </div>
		</div>
		<br><br>
		<div class="row" id ="myCan">
			<div class="col-md-12">
				<table class="table table-striped">
					
						<tr>
						  <td>ID</td>
						  <td>歌名</td>
						  <td>歌手</td>
						  <td>大小</td>
						  <td>上传者</td>
						  
						  <td>上传时间</td>
						  <td>操作</td>  
						</tr>
						<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
					<tbody id="music_table"></tbody>
					
				
				</table>
			</div>
		</div>
		
		<!-- 信息栏 -->
			<div class="row">
			  <div class="col-md-3 col-md-offset-2" id="page_information"> </div>
			 
			  <!-- 分页栏 -->
			  <div class="col-md-6 col-md-offset-5" >
			  		<nav aria-label="Page navigation">
						  <ul class="pagination" id="music_page_navigation">
						  		 
						  </ul>
					</nav>
			  </div>
			  
			</div>
			
			
		<!--container结束  -->
	</div>
	<div  class="aplayer aplayer-arrow aplayer-fixed" id="aplayer8" style="width:500px;"></div>
</body>
<script type="text/javascript">

	window.SongUrl = "";
	window.SongName = "";
	$(function(){
		to_page(1);
		
	}); 
	
	
	function to_page(pn){
		$.ajax({
					
				url: "${APP_PATH}/common/musicList",
				data: "pn="+ pn,
				type: "GET",
				success: function(result){
					//console.log(result);
					build_music_table(result);
					build_music_pageInfo(result);
					build_music_navigation(result);
				},
				error:function(){
					
				}
						
			});
	}
	String.prototype.endWith=function(endStr){
	      var d=this.length-endStr.length;
	 
	      return (d>=0&&this.lastIndexOf(endStr)==d)
	 
	 };
	//格式化时间
	 Date.prototype.Format = function (fmt) { //author: meizz  
         var o = {  
             "M+": this.getMonth() + 1, //月份  
             "d+": this.getDate(), //日  
             "h+": this.getHours(), //小时  
             "m+": this.getMinutes(), //分  
             "s+": this.getSeconds(), //秒  
             "q+": Math.floor((this.getMonth() + 3) / 3), //季度  
             "S": this.getMilliseconds() //毫秒  
         };  
         if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
         for (var k in o)  
             if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
         return fmt;  
     }; 
	//构建表单
	function build_music_table(result){
		$("#music_table").empty();
		 var muisicList = result.content.pageInfo.list;
		 $.each(muisicList,function(index,item){
			 var idTd = $("<td></td>").append(item.musicId);
			 var nameTd = $("<td></td>").append(item.musicName).attr("style","width:250px");
			 var singerTd = $("<td></td>").append(item.singer);
			 var sizeTd = $("<td></td>").append(item.size).append(" M");
			 var timeTd = $("<td></td>").append(new Date(item.time).Format("yyyy-MM-dd hh:mm:ss"));
			 
			 var whoUploadTd = $("<td></td>").append(item.whoUpload);
			
			 var playBtn = $("<button></button>").attr("urlId",item.musicId).addClass("btn btn-success btn-primary play_Btn")
			 					.append($("<span></span>").addClass("glyphicon glyphicon-headphones"));
			 var downLoadBtn = $("<button></button>").attr("urlId",item.musicId).addClass("btn btn-info btn-primary download_Btn")
			 					.append($("<span></span>").addClass("glyphicon glyphicon-download-alt"));
			 if(item.musicName.endWith(".mp3")){
				 var operation = $("<td></td>").append(downLoadBtn).append("&nbsp;&nbsp;").append(playBtn);
			 }
			 else{
				 var operation = $("<td></td>").append(downLoadBtn);
			 }
			 
			 $("<tr></tr>").append(idTd).append(nameTd).append(singerTd).append(sizeTd).append(whoUploadTd).append(timeTd).append(operation).appendTo("#music_table");
		 });
	}
	//构建导航栏
	function build_music_navigation(result){
		$("#music_page_navigation").empty();
			var firstPage = $("<li></li>").append($("<a></a>").append("首页"));
			var prePage = $("<li></li>").append($("<a></a>").append($("<span></span>").append("&laquo;")));
			
			if(result.content.pageInfo.hasPreviousPage == false){
				firstPage.addClass("disabled");
				prePage.addClass("disabled");
			}
			else{
				firstPage.click(function(){
					to_page(1);
				});
				prePage.click(function(){
					to_page(result.content.pageInfo.pageNum - 1 );
				});
			}
			var lastPage = $("<li></li>").append($("<a></a>").append("末页"));
			var nextPage = $("<li></li>").append($("<a></a>").append($("<span></span>").append("&raquo;")));
			if(result.content.pageInfo.hasNextPage == false){
				lastPage.addClass("disabled");
				nextPage.addClass("disabled");
			}
			else{
				lastPage.click(function(){
					to_page(result.content.pageInfo.total);
				});
				nextPage.click(function(){
					to_page(result.content.pageInfo.pageNum + 1 );
				});
			}
		
			var ul =$("#music_page_navigation").append(firstPage).append(prePage);
				
			
			$.each(result.content.pageInfo.navigatepageNums ,function(index,item){
				 var li = $("<li></li>").append($("<a></a>").append(item));
				 li.click(function(){
					 to_page(item);
				 });
				 if(result.content.pageInfo.pageNum == item){
					 li.addClass("active");
				 }
				 ul.append(li);
				 
				
			});
			//添加末页 下一页
			ul.append(nextPage).append(lastPage);
	}
	function filechange(fileInput){
		var file = fileInput.files;
	}
	function build_music_pageInfo(result){
		$("#page_information").empty();
		$("#page_information").append("当前第 "+ result.content.pageInfo.pageNum+"  页, 总共"+ result.content.pageInfo.pages+"  页, 共有"+ result.content.pageInfo.total+"  条记录")
	}  
	
		//上传
		$("#addMusicBtn").click(function(){
			$('#uploadMusicModal').modal({
				  keyboard: true,
				  backdrop: true
				});
			$('#tempFile').val("");
			$('#tempSinger').val("");
			$("#uploadProgress").attr("style","display:none;");
			
		});
		var task = null;
		$("#uploadMusicBtn").click(function(){
			
			var fileObj = document.getElementById("tempFile").files[0]; // 获取文件对象
			var singer = document.getElementById("tempSinger").value;
			if(fileObj == null || singer == null){
				return;
			}
			//防止重复点击上传
		    $("#uploadMusicBtn").attr("disabled","disabled");
			$("#uploadProgress").attr("style","display:block;");
			 // FormData 对象
			
            var form = new FormData();

            form.append("singer", singer);                    // 可以增加表单数据

            form.append("file", fileObj);                        // 文件对象
          	//记录当前时间
            var time=new Date().getTime();
            //记录当前进度
            var percentage =null;
            //记录当前上传速度
            var velocity=null;
            //记录已上传文件字节大小
            var loaded=0;
			task = $.ajax({
				url:"${APP_PATH}/user/upload",
				type:"POST",
				data:form,
				processData:false,  //必须false才会避开jQuery对 formdata 的默认处理 
				contentType:false, //必须 不设置内容类型
				xhr: function xhr() {
					  //获取原生的xhr对象
					  var xhr = $.ajaxSettings.xhr();
					  if (xhr.upload) {
					   //添加 progress 事件监听
					   xhr.upload.addEventListener('progress', function (e) {
					    var nowDate = new Date().getTime();
					    //每一秒刷新一次状态
					    if (nowDate - time >= 1000) {
						     //已上传文件字节数/总字节数
						     percentage = parseInt(e.loaded / e.total * 100);
							 $(".progress-bar").attr("style","width:"+percentage+"%;");
						     //当前已传大小(字节数)-一秒前已传文件大小(字节数)
						     velocity = (e.loaded - loaded) / 1024;
						     if (percentage >= 99) {
						      //$(".hintText").html('服务端正在解析，请稍后');
								
						     } else {
						      //修改上次记录时间及数据大小
						      time = nowDate;
						      loaded = e.loaded;
						     }
					    }else{
							/* if(e.loaded == e.total){
								$(".progress-bar").attr("style","width:100%;");
								e.loaded = 0;
							} */
					     	return;
					    }
					   }, false);
					
					  }
					  return xhr;
					 },
				success:function(result){ 
					$('#uploadMusicModal').modal("hide");
					 alert("上传成功！");
					 $("#uploadMusicBtn").removeAttr("disabled");
					 to_page(999999);
				}
			}); 
		});
		//取消
		$("#cancleBtn").click(function(){
			if(task) {task.abort();} 
			$("#uploadMusicBtn").removeAttr("disabled");
			$('#uploadMusicModal').modal("hide");
		});
		//下载
		$(document).on("click",".download_Btn", function(){
			
			var CurrentId = $(this).attr("urlId");
			var findUrl = null;
			
			$.ajax({
				url:"${APP_PATH}/common/findMusic/"+ CurrentId,
				type:"GET",
				async:false, 
				success:function(result){ 
					
					findUrl = result.content.findMusic.location;
					
				}
			}); 
			downloadFile(findUrl);
			
		});
		//播放
		$(document).on("click",".play_Btn", function(){
			
			var CurrentId = $(this).attr("urlId");
			var findUrl = null;
			
			$.ajax({
				url:"${APP_PATH}/common/findMusic/"+ CurrentId,
				type:"GET",
				success:function(result){ 
					
					findUrl = result.content.findMusic.location;
					findName = result.content.findMusic.musicName;
					//$("#player").src="./musicFile/"+findUrl;
					//alert(findUrl)
					window.SongUrl = "/MyWeb/musicFile/"+findUrl;
					window.SongName = findName;
					//
					window.ap9 = new APlayer({  
					    container: document.getElementById('aplayer8'),
					    mini: false,
					    autoplay: false,
					    theme: '#FADFA3',
					    lrcType: 3,
					    audio: [{
					        name: window.SongName,
					        //artist: 'Goose house',
					        lrc: '',
					        url: window.SongUrl,
					        theme: '#ebd0c2'
					    }]
					    });
					window.ap9.play();		
					
				}
			}); 
			
			
		});
		//播放控制
		/* function playPause()
		{
			var myVideo=document.getElementById("player");
			
			if(myVideo.src == ""){
				
			}else{
				if(myVideo.paused){
					myVideo.play();
					$("#pauseMusicBtn span").attr("class","glyphicon glyphicon-pause");
							
				}
				
				else{
					myVideo.pause();
					$("#pauseMusicBtn span").attr("class","glyphicon glyphicon-play");
							
				}
			} 
			
		}
		 */
		/* var myvideo = document.getElementById("player");
		
		myvideo.addEventListener("ended",function(){
			$("#pauseMusicBtn span").attr("class","glyphicon glyphicon-play");
		});
		 */
		function downloadFile(url){
			//window.location.href="${APP_PATH}/user/download?filename="+url; 
			window.open("${APP_PATH}/user/download?filename="+ url);
		}

</script>
</html>