<%--최초 작성자 : 김보영--%>
<%--최초 작성일 : 2023.11.12.--%>
<%--최초 변경일 : 2023.11.12.--%>
<%--목적 : 게시물 댓글 작성 --%>
<%--개정 이력 : 김보영, 2023.11.12.(var. 01)--%>
<%--저작권 : 없음--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Post.CommentDao" %>


<%
  request.setCharacterEncoding("UTF-8");
  PrintWriter script = response.getWriter();

  String commentText = (String) request.getParameter("comment");
  int postId = Integer.parseInt(request.getParameter("postId"));
  String userId = (String) session.getAttribute("userID");

  if (userId == null) {
    script.println("<script>");
    script.println("alert('댓글 작성은 로그인 후에 사용하시기 바랍니다.')");
    script.println("location.href='../Login.jsp'");
    script.println("</script>");
    script.close();
  } else if (commentText == null || commentText.trim().isEmpty()) {
    script.println("<script>");
    script.println("alert('댓글 내용을 입력해주세요.')");
    script.println("history.back()");
    script.println("</script>");
    script.close();
  } else {
    CommentDao commentDao = new CommentDao();

    int insert = commentDao.insertComment(postId, userId, commentText);

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