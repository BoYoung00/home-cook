<!-- 최초 작성자 : 김보영 -->
<!-- 최초 작성일 : 2023.10.25. -->
<!-- 최초 변경일 : 2023.11.11. -->
<!-- 목적 : 게시글 조회 페이지 -->
<!-- 개정 이력 :
김보영, 2023.10.25.(var. 01)
김보영, 2023.11.11.(var. 02)
-->
<!-- 저작권 : 없음 -->

<%@ page import="User.UserDao" %>
<%@ page import="java.util.List" %>
<%@ page import="Post.*" %>
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

    // 댓글 목록 가져오기
    CommentDao commentDao = new CommentDao();
    List<CommentDto> commentList = commentDao.selectCommentAll(postId);

    // 대댓글 목록 가져오기
    ReplyCommentDao replyDao = new ReplyCommentDao();
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
        <a href="#" onclick="confirmDelete(<%=postId%>)">삭제</a>
    </p>
    <hr>
    <img src="<%= post.getFileName() %>" alt="<%= post.getTitle() %>">
    <div><%= post.getContent() %></div>

<%-- 댓글 --%>
    <div class="comments">
        <h2>댓글</h2>

        <!-- 댓글 목록 -->
        <ul>
            <li>
                <% for(CommentDto comment : commentList) {
                    String userId = comment.getUserId(); // 작성자 아이디
                    String createdAt = comment.getCreatedAt(); // 만든 일자
                    String text = comment.getCommentText(); // 댓글 내용
                    int commentId = comment.getCommentId(); // 댓글 번호
                %>
                    <%-- 댓글들--%>
                    <p>
                        <%= userId %> (<%= createdAt %>) : <%= text %> &nbsp;
                        <button onclick="toggleReplyForm(<%= commentId %>)">대댓글 작성</button>
                    </p>
                    <form id="replyForm-<%= commentId %>" action="Action/Reply_add_action.jsp" method="post" style="display: none; margin-right: 20px;">
                        <textarea name="reply" placeholder="대댓글을 입력하세요"></textarea>
                        <input type="hidden" name="postId" value="<%= postId %>"> <%-- 게시물 번호 보내기--%>
                        <input type="hidden" name="commentId" value="<%= commentId %>"> <%-- 댓글 번호 보내기--%>
                        <input type="submit" value="대댓글 작성">
                    </form>
                    <%-- 대댓글들--%>
                    <ul>
                        <%
                            List<ReplyCommentDto> replyList = replyDao.selectReplyAll(commentId); // 대댓글 가져오기
                            for(ReplyCommentDto reply : replyList) {
                        %>
                        <li>
                            <p><%= reply.getUserId() %> (<%= reply.getCreatedAt()%>) : <%= reply.getReplyText() %></p>
                        </li>
                        <% } // reply for %>
                    </ul>
                <% } // comment for %>
            </li>
        </ul>

        <form action="Action/Comment_add_action.jsp" method="post">
            <textarea name="comment" placeholder="댓글을 입력하세요"></textarea>
            <input type="hidden" name="postId" value="<%= postId %>"> <%-- 게시물 번호 보내기--%>
            <input type="submit" value="댓글 작성">
        </form>
    </div>

    <script>
        // 대댓글 작성 눌렀을 때 나타내기
        function toggleReplyForm(commentId) {
            var replyForm = document.getElementById("replyForm-" + commentId);
            replyForm.style.display = replyForm.style.display === "none" ? "block" : "none";
        }
    </script>

    <script>
        // 삭제 여부
        function confirmDelete(postId) {
            if (confirm("정말 삭제하시겠습니까?")) {
                window.location.href = "Post_delete_action.jsp?postId=" + postId;
            }
        }
    </script>
</body>
</html>
