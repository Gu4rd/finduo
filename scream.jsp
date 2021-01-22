<%@ page language="java" contentType = "text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.scream_bbs"%>
<%@ page import="bbs.scream_BbsDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width", initial-scale="1">
        <link rel="stylesheet" href="bootstrap-4.5.2/css/bootstrap.css">
        <title>Finduo</title>
        <style>
            .hiddenRow{
                padding: 0 !important;
            }
            div.pa{
                padding:20px 10px 10px 20px;
            }
            div.ma{
                margin:20px 10px 10px 20px;
            }
        </style>
    </head>
    <body>
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
            <div class="pa row justify-content-around">
                <table id="scream" class="table text-center" style="border-collapse:collapse;">
                            <thead>
                                <tr>
                                    <th>TEAM AVG</th>
                                    <th>TEAM NAME</th>
                                    <th>DETAIL</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                            scream_BbsDAO scream_BbsDAO = new scream_BbsDAO();
                            ArrayList<scream_bbs> list4 = scream_BbsDAO.getList(1);
                            for(int i = 0; i<list4.size(); i++){
                            %>
                            <tr data-toggle="collapse" data-target="#scream<%=i %>" class="accordion-toggle">
                                <td><img src="/img/tier/ranked-emblems/Emblem_<%=list4.get(i).getAVGtier() %>.png" width="50" height="50" class="d-inline-block align-top" alt=""></td>
                                <td><h2><%=list4.get(i).getname()%></h2></td>
                                <td><button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#scream<%=i %>" class="accordion-toggle">...</button></td>
                            </tr>
                            <tr>
                                <td colspan="2" class="hiddenRow"><div class="accordian-body collapse" id="scream<%=i %>"><%=list4.get(i).getcontent() %><br/>리더명 : <%=list4.get(i).getleadername() %></div></td>
                                <td colspan="1" class="hiddenRow"><div class="accordian-body collapse" id="scream<%=i %>">
                                    <a href = "scream_accessPassword.jsp?name=<%=list4.get(i).getname()%>&which=1" class="btn btn-primary pull-right row">수정</a><br/>
                                    <a href = "scream_accessPassword.jsp?name=<%=list4.get(i).getname()%>&which=2" class="btn btn-primary pull-right row">삭제</a>
                                </div></td>
                            </tr>
                            <%
                            }
                            %>
                        </tbody>
                        </table>
            </div>
            <a href = "scream_write.jsp" class="btn btn-primary pull-right row">스크림 팀 구하기</a>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    </body>
</html>