<%@ page import="Post.PostDao" %>
<%@ page import="Post.PostDto" %>
<%@ page import="User.UserDao" %><%--
  Created by IntelliJ IDEA.
  User: Bo
  Date: 2023-10-24
  Time: 오후 10:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // 페이지 넘버 받아오기
    int postId = Integer.parseInt(request.getParameter("no"));

    // JDBC
    PostDao postDao = new PostDao();
    PostDto post = postDao.selectView(postId);

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
    <title><%=post.getTitle()%></title>
</head>
<body>
    <h3><%=post.getTitle()%></h3>
    <p>작성자 : <span><%=userName%></span> |
        <span> 작성날짜 : <%=post.getCreatedAt()%></span>
    </p>
    <hr>
    <img src="<%="uploadFile\\" + post.getFileName() %>" alt="이미지">
    <div><%=post.getContent()%></div>
</body>
</html>
