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

<jsp:useBean id="CommentDto" class="bbs.CommentDto" scope="page" />

<!-- // Bbs bbs = new Bbs(); -->
<jsp:setProperty name="CommentDto" property="password" />


<%

	System.out.println(CommentDto);

%>

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
			script.println("alert('유효하지 않은 댓글 입니다')");
			script.println("window.close();");
			script.println("</script>");
		}
	    BbsDAO BbsDAO = new BbsDAO();
        if (CommentDto.getPassword() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호를 입력해주십시오.')");
            script.println("history.back()");
			script.println("</script>");            
        }
		else if(!CommentDto.getPassword().equals(BbsDAO.callCommentPassword(number))) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("history.back()");
			script.println("</script>");			
		}
        else{
            int result = BbsDAO.deleteComment(number);
            if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글 삭제에 실패했습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
                script.println("opener.location.reload();");
				script.println("window.close();");
				script.println("</script>");
			}
        }
		
	
	%>
</body>
</html>