<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="bbs.duo_BbsDao"%>

<%@ page import="java.io.PrintWriter"%>

<%

	request.setCharacterEncoding("UTF-8");

	//response.setContentType("text/html; charset=UTF-8");

%>
<jsp:useBean id="duo_bbs" class="bbs.duo_bbs" scope="page" />

<jsp:setProperty name="duo_bbs" property="password" />

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Finduo</title>

</head>

<body>

	<%

		String name = "";
		if(request.getParameter("name") != null){
			name = request.getParameter("name");
            name = new String(name.getBytes("ISO-8859-1"), "UTF-8");
            System.out.println(name);
		}
		if(name == "") {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다')");
			script.println("location.href='duo.jsp'");
			script.println("</script>");
		}
    
        duo_BbsDao duo_BbsDao = new duo_BbsDao();
        if (duo_bbs.getpassword() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호를 입력해주십시오.')");
            script.println("history.back()");
			script.println("</script>");            
        }
		else if(!duo_bbs.getpassword().equals(duo_BbsDao.callPassword(name))) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("location.href='duo.jsp'");
			script.println("</script>");			
		}
		else{
			int result = duo_BbsDao.delete(name);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패했습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='duo.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>