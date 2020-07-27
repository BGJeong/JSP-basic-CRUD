<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> 
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트문을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 모든 데이터를 UTF-8로 받음 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" /> 
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />

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
		if(userID == null ){ 
		 PrintWriter script = response.getWriter();
		 script.println("<script>");
		 script.println("alert('로그인을 하세요.')");
		 script.println("location.href='login.jsp'"); //이전 페이지로 돌려보냄(login 페이지)
		 script.println("</script>");		
		} else {
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
			 PrintWriter script = response.getWriter();
			 script.println("<script>");
	 		 script.println("alert('아이디 또는 비밀번호또는 이름을 입력하지 않았습니다')");
			 script.println("history.back()"); 
			 script.println("</script>");
			}
			else
			{
				
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent()); //6~13라인에서의 각각의 값을 입력받은 user라는 인스턴스가 join 함수를 수행하도록 매개변수가 됨
			
			 if(result == -1)
			 {
				 PrintWriter script = response.getWriter();
				 script.println("<script>");
				 script.println("alert('글쓰기에 실패하였습니다.')");
				 script.println("history.back()"); //이전 페이지로 돌려보냄(join 페이지)
				 script.println("</script>"); 
			 }
			 else {
				 PrintWriter script = response.getWriter();
				 script.println("<script>");
				 script.println("location.href = 'bbs.jsp'");
				 script.println("</script>");
			 }
		}
		
	}
	%>
</body>
</html>