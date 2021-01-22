<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.team_BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!-- 자바 클래스 사용 -->

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>

<jsp:useBean id="bbs" class="bbs.team_bbs" scope="page" />

<!-- // Bbs bbs = new Bbs(); -->

<jsp:setProperty name="bbs" property="name" /><!-- bbs.setBbsTitle(requrst) -->
<jsp:setProperty name="bbs" property="password" />
<jsp:setProperty name="bbs" property="content" />
<jsp:setProperty name="bbs" property="AVGtier" />
<jsp:setProperty name="bbs" property="top" />
<jsp:setProperty name="bbs" property="mid" />
<jsp:setProperty name="bbs" property="bot" />
<jsp:setProperty name="bbs" property="support" />
<jsp:setProperty name="bbs" property="jungle" />


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
	if ( bbs.getAVGtier() == null  || bbs.getcontent() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 사항이 있습니다')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		team_BbsDAO team_BbsDAO = new team_BbsDAO();
		int result = team_BbsDAO.update(bbs.getAVGtier(), bbs.gettop(), bbs.getjungle(), bbs.getmid(), bbs.getbot(), bbs.getsupport(), bbs.getcontent() ,bbs.getname());
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='team.jsp'");
			//script.println("history.back()");
			script.println("</script>");
		}
	}
	
	%>
</body>
</html>