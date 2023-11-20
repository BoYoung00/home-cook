<%--최초 작성자 : 김보영--%>
<%--최초 작성일 : 2023.11.12.--%>
<%--최초 변경일 : 2023.11.12.--%>
<%--목적 : 게시물 대댓글 작성 --%>
<%--개정 이력 : 김보영, 2023.11.12.(var. 01)--%>
<%--저작권 : 없음--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Post.ReplyCommentDao" %>

<%
    request.setCharacterEncoding("UTF-8");
    PrintWriter script = response.getWriter();

    String replyText = (String) request.getParameter("reply");
    int commentId = Integer.parseInt(request.getParameter("commentId"));
    int postId = Integer.parseInt(request.getParameter("postId"));
    String userId = (String) session.getAttribute("userID");

    if (userId == null) {
        script.println("<script>");
        script.println("alert('댓글 작성은 로그인 후에 사용하시기 바랍니다.')");
        script.println("location.href='../Login.jsp'");
        script.println("</script>");
        script.close();
    } else if (replyText == null || replyText.trim().isEmpty()) {
        script.println("<script>");
        script.println("alert('댓글 내용을 입력해주세요.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
    } else {
        ReplyCommentDao replyDao = new ReplyCommentDao();

        int insert = replyDao.insertReply(commentId, userId, replyText);

        if (insert == 1) {
            script.println("<script>");
            script.println("location.href = '../Post_view.jsp?no=" + postId + "'");
            script.println("</script>");
            script.close();
        } else {
            script.println("<script>");
            script.println("alert('댓글 작성에 실패하였습니다. 다시 시도해주세요.')");
            script.println("history.back()");
            script.println("</script>");
            script.close();
        }
    }
%>