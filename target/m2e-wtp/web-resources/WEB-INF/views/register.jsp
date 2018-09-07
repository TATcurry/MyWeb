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
<title>注册</title>
<meta name="author" content="DeathGhost" />

<link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/style.css" />
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.11.1.min.js" ></script>
<script type="text/javascript" src="${APP_PATH}/static/js/Particleground.js" ></script>
<script type="text/javascript" src="${APP_PATH}/static/js/verificationNumbers.js" ></script> 

<style>
body{height:100%;background:#16a085;overflow:hidden;}
canvas{z-index:-1;position:absolute;}
#error_text p{ font-size:15px;color:#ff0000;font-weight:900;text-align:center;}
.ver_btn{background:#0080ff;}
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
	<form action="/MyWeb/register" method="POST" onsubmit="return register_validate()">
		<dl class="admin_login">
		 <dt>
		  <strong>用户注册</strong>
		  <em>Management System</em>
		 </dt>
		 <dd class="error_icon" >
		 	<div id="error_text">
		 	<c:if test="${registerError == null}"><p></p></c:if>
		 	
		 	<c:if test="${registerError != null}"><p>${registerError}</p></c:if>
		 	</div>
		 </dd>
		 <dd class="pwd_icon">
		  <input type="text" placeholder="账号" class="login_txtbx" name="username" id="username"/>
		 </dd>
		 <dd class="pwd_icon">
		  <input type="password" placeholder="密码" class="login_txtbx" name="password" id="password"/>
		 </dd>
		  <dd class="pwd_icon">
		  <input type="email" placeholder="邮箱" class="login_txtbx" name="email" id="email" onblur="emailValidate()"/>
		 </dd>
		 <dd class="val_icon">
		  <div class="emailcode">
		    <input type="text" id="codetext" placeholder="验证码"  class="login_txtbx" name="codetext">
		    
		  </div>
		  <input type="button" value="发送验证码"  class="ver_btn" id="send" onClick="sendValData()">
		 </dd>
		 <dd>
		  <input type="submit" value="注册" class="submit_btn"/>
		 </dd>
		 <dd>
			<p style="font-size:15px;color:#45bda6">Already Have a Acount ? <a style="font-size:17px;color:#ff8000;font-weight:bold;margin-left:13px;" href="/MyWeb/tologin">To Login</a></p>
		
		 </dd>
		</dl>
	</form>
</body>
<script type="text/javascript"> 

</script>
</html>