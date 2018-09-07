package com.jxufe.utils;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.Node;
import org.jsoup.select.Elements;

public class TestCrawler {
	
	private static int size = 0;
	
	private static int pages = 0;

	static String[] head = new String[3];
	
	static List<MyData> data = new ArrayList<>();
	
	public static void main(String[] args) throws IOException {
		String startPage="http://fund.eastmoney.com/f10/F10DataApi.aspx?type=lsjz&code=001234&page=1&per=892";
		 
		Document doc = Jsoup.connect(startPage)
				.userAgent("Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko)Chrome/52.0.2743.116 Safari/537.36")
				.get();
		
		Element body = doc.body();
		
		Elements elementsByTag = body.getElementsByTag("th");
		for (int i = 0; i < elementsByTag.size()-3; i++) {
			
			head[i] = elementsByTag.get(i).text();
		}
		
		Elements getdata = body.getElementsByTag("tbody").get(0).getElementsByTag("tr");
		for (int i = 0; i < getdata.size(); i++) {
			MyData temp = new MyData();
			Elements elementsByTag2 = getdata.get(i).getElementsByTag("td");
			
			temp.setValue1(elementsByTag2.get(0).text());
			temp.setValue2(elementsByTag2.get(1).text());
			temp.setValue3(elementsByTag2.get(2).text());
			data.add(temp);
			
		}
		
		getExcel();
		
	}
	public static void getExcel(){
		 //第一步，创建一个workbook对应一个excel文件
        HSSFWorkbook workbook = new HSSFWorkbook();
        //第二部，在workbook中创建一个sheet对应excel中的sheet
        HSSFSheet sheet = workbook.createSheet("用户表一");
        //第三部，在sheet表中添加表头第0行，老版本的poi对sheet的行列有限制
        HSSFRow row = sheet.createRow(0);
        //第四步，创建单元格，设置表头
        HSSFCell cell = row.createCell(0);
        cell.setCellValue(head[0]);
        cell = row.createCell(1);
        cell.setCellValue(head[1]);
        cell = row.createCell(2);
        cell.setCellValue(head[2]);
        //第五步，写入实体数据，实际应用中这些数据从数据库得到,对象封装数据，集合包对象。对象的属性值对应表的每行的值
        
        for (int i = 0; i < data.size(); i++) {
            HSSFRow row1 = sheet.createRow(i + 1);
            MyData mydata = data.get(i);
            //创建单元格设值
            row1.createCell(0).setCellValue(mydata.getValue1());
            row1.createCell(1).setCellValue(mydata.getValue2());
            row1.createCell(2).setCellValue(mydata.getValue3());
        }

        //将文件保存到指定的位置
        try {
            FileOutputStream fos = new FileOutputStream("E:\\user1.xls");
            workbook.write(fos);
            System.out.println("写入成功");
            fos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
	
	public static void getInfo() throws IOException{
		String startPage="http://fund.eastmoney.com/f10/F10DataApi.aspx?type=lsjz&code=000198&page=1&per=20";
		 
		Document doc = Jsoup.connect(startPage)
				.userAgent("Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko)Chrome/52.0.2743.116 Safari/537.36")
				.get();
		
		Element body = doc.body();
		
		String temp = body.toString().substring(body.toString().indexOf("{")+1, body.toString().indexOf("}"));
		String[] datalist = temp.split(",");
		size = Integer.valueOf(datalist[1].substring(datalist[1].indexOf(":")+1));
		pages = Integer.valueOf(datalist[2].substring(datalist[2].indexOf(":")+1));
	}
}
