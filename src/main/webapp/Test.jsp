<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--
  Created by IntelliJ IDEA.
  User: Bo
  Date: 2023-10-22
  Time: 오후 11:58
  To change this template use File | Settings | File Templates.
--%>

<%
    // 서버에서 저장할 localhost 뒤에 붙는 위치
    String path = "/upload/image";
    String realPath = request.getServletContext().getRealPath(path);
    System.out.println(realPath);

    // 저장 용량 제한
    int size = 10 * 1024 * 1024; //10M

    // 실제적 파일 업로드 처리
    MultipartRequest multi = new MultipartRequest(request, realPath, size, "UTF-8", new DefaultFileRenamePolicy());
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>

</body>
</html>