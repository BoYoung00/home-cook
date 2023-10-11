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
    String id = (String) request.getParameter("id");;
    String password = (String) request.getParameter("password");
    String name = (String) request.getParameter("name");
    String email = (String) request.getParameter("email");

    UserDao dao = new UserDao();
    UserDto dto = new UserDto(id, password, name, email);

    List<UserDto> list = dao.selete(id);

    if (list.isEmpty()) {

        int insert = dao.insert(dto);

        if (insert == 1) {
            script.println("<script>");
            script.println("alert('회원가입에 성공하셨습니다.')");
            script.println("location.href='Login.jsp'");
            script.println("</script>");
            script.close();
        } else {
            script.println("<script>");
            script.println("alert('회원가입에 실패하였습니다. 다시 시도해주세요.')");
            script.println("history.back()");
            script.println("</script>");
            script.close();
        }
    } else {
        script.println("<script>");
        script.println("alert('아이디가 이미 존재합니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();

    }
%>