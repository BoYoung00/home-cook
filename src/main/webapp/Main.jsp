<!-- 최초 작성자 : 김예지 -->
<!-- 최초 작성일 : 2023.10.15. -->
<!-- 최초 변경일 : 2023.10.17. -->
<!-- 목적 : 메인 페이지 -->
<!-- 개정 이력 :
김예지, 2023.10.15.(var. 01)
김보영, 2023.10.17.(var. 02)
-->
<!-- 저작권 : 없음 -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Post.PostDao" %>
<%@ page import="java.util.List" %>
<%@ page import="Post.PostDto" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인 홈페이지</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link rel="icon" href="Default/img/icon.png" type="image/x-icon">

    <link href="Default/CSS/Main.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
    // 로그인 섹션
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }

    // 글 목록
    PostDao postDao = new PostDao();
    List<PostDto> posts = postDao.selectAll();
    int displayCount = 3; // 표시할 게시글 개수

    // 해당 카테고리 게시물들 가져오기
    List<PostDto> foodPostList = postDao.selectCategory("food");
    List<PostDto> dessertPostList = postDao.selectCategory("dessert");
    List<PostDto> drinkPostList = postDao.selectCategory("drink");
%>

<!-- 페이지 상단 부분 -->
<div class="wrap">
    <div class="intro_bg">
        <div class="header_bg">
            <div class="header" id="link_header">
                <p><img src="Default/img/logo.png" class="LOGO" onclick="location='Main.jsp'"></p>
                <!-- 상단 탭 바 -->
                <ul class="nav">
                    <li><a href="#">홈</a></li>
                    <li><a href="#link_food">식사</a></li>
                    <li><a href="#link_dessert">디저트</a></li>
                    <li><a href="#link_drink">음료</a></li>
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
        <div class="intro_text">
            <h1>물가 상승에 맞서, <br>
                모두가 함께 아끼자! 💰</h1>
        </div>
    </div>
</div>

<!-- 중간 소개글 -->
<ul class="amount">
    <li>
        <div>
            <div class="contents1">4인 가구 기준 월 평균 식비</div>
            <div class="result">1,500,000원</div>
        </div>
    </li>
    <li>
        <div>
            <div class="contents1">4인 가구 기준 월 평균 생활비</div>
            <div class="result">2,500,000원</div>
        </div>
    </li>
    <li>
        <div>
            <div class="contents1">1인 가구 기준 월 평균 식비</div>
            <div class="result">500,000원</div>
        </div>
    </li>
    <li>
        <div>
            <div class="contents1">1인 가구 기준 월 평균 생활비</div>
            <div class="result">1,000,000원</div>
        </div>
    </li>
</ul>

<!-- 식사 레시피 미리보기 -->
<div class="food" id="link_food">
    <h1>식사 레시피</h1>
    <%--    식사 목록 더보기--%>
    <p><a href="Post_list.jsp?category=food" class="show_more">더보기</a></p>
    <ul class="Preview">
        <% for (int i = 0; i < foodPostList.size() && i < displayCount; i++) {
            PostDto post = foodPostList.get(i);
        %>
            <li class="imgHoverEvent event1" onclick="location='Post_view.jsp?no=<%=post.getPostId()%>'">
                <div class="contents1_bold">firework</div>
                <div class="imgBox">
                    <img class="preview_img" src="<%=post.getFileName() %>" alt="<%= post.getTitle() %>">
                </div>
                <div class="hoverBox">
                    <%
                        // 제목 자르기
                        String title = post.getTitle().length() > 10 ? post.getTitle().substring(0, 10) + "⋯" : post.getTitle();
                    %>
                    <p class="p1"><%= title %></p>
                    <%
                        // 내용 자르기
                        String content = post.getContent().length() > 20 ? post.getContent().substring(0, 20) + "⋯" : post.getContent();
                    %>
                    <p class="p2"><%= content %></p>
                </div>
            </li>
        <% } %>
    </ul>
</div>

<!-- 디저트 레시피 미리보기 -->
<div class="dessert" id="link_dessert">
    <h1>디저트 레시피</h1>
    <%--    디저트 목록 더보기--%>
    <p><a href="Post_list.jsp?category=dessert" class="show_more">더보기</a></p>
    <ul class="Preview">
        <% for (int i = 0; i < dessertPostList.size() && i < displayCount; i++) {
            PostDto post = dessertPostList.get(i);
        %>
        <li class="imgHoverEvent event1" onclick="location='Post_view.jsp?no=<%=post.getPostId()%>'">
            <div class="contents1_bold">firework</div>
            <div class="imgBox">
                <img class="preview_img" src="<%=post.getFileName() %>" alt="<%= post.getTitle() %>">
            </div>
            <div class="hoverBox">
                <%
                    // 제목 자르기
                    String title = post.getTitle().length() > 10 ? post.getTitle().substring(0, 10) + "⋯" : post.getTitle();
                %>
                <p class="p1"><%= title %></p>
                <%
                    // 내용 자르기
                    String content = post.getContent().length() > 20 ? post.getContent().substring(0, 20) + "⋯" : post.getContent();
                %>
                <p class="p2"><%= content %></p>
            </div>
        </li>
        <% } %>
    </ul>
</div>

<!-- 음료 레시피 미리보기 -->
<div class="drink" id="link_drink">
    <h1>음료 레시피</h1>
    <%--    음료 목록 더보기--%>
    <p><a href="Post_list.jsp?category=drink" class="show_more">더보기</a></p>
    <ul class="Preview">
        <% for (int i = 0; i < drinkPostList.size() && i < displayCount; i++) {
            PostDto post = drinkPostList.get(i);
        %>
        <li class="imgHoverEvent event1" onclick="location='Post_view.jsp?no=<%=post.getPostId()%>'">
            <div class="contents1_bold">firework</div>
            <div class="imgBox">
                <img class="preview_img" src="<%=post.getFileName() %>" alt="<%= post.getTitle() %>">
            </div>
            <div class="hoverBox">
                <%
                    // 제목 자르기
                    String title = post.getTitle().length() > 10 ? post.getTitle().substring(0, 10) + "⋯" : post.getTitle();
                %>
                <p class="p1"><%= title %></p>
                <%
                    // 내용 자르기
                    String content = post.getContent().length() > 20 ? post.getContent().substring(0, 20) + "⋯" : post.getContent();
                %>
                <p class="p2"><%= content %></p>
            </div>
        </li>
        <% } %>
    </ul>
</div>

<!-- 사이트 소개 글 -->
<div class="main_text1" id="link_main_text1">
    <div class="service">
        <div class="fooh_photo">
            <img src="Default/img/main1.jpg" alt="" width="400" height="400">
        </div>
        <div class="contents2">
            <h2>집밥의 민족 소개글</h2>

            "집밥의 민족"은 물가 상승으로 인해 생활비 부담을 <br>
            덜어주기 위해 탄생한 공간입니다. <br><br>

            요리 레시피를 공유하고 경제적인 요리의 즐거움을 함꼐 나누며, <br>
            집에서 요리하는 스킬을 향상시키는 곳이에요. <br>
            아낄 수 있는 비법을 배우고 레시피를 공유하며, <br>
            더 현명한 요리를 통해 더 많은 가정이 행복한 식사를 누릴 수 있도록 돕습니다.<br><br>

            집밥의 민족과 함께하면 요리가 더욱 즐겁고 경제적으로 <br>
            현명한 선택이 될 것입니다. <br>
        </div>
    </div>
</div>

<jsp:include page="Default/Footer.jsp"></jsp:include>
</body>
</html>