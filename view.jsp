<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="javax.security.auth.callback.ConfirmationCallback"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.bbs"%>
<%@ page import="bbs.CommentDto"%>
<%@ page import="bbs.BbsDAO"%>

<%!
String getClientIP(HttpServletRequest request){
  String ip = request.getHeader("X-FORWARDED-FOR");
  if (ip == null || ip.length() == 0) {
      ip= request.getHeader("Proxy-Client-IP");
  }
  if (ip == null || ip.length() == 0) {
      ip= request.getHeader("WL-Proxy-Client-IP");
  }
  if (ip == null || ip.length() == 0) {
      ip= request.getRemoteAddr();
  }
  String[] array = ip.split(",");
  String[] array2 = array[0].split("\\.");
  String newIp = array2[0] + "." + array2[1] + "." + "***" + "." + "***";
  return newIp;
}
%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="bootstrap-4.5.2/css/bootstrap.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Finduo</title>
    <script type="text/javascript">

      function PopupCenter(url, title, w, h) {
        // Fixes dual-screen position                         Most browsers      Firefox
        var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
        var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
        var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
        var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;
        var left = ((width / 2) - (w / 2)) + dualScreenLeft;
        var top = ((height / 2) - (h / 2)) + dualScreenTop;
        var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
        // Puts focus on the newWindow
        if (window.focus) {
          newWindow.focus();
        }
      }
    </script>
</head>
<body class="overflow-auto">

	<%
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
        BbsDAO bbsDAO = new BbsDAO();
	%>
	<!-- 네비게이션  -->

        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <a class="navbar-brand" href="#index.jsp">
                <img src="/img/tier/ranked-emblems/Emblem_Bronze.png" width="30" height="30" class="d-inline-block align-top" alt="">Finduo
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                  <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="duo.jsp">듀오</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="team.jsp">팀</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="scream.jsp">스크림</a>
                  </li>
                  <li class="nav-item active">
                    <a class="nav-link" href="board.jsp">자유게시판<span class="sr-only">(current)</span></a>
                  </li>
                </ul>
                <span class="navbar-text">
                  v1.0.0-alpha
                </span>
            </div>
        </nav>
	<!-- 게시판 -->

	<div class="container">
		<div class="row">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3"
								style="background-color: #eeeeee; text-align: center;">글 보기 </th>
						</tr>
					</thead>
					<tbody>
                        <tr>
							<td style="width: 20%;"> 번호 </td>
							<td colspan="2"><input type="hidden" name="number" id="number" value="<%= bbs.getBbsNumber() %>"><%= bbs.getBbsNumber() %></td>
						</tr>
						<tr>
							<td style="width: 20%;"> 글 제목 </td>
							<td colspan="2"><%= bbs.getBbsName() %></td>
						</tr>
						<tr>
							<td>작성자</td>	
							<td colspan="2"><%= bbs.getUserNickname() %></td>
						</tr>
						<tr>
							<td>작성일</td>	
							<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"
							+ bbs.getBbsDate().substring(14, 16) + "분"%></td>
						</tr>
						<tr>
							<td>내용</td>
	                        <td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") %></td>
						</tr>
					</tbody>
				</table>	
				<a href = "board.jsp" class="btn btn-primary">목록</a>
				<a href="accessPassword.jsp?number=<%= number %>&which=1" class="btn btn-primary">수정</a>
				<a href="accessPassword.jsp?number=<%= number %>&which=2" class="btn btn-primary">삭제</a>
		</div>
        <div class="row">
          <br><br>
        </div>
        <div class="row">
          <thead>
            <tr>
              <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                  <thead>
                    <tr><th colspan="3">댓글(<%= bbsDAO.countComments(number) %>)</th></tr>
                  </thead>
                  <tbody id="commentOutput">
                      <% 
                          
                          ArrayList<CommentDto> list = bbsDAO.getCommentList(bbs.getBbsNumber());
                          for(int i=0; i<list.size();i++){
                      %>
                    <tr>
                      <td style="width: 10%; border-right: 1px solid white; font-weight: bold;"><%= list.get(i).getId() %><span style="font-size: 10px; color: grey;">(<%=getClientIP(request)%>)</span></td>
                      <td style="width: 60%; border-right: 1px solid white; font-size: 14px;"><%= list.get(i).getCommentContent() %></td>
                      <td style="width: 20%; border-right: 1px solid white; font-size: 12px;"><%= list.get(i).getCommentDate().substring(0, 11) + list.get(i).getCommentDate().substring(11, 13) + "시"
							+ list.get(i).getCommentDate().substring(14, 16) + "분"%></td>
                      <td style="width: 10%;"><button type="button" name="button" style="width: 100%; height: 40%;" onclick="PopupCenter('accessCommentPassword.jsp?number=<%= list.get(i).getCommentNumber() %>', 'a', 400, 300)">삭제</button></td>
                    </tr>
                      <%
                          }
                      %>
                  </tbody>
              </table>
            </tr>
          </thead>
        </div>
        <div class="row">
          <br>
        </div>
            <table style="width: 100%">
                <input type="hidden" name="boardNumber" id="boardNumber" value="<%= bbs.getBbsNumber() %>">
                <div class="row" style="height: 100px;">
                    <textarea name="commentContent" rows="8" cols="5" style="width: 90%; height:100%; resize: none;" id="content"></textarea>
                    <div style="width: 10%; height: 100%;">
                        <input type="text" id="commentNickname" name="id" placeholder="닉네임" style="width: 100%; height:25%;"><br>
                        <input type="password" id="commentPassword" name="password" placeholder="비밀번호" style="width: 100%; height:25%;">
                        <button type="button" name="writeComment" style="width: 100%; height:50%;" id="writeComment">작성하기</button>    
                    </div>
                </div>
            </table>
    </div>
        <script>
        function reloadComment(){
            $('#commentOutput').load(location.href + '#commentOutput');
        };
        $(document).ready(function(){
            $('#writeComment').click(function(){
                if($('#commentNickname').val() == "" || $('#commentPassword').val() == "" || $('#content').val() == ""){
                    alert('업력이 안된 사항이 있습니다.');
                }
                else{
                    $.ajax({
                        url: "commentAction.jsp",
                        type: "POST",
                        data: {
                            id: $('#commentNickname').val(),
                            password: $('#commentPassword').val(),
                            commentContent: $('#content').val(),
                            boardNumber: $('#boardNumber').val()
                        },
                        success: function(){
                            var output = "";
                            $('#content').val("");
                            location.reload();
                            
                        }
                        
                    });
                }
            });
            
        });

    </script>
</body>
</html>