package com.jxufe.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


public class CrawlerUtil {

	
		public static void main(String[] args) throws IOException {
			String startPage="http://99dyy.cn/index.php?m=vod-play-id-5401-src-1-num-1.html";
			 
			Document doc = Jsoup.connect(startPage)
					.userAgent("Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko)Chrome/52.0.2743.116 Safari/537.36")
					.get();
			/*Document document = Jsoup.connect("http://aaxxy.com/vod-play-id-11920-src-1-num-1.html")
	                   .data("query", "Java")
	                   .userAgent("Mozilla")
	                   .cookie("auth", "token")
	                   .timeout(3000)
	                   .post();*/
			Document document = Jsoup.connect("http://99dyy.cn/index.php?m=vod-play-id-5401-src-1-num-1.html")
	                   .data("query", "Java")
	                   .userAgent("Mozilla")
	                   .cookie("auth", "token")
	                   .timeout(3000)
	                   .post();
			
			
			String title = doc.title();
			System.out.println(title);
			/*Element container = document.getElementById("jp_video_0");
			System.out.println(container.attr("src"));*/
//			Elements imgList = container.getElementsByTag("video");
//			for (Element li : imgList){
//				
//					System.out.println(li.attr("src"));
//				}
//				
//			}
			
//			Elements liList = container.getElementsByTag("li");
//			for (Element li : liList) {
//				Elements imgList = li.getElementsByTag("img");
//				for (Element img : imgList) {
//					System.out.println(img.attr("src"));
//				}
//            }
		}
	
		public void getHtmlStr(String htmlUrl){
			String r;
			//1.新建url对象，表示要访问的网页
			try { 
				URL url = new URL(htmlUrl);
				//2.建立http连接,返回连接对象urlconnection
				HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
				//3.获取相应的http状态码，
				int responseCode= urlConnection.getResponseCode();
				//4.如果获取成功，从URLconnection对象获取输入流来获取请求网页的源代码
				if(responseCode == 200){
					BufferedReader reader = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(), "utf-8"));
					while((r=reader.readLine())!=null){
						System.out.println(r);
						}
					}else{
				System.out.println("获取不到源代码 ，服务器响应代码为："+responseCode);
				}
			} catch (Exception e) {
			System.out.println("获取不到网页源码："+e);
			}
		}
		
		
//		复制单个文件 
//		 @param oldPath String 原文件路径 如：c:/fqf.txt 
//		 @param newPath String 复制后路径 如：f:/fqf.txt 
//		 @return boolean 
		 
		public static void copyFile(String oldPath, String newPath) { 
			try { 
				int bytesum = 0; 
				int byteread = 0; 
				File oldfile = new File(oldPath); 
				if (oldfile.exists()) { //文件存在时 
					InputStream inStream = new FileInputStream(oldPath); //读入原文件 
					FileOutputStream fs = new FileOutputStream(newPath); 
					byte[] buffer = new byte[1444]; 
					int length; 
					while ( (byteread = inStream.read(buffer)) != -1) { 
						bytesum += byteread; //字节数 文件大小 
						System.out.println(bytesum); 
						fs.write(buffer, 0, byteread); 
						} 
					inStream.close(); 
					} 
				} 
			catch (Exception e) { 
			System.out.println("复制单个文件操作出错"); 
			e.printStackTrace(); 
	
			} 

		} 
		
}
