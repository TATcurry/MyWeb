package com.jxufe.utils;

import java.util.Properties;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class EmailUtils {

	//
	public static void sendEmail(String address, String personal, String subject, String content) throws Exception{
		//创建一封邮件
		
		//
		Properties props = new Properties();
		//使用的协议
		props.setProperty("mail.transport.protocol", "smtp");
		//邮箱的服务器地址
		props.setProperty("mail.smtp.host", SendEmailConfig.EMAIL_SMTP_URL);
		//授权
		props.setProperty("mail.smtp.auth", "true");
		
		//props.setProperty("mail.smtp.timeout", "500000");
		//端口
		props.setProperty("mail.smtp.port", "587");
		//配置一个邮箱Session
		
		Session session = Session.getDefaultInstance(props);
		//创建邮件
		MimeMessage message = new MimeMessage(session);
		//设置发送人
		message.setFrom(new InternetAddress(SendEmailConfig.FROM_ADDRESS, SendEmailConfig.SEND_NICKNAME, "UTF-8"));
		//设置收件人
		message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(address, personal, "UTF-8"));
		//设置邮件主题
		message.setSubject(subject, "UTF-8");
		//设置邮件内容
		message.setContent(content, "text/html; charset=UTF-8;");
		//保存
		message.saveChanges();
		
		//发送
		
		//邮件传递者
		Transport transport = session.getTransport();
		//授权
		transport.connect(SendEmailConfig.FROM_ADDRESS, SendEmailConfig.EMAIL_PWD);
		//发送
		transport.sendMessage(message, message.getAllRecipients());
		//
		transport.close();
	}
}
