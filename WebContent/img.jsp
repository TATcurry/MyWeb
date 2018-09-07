<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
	//path = request.getContextPath();
	//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>image</title>
	<script src="${APP_PATH}/static/js/jquery-1.11.1.min.js"></script>
	<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="${APP_PATH}/static/imageCut/cropper.min.css" rel="stylesheet">
	<link href="${APP_PATH}/static/imageCut/sitelogo.css" rel="stylesheet">
	<!-- header -->
	<link href="${APP_PATH}/static/header/style.css" rel="stylesheet">
    <%-- <link href="${APP_PATH}/static/header/css/bootstrap.css" rel="stylesheet"> --%>
	 <link href="${APP_PATH}/static/header/custom.css" rel="stylesheet">
	 <%-- <script src="${APP_PATH}/static/header/js/bootstrap.js"></script> --%>
	<link href="${APP_PATH}/static/header/animate.css" rel="stylesheet">
	<link href="${APP_PATH}/static/header/css/font-awesome.css" rel="stylesheet">
	<!--  -->
	<script src="${APP_PATH}/static/imageCut/cropper.min.js"></script>
	<script src="${APP_PATH}/static/imageCut/sitelogo.js"></script>
	<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<style>
.page_header{
	width: 100%;
    height: 65px;
    background: #e3c0d3;
    box-shadow: 3px 3px 3px;}
#logo a{
	font-size:20px;
	color:#337ab7;
}    
</style>
<body>
	
	<%-- <%@ include file="header.jsp" %>  --%>
	
	
	<div class="ibox-content">
		<div class="row">
			<div id="crop-avatar" class="col-md-6">
				<div class="avatar-view" title="">
			    	<img src="${APP_PATH}/imgs/example.jpg" alt="Logo">
			    </div>
			</div>
		</div>
	</div>

		<div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<form class="avatar-form" action="${APP_PATH}/changeUserPic" enctype="multipart/form-data" method="post">
						<div class="modal-header">
							<button class="close" data-dismiss="modal" type="button">&times;</button>
							<h4 class="modal-title" id="avatar-modal-label">Change Logo Picture</h4>
						</div>
						<div class="modal-body">
							<div class="avatar-body">
								<div class="avatar-upload">
									<input class="avatar-src" name="avatar_src" type="hidden">
									<input class="avatar-data" name="avatar_data" type="hidden">
									<label for="avatarInput">图片上传</label>
									<input class="avatar-input" id="avatarInput" name="avatar_file" type="file"></div>
								<div class="row">
									<div class="col-md-9">
										<div class="avatar-wrapper"></div>
									</div>
									<div class="col-md-3">
										<div class="avatar-preview preview-lg"></div>
										<div class="avatar-preview preview-md"></div>
										<div class="avatar-preview preview-sm"></div>
									</div>
								</div>
								<div class="row avatar-btns">
									<div class="col-md-9">
										<div class="btn-group">
											<button class="btn" data-method="rotate" data-option="-90" type="button" title="Rotate -90 degrees"><i class="fa fa-undo"></i> 向左旋转</button>
										</div>
										<div class="btn-group">
											<button class="btn" data-method="rotate" data-option="90" type="button" title="Rotate 90 degrees"><i class="fa fa-repeat"></i> 向右旋转</button>
										</div>
									</div>
									<div class="col-md-3">
										<button class="btn btn-success btn-block avatar-save" type="submit"><i class="fa fa-save"></i> 保存修改</button>
									</div>
								</div>
							</div>
						</div>
		  		</form>
		  	</div>
		  </div>
		</div>

		<div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>
</body>
</html>