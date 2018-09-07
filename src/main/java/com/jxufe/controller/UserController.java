package com.jxufe.controller;



import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.jxufe.entity.User;
import com.jxufe.service.UserService;
import com.jxufe.shiro.realms.ShiroRealm;
import com.jxufe.utils.EmailUtils;

@Controller
public class UserController {
	
	private String valData = null;
	
	@Autowired
	private UserService userService;

	@RequestMapping("/login")
	public String login(@RequestParam String username,  @RequestParam String password, Model model,HttpSession session){
		
		UsernamePasswordToken token = new UsernamePasswordToken(username, password);  
		System.out.println(username);
		System.out.println(password);
		 //获取当前的Subject  
        Subject currentUser = SecurityUtils.getSubject();  
        //判断是否认证
        if(!currentUser.isAuthenticated()){  
        	//在调用了login方法后,SecurityManager会收到AuthenticationToken,并将其发送给已配置的Realm执行必须的认证检查  
            //每个Realm都能在必要时对提交的AuthenticationTokens作出反应  
        	try {
        		currentUser.login(token);
                System.out.println("用户[" + username + "]登录认证通过()");  
                User findUser = null;
                if(username.contains("@")){
                	findUser = userService.findUserByEmail(username);
                }else{
                	findUser = userService.findUserByName(username);
                }
                session.setAttribute("username",findUser.getUserName());
                session.setAttribute("userPic",findUser.getUserPic());
                
			}catch(UnknownAccountException uae){  
	            System.out.println("对用户[" + username + "]进行登录验证..验证未通过,未知账户");  
	            model.addAttribute("loginError", uae.getMessage());
	            return "login";
			}
        	catch(IncorrectCredentialsException ice){  
                System.out.println("对用户[" + username + "]进行登录验证..验证未通过,错误的凭证");  
                model.addAttribute("loginError", "密码输入错误"); 
                return "login";
        	}
        }  
      //获取之前的地址
      	String resultPageURL = InternalResourceViewResolver.REDIRECT_URL_PREFIX + "/";
      	String nextUrl = (String) session.getAttribute("nextUrl");
      	System.out.println("之前的地址"+nextUrl);
		return resultPageURL + "common/filePage";
	}
	
	@RequestMapping("/emailValidate")
	@ResponseBody
	public String emailValidate(@RequestParam("email") String email){
		String validateMsg = userService.emailValidate(email);
		return validateMsg;
	}
	
	//发送验证码
	@RequestMapping("/sendValData")
	@ResponseBody
	public void sendValData(@RequestParam("email") String email, HttpSession session){
		String subject ="Fantasy的验证邮件";
		valData = getRandomNumCode(4);
		System.out.println(email);
		System.out.println(valData);
		String content = "您好,欢迎注册Fantasy账号:<br>&nbsp;&nbsp;您的验证码为:&nbsp;&nbsp;<p style='color:#9A32CD;font-weight:bold;'>  "+valData+"  </p>"+
							"<br>&nbsp;&nbsp;请勿告诉他人哦";
		try {
			EmailUtils.sendEmail(email, "用户", subject, content);
			session.setAttribute("valData", valData);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping("/tologin")
	public String tologin(HttpSession session){
		return "login";
	}
	@RequestMapping("/toregister")
	public String toregister(HttpSession session){
		return "register";
	}
	
	@RequestMapping("/register")
	public String register(HttpServletRequest request, Model model){
		User user = new User();
		user.setUserName(request.getParameter("username"));
		user.setPassword(ShiroRealm.MD5EntryPssword(request.getParameter("password"),request.getParameter("username")).toString());
		user.setUserEmail(request.getParameter("email"));
		user.setRegisterCode("000000000");
		String codetext = request.getParameter("codetext");
		String resultPageURL = InternalResourceViewResolver.FORWARD_URL_PREFIX + "/";
		if(codetext.equals(valData)){
			
			String register = userService.register(user);
			//获取之前的地址
		  	
			if(register.equals("ok")){
				return "login";
			}
			else return resultPageURL+"register";
			}
		
		else{
			model.addAttribute("registerError","验证码不一致");
			return "register";
		}
	}
	public String getRandomNumCode(int size){
		String codeNum = "";  
        int [] numbers = {0,1,2,3,4,5,6,7,8,9};  
        Random random = new Random();  
        for (int i = 0; i < size; i++) {  
            int next = random.nextInt(10000);//目的是产生足够随机的数，避免产生的数字重复率高的问题  
            codeNum+=numbers[next%10];  
        }  
        System.out.println("--------"+codeNum);  
    return codeNum;   
	}
	
}
