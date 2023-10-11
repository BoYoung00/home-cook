<%--최초 작성자 : 김보영--%>
<%--최초 작성일 : 2023.10.03.--%>
<%--최초 변경일 : 2023.10.05.--%>
<%--목적 : 사용자 회원가입--%>
<%--개정 이력 : 김보영, 2023.10.05.(var. 01)--%>
<%--저작권 : 없음--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="User.UserDao" %>
<%@ page import="User.UserDto" %>
<%@ page import="java.util.List" %>

<%
    request.setCharacterEncoding("UTF-8");
    PrintWriter script = response.getWriter();

    String userID = (String) session.getAttribute("userID");
    if (userID != null) {
        script.println("<script>");
        script.println("alert('이미 로그인 되어있습니다.')");
        script.println("location.href='Main.jsp'");
        script.println("</script>");
        script.close();
    }

    String id = (String) request.getParameter("userId");;
    String password = (String) request.getParameter("userPassword");

    UserDao dao = new UserDao();
    int result = dao.login(id, password);

    if (result == 1) {
        session.setAttribute("userID", id);
        script.println("<script>");
        script.println("location.href='Main.jsp'");
        script.println("</script>");
        script.close();
    } else if (result == 0) {
        script.println("<script>");
        script.println("alert('비밀번호가 일치하지 않습니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
    } else if (result == -1) {
        script.println("<script>");
        script.println("alert('아이디가 존재하지 않습니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
    } else if (result == -2) {
        script.println("<script>");
        script.println("alert('데이터베이스 오류')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
    }

%>