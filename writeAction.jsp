<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="bbs.BbsDAO"%>

<!-- bbsdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter"%>

<!-- 자바 클래스 사용 -->

<%

	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");

%>


<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->

<jsp:useBean id="bbs" class="bbs.bbs" scope="page" />

<!-- // Bbs bbs = new Bbs(); -->

<jsp:setProperty name="bbs" property="bbsName" /><!-- bbs.setBbsTitle(requrst) -->
<jsp:setProperty name="bbs" property="userNickname" />
<jsp:setProperty name="bbs" property="userPassword" />
<jsp:setProperty name="bbs" property="userIp" />
<jsp:setProperty name="bbs" property="bbsContent" />

<%

	System.out.println(bbs);

%>

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Finduo</title>
</head>
<body>

	<%
	if (bbs.getBbsName() == null || bbs.getBbsContent() == null || bbs.getUserNickname() == null || bbs.getUserPassword() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 사항이 있습니다')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		BbsDAO BbsDAO = new BbsDAO();
		int result = BbsDAO.write(bbs.getBbsName(), bbs.getUserNickname(), bbs.getUserPassword(), bbs.getBbsContent(), bbs.getUserIp());
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='board.jsp'");
			//script.println("history.back()");
			script.println("</script>");
		}
	}
	
	%>
</body>
</html>