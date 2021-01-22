<%@page import="javax.security.auth.callback.ConfirmationCallback"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.bbs"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType = "text/html;charset=utf-8" pageEncoding="UTF-8"%>
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
        <meta name="viewport" content="width=device-width", initial-scale="1">
        <link rel="stylesheet" href="bootstrap-4.5.2/css/bootstrap.css">
        <title>Finduo</title>
        <style type="text/css">
            a, a:hover {
                color: #000000;
                text-decoration: none;
            }
        </style>
    </head>

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
        
        function keyword(){
            
            var x = document.getElementById('search').value;
            if(x == ""){
                alert('입력이 안된 사항이 있습니다.');
                    location.reload();
            }
            else if(x.length < 2){
                alert('2글자 이상 입력하여 주십시오.');
                location.reload();
                
            }
            else{
                document.getElementById('frm').submit();
            }
                document.getElementById('search').value = "";
            
        }
    </script>
    <body>
        <%
            int pageNumber = 1;
            if(request.getParameter("pageNumber") != null) {
                pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
            }
        %>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <a class="navbar-brand" href="index.jsp">
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

    <div class = "row">
      <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
        <thead>
          <tr>
            <th style="background-color: #eeeeee; text-align: center;">번호</th>
            <th style="background-color: #eeeeee; text-align: center;">제목</th>
            <th style="background-color: #eeeeee; text-align: center;">작성자</th>
            <th style="background-color: #eeeeee; text-align: center;">작성일</th>
            <th style="background-color: #eeeeee; text-align: center;">게시글 신고</th>
          </tr>
        </thead>
        <tbody>
          <% BbsDAO bbsDAO = new BbsDAO();
             ArrayList<bbs> list = bbsDAO.getList(pageNumber);
             
             for(int i=0; i<list.size();i++){
            
          %>
          <tr>
            <td><%=list.get(i).getBbsNumber()%></td>
            <td><a href="view.jsp?number=<%=list.get(i).getBbsNumber()%>"><%=list.get(i).getBbsName()%></a></td>
            <td><%=list.get(i).getUserNickname()%></td>
            <td><%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분"%></td>
            <td><button type="button" onclick="PopupCenter('report.jsp?number=<%=list.get(i).getBbsNumber()%>', '게시물 신고', '400', '300');">신고</button></td>
          </tr>
          <%
            }
          %>
        </tbody>
      </table>
        <%
            if(pageNumber != 1){   
        %>
        <a href="board.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전 페이지</a>
        <%
            }
            if(bbsDAO.nextPage(pageNumber+1)){
        %>
        <a href="board.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-left">다음 페이지</a>
        <%
            }
        %>
        <tr>
            <td><a href = "write.jsp" class="btn btn-primary pull-right">글쓰기</a></td><span>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</span>
            <form id="frm" onsubmit="return false;" method="post" action="searchBoard.jsp">
              <td><input type="text" id="search" name="search"><button type="button" onclick="keyword();">검색</button></td>
            </form>
        </tr>
    </div>
  </div>
    </body>
</html>
