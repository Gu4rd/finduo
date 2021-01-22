<%@ page contentType = "text/html;charset=utf-8" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.duo_bbs"%>
<%@ page import="bbs.duo_BbsDao"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width", initial-scale="1">
        <link rel="stylesheet" href="bootstrap-4.5.2/css/bootstrap.css">
        <title>Finduo</title>
        <style type="text/css">
            .div_box {
              position: absolute;
              width: 30vh;
              height: 20vh;
              background: white;
              color: #fff;
              top: 30%;
              left: 50%;
              margin: -10vh 0 0 -15vh;
            }
            .topFont{
              position: absolute;
              font-size: 20px;
              top: 30%;
              left: 30%;
              margin: 0 0 0 0;
              color: white;
            }
            .passwordBox{
              position: absolute;
              top: 40%;
              left: 20%;
            }
        </style>
    </head>

    <body>
    <%
        int which = Integer.parseInt(request.getParameter("which"));
		String name = "";
		if (request.getParameter("name") != null) {
			name = request.getParameter("name");
            name = new String(name.getBytes("ISO-8859-1"), "UTF-8");
		}
		if (name == "") {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		duo_bbs duo_bbs = new duo_BbsDao().getBbs(name);
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

        <div class="container">
          <div class="div_box border border-info rounded-lg">
            <div class="rounded-lg bg-primary" style="position: absolute; width:100%; height:30%;">
                <input type="hidden" name="name" value="<%= name %>">
                <div class="topFont font-weight-bolder">비밀번호 입력</div>
            </div>
            <div class="" style="background: #ddd; position: absolute; width:100%; height:70%; top:30%">
              <div class="passwordBox rounded-lg">
                <%
                  if(which == 1){
                     %><form action="duo_update.jsp?name=<%= name %>" method="post"><%
                  }
                  else if(which == 2){
                      %><form action="duo_delete.jsp?name=<%= name %>" method="post"><%
                  }
                  %>
                
                    <input class="btn" style="background: white; width:50%;" type="password" name="password" placeholder="********">
                    <input type="hidden" name="content" value="<%= duo_bbs.getcontent() %>">
                    <input type="hidden" name="me_tier" value="<%= duo_bbs.getme_tier()%>">
                    <input type="hidden" name="me_line" value="<%= duo_bbs.getme_line()%>">
                    <input type="hidden" name="you_line" value="<%= duo_bbs.getyou_line()%>">
                    <input type="hidden" name="name" value="<%= duo_bbs.getnickname() %>">
                    <button class="btn btn-primary" type="submit" name="transPassword">입력</button>
                </form>
                </form>
              </div>
            </div>
          </div>
        </div>
    </body>
</html>
