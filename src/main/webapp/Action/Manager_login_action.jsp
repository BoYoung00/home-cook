<%--최초 작성자 : 김보영--%>
<%--최초 작성일 : 2023.11.22.--%>
<%--최초 변경일 : 2023.11.22.--%>
<%--목적 : 사용자 회원가입--%>
<%--개정 이력 : 김보영, 2023.11.22.(var. 01)--%>
<%--저작권 : 없음--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="User.UserDao" %>

<%
    request.setCharacterEncoding("UTF-8");
    PrintWriter script = response.getWriter();

    String userID = (String) session.getAttribute("userID");
    if (userID != null) {
        script.println("<script>");
        script.println("alert('이미 로그인 되어있습니다.')");
        script.println("location.href='../Main.jsp'");
        script.println("</script>");
        script.close();
    }

    String id = (String) request.getParameter("managerID");
    String password = (String) request.getParameter("managerPassword");

    if (id.equals("admin") && password.equals("pw123")) {
        session.setAttribute("userID", "admin");
        script.println("<script>");
        script.println("location.href='../ManagerPage.jsp'");
        script.println("</script>");
        script.close();
    } else {
        script.println("<script>");
        script.println("alert('비밀번호 또는 아이디가 틀립니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
    }

%>