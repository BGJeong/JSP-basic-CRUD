<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %> 
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %> 
<jsp:useBean id="user" class="user.User" scope="page" /> 
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판!!</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null) { 
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
			 script.println("alert('이미 로그인 되었습니다.')");
			 script.println("location.hrer('main.jsp'"); //이전 페이지로 돌려보냄(login 페이지)
			 script.println("</script>");		
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword()); 
		 /*public int login(String userID, String userPassword) //로그인 처리하는 함수
	          userDAO의 login() return -2(DB오류), -1(입력된 ID가 없음), 0(로그인 실패-비밀번호 오류), 1(로그인 성공)이 저장*/
		 
		 if(result == 1)
		 {
			 session.setAttribute("userID", user.getUserId());
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
			 script.println("location.href = 'main.jsp'");
			 script.println("</script>"); 
		 }
		 
		 else if(result == 0)
		 {
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
			 script.println("alert('비밀번호가 틀립니다.')");
			 script.println("history.back()"); //이전 페이지로 돌려보냄(login 페이지)
			 script.println("</script>");
		 }
		 
		 else if(result == -1)
		 {
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
			 script.println("alert('존재하지 않는 아이디입니다!!')");
			 script.println("history.back()"); //이전 페이지로 돌려보냄(login 페이지)
			 script.println("</script>");
		 }
		 
		 else if(result == -2)
		 {
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
			 script.println("alert('데이터베이스 오류가 발생했습니다!!')");
			 script.println("history.back()"); //이전 페이지로 돌려보냄(login 페이지)
			 script.println("</script>");
		 }
	%>
</body>
</html>
