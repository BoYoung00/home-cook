<%--최초 작성자 : 김보영--%>
<%--최초 작성일 : 2023.12.04.--%>
<%--최초 변경일 : 2023.12.04.--%>
<%--목적 : 게시물 북마크 삭제 --%>
<%--개정 이력 : 김보영, 2023.12.04.(var. 01)--%>
<%--저작권 : 없음--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Post.CommentDao" %>
<%@ page import="java.util.List" %>
<%@ page import="Post.CommentDto" %>
<%@ page import="Post.ReplyCommentDao" %>

<%
    request.setCharacterEncoding("UTF-8");
    PrintWriter script = response.getWriter();

    int commentId = Integer.parseInt(request.getParameter("commentId"));
    String userId = (String) session.getAttribute("userID");

    CommentDao commentDao = new CommentDao();

    // 해당 댓글 정보 모두 가져오기
    CommentDto commentDto = commentDao.selectComment(commentId);

    if (!userId.equals(commentDto.getUserId())) {
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
    } else {
        // 해당 댓글의 대댓글들 삭제
        ReplyCommentDao replyCommentDao = new ReplyCommentDao();
        int reply = replyCommentDao.parentCommentIdIdDelete(commentId);
        if (reply > -1)
            System.out.println("연관 대댓글 삭제 완료 : " + reply);

        int remove = commentDao.deleteCommentId(commentId);

        if (remove > 0) {
            script.println("<script>");
            script.println("location.href = '../Post_view.jsp?no=" + commentDto.getPostId() + "'");
            script.println("alert('댓글이 삭제되었습니다.');");
            script.println("</script>");
            script.close();
        } else {
            script.println("<script>");
            script.println("alert('댓글 삭제에 실패하셨습니다.')");
            script.println("history.back()");
            script.println("</script>");
            script.close();
        }
    }
%>