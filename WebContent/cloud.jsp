<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%
		pageContext.setAttribute("APP_PATH",request.getContextPath());
		//path = request.getContextPath();
		//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${APP_PATH}/static/js/jquery-1.11.1.min.js"></script> 
<script src="${APP_PATH}/static/js/APlayer.min.js"></script> 
<link  rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/APlayer.min.css" >
</head>
<style>
body{background:#BFEFFF;}
.players{width:600px;margin: 20px auto;}
</style>
<body>
	<div  class="players" id="aplayer1"></div>
	<div  class="players" id="aplayer2"></div>
	<div  class="players" id="aplayer3"></div>
	<div  class="players" id="aplayer4"></div>
	<div  class="players" id="aplayer5"></div>
	<div  class="players" id="aplayer6"></div>
	<div  class="players" id="aplayer7"></div>
	<div  class="players" id="aplayer8"></div>
	
</body>
    <script type="text/javascript">
    // const ap9 = new APlayer({
    // container: document.getElementById('aplayer1'),
    // mini: true,
    // autoplay: false,
    // theme: '#FADFA3',
    // lrcType: 3,
    // audio: [{
    //     name: '光るなら',
    //     artist: 'Goose house',
    //     url: 'https://moeplayer.b0.upaiyun.com/aplayer/hikarunara.mp3',
    //     cover: 'https://moeplayer.b0.upaiyun.com/aplayer/hikarunara.jpg',
    //     lrc: 'https://moeplayer.b0.upaiyun.com/aplayer/hikarunara.lrc',
    //     theme: '#ebd0c2'
    // }]
    // });
    $.ajax({
        url: "https://api.i-meto.com/meting/api?server=netease&type=playlist&id=649371983",
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
    $.ajax({
        url: "https://api.i-meto.com/meting/api?server=netease&type=playlist&id=561163114",
        success: function (e) {
        	const ap = new APlayer({
                container: document.getElementById('aplayer3'),
                mutex: true,
                listFolded: true,
                listMaxHeight: '500px',
                lrcType: 3,
                audio: JSON.parse(e)
                
            });
        }
    });
    $.ajax({
        url: "https://api.i-meto.com/meting/api?server=netease&type=playlist&id=558189534",
        success: function (e) {
        	const ap = new APlayer({
                container: document.getElementById('aplayer4'),
                mutex: true,
                listFolded: true,
                listMaxHeight: '500px',
                lrcType: 3,
                audio: JSON.parse(e)
                
            });
        }
    });
    $.ajax({
        url: "https://api.i-meto.com/meting/api?server=netease&type=playlist&id=388653572",
        success: function (e) {
        	const ap = new APlayer({
                container: document.getElementById('aplayer5'),
                mutex: true,
                listFolded: true,
                listMaxHeight: '500px',
                lrcType: 3,
                audio: JSON.parse(e)
                
            });
        }
    });
    $.ajax({
        url: "https://api.i-meto.com/meting/api?server=netease&type=playlist&id=382622520",
        success: function (e) {
        	const ap = new APlayer({
                container: document.getElementById('aplayer6'),
                mutex: true,
                listFolded: true,
                listMaxHeight: '500px',
                lrcType: 3,
                audio: JSON.parse(e)
                
            });
        }
    });
    $.ajax({
        url: "https://api.i-meto.com/meting/api?server=netease&type=playlist&id=382614627",
        success: function (e) {
        	const ap = new APlayer({
                container: document.getElementById('aplayer7'),
                mutex: true,
                listFolded: true,
                listMaxHeight: '500px',
                lrcType: 3,
                audio: JSON.parse(e)
                
            });
        }
    });
    $.ajax({
        url: "https://api.i-meto.com/meting/api?server=netease&type=playlist&id=382511830",
        success: function (e) {
        	const ap = new APlayer({
                container: document.getElementById('aplayer8'),
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