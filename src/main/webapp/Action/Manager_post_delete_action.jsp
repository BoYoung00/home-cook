<!-- 최초 작성자 : 김보영 -->
<!-- 최초 작성일 : 2023.11.27. -->
<!-- 최초 변경일 : 2023.11.27. -->
<!-- 목적 : 회원 정보 삭제 액션 -->
<!-- 개정 이력 :
김보영, 2023.11.27.(var. 01)
-->
<!-- 저작권 : 없음 -->

<%@ page import="java.io.PrintWriter" %>
<%@ page import="User.UserDao" %>
<%@ page import="java.util.List" %>
<%@ page import="Post.*" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    PrintWriter script = response.getWriter();

    // 페이지 넘버 받아오기
    int postId = Integer.parseInt(request.getParameter("postId"));

    // 관리자 로그인 유무 확인
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");

        if (!userID.equals("admin")) {
            script.println("<script>");
            script.println("alert('권한이 없습니다.')");
            script.println("history.back()");
            script.println("</script>");
            script.close();
        }
    }
    // 외래키로 연결된 데이터 모두 삭제
    ReplyCommentDao replyCommentDao = new ReplyCommentDao();
    CommentDao commentDao = new CommentDao();
    BookmarkDao bookmarkDao = new BookmarkDao();
    PostDao postDao = new PostDao();
    PostDto post = postDao.selectView(postId); // 게시글 값들 가져오기

    // 해당 게시글 번호로 대댓글 모두 불러와서 대댓글 삭제
    List<CommentDto> comments = commentDao.selectCommentAll(postId);
    for (CommentDto comment : comments) {
        // 대댓글 모두 삭제
        int replyDelete = replyCommentDao.replyCommentDelete(comment.getCommentId());
        if (replyDelete > -1)
            out.println("대댓글 삭제 완료");
    }
    // 댓글 모두 삭제
    int commentDelete = commentDao.commentDelete(postId);
    if (commentDelete > -1)
        out.println("댓글 삭제 완료");

    // 북마크 삭제
    int bookmarkDelete = bookmarkDao.removeAllPostBookmark(postId);
    if (bookmarkDelete > -1)
        out.println("북마크 삭제 완료");

    // 실제 폴더에 있는 이미지 파일 삭제
    File oldFile = new File(request.getServletContext().getRealPath(post.getFileName()));

    // 게시글 삭제
    int delete = postDao.postDelete(postId);

    if (delete == 1) {
        script.println("<script>");
        script.println("alert('게시글 삭제가 완료되었습니다.')");
        script.println("location.href='../ManagerPage.jsp'");
        script.println("</script>");
        script.close();
    } else {
        script.println("<script>");
        script.println("alert('게시글 삭제에 실패하셨습니다. 다시 시도해주세요.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
    }
    // 이미지 파일 삭제
    if(delete > 0 && oldFile.exists()) {
        System.out.println(oldFile.getAbsolutePath());
        oldFile.delete();
    }
%>
