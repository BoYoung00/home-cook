<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="Writing_action.jsp" method="post">
  <table style="text-align: center; border: 1px solid black">
    <thead>
      <tr>
        <th>글 쓰기</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <input type="file" name="image" multiple>
      </tr>
      <tr>
        <td><input type="text" name="title" id="title" placeholder="글 제목" maxlength="50"></td>
      </tr>
      <tr>
        <td><textarea type="text" name="content" id="content" style="height: 300px; width: 300px;"></textarea></td>
      </tr>
      <tr>
        <td><input type="submit" value="글쓰기"></td>
      </tr>
    </tbody>
  </table>
</form>
</body>
</html>
