<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%-- <jsp:forward page="/common/filePage"></jsp:forward> --%>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
	//path = request.getContextPath();
	//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>

<link rel="stylesheet" href="${APP_PATH}/static/indexResourse/bootstrap.css">

<!-- Theme style  -->
<link rel="stylesheet" href="${APP_PATH}/static/indexResourse/style.css">




</head>
<body>
 	<div id="page">
	<nav class="fh5co-nav" role="navigation">
		<div class="container">
			<div class="row">
				<div class="col-xs-2">
					<div id="fh5co-logo"><a href="index.jsp">Fantasy</a></div>
				</div>
				<div class="col-xs-10 text-right menu-1">
					<ul>
						<li class="active"><a href="index.jsp">Home</a></li>
						<li><a href="test.jsp">Music</a></li>
						<!-- <li class="has-dropdown">
							<a href="services.html">Services</a>
							<ul class="dropdown">
								<li><a href="#">Web Design</a></li>
								<li><a href="#">eCommerce</a></li>
								<li><a href="#">Branding</a></li>
								<li><a href="#">API</a></li>
							</ul>
						</li>
						<li class="has-dropdown">
							<a href="#">Tools</a>
							<ul class="dropdown">
								<li><a href="#">HTML5</a></li>
								<li><a href="#">CSS3</a></li>
								<li><a href="#">Sass</a></li>
								<li><a href="#">jQuery</a></li>
							</ul>
						</li>
						<li><a href="work.html">Work</a></li>
						<li><a href="contact.html">Contact</a></li> -->
					</ul>
				</div>
			</div>
			
		</div>
	</nav>

	<header id="fh5co-header" class="fh5co-cover" role="banner" style="background-image:url(${APP_PATH}/imgs/img_bg_1.jpg);">
		<div class="overlay"></div>
		<div class="container">
			<div class="row">
				<div class="col-md-10 col-md-offset-1 text-center">
					<div class="display-t">
						<div class="display-tc animate-box" data-animate-effect="fadeIn">
							<h1>Welcome To Fantasy</h1>
							<p><a href="/MyWeb/common/filePage" class="btn btn-default">Start</a></p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</header>
</div>
</body>
</html>