<%@ page import="Post.PostDao" %>
<%@ page import="Post.PostDto" %>
<%@ page import="User.UserDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Post.CategoryEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="food_posts_list.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link rel="icon" href="Default/img/icon.png" type="image/x-icon">

    <title>식사 게시물 목록</title>

    <style>
        *{
            font-family: 'Hi Melody', sans-serif;
            list-style: none;
            text-decoration: none;
            border-collapse: collapse;
            margin: 0px;
            padding: 0px;
            color: #000;

        }
        /* header */
        .LOGO{
            width: 200px;
            height: 90px;
            cursor: pointer;
        }

        .header_bg{
            background-color: #000;
            position: fixed;
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

        .nav > li >a {
            color: #fff;
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

        /* 페이지 상단부 */
        .title{
            width: 100%;
            height: 180px;
            background-color: #FFFFE0;
            padding-top: 106px;

        }

        .title > h1{
            text-align: center;
            font-size: 50px;
        }


        /* 글쓰기 버튼 */
        .ok_button{
            font-size: 14px;
            width: 80px;
            height: 30px;
            margin: auto;
            margin-top: 50px;
            background-color: #dc143c;
            color: #fff;
            border: none;
            border-radius: 10px;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
            cursor: pointer;
            margin-right: 200px;
            position: absolute;
            right: 0;
        }

        .clicked  {
            background-color: #FFFFE0;
            color: #dc143c;
            border: 2px solid #dc143c;
        }


        /* 글 목록 */
        body {
            font-family: Arial, sans-serif;
            background-color: #FFFFE0;
            margin: 0;
            padding: 0;
        }

        .post-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(210px, 1fr));
            grid-auto-rows: 210px;
            gap: 20px;
            padding: 20px;
            /* background-color: #FFFFE0; */
        }

        .post {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            cursor: pointer; /* 이 부분을 추가하여 커서를 클릭로 변경 */
        }

        .thumbnail {
            max-width: 100%;
            max-height: 120px;
            object-fit: cover;
        }

        .post-title {
            font-size: 20px;
            margin-top: 10px;
        }

        .post-description {
            font-size: 14px;
            margin-top: 5px;
        }

        .first{
            width: 1000px;
            margin: auto;
            /* background-color: #FFFFE0; */
        }

        /* footer */
        footer {
            position: fixed;
            bottom: 0;
            display: flex;
            background: #1f1f1f;
            padding: 30px;
            width: 100%;
        }

        footer > div:first-child {
            flex: 3;
            text-align: center;
            color: #fff;
        }

        footer > div:last-child {
            flex: 9;
            color: #fff;
        }

        .footer_logo {
            width: 200px;
            height: 90px;
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

    // 페이지 넘버 받아오기
    String inputCategory = request.getParameter("category");

    // 해당 카테고리 게시물들 가져오기
    PostDao postDao = new PostDao();
    List<PostDto> posts = postDao.selectCategory(inputCategory);
%>

<!-- 헤더 -->
<div class="header_bg">
    <div class="header" id="link_header">
        <p><img src="img/logo.png" class="LOGO" onclick="location='Main.jsp'"></p>
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
            <li><a href="#">마이페이지</a></li>
            <form action="Logout_action.jsp" method="post">
                <li><a><input type="submit" id="logout" value="로그아웃"></a></li>
            </form>
            <% } %>
        </ul>
    </div>
</div>

<!-- 페이지 상단부  -->
<div class="title">
    <h1>식사 레시피 목록</h1>
    <%--<p><button class="write_btn" onclick="location='Posting_page.jsp'">글 작성하기</button></p>--%>
    <p><input type="button" value="글 작성하기" id= "myButton" class="ok_button" onclick="location='Posting_page.jsp?category=<%=inputCategory%>'"></p>
</div>

<!-- 내용 -->
<div class="first">
    <div class="post-list">
        <% for(PostDto post : posts) { %>
            <div class="post" onclick="location='Post_view.jsp?no=<%= post.getPostId() %>'"> <!-- 해당 게시글 조회 -->
                <img class="thumbnail" src="<%= post.getFileName() %>" alt="<%= post.getTitle() %>"> <!-- 이미지 -->
                <h2 class="post-title"><%= post.getTitle() %></h2> <!-- 제목 -->
                <p class="post-description"><%= post.getContent() %></p> <!-- 내용 -->
            </div>
        <% } %>
    </div>
</div>


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

<!-- footer -->
<br>
<br>
<br>
<footer>
    <div>
        <img src="img/logo.png" class="footer_logo">
    </div>
    <div>
        CEO. 집밥의 민족 <br>
        Addr. 부천대학교 컴퓨터 소프트웨어과.<br>
        Tel. 010-XXXX-XXXX
    </div>
</footer>

</body>
</html>
