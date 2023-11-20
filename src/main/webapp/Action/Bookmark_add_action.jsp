<%--최초 작성자 : 김보영--%>
<%--최초 작성일 : 2023.11.20.--%>
<%--최초 변경일 : 2023.11.20.--%>
<%--목적 : 게시물 북마크 추가 --%>
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
        script.println("alert('북마크는 로그인 후에 사용하시기 바랍니다.')");
        script.println("location.href='../Login.jsp'");
        script.println("</script>");
        script.close();
    } else {
        BookmarkDao bookmarkDao = new BookmarkDao();

        int add = bookmarkDao.addBookmark(postId, userId);

        if (add == 1) {
            script.println("<script>");
            script.println("location.href = '../Post_view.jsp?no=" + postId + "'");
            script.println("alert('북마크에 저장되었습니다.');");
            script.println("</script>");
            script.close();
        } else {
            script.println("<script>");
            script.println("alert('북마크 저장에 실패하셨습니다.')");
            script.println("history.back()");
            script.println("</script>");
            script.close();
        }
    }
%>