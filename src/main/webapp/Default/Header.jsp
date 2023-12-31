<%--
  Created by IntelliJ IDEA.
  User: Bo
  Date: 2023-10-25
  Time: 오후 9:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <title>Header</title>

    <style>
        *{
            font-family: 'Hi Melody', sans-serif;
            list-style: none;
            text-decoration: none;
            border-collapse: collapse;
            margin: 0px;
            padding: 0px;
            color: #000;
            user-select: none;
        }

        /* header */
        .LOGO{
            width: 200px;
            height: 90px;
            cursor: pointer;
        }

        .header_bg{
            background-color: #000;
            top: 0;
            width: 100%;
            z-index: 100;
        }

        .header{
            display: flex;
            width:80%;
            margin: auto;
            height: 86px;
        }

        .nav{
            display: flex;
            justify-content: flex-end;
            line-height: 86px;
            width: calc(1280px - 300px);
        }

        .nav > li {
            margin-left:64px ;
        }

        .nav > li > a {
            color: #fff;
            width: 100px;
        }

        /*로그아웃 버튼*/
        #logout {
            font-family: 'Hi Melody', sans-serif;
            font-size: 16px;
            background-color: transparent;
            color: white;
            padding-left: 50px;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
<%
    // 로그인 섹션
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
%>

<!-- 헤더 -->
<div class="header_bg">
    <div class="header" id="link_header">
        <p><img src="Default/img/logo.png" class="LOGO" onclick="location='Main.jsp'"></p>
        <!-- 상단 탭 바 -->
        <ul class="nav">
            <li><a href="Main.jsp">홈</a></li>
            <li><a href="Post_list.jsp?category=food">식사</a></li>
            <li><a href="Post_list.jsp?category=dessert">디저트</a></li>
            <li><a href="Post_list.jsp?category=drink">음료</a></li>
            <%
                if (userID == null) {
            %>
                <li><a href="Login.jsp">로그인</a></li>
            <%
                } else {
            %>
                <li><a href="MyPage.jsp">마이페이지</a></li>
                <form action="Action/Logout_action.jsp" method="post">
                    <li><a><input type="submit" id="logout" value="로그아웃"></a></li>
                </form>
            <% } %>
        </ul>
    </div>
</div>
</body>
</html>
