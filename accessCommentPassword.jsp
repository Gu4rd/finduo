<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>


<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="bootstrap-4.5.2/css/bootstrap.css">
      <style>
          *, body, html{
              margin-left: -5px;
              padding: 0;
          }
      </style>
  </head>
  <body>
    <%
		int number = 0;
		if (request.getParameter("number") != null) {
			number = Integer.parseInt(request.getParameter("number"));
		}
		if (number == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글 입니다.')");
            script.println("window.close();");
			script.println("</script>");
		}
	%>
    <div class="container">
      <div class="div_box border border-info rounded-lg">
        <div class="rounded-lg bg-primary" style="position: absolute; width:400px; height:100px;">
          <input type="hidden" name="number" value="<%= number %>">
          <div class="topFont font-weight-bolder" style="text-align: center; font-size: 20px; font-weight: bold; color: white;"><br><br>비밀번호 입력</div>
        </div>
    <div class="" style="background: #ddd; position: absolute; width:400px; height:200px; top:100px;">
      <div class="passwordBox rounded-lg">
          <form method="post" action="deleteCommentAction.jsp?number=<%= number %>">
            <input class="btn" style="background: white; position: absolute; left: 100px; top: 70px; width:200px;" type="password" name="password" placeholder="********">  
            <button class="btn btn-primary" type="submit" style="position: absolute; left: 150px; top: 150px; width:100px;" name="transPassword">입력</button>
          </form>
      </div>
    </div>
  </div>
</div>
  </body>
</html>
