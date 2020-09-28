<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="user.User" %> 
<%@ page import="user.UserDAO" %> 
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트문을 작성하기 위해 사용 -->
<%@ page import="java.util.ArrayList"%>
<% request.setCharacterEncoding("UTF-8"); %> <!-- 모든 데이터를 UTF-8로 받음 -->
<jsp:useBean id="user" class="user.User" scope="page" /> 
<!-- id="빈이름", class="패키지.클래스명", scope="유효범위" page = 현재의 페이지에서만 사용 -->

<jsp:setProperty name="user" property="userID" />
<!-- name="빈이름", property="필드명", value="값" -->

<jsp:setProperty name="user" property="userPassword" />
<!-- joinAction페이지는 아이뒤, 비밀번호 외에도 이름, 성별, 이메일을 입력받아야 하므로 추가한다.  -->

<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		
		
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		 script.println("alert('gg')");
		 script.println("history.back()");
		 script.println("</script>");
	%>
</body>
</html>