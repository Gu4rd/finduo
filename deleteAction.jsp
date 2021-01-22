<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="bbs.BbsDAO"%>

<%@ page import="java.io.PrintWriter"%>

<%

	request.setCharacterEncoding("UTF-8");

	//response.setContentType("text/html; charset=UTF-8");

%>
<jsp:useBean id="bbs" class="bbs.bbs" scope="page" />

<!-- // Bbs bbs = new Bbs(); -->
<jsp:setProperty name="bbs" property="userPassword" />

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Finduo</title>

</head>

<body>

	<%

		int number = 0;
		if(request.getParameter("number") != null){
			number = Integer.parseInt(request.getParameter("number"));
		}
		if(number == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다')");
			script.println("location.href='board.jsp'");
			script.println("</script>");
		}
    
        BbsDAO BbsDAO = new BbsDAO();
        if (bbs.getUserPassword() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호를 입력해주십시오.')");
            script.println("history.back()");
			script.println("</script>");            
        }
		else if(!bbs.getUserPassword().equals(BbsDAO.callPassword(number))) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("location.href='board.jsp'");
			script.println("</script>");			
		}
		else{
			int result = BbsDAO.delete(number);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패했습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='board.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>