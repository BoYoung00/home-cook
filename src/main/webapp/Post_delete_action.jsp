<%@ page import="java.io.PrintWriter" %>
<%@ page import="Post.PostDao" %>
<%@ page import="Post.PostDto" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("UTF-8");
    PrintWriter script = response.getWriter();

    // 페이지 넘버 받아오기
    int postId = Integer.parseInt(request.getParameter("postId"));

    // 로그인 유무 확인
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }

    // 게시글 내용 가져오기
    PostDao postDao = new PostDao();
    PostDto post = postDao.selectView(postId); // 게시글 값들 가져오기

    // 로그인이 안되어 있을 시
    if (userID == null ) {
        script.println("<script>");
        script.println("alert('글 삭제는 로그인 후에 사용해주세요.')");
        script.println("location.href='Login.jsp'");
        script.println("</script>");
        script.close();
    }

    // 해당 게시글 작성자가 아닐 시
    if (!userID.equals(post.getPostUserId())) {
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
    } else {
        int delete = postDao.postDelete(postId);

        if (delete == 1) {
            script.println("<script>");
            script.println("alert('게시글 삭제가 완료되었습니다.')");
            script.println("location.href='Main.jsp'");
            script.println("</script>");
            script.close();
        } else {
            script.println("<script>");
            script.println("alert('게시글 삭제에 실패하셨습니다. 다시 시도해주세요.')");
            script.println("history.back()");
            script.println("</script>");
            script.close();
        }
    }
%>
