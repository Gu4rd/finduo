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
String getClientIP2(HttpServletRequest request){
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
  return array[0];
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width", initial-scale="1">
        <link rel="stylesheet" href="bootstrap-4.5.2/css/bootstrap.css">
        <title>Finduo</title>
    </head>
    <script type="text/javascript">
        window.onload = function(){
            var x = document.getElementById('userIp');
            x.value = "<%= getClientIP2(request) %>"
        }
        
    </script>

    <body>
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
      			<form method="post" action="duo_writeAction.jsp">
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
      							<td>DUO WISH TIER
                                    <input type="radio" name="you_tier" value="Challenger">C
                                    <input type="radio" name="you_tier" value="Grandmaster">GM
                                    <input type="radio" name="you_tier" value="Master">M
                                    <input type="radio" name="you_tier" value="Diamond">D
                                    <input type="radio" name="you_tier" value="Platinum">P
                                    <input type="radio" name="you_tier" value="Gold">G
                                    <input type="radio" name="you_tier" value="Silver">S
                                    <input type="radio" name="you_tier" value="Bronze">B
                                    <input type="radio" name="you_tier" value="Iron">I
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
                                <td><input type="text" class="" placeholder="롤 닉네임" name="nickname" maxlength="8"/><span style="font-size: 11px" id="getUserIp"><%=getClientIP(request)%></span>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<input type="password" class="" placeholder="게시글 비밀번호" name="password" maxlength="10"/></td>
                                <td style="display: none;"><input type="text" id="userIp" name="userIp" value="" readonly="true"></td>
                            </tr>
      						<tr>
      							<td><textarea class="form-control" placeholder="글 내용" name="content" maxlength="2000" style="height: 500px;"></textarea></td>
      						</tr>
      					</tbody>
      				</table>
      				<input type="submit" class="btn btn-primary pull-right" value="글쓰기" />
      			</form>
      		</div>
      	</div>
    </body>
</html>