package com.jxufe.utils;

import java.awt.Rectangle;  
import java.awt.image.BufferedImage;  
import java.io.*;  
import java.util.Iterator;  
import javax.imageio.ImageIO;  
import javax.imageio.ImageReadParam;  
import javax.imageio.ImageReader;  
import javax.imageio.stream.ImageInputStream;  
  
public class ImageUtils {  
	
	public  FileInputStream input = null;
	public  FileOutputStream output = null;
	//输出图片地址
	public  String out = null;
	
	
    public  void cutJPG(int x,  int y, int width, int height) throws IOException { 
             
        ImageInputStream imageStream = null;  
        try {  
            Iterator<ImageReader> readers = ImageIO.getImageReadersByFormatName("jpg");  
            ImageReader reader = readers.next();  
            imageStream = ImageIO.createImageInputStream(input);  
            reader.setInput(imageStream, true);  
            ImageReadParam param = reader.getDefaultReadParam();  
              
            System.out.println(reader.getWidth(0));  
            System.out.println(reader.getHeight(0));  
            Rectangle rect = new Rectangle(x, y, width, height);  
            param.setSourceRegion(rect);  
            BufferedImage bi = reader.read(0, param);  
            ImageIO.write(bi, "jpg", new File(out));  
        } finally {  
        	if (input != null )  
        		input.close() ;      
	        if (imageStream != null )  
	    	   imageStream.close();  
            
        }  
    }  
      
      
    public  void cutPNG( int x,  int y, int width, int height) throws IOException { 
             
        ImageInputStream imageStream = null;  
        try {  
            Iterator<ImageReader> readers = ImageIO.getImageReadersByFormatName("png");  
            ImageReader reader = readers.next();  
            imageStream = ImageIO.createImageInputStream(input);  
            reader.setInput(imageStream, true);  
            ImageReadParam param = reader.getDefaultReadParam();  
              
            System.out.println(reader.getWidth(0));  
            System.out.println(reader.getHeight(0));
              
            Rectangle rect = new Rectangle(x, y, width, height);  
            param.setSourceRegion(rect);  
            BufferedImage bi = reader.read(0, param);  
            ImageIO.write(bi, "png", new File(out));  
        } finally {  
        	if (input != null )  
        		input.close() ;      
	        if (imageStream != null )  
	    	   imageStream.close();   
           
        }  
    }  
      
    public  void cutImage(String type,int x,  int y, int width, int height) throws IOException {  
           
        ImageInputStream imageStream = null;  
        try {  
            String imageType=(null==type||"".equals(type))?"jpg":type;  
            Iterator<ImageReader> readers = ImageIO.getImageReadersByFormatName(imageType);  
            ImageReader reader = readers.next();  
            imageStream = ImageIO.createImageInputStream(input);  
            reader.setInput(imageStream, true);  
            ImageReadParam param = reader.getDefaultReadParam();  
            Rectangle rect = new Rectangle(x, y, width, height);  
            param.setSourceRegion(rect);  
            BufferedImage bi = reader.read(0, param);  
            ImageIO.write(bi, imageType, new File(out)); 
            /*ImageIO.write(bi, imageType, output); */
            /*
             * 假如输出到原图片地址，ImageIO.write(),,第三个参数必须 new File
             * 而不是一个 FileOutputStream ，否则报错
             */
        } finally {  
        	if (input != null )  
        		input.close() ;      
	        if (imageStream != null )  
	    	   imageStream.close();   
            
        }  
    }  
  
      
    public static void main(String[] args) throws Exception {  
       /* ImageUtils.cutJPG(new FileInputStream("c:\\test.JPG"),  
                  new FileOutputStream("c:\\test2.jpg"), 0,0,200,100);  */
    	ImageUtils test = new ImageUtils();
    	test.input = new FileInputStream("D:\\11.jpg"); 
    	/*test.out = new FileOutputStream("D:\\66666666.jpg"); */
    	test.out = "D:\\66666666.jpg"; 		
    	test.cutImage("jpg",127,79,864,864);  
        System.out.println("ok");
    }  
}  