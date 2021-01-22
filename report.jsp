<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale="1">
    <title>신고</title>
  </head>
  <body>
      <%
          String number = request.getParameter("number");
      %>
    <form action="mailsend.jsp" method="post">
      <table>
        <tr>
          <td><label><input type="hidden" name="number" value="<%= number %>">게시물 신고</label></td>
        </tr>
        <tr>
          <td><label>신고 사유</label></td>
        </tr>
        <tr>
          <input type="hidden" name="to" value="developjsg@gmail.com">
          <input type="hidden" name="from" value="developjsg@gmail.com">
          <td><textarea name="content" rows="8" cols="80" style="width:200px; resize: none;"></textarea></td>
        </tr>
        <tr>
          <td><input type="submit" name="" value="전송"> <button type="button" name="button">취소</button></td>
        </tr>
      </table>
    </form>
  </body>
</html>
