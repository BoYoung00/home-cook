<%--최초 작성자 : 김보영--%>
<%--최초 작성일 : 2023.11.06.--%>
<%--최초 변경일 : 2023.11.06.--%>
<%--목적 : 게시글 수정--%>
<%--개정 이력 : 김보영, 2023.11.06.(var. 01)--%>
<%--저작권 : 없음--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.List" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="Post.PostDao" %>
<%@ page import="java.io.File" %>

<%
    request.setCharacterEncoding("UTF-8");
    PrintWriter script = response.getWriter();

    // 서버에서 저장할 localhost 뒤에 붙는 위치
    String path = "uploadFile/";
    String realPath = request.getServletContext().getRealPath(path);

    // 저장 용량 제한
    int size = 10 * 1024 * 1024; //10M

    // 실제적 파일 업로드 처리
    MultipartRequest multi = new MultipartRequest(request, realPath, size, "UTF-8", new DefaultFileRenamePolicy());

    // 파라미터
    int postId = Integer.parseInt(multi.getParameter("postId"));
    String title = (String) multi.getParameter("title");
    String content = (String) multi.getParameter("content");
    String fileName = (String) multi.getParameter("fileName");
    String category = (String) multi.getParameter("category");

    // 로그인 섹션
    String userID = (String) session.getAttribute("userID");

    if (title.isEmpty() || content.isEmpty()) {
        script.println("<script>");
        script.println("alert('입력이 안된 사항이 있습니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }

    PostDao dao = new PostDao();
    int updateResult = dao.postUpdate(postId, title, content, fileName, category);

    if (updateResult == 1) {
        script.println("<script>");
        script.println("alert('글 수정이 완료되었습니다.')");
        script.println("location.href='Post_list.jsp?category=" + category + "'");
        script.println("</script>");
        script.close();
    } else {
        script.println("<script>");
        script.println("alert('글 수정에 실패하셨습니다. 다시 시도해주세요.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
    }

    // 실제 폴더에 있는 이미지 파일 삭제
    String oldFileName = (String) multi.getParameter("oldFileName");

    File oldFile = new File(request.getServletContext().getRealPath(oldFileName));
    if(updateResult > 0 && oldFile.exists()) {
        System.out.println(oldFile.getAbsolutePath());
        oldFile.delete();
    }

%>