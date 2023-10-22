<%--최초 작성자 : 김보영--%>
<%--최초 작성일 : 2023.10.22.--%>
<%--최초 변경일 : 2023.10.22.--%>
<%--목적 : 게시글 작성--%>
<%--개정 이력 : 김보영, 2023.10.22.(var. 01)--%>
<%--저작권 : 없음--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Post.PostDao" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%
    request.setCharacterEncoding("UTF-8");
    PrintWriter script = response.getWriter();

    String userID = (String) session.getAttribute("userID");

    if (request.getParameter("title").isEmpty() || request.getParameter("title").isEmpty()) {
        script.println("<script>");
        script.println("alert('입력이 안된 사항이 있습니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }


    // 서버에서 저장할 localhost 뒤에 붙는 위치
    String path = "/upload/image";
    String realPath = request.getServletContext().getRealPath(path);
    System.out.println(realPath);

    // 저장 용량 제한
    int size = 10 * 1024 * 1024; //10M

    // 실제적 파일 업로드 처리
    MultipartRequest multi = new MultipartRequest(request, realPath, size, "UTF-8", new DefaultFileRenamePolicy());

    String title = (String) request.getParameter("title");
    String content = (String) request.getParameter("content");

    PostDao dao = new PostDao();
    int result = dao.write(userID, title, content);

    if (result == 1) {
        script.println("<script>");
        script.println("alert('글 작성이 완료되었습니다.')");
        script.println("location.href='Main.jsp'");
        script.println("</script>");
        script.close();
    } else {
        script.println("<script>");
        script.println("alert('글 작성이 실패하셨습니다. 다시 시도해주세요.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
    }

%>