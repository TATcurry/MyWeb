<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
 <%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
	//path = request.getContextPath();
	//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<meta name="author" content="DeathGhost" />

<link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/style.css" />
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.11.1.min.js" ></script>
<script type="text/javascript" src="${APP_PATH}/static/js/Particleground.js" ></script>
<script type="text/javascript" src="${APP_PATH}/static/js/verificationNumbers.js" ></script> 
<style>
body{height:100%;background:#16a085;overflow:hidden;}
canvas{z-index:-1;position:absolute;}
#J_codetext p{ font-size:15px;color:#ff0000;font-weight:900;text-align:center;}
</style>

<script type="text/javascript">
$(document).ready(function() {
	
  //粒子背景特效
  $('body').particleground({
    dotColor: '#5cbdaa',
    lineColor: '#5cbdaa'
  });
  //验证码
 
});
 

</script>
</head>
<body>
	<form action="/MyWeb/login" method="POST" onsubmit="return validate()">
		<dl class="admin_login">
		 <dt>
		  <strong>用户登录</strong>
		  <em>Management System</em>
		 </dt>
		 <dd class="error_icon" >
		 	<div id="J_codetext">
		 	<c:if test="${loginError == null}"><p></p></c:if>
		 	
		 	<c:if test="${loginError != null}"><p>${loginError}</p></c:if>
		 	</div>
		 </dd>
		 <dd class="user_icon">
		  <input type="text" placeholder="账号" class="login_txtbx" name="username" id="username"/>
		 </dd>
		 <dd class="pwd_icon">
		  <input type="password" placeholder="密码" class="login_txtbx" name="password" id="password"/>
		 </dd>
		 <%-- <dd class="val_icon">
		  <div class="checkcode">
		    <input type="text" id="J_codetext" placeholder="验证码" maxlength="4" class="login_txtbx">
		    <canvas class="J_codeimg" id="myCanvas" onclick="createCode()">对不起，您的浏览器不支持canvas，请下载最新版浏览器!</canvas>
		  </div>
		  <input type="button" value="验证码核验" class="ver_btn" onClick="">
		 </dd> --%>
		 <dd>
		  <input type="submit" value="立即登陆" class="submit_btn"/>
		 </dd>
		 <dd>
			<p style="font-size:15px;color:#45bda6">Not a member yet ? <a style="font-size:17px;color:#ff8000;font-weight:bold;margin-left:13px;" href="/MyWeb/toregister">Join Us</a></p>
		
		 </dd>
		</dl>
	</form>
</body>
</html>