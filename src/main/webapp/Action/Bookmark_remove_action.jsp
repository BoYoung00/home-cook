<%--최초 작성자 : 김보영--%>
<%--최초 작성일 : 2023.11.20.--%>
<%--최초 변경일 : 2023.11.20.--%>
<%--목적 : 게시물 북마크 삭제 --%>
<%--개정 이력 : 김보영, 2023.11.20.(var. 01)--%>
<%--저작권 : 없음--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Post.BookmarkDao" %>

<%
    request.setCharacterEncoding("UTF-8");
    PrintWriter script = response.getWriter();

    int postId = Integer.parseInt(request.getParameter("postId"));
    String userId = (String) session.getAttribute("userID");

    if (userId == null) {
        script.println("<script>");
        script.println("alert('잘못된 접근입니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
    } else {
        BookmarkDao bookmarkDao = new BookmarkDao();

        int add = bookmarkDao.removeBookmark(postId, userId);

        if (add == 1) {
            script.println("<script>");
            script.println("location.href = '../Post_view.jsp?no=" + postId + "'");
            script.println("alert('북마크가 삭제되었습니다.');");
            script.println("</script>");
            script.close();
        } else {
            script.println("<script>");
            script.println("alert('북마크 삭제에 실패하셨습니다.')");
            script.println("history.back()");
            script.println("</script>");
            script.close();
        }
    }
%>