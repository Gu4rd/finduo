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

<jsp:setProperty name="CommentDto" property="id" /><!-- bbs.setBbsTitle(requrst) -->
<jsp:setProperty name="CommentDto" property="password" />
<jsp:setProperty name="CommentDto" property="commentContent" />
<jsp:setProperty name="CommentDto" property="boardNumber" />

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
	    BbsDAO BbsDAO = new BbsDAO();
        if(CommentDto.getPassword() == null){
            
        }
		int result = BbsDAO.insertComment(CommentDto.getId(), CommentDto.getPassword(), CommentDto.getCommentContent(), CommentDto.getBoardNumber());
	
	%>
</body>
</html>