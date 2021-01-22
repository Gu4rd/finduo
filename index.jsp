<%@ page language="java" contentType = "text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="notice.noticeDAO"%>
<%@ page import="notice.notice"%>
<%@ page import="bbs.duo_bbs"%>
<%@ page import="bbs.duo_BbsDao"%>
<%@ page import="bbs.team_bbs"%>
<%@ page import="bbs.team_BbsDAO"%>
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
                  <li class="nav-item active">
                    <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
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
                  <li class="nav-item">
                    <a class="nav-link" href="board.jsp">자유게시판</a>
                  </li>
                </ul>
                <span class="navbar-text">
                  v1.0.0-alpha
                </span>
            </div>
        </nav>
        <div class="container-fluid">
            <div class="pa row justify-content-around">
                <div class="col-sm-10">
                    <table id="admin_topic" class="table table-striped text-center" style="border-collapse:collapse;">
                        <thead>
                            <tr>
                                <th colspan="5">공지사항</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                noticeDAO noticeDao = new noticeDAO();
                            ArrayList<notice> list = noticeDao.getList(1);
                            for(int i = 0; i<list.size(); i++){
                            %>
                            <tr data-toggle="collapse" data-target="#notice<%=i %>" class="accordion-toggle">
                                <td colspan="3"><%=list.get(i).getnoticeName() %></td>
                                <td colspan="2"><%=list.get(i).getnoticeDate() %></td>
                            </tr>
                            <tr>
                                <td colspan="5" class="hiddenRow"><div class="accordian-body collapse" id="notice<%=i %>"><%=list.get(i).getnoticeContent() %></div></td>
                            </tr>
                            <%
                            }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
            
            
            
            
            
            <div class="pa row justify-content-around">
                    <table id="duorank" class="table col-sm-3 text-center" style="border-collapse:collapse;">
                        <thead>
                            <tr>
                                <th class="text-center">ME</th>
                                <th class="text-center">DUO WISH LINE</th>
                                <th class="text-center">DETAIL</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                duo_BbsDao duo_BbsDao = new duo_BbsDao();
                            ArrayList<duo_bbs> list2 = duo_BbsDao.getList(1);
                            for(int i = 0; i<list2.size(); i++){
                            %>
                            <tr data-toggle="collapse" data-target="#duo<%=i %>" class="accordion-toggle">
                                <td><img src="/img/tier/ranked-emblems/Emblem_<%=list2.get(i).getme_tier() %>.png" width="50" height="50" class="d-inline-block align-top" alt="">
                                    <img src="/img/line/ranked-positions/Position_<%=list2.get(i).getme_line() %>.png" width="50" height="50" class="d-inline-block align-top" alt=""></td>
                                <td><img src="/img/line/ranked-positions/Position_<%=list2.get(i).getyou_line() %>.png" width="50" height="50" class="d-inline-block align-top" alt=""></td>
                                <td><button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#duo<%=i %>" class="accordion-toggle">...</button></td>
                            </tr>
                            <tr>
                                <td colspan="5" class="hiddenRow"><div class="accordian-body collapse" id="duo<%=i %>"><%=list2.get(i).getcontent() %></div></td>
                            </tr>
                            <%
                            }
                            %>
                        </tbody>
                    </table>
                    <table id="teamrank" class="table col-sm-4 text-center" style="border-collapse:collapse;">
                            <thead>
                                <tr>
                                    <th>TEAM AVG</th>
                                    <th>LINE</th>
                                    <th>DETAIL</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                            team_BbsDAO team_BbsDAO = new team_BbsDAO();
                            ArrayList<team_bbs> list3 = team_BbsDAO.getList(1);
                            for(int i = 0; i<list3.size(); i++){
                                String top = list3.get(i).gettop();
                                String jungle = list3.get(i).getjungle();;
                                String mid = list3.get(i).getmid();
                                String bot = list3.get(i).getbot();
                                String support = list3.get(i).getsupport();
                                if(list3.get(i).gettop() == null ){
                                    top="NULL_Top";
                                }
                                if(list3.get(i).getjungle() == null){
                                    jungle="NULL_Jungle";
                                }
                                if(list3.get(i).getmid() == null){
                                    mid="NULL_Mid";
                                }
                                if(list3.get(i).getbot() == null){
                                    bot="NULL_Bot";
                                }
                                if(list3.get(i).getsupport() == null){
                                    support="NULL_Support";
                                }
                            %>
                            <tr data-toggle="collapse" data-target="#team<%=i %>" class="accordion-toggle">
                                <td><img src="/img/tier/ranked-emblems/Emblem_<%=list3.get(i).getAVGtier() %>.png" width="50" height="50" class="d-inline-block align-top" alt=""></td>
                                <td>
                                    <img src="/img/line/ranked-positions/Position_<%=top%>.png" width="50" height="50" class="d-inline-block align-top" alt="">
                                    <img src="/img/line/ranked-positions/Position_<%=jungle %>.png" width="50" height="50" class="d-inline-block align-top" alt="">
                                    <img src="/img/line/ranked-positions/Position_<%=mid %>.png" width="50" height="50" class="d-inline-block align-top" alt="">
                                    <img src="/img/line/ranked-positions/Position_<%=bot %>.png" width="50" height="50" class="d-inline-block align-top" alt="">
                                    <img src="/img/line/ranked-positions/Position_<%=support %>.png" width="50" height="50" class="d-inline-block align-top" alt="">
                                </td>
                                <td><button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#team<%=i %>" class="accordion-toggle">...</button></td>
                            </tr>
                            <tr>
                                <td colspan="3" class="hiddenRow"><div class="accordian-body collapse" id="team<%=i %>"><%=list3.get(i).getcontent() %></div></td>
                            </tr>
                            <%
                            }
                            %>
                        </tbody>
                        </table>
                    <table id="scream" class="table col-sm-3 text-center" style="border-collapse:collapse;">
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
                                <td colspan="3" class="hiddenRow"><div class="accordian-body collapse" id="scream<%=i %>"><%=list4.get(i).getcontent() %><br/>팀장명 : <%=list4.get(i).getleadername()%></div></td>
                            </tr>
                            <%
                            }
                            %>
                        </tbody>
                        </table>
                </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    </body>
</html>









