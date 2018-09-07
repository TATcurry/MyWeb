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
<title>Music</title>
<meta name="author" content="DeathGhost" />

<link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/style.css" />
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.11.1.min.js" ></script>
<script type="text/javascript" src="${APP_PATH}/static/js/Particleground.js" ></script>
<script type="text/javascript" src="${APP_PATH}/static/js/verificationNumbers.js" ></script> 
<script src="${APP_PATH}/static/js/APlayer.min.js"></script> 
<link  rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/APlayer.min.css" >
<style>
body{background:#16a085;}
canvas{z-index:-1;position:absolute;}
.players{width:600px;margin: 20px auto;}
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
	<div  class="players" id="aplayer1"></div>
	<div  class="players" id="aplayer2"></div>
	<div  class="players" id="aplayer3"></div>
	
</body>
 <script type="text/javascript">
     
    $.ajax({
        url: "https://api.i-meto.com/meting/api?server=netease&type=playlist&id=719704419",
        success: function (e) {
        	const ap = new APlayer({
                container: document.getElementById('aplayer1'),
                mutex: true,
                listFolded: true,
                listMaxHeight: '500px',
                lrcType: 3,
                audio: JSON.parse(e)
                
            });
        }
    });
    $.ajax({
        url: "https://api.i-meto.com/meting/api?server=netease&type=playlist&id=19723756",
        success: function (e) {
        	const ap = new APlayer({
                container: document.getElementById('aplayer2'),
                mutex: true,
                listFolded: true,
                listMaxHeight: '500px',
                lrcType: 3,
                audio: JSON.parse(e)
                
            });
        }
    });	
   </script>
</html>