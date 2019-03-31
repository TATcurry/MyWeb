package com.jxufe.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jxufe.service.UserService;
import com.jxufe.utils.ImageUtils;

import net.sf.json.JSONObject;


@Controller
public class SomeController {
	@Autowired
	private UserService userService;

	@RequestMapping("changeUserPic")
	@ResponseBody
	public Map<String, String> changeUserPic(HttpServletRequest request,
			@RequestParam("avatar_file") MultipartFile file,
			@RequestParam("avatar_data") String dataStr,HttpSession session) throws IllegalStateException, IOException{
		
		JSONObject data = JSONObject.fromObject(dataStr);
		
		
		int height = (int) data.get("height");
		int width = (int) data.get("width");
		int startX = (int) data.get("x");
		int startY = (int)data.get("y");
		Map<String, String> map = new HashMap<String, String>();
		
		if(!file.isEmpty()&&(height > 0 && width > 0 && startX > 0 && startY > 0)) {
	           //上传文件路径
	           String path = request.getServletContext().getRealPath("/userImageFile/");
	           //上传文件名
	           String filename = file.getOriginalFilename();
	           String fileType = filename.substring(filename.indexOf(".") + 1).toLowerCase();
	           
	           String name = UUID.randomUUID().toString()+ filename.substring(filename.indexOf("."));
	           File filepath = new File(path,name);
	           //判断路径是否存在，如果不存在就创建一个
	           if (!filepath.getParentFile().exists()) { 
	               filepath.getParentFile().mkdirs();
	           }
	           //将上传文件保存到一个目标文件当中
	           String imagepath = path + File.separator + name;
	           System.out.println(imagepath);
	           file.transferTo(new File(imagepath));
	           
	           
	           //开始剪裁
	           ImageUtils test = new ImageUtils();
	           test.input = new FileInputStream(imagepath); 
	           test.out = imagepath; 
	           test.cutImage(fileType,startX, startY, width, height);
	           
	           //更新数据库
	           String picPath = request.getContextPath()+File.separator+"userImageFile"+File.separator+ name;
	           userService.updateUser(session.getAttribute("username").toString(), picPath);
	           session.setAttribute("userPic", picPath);
	   		   map.put("result", picPath);
		}
		//前台做了校验，不能上传 
		return map;
	}
	
	
	@RequestMapping("/toUserPage")
	public String toUserPage(){
		return "userPage";
		
	}
	
}
