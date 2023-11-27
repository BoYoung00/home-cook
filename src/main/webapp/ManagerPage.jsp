<%@ page import="User.UserDao" %>
<%@ page import="java.util.List" %>
<%@ page import="User.UserDto" %>
<%@ page import="Post.PostDao" %>
<%@ page import="Post.PostDto" %><%--
  Created by IntelliJ IDEA.
  User: qhdud
  Date: 2023-11-22
  Time: 오후 1:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원관리</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link href="Default/CSS/ManagerPage.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
    // 회원 정보
    UserDao userDao = new UserDao();
    List<UserDto> users = userDao.selectUserAll();

    // 게시글 정보
    PostDao postDao = new PostDao();
    List<PostDto> posts = postDao.selectAll();
%>
<div class="header">
    <img src="Default/img/logo.png" alt="">
    <a href="Action/Logout_action.jsp">로그아웃</a>
</div>
<div class="sidetap">
    <input type="submit" value="회원 관리" id="Button1" class="ok_button" onclick="showSection('userlist')">
    <input type="submit" value="게시물 관리" id="Button2" class="ok_button" onclick="showSection('postlist')">
</div>
<div class="userlist" id="userlist">
    <h2>회원 목록</h2>
    <br>
    <br>
    <table>
        <thead>
        <tr>
            <th>이름</th>
            <th>이메일</th>
            <th>ID</th>
            <th>비밀번호</th>
            <th>비고</th>
        </tr>
        </thead>
        <tbody>
        <% for(UserDto user : users) { %>
            <tr>
                <td><%= user.getUserName() %></td>
                <td><%= user.getUserMail() %></td>
                <td><%= user.getUserID() %></td>
                <td><%= user.getUserPasswerd() %></td>
                <td></td>
            </tr>
        <% } %>
        </tbody>
    </table>
    <br>
    <br>
</div>

<div class="postlist" id="postlist">
    <h2>게시물 목록</h2>
    <br>
    <br>
    <table>
        <thead>
        <tr>
            <th>제목</th>
            <th>작성자</th>
            <th>작성시간</th>
            <th>카테고리</th>
            <th>비고</th>
            <th>삭제</th>
        </tr>
        </thead>
        <tbody>
        <% for(PostDto post : posts) { %>
        <tr>
            <td onclick="location='Post_view.jsp?no=<%= post.getPostId() %>'" style="cursor: pointer; color: blue"><%= post.getTitle() %></td>
            <td><%= post.getPostUserId() %></td>
            <td><%= post.getCreatedAt() %></td>
            <td><%= post.getCategory() %></td>
            <td></td>
            <td>
                <!-- 삭제 버튼 -->
                <form action="Action/Manager_post_delete_action.jsp" method="post" id="deleteForm">
                    <input type="hidden" name="postId" value="<%= post.getPostId() %>">
                    <input type="button" value="삭제" class="delete ok_button" onclick="confirmDelete()">
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <br>
    <br>
</div>

<script>
    function showSection(sectionId) {
        // 모든 섹션을 숨깁니다.
        document.getElementById('userlist').style.display = 'none';
        document.getElementById('postlist').style.display = 'none';

        // 클릭한 버튼에 해당하는 섹션을 표시합니다.
        document.getElementById(sectionId).style.display = 'block';
    }

    // 삭제 여부
    function confirmDelete() {
        if (confirm('정말로 삭제하시겠습니까?')) {
            submitForm();
        }
    }

    function submitForm() {
        document.getElementById('deleteForm').submit();
    }
</script>

</body>
</html>