<%@ page language="java" contentType = "text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.duo_BbsDao"%>
<%@ page import="java.io.PrintWriter"%>
<!-- 자바 클래스 사용 -->

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>

<jsp:useBean id="bbs" class="bbs.duo_bbs" scope="page" />

<!-- // Bbs bbs = new Bbs(); -->

<jsp:setProperty name="bbs" property="nickname" /><!-- bbs.setBbsTitle(requrst) -->
<jsp:setProperty name="bbs" property="password" />
<jsp:setProperty name="bbs" property="content" />
<jsp:setProperty name="bbs" property="me_tier" />
<jsp:setProperty name="bbs" property="me_line" />
<jsp:setProperty name="bbs" property="you_line" />


<%
	System.out.println(bbs);
    System.out.println(bbs.getnickname());
%>

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Finduo</title>
</head>
<body>

	<%
	if (bbs.getme_tier() == null || bbs.getme_line() == null || bbs.getyou_line() == null || bbs.getcontent() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 사항이 있습니다')");
		script.println("history.back()");
		script.println("</script>");
    } else {
		duo_BbsDao duo_BbsDao = new duo_BbsDao();
        int result = duo_BbsDao.update(bbs.getme_tier(), bbs.getme_line(), bbs.getyou_line(), bbs.getcontent(), bbs.getnickname());
        if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('수정에 실패했습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href='duo.jsp'");
            //script.println("history.back()");
            script.println("</script>");
        }
    }
	
	%>
</body>
</html>