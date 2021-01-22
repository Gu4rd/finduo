<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.scream_BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!-- 자바 클래스 사용 -->

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>

<jsp:useBean id="bbs" class="bbs.scream_bbs" scope="page" />

<!-- // Bbs bbs = new Bbs(); -->

<jsp:setProperty name="bbs" property="name" /><!-- bbs.setBbsTitle(requrst) -->
<jsp:setProperty name="bbs" property="leadername" />
<jsp:setProperty name="bbs" property="content" />
<jsp:setProperty name="bbs" property="AVGtier" />
<jsp:setProperty name="bbs" property="password" />


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
	if (bbs.getAVGtier() == null || bbs.getname() == null || bbs.getcontent() == null || bbs.getleadername() == null || bbs.getpassword() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 사항이 있습니다')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		scream_BbsDAO scream_BbsDAO = new scream_BbsDAO();
		int result = scream_BbsDAO.write(bbs.getAVGtier(), bbs.getname(), bbs.getcontent());
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='scream.jsp'");
			//script.println("history.back()");
			script.println("</script>");
		}
	}
	
	%>
</body>
</html>