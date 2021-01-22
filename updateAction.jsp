<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>

<%@ page import="bbs.BbsDAO"%>

<%@ page import="bbs.bbs"%>

<%@ page import="java.io.PrintWriter"%>

<%

	request.setCharacterEncoding("UTF-8");

	//sresponse.setContentType("text/html; charset=UTF-8");

%>

<!DOCTYPE html>

<html>

<head>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Finduo</title>

</head>

<body>

	<%

		//글이 유효한지 판별

		int number = 0;
		if (request.getParameter("number") != null) {
			number = Integer.parseInt(request.getParameter("number"));
		}
		if (number == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
		bbs bbs = new BbsDAO().getBbs(number);			
		if (request.getParameter("bbsName") == null || request.getParameter("bbsContent") == null
				|| request.getParameter("bbsName").equals("") || request.getParameter("bbsContent").equals("") ) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			BbsDAO BbsDAO = new BbsDAO();
			int result = BbsDAO.update(number, request.getParameter("bbsName"), request.getParameter("bbsContent"));
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글수정에 실패했습니다')");
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