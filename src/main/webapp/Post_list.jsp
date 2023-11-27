<!-- 최초 작성자 : 김예지 -->
<!-- 최초 작성일 : 2023.10.25. -->
<!-- 최초 변경일 : 2023.10.25. -->
<!-- 목적 : 게시글 리스트 페이지 -->
<!-- 개정 이력 :
김예지, 2023.10.25.(var. 01)
김보영, 2023.10.25.(var. 02)
-->
<!-- 저작권 : 없음 -->

<%@ page import="Post.PostDao" %>
<%@ page import="Post.PostDto" %>
<%@ page import="User.UserDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link rel="icon" href="Default/img/icon.png" type="image/x-icon">
    <link href="Default/CSS/Post_list.css" rel="stylesheet" type="text/css">

    <title>식사 게시물 목록</title>

</head>
<body>
<%
    // 로그인 섹션
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }

    // 페이지 넘버 받아오기
    String inputCategory = request.getParameter("category");

    // 해당 카테고리 게시물들 가져오기
    PostDao postDao = new PostDao();
    List<PostDto> posts = postDao.selectCategory(inputCategory);
%>

<jsp:include page="Default/Header.jsp"></jsp:include>

<!-- 페이지 상단부  -->
<div class="title">
    <h1>식사 레시피 목록</h1>
    <p><input type="button" value="글 작성하기" id= "myButton" class="ok_button" onclick="location='Posting_page.jsp?category=<%= inputCategory %>'"></p>
</div>

<!-- 내용 -->
<div class="first">
    <div class="post-list">
        <% for(PostDto post : posts) { %>
            <div class="post" onclick="location='Post_view.jsp?no=<%= post.getPostId() %>'"> <!-- 해당 게시글 조회 -->
                <img class="thumbnail" src="<%= post.getFileName() %>" alt="<%= post.getTitle() %>"> <!-- 이미지 -->
                <%
                    // 제목 자르기
                    String title = post.getTitle().length() > 10 ? post.getTitle().substring(0, 10) + "⋯" : post.getTitle();
                %>
                <h2 class="post-title"><%= title %></h2> <!-- 제목 -->
                <%
                    // 내용 자르기
                    String content = post.getContent().length() > 15 ? post.getContent().substring(0, 15) + "⋯" : post.getContent();
                %>
                <p class="post-description"><%= content %></p> <!-- 내용 -->
            </div>
        <% } %>
    </div>
</div>

<!-- footer -->
<br><br><br>
<jsp:include page="Default/Footer.jsp"></jsp:include>

<script>
    const button = document.getElementById('myButton');

    button.addEventListener('mousedown', function() {
        button.classList.add('clicked');
    });
    button.addEventListener('mouseup', function() {
        button.classList.remove('clicked');
    });
    button.addEventListener('mouseout', function() {
        button.classList.remove('clicked');
    });
</script>
</body>
</html>
