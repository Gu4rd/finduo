<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="bbs.scream_BbsDAO"%>

<%@ page import="java.io.PrintWriter"%>

<%

	request.setCharacterEncoding("UTF-8");

	//response.setContentType("text/html; charset=UTF-8");

%>
<jsp:useBean id="scream_bbs" class="bbs.scream_bbs" scope="page" />

<jsp:setProperty name="scream_bbs" property="password" />

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
			script.println("location.href='scream.jsp'");
			script.println("</script>");
		}
    
        scream_BbsDAO scream_BbsDAO = new scream_BbsDAO();
        if (scream_bbs.getpassword() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호를 입력해주십시오.')");
            script.println("history.back()");
			script.println("</script>");            
        }
		else if(!scream_bbs.getpassword().equals(scream_BbsDAO.callPassword(name))) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("location.href='scream.jsp'");
			script.println("</script>");			
		}
		else{
			int result = scream_BbsDAO.delete(name);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패했습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='scream.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>