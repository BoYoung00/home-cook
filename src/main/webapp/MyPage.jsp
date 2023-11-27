<!-- 최초 작성자 : 김예지 -->
<!-- 최초 작성일 : 2023.11.22. -->
<!-- 최초 변경일 : 2023.11.22. -->
<!-- 목적 : 마이페이지 -->
<!-- 개정 이력 :
김예지, 2023.11.22.(var. 01)
김보영, 2023.11.22.(var. 02)
-->
<!-- 저작권 : 없음 -->

<%@ page import="Post.PostDao" %>
<%@ page import="Post.PostDto" %>
<%@ page import="java.util.List" %>
<%@ page import="Post.BookmarkDao" %>
<%@ page import="Post.BookmarkDto" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- <link rel="stylesheet" href="mypage.css"> -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link href="Default/CSS/MyPage.css" rel="stylesheet" type="text/css">

    <title>마이페이지</title>
</head>
<body>
<%
    // 로그인 섹션
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }

    // 로그인 되어있는 유저가 쓴 게시글 가져오기
    PostDao postDao = new PostDao();
    List<PostDto> posts = postDao.selectUserPostAll(userID);

    // 로그인 되어있는 유저가 한 북마크 가져오기
    BookmarkDao bookmarkDao = new BookmarkDao();
    List<BookmarkDto> bookmarks = bookmarkDao.selectBookmarkAll(userID);
%>

<jsp:include page="Default/Header.jsp"></jsp:include>

<!-- 페이지 상단부  -->
<div class="title">
    <h1>마이페이지</h1>
    <p><input type="submit" value="글 작성하기" id= "myButton" class="ok_button" onclick="location='Posting_page.jsp'"></p>
</div>

<div class="tabSet">
    <ul class="tabs">
        <p class="tabs1">
            <a href="#panel1" class="on" id="panel1">내 북마크</a>
            <a href="#panel1" id="panel2">내가 쓴 글</a>
        </p>
    </ul>
    <div class="panels">
        <!--            내 북마크-->
        <div class="panel on">
            <div class="first">
                <div class="post-list">

                    <%
                        for(BookmarkDto bookmark : bookmarks) {
                            List<PostDto> bookmarkPosts = postDao.selectPostIdAll(bookmark.getBookmarkPostId());
                            for(PostDto post : bookmarkPosts) {
                    %>
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
                        <%
                            } // post for
                        } // bookmark for
                        %>
                </div>
            </div>
        </div>

        <!--            내가 쓴 글-->
        <div class="panel">
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
        </div>
    </div>
</div>

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


    document.addEventListener("DOMContentLoaded", function () {
        var tabLinks = document.querySelectorAll(".tabs a");
        var panels = document.querySelectorAll(".panel");

        // 처음에는 첫 번째 탭이 활성화되어야 합니다.
        showPanel(0);

        tabLinks.forEach(function (tabLink, idx) {
            tabLink.addEventListener("click", function () {
                tabLinks.forEach(function (link) {
                    link.classList.remove("on");
                });
                this.classList.add("on");

                // 클릭한 탭의 인덱스를 가져와 해당 패널을 보여줍니다.
                showPanel(idx);
            });
        });

        function showPanel(index) {
            panels.forEach(function (panel) {
                panel.style.display = "none";
            });
            panels[index].style.display = "block";
        }
    });
</script>

</body>
</html>
