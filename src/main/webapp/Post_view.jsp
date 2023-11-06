<%@ page import="Post.PostDao" %>
<%@ page import="Post.PostDto" %>
<%@ page import="User.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // 페이지 넘버 받아오기
    int postId = Integer.parseInt(request.getParameter("no"));

    // JDBC
    PostDao postDao = new PostDao();
    PostDto post = postDao.selectView(postId); // 조회

    // 작성자 이름 찾기
    UserDao userDao = new UserDao();
    String userName = userDao.selectUserName(post.getPostUserId());
%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="icon" href="Default/img/icon.png" type="image/x-icon">

    <title><%=post.getTitle()%></title>
</head>
<body>
    <h3><%= post.getTitle() %></h3>
    <p>작성자 : <span><%= userName %></span> |
        <span> 작성날짜 : <%= post.getCreatedAt() %></span>
    </p>
    <p>
        <a href="Post_update.jsp?postId=<%=postId%>">수정</a>
        <a href="Post_delete_action.jsp?postId=<%=postId%>">삭제</a>
    </p>
    <hr>
    <img src="<%= post.getFileName() %>" alt="<%= post.getTitle() %>">
    <div><%= post.getContent() %></div>
</body>
</html>
