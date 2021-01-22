<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="bbs.duo_BbsDao"%>
<!-- bbsdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter"%>

<!-- 자바 클래스 사용 -->

<%

	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");

%>


<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->

<jsp:useBean id="duo_bbs" class="bbs.duo_bbs" scope="page" />

<!-- // Bbs bbs = new Bbs(); -->
<jsp:setProperty name="duo_bbs" property="password" />
<jsp:setProperty name="duo_bbs" property="content" />
<jsp:setProperty name="duo_bbs" property="me_tier" />
<jsp:setProperty name="duo_bbs" property="me_line" />
<jsp:setProperty name="duo_bbs" property="you_line" />

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
			script.println("location.href = 'duo.jsp'");
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
		else if (!duo_bbs.getpassword().equals(duo_BbsDao.callPassword(name))) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'duo.jsp'");
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
                    <a class="nav-link" href="index.jsp">Home</a>
                  </li>
                  <li class="nav-item  active">
                    <a class="nav-link" href="duo.jsp">듀오<span class="sr-only">(current)</span></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="team.jsp">팀</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="scream.jsp">스크림</a>
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
                <form method="post" action="duo_updateAction.jsp">
      				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; width: 600px;">
      					<thead>
      						<tr>
      							<th colspan="2" style="background-color: #eeeeee; text-align: center;">듀오 구하기</th>
      						</tr>
      					</thead>
      					<tbody>
      						<tr>
      							<td>YOUR TIER
                                    <input type="radio" name="me_tier" value="Challenger">C
                                    <input type="radio" name="me_tier" value="Grandmaster">GM
                                    <input type="radio" name="me_tier" value="Master">M
                                    <input type="radio" name="me_tier" value="Diamond">D
                                    <input type="radio" name="me_tier" value="Platinum">P
                                    <input type="radio" name="me_tier" value="Gold">G
                                    <input type="radio" name="me_tier" value="Silver">S
                                    <input type="radio" name="me_tier" value="Bronze">B
                                    <input type="radio" name="me_tier" value="Iron">I
                                </td>
      						</tr>
                            <tr>
                                <td>YOUR LINE
                                    <input type="radio" name="me_line" value="Top"/>TOP
                                    <input type="radio" name="me_line" value="Jungle"/>JG
                                    <input type="radio" name="me_line" value="Mid"/>MID
                                    <input type="radio" name="me_line" value="Bot"/>BOT
                                    <input type="radio" name="me_line" value="Support"/>SUP
                                </td>
                            </tr>
                            <tr>
                                <td>DUO WISH LINE
                                    <input type="radio" name="you_line" value="Top"/>TOP
                                    <input type="radio" name="you_line" value="Jungle"/>JG
                                    <input type="radio" name="you_line" value="Mid"/>MID
                                    <input type="radio" name="you_line" value="Bot"/>BOT
                                    <input type="radio" name="you_line" value="Support"/>SUP
                                </td>
                            </tr>
      						<tr>
      							<td><textarea class="form-control" name="content" maxlength="2000" style="height: 500px;"><%= duo_bbs.getcontent()%></textarea></td>
      						</tr>
      					</tbody>
      				</table>
                    <input type="hidden" name="nickname" value="<%= name%>">
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
            $("input:radio[name='me_tier']:input[value='<%= duo_bbs.getme_tier()%>']").prop("checked", true);
            $("input:radio[name='me_line']:input[value='<%= duo_bbs.getme_line()%>']").prop("checked", true);
            $("input:radio[name='you_line']:input[value='<%= duo_bbs.getyou_line()%>']").prop("checked", true);
        </script>
    </body>
</html>