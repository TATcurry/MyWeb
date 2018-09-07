package com.jxufe.shiro.realms;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthenticatingRealm;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.jxufe.entity.User;
import com.jxufe.service.UserService;

public class ShiroRealm extends AuthenticatingRealm {

	@Autowired
	private UserService userService;
	
	/*
	 * 
	 * @see 该方法的调用时机为UserController.login()方法中执行Subject.login()时
	 */
	@SuppressWarnings("unused")
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
		// TODO Auto-generated method stub
		
		  UsernamePasswordToken token = (UsernamePasswordToken)authcToken; 
		  String username = token.getUsername();
		  User findUser = null;
		  Object principal = null;
		  if(username.contains("@")){
			  findUser = userService.findUserByEmail(username);
			  principal = findUser.getUserEmail();
		  }else{
			  findUser = userService.findUserByName(username);
			  principal = findUser.getUserName();
		  }
		  
		  
		  if(findUser == null){
			  throw new UnknownAccountException("该用户不存在");
		  }else
		  if(findUser.getValidateStatus() != 0){
			  throw new UnknownAccountException("该账号未被有效的邮箱验证");
		  }
		  /*
		   * principal ：认证的实体信息
		   * credentials : 从数据库获取的密码 
		   * realmName : 用户的角色，调用父类的getName()
		   */
		  //由shiro完成密码比对
		  /*Object principal = findUser.getUserName();*/
		  Object credentials = findUser.getPassword();
		  System.out.println(credentials);
		  String realmName = getName();
		  //把用户名做盐值
		  ByteSource credentialsSalt = ByteSource.Util.bytes(findUser.getUserName());
		  
		  SimpleAuthenticationInfo info  = null;
		  info = new SimpleAuthenticationInfo(principal, credentials, credentialsSalt, realmName);
		  
		  return info;
	}
	//MD5盐值加密
	public static Object MD5EntryPssword(Object source , Object salt){
		String algorithmName = "MD5";
		
		int hashIterations = 1024;
		Object simpleHash = new SimpleHash(algorithmName, source, salt, hashIterations);
		return simpleHash;
		
	}

}
