<!-- 최초 작성자 : 김보영 -->
<!-- 최초 작성일 : 2023.10.25. -->
<!-- 최초 변경일 : 2023.11.11. -->
<!-- 목적 : 게시글 조회 페이지 -->
<!-- 개정 이력 :
김보영, 2023.10.25.(var. 01)
김보영, 2023.11.11.(var. 02)
김예지, 2023.11.13.(var. 03)
-->
<!-- 저작권 : 없음 -->

<%@ page import="User.UserDao" %>
<%@ page import="java.util.List" %>
<%@ page import="Post.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // 페이지 넘버 받아오기
    int postId = Integer.parseInt(request.getParameter("no"));

    // 로그인 정보 가져오기
    String loginUserId = (String) session.getAttribute("userID");

    // 해당 게시글 조회
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
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link href="Default/CSS/Post_view.css?after" rel="stylesheet" type="text/css">

    <title><%=post.getTitle()%></title>
</head>
<body >
    <!-- 헤더 -->
    <jsp:include page="Default/Header.jsp"></jsp:include>
    <!-- 제목 -->
    <div id="post_view_body">
        <section class="container">
            <h1 class="posting_title"><%= post.getTitle() %></h1>
            <!-- 작성자 이름과 날짜 -->
            <section class="con">
                <section class="info">
                    <div class="profile_info">
                        <strong id="pro_name">
                            <span><%= userName %></span>
                        </strong>
                        <span id="date">
                            <span><%= post.getCreatedAt() %></span>
                        </span>
                    </div>
                </section>
                <!-- 수정 삭제 버튼 -->
                <span id="corre_delete">
                    <a href="Post_update.jsp?postId=<%=postId%>" id="myButton1" class="corre" style="display: none;">수정</a>
                    <a href="#" onclick="confirmDelete(<%=postId%>)" id="myButton2" class="delete" style="display: none;">삭제</a>
                </span>
            </section>
            <!-- 본문내용 -->
            <section class="text">
                <img src="<%= post.getFileName() %>" alt="<%= post.getTitle() %>">
                <div id="text"><%= post.getContent() %></div>
            </section>
            <img class="bookmark" src="Default/img/bookmark_W.png" onclick="changeBookmark()">
            <img class="bookmark" src="Default/img/bookmark_B.png" style="display: none;" onclick="changeBookmark()">

            <!-- 댓글란 -->
            <section class="comments">
                <div class="comments_icon">
                    <input type="submit" value="댓글" id= "myButton3" class="delete" onclick="toggleCommentBox(0)">
                </div>

            <!-- 댓글 목록 -->
            <div class="commentbox" id="commentbox-0">
                <section class="reply">
                    <% for(CommentDto comment : commentList) {
                        String userId = comment.getUserId(); // 작성자 아이디
                        String createdAt = comment.getCreatedAt(); // 만든 일자
                        String text = comment.getCommentText(); // 댓글 내용
                        int commentId = comment.getCommentId(); // 댓글 번호

                        String commentUserName = userDao.selectUserName(userId); // 댓글 작성자 이름 찾기
                    %>
                        <%-- 댓글들--%>
                        <div class="reply_info">
                            <span class="content_name"><%= commentUserName %></span>
                            <span id="content"><%= text %></span>
                            <br>
                            <span onclick="toggleCommentBox(<%= commentId %>)" id="reply_but">대댓글 작성</span>
                        </div>
                        <form class="commentForm" id="commentbox-<%= commentId %>" action="Action/AddReply_action.jsp" method="post" style="display: none; margin-right: 10px;">
                            <textarea name="reply" placeholder="대댓글을 입력하세요"></textarea>
                            <input type="hidden" name="postId" value="<%= postId %>"> <%-- 게시물 번호 보내기--%>
                            <input type="hidden" name="commentId" value="<%= commentId %>"> <%-- 댓글 번호 보내기--%>
                            <input type="submit" value="대댓글 작성" class="commit">
                        </form>
                        <%-- 대댓글들--%>
                        <div class="content_in_content">
                            <%
                                List<ReplyCommentDto> replyList = replyDao.selectReplyAll(commentId); // 대댓글 가져오기
                                for(ReplyCommentDto reply : replyList) {
                                    String replyUserName = userDao.selectUserName(reply.getUserId()); // 대댓글 작성자 이름 찾기
                            %>
                                <p>
                                    <span class="content_name"> └ <%= replyUserName %> </span>
                                    <span class=""><%= reply.getReplyText() %></span>
                                </p>
                            <% } // reply for %>
                        </div>
                    <% } // comment for %>
                </section>
                <br>
                <!-- 댓글 입력 -->
                <div>
                    <% if(loginUserId != null) {
                        String loginUserName = userDao.selectUserName(loginUserId); // 로그인 상태인 유저 이름
                    %>
                        <p class="writer"><%= loginUserName %></p>
                    <% } else { %>
                        <p class="writer">로그인 후 사용해주세요.</p>
                    <% } %>
                    <form action="Action/AddComment_action.jsp" method="post" class="commentForm">
                        <textarea name="comment" id="myTextarea" cols="30" rows="10" placeholder="댓글을 입력하세요"></textarea>
                        <input type="hidden" name="postId" value="<%= postId %>"> <%-- 게시물 번호 보내기--%>
                        <input type="submit" value="댓글 작성" id= "myButton4" class="commit">
                    </form>
                </div>
            </div>
        </section>
    </section>
</div>

    <script>
        // 대댓글 작성 버튼 토글
        function toggleCommentBox(commentId) {
            var commentbox = document.getElementById("commentbox-" + commentId);
            if (commentbox) {
                commentbox.style.display = commentbox.style.display === "none" ? "block" : "none";
            }
        }

        // 삭제 여부
        function confirmDelete(postId) {
            if (confirm("정말 삭제하시겠습니까?")) {
                window.location.href = "Action/Post_delete_action.jsp?postId=" + postId;
            }
        }

        // 북마크 이미지 변경 및 alert 창 생성
        let currentBookmark = 0; // 이미지가 안 보이도록 초기값을 0으로 설정
        const bookmarks = document.querySelectorAll('.bookmark');

        function changeBookmark() {
            bookmarks[currentBookmark].style.display = 'none';
            currentBookmark = (currentBookmark + 1) % bookmarks.length;
            bookmarks[currentBookmark].style.display = 'inline';

            setTimeout(function () {
                if (currentBookmark === 0) {
                    alert("북마크가 해제되었습니다.");
                } else if (currentBookmark === 1) {
                    alert("북마크에 저장되었습니다.");
                }
            }, 0);
        }

        // 버튼 클릭시 색 변환
        ['myButton1', 'myButton2', 'myButton3', 'myButton4'].forEach(buttonId => {
            const button = document.getElementById(buttonId);

            button.addEventListener('mousedown', () => {
                button.classList.add('clicked');
            });

            button.addEventListener('mouseup', () => {
                button.classList.remove('clicked');
            });

            button.addEventListener('mouseout', () => {
                button.classList.remove('clicked');
            });
        });

        // 작성자 이름과 로그인 유저 이름이 같으면 보이도록 설정
        function showEditButtons() {
            var loginUserId = '<%= loginUserId %>';
            var postUserId = '<%= post.getPostUserId() %>';
            var editButtons = document.querySelectorAll('.corre, .delete');

            if (loginUserId === postUserId) {
                for (var i = 0; i < editButtons.length; i++) {
                    editButtons[i].style.display = 'inline';
                }
            }
        }

        // Main
        showEditButtons();
    </script>

</body>
</html>
