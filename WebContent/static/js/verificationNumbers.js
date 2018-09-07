function showCheck(a){
	var c = document.getElementById("myCanvas");
  var ctx = c.getContext("2d");
	ctx.clearRect(0,0,1000,1000);
	ctx.font = "80px 'Microsoft Yahei'";
	ctx.fillText(a,0,100);
	ctx.fillStyle = "white";
}
var code ;    
function createCode(){       
    code = "";      
    var codeLength = 4;
    var selectChar = new Array(1,2,3,4,5,6,7,8,9,'a','b','c','d','e','f','g','h','j','k','l','m','n','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z');      
    for(var i=0;i<codeLength;i++) {
       var charIndex = Math.floor(Math.random()*60);      
      code +=selectChar[charIndex];
    }      
    if(code.length != codeLength){      
      createCode();      
    }
    showCheck(code);
}
         
function validate() {
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;
   
    var errorBox = $("#J_codetext p");
    if(username=="" || username==null) {
    	//$(".error_icon").style.display="block";
    	errorBox.text("请输入账号！");
      return false;
    }
    else  if(password==null|| password=="") {
    	//document.getElementsByClassName("error_icon").style.display="block";
    	errorBox.text("请输入密码！");
        return false;
      }
    else {
    	errorBox.text("");
    	//document.getElementsByClassName("error_icon").style.display="none";
        return true;
    }

}
var status = null;
function emailValidate() {
	var email = document.getElementById("email").value;
	var errorBox = $("#error_text p");
	if(email != null ) {
    	$.ajax({
    		url:"/MyWeb/emailValidate",
    		data: "email="+email,
    		type:"POST",
    		async:false,
    		success: function(result){
    			if(result=="exist"){
    				errorBox.text("该邮箱已被使用验证");
    				$(".ver_btn").attr("disabled","disabled");
    				$(".ver_btn").attr("style","background:#CDCDC1;");
    			}
    			else {
    				errorBox.text("");
    				$(".ver_btn").removeAttr("disabled");
    				$(".ver_btn").attr("style","background:#ff5f11;");
    				status = "ok";
    			}
    		},
    	});
    	
      }
}
var countdown=60; 
var t = null;
function sendValData(){
	var email = document.getElementById("email").value;
	var errorBox = $("#error_text p");
	var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/; 
	var result = reg.test(email);
	if(email == null || email ==""){
		errorBox.text("未填写邮箱地址！");
	}
	else if(result == false){
		errorBox.text("邮箱地址格式不正确！");
	}
	
	else if(status == "ok"){
		$.ajax({
			url:"/MyWeb/sendValData",
			data: "email="+email,
			type:"POST",
			success: function(result){
				alert("验证码已发送至邮箱,请注意查收!");
			},
		});
		var test = document.getElementById("send");
		settime(test);
	}
	
	
	
}

function settime(val) { 
	if (countdown == 0) { 
		val.removeAttribute("disabled"); 
		val.setAttribute("style", "background:#ff5f11;"); 
		val.value="获取验证码"; 
		countdown = 60; 
		clearTimeout(t);
		return;
	} else { 
		val.setAttribute("disabled", true); 
		val.value="已发送(" + countdown + ")"; 
		val.setAttribute("style", "background:#CDCDC1;"); 
		countdown--; 
	} 
	t = setTimeout(function() { 
		settime(val) 
	},1000) 
} 
function register_validate() {
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;
    var email = document.getElementById("email").value;
    var codetext = document.getElementById("codetext").value;
    
    var errorBox = $("#error_text p");
    if(username=="" || username==null) {
    	//$(".error_icon").style.display="block";
    	errorBox.text("请输入账号！");
      return false;
    }
    else  if(password==null|| password=="") {
    	//document.getElementsByClassName("error_icon").style.display="block";
    	errorBox.text("请输入密码！");
        return false;
      }
    else  if(email==null|| email=="") {
    	//document.getElementsByClassName("error_icon").style.display="block";
    	errorBox.text("请输入邮箱！");
        return false;
      }
    else  if(codetext==null|| codetext=="") {
    	
    	errorBox.text("请输入验证码！");
        return false;
      }
    
    else {
    	errorBox.text("");
    	alert("恭喜您，注册成功！");
        return true;
    }

}