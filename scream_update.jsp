<%@ page language="java" contentType = "text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.scream_BbsDAO"%>
<!-- bbsdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter"%>

<!-- 자바 클래스 사용 -->

<%

	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");

%>

<jsp:useBean id="scream_bbs" class="bbs.scream_bbs" scope="page" />

<!-- // Bbs bbs = new Bbs(); -->
<jsp:setProperty name="scream_bbs" property="name" />
<jsp:setProperty name="scream_bbs" property="AVGtier" />
<jsp:setProperty name="scream_bbs" property="content" />
<jsp:setProperty name="scream_bbs" property="password" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width", initial-scale="1">
        <link rel="stylesheet" href="bootstrap-4.5.2/css/bootstrap.css">
        <title>Finduo</title>
    </head>

    <body>
	<%
		String name = "";
		if (request.getParameter("name") != null) {
			name = request.getParameter("name");
            name = new String(name.getBytes("ISO-8859-1"), "UTF-8");
    %>
         <input type="hidden" name="name" value="<%= name %>">
    <%
            System.out.println(name);
		}
		if (name == "") {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'scream.jsp'");
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
		else if (!scream_bbs.getpassword().equals(scream_BbsDAO.callPassword(name))) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'scream.jsp'");
			script.println("</script>");				
		}
        else{
            PrintWriter script = response.getWriter();
            script.println("<script>");
    %>
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
                    <a class="nav-link" href="#">Home</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="duo.jsp">듀오</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="team.jsp">팀</a>
                  </li>
                  <li class="nav-item active">
                    <a class="nav-link" href="scream.jsp">스크림<span class="sr-only">(current)</span></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="board.jsp">자유게시판</a>
                  </li>
                </ul>
                <span class="navbar-text">
                  v1.0.0-alpha
                </span>
            </div>
        </nav>
        <div class="container">
      		<div class="row justify-content-around">
      			<form method="post" action="scream_updateAction.jsp">
      				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; width: 600px;">
      					<thead>
      						<tr>
      							<th colspan="2" style="background-color: #eeeeee; text-align: center;">스크림 팀 구하기</th>
      						</tr>
      					</thead>
      					<tbody>
                            <tr>
      							<td>TEAM AVG TIER
                                    <input type="radio" name="AVGtier" value="Challenger">C
                                    <input type="radio" name="AVGtier" value="Grandmaster">GM
                                    <input type="radio" name="AVGtier" value="Master">M
                                    <input type="radio" name="AVGtier" value="Diamond">D
                                    <input type="radio" name="AVGtier" value="Platinum">P
                                    <input type="radio" name="AVGtier" value="Gold">G
                                    <input type="radio" name="AVGtier" value="Silver">S
                                    <input type="radio" name="AVGtier" value="Bronze">B
                                    <input type="radio" name="AVGtier" value="Iron">I
                                </td>
      						</tr>
      						<tr>
      							<td><textarea class="form-control" name="content" maxlength="2000" style="height: 500px;"><%= scream_bbs.getcontent()%></textarea></td>
      						</tr>
      					</tbody>
      				</table>
                    <input type="hidden" name="name" value="<%= name%>">
      				<input type="submit" class="btn btn-primary pull-right" value="수정하기" />
      			</form>
      		</div>
      	</div>
        <%        
            script.println("</script>");
        }
	    %>
         <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
        <script>
            $("input:radio[name='AVGtier']:input[value='<%= scream_bbs.getAVGtier()%>']").prop("checked", true);
        </script>
    </body>
</html>