package com.jxufe.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jxufe.entity.Msg;
import com.jxufe.entity.Music;
import com.jxufe.service.MusicService;



@Controller
public class FileController {
	
	
	@Autowired
	private MusicService musicService;

	@RequestMapping("/common/filePage")
	public String goFilePage(){
		
		return "uploadAndDownload";
		
	}
	
	@RequestMapping("/common/musicList")
	@ResponseBody
	public Msg getEmpList(@RequestParam(value="pn", defaultValue="1") Integer pn){
		
		/*
		 * PageHelper.startPage() 后要紧跟查询语句
		 */
		PageHelper.startPage(pn, 7);
		List<Music> allMusic = musicService.getAllMusic();
		
		//使用pageInfo包装查询结果，在将pageInfo交给页面
		//param: 分页信息 ， 连续显示页数
		PageInfo<Music> page = new PageInfo<Music>(allMusic,5);
		
		return Msg.success().add("pageInfo", page);
		
	}
	
	@RequestMapping(value="/user/upload",method=RequestMethod.POST)
	@ResponseBody
    public Msg upload(HttpServletRequest request,
           @RequestParam("singer") String singer,
           @RequestParam("file") MultipartFile file) throws Exception {

       //如果文件不为空，写入上传路径
       if(!file.isEmpty()) {
           //上传文件路径
           String path = request.getServletContext().getRealPath("/musicFile/");
           //上传文件名
           String filename = file.getOriginalFilename();
           File filepath = new File(path,filename);
           //判断路径是否存在，如果不存在就创建一个
           if (!filepath.getParentFile().exists()) { 
               filepath.getParentFile().mkdirs();
           }
           //将上传文件保存到一个目标文件当中
           file.transferTo(new File(path + File.separator + filename));
           //将数据保存到数据库
           
           Music music = new Music();
           music.setMusicName(filename);
           music.setSinger(singer);
           double size = 1048576; //1M
           BigDecimal bg = new BigDecimal((double)file.getSize() / size);
           Float d3 = bg.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
           music.setSize(d3);
           Date date = new Date();
           //SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd :hh:mm:ss");
           music.setTime(date);
           music.setLocation(filename);
           music.setWhoUpload("Admin");
           musicService.addMusic(music);
          
           return  Msg.success();
          
       } else {
           return Msg.fail();
       }

    }
	
	@RequestMapping(value="/user/download")
	@ResponseBody
	public ResponseEntity<byte[]>  testDownload(@RequestParam("filename") String filename,
			HttpServletRequest request,HttpServletResponse resp){
        
        String path=request.getServletContext().getRealPath("/musicFile/");
        System.out.println(path);
        File file = new File(path + File.separator + filename);
       
        InputStream in =null;
        ResponseEntity<byte[]> response=null ;
        try {
            in = new FileInputStream(file);
            byte[] b=new byte[in.available()];
            in.read(b);
            HttpHeaders headers = new HttpHeaders();
            filename =  new String(filename.getBytes("UTF-8"),"iso-8859-1");
            //MediaType mt = new MediaType("application/vnd.android.package-archive");
            //headers.setContentType(mt);
            //以下的类型必须要设置，要不不能在android机上正常下载的   
            headers.add("Content-Disposition", "attachment;filename="+filename);
            
            //resp.setContentType("application/vnd.android.package-archive");
            resp.setContentType("application/octet-stream");
            HttpStatus statusCode=HttpStatus.OK;
            response = new ResponseEntity<byte[]>(b, headers, statusCode);  
            
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally{
            try {
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            
        }
        return response;
    }
    
    
    
    @RequestMapping(value="/common/findMusic/{musicId}" ,method= RequestMethod.GET)
	@ResponseBody
	public Msg findEmp(@PathVariable("musicId") Integer musicId ){
		
		Music findMusic = musicService.findmusic(musicId);
		return Msg.success().add("findMusic", findMusic);
		
		
	}
}
