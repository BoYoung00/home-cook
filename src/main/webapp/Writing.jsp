<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://code.jquery.com/jquery-3.7.1.slim.js" integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc=" crossorigin="anonymous"></script>
  <title>글쓰기</title>
</head>

<style>
  form {
    text-align: center;
    width: 800px; height: 600px;
  }

  #content_container {
    border: 1px solid black;
  }

  img {
    max-width: 100%; max-height: 100%;
    margin: auto;
  }

  textarea, textarea:focus {
    border: none;
    outline: none;
  }

  textarea {
    width: 100%; height: 70%;
    font-size: 18px;
    resize: none;
    overflow: auto;
  }

  #image_container {
    height: 250px; width: 100%;
    display: none
  }

</style>

<body>
<%
  PrintWriter script = response.getWriter();
  String userID = null;

  if (session.getAttribute("userID") != null) {
    userID = (String) session.getAttribute("userID");
  }

  if (userID == null) {
    script.println("<script>");
    script.println("alert('글 작성은 로그인 후에 사용해주세요.')");
    script.println("location.href='Login.jsp'");
    script.println("</script>");
    script.close();
  }
%>

<form action="Writing_action.jsp" method="post" enctype="multipart/form-data">0
  <h1 style="text-align: center;">글 쓰기</h1>
  <input class="prImageFile" name="imageFile" type="file" id="image" accept="image/*" onchange="setThumbnail(event)" />
  <select name="category" id="category">
    <option value="식사" selected>식사</option>
    <option value="디저트">디저트</option>
    <option value="음료">음료</option>
  </select>
  <input type="text" name="title" id="title" placeholder="글 제목" maxlength="50">
  <div id="content_container">
    <div id="image_container">
      <img id="thumbnail" src="" alt="Image">
    </div>
    <textarea type="text" name="content" id="content" placeholder="글을 작성해주세요."></textarea>
  </div>

  <input type="submit" value="글쓰기">
</form>


<script>
  $(function () {
    function setThumbnail(event) {
      var reader = new FileReader();
      var img = $("<img />");
      var container = $("#image_container");

      reader.onload = function (event) {
        img.attr("src", event.target.result);

        img.on("load", function () {
          var maxWidth = container.width();
          var maxHeight = container.height();
          var width = img.width();
          var height = img.height();
          var ratio = 1;

          if (width > maxWidth || height > maxHeight) {
            ratio = Math.min(maxWidth / width, maxHeight / height);
          }

          img.css({
            width: width * ratio + "px",
            height: height * ratio + "px"
          });
        });

        container.css("display", "block");
        container.empty(); // 이미지를 새로운 이미지로 대체
        container.append(img);
      };

      reader.readAsDataURL(event.target.files[0]);
    }

    function TextareaFocus() {
      let textarea = $("textarea");
      textarea.focus();
    }

    // Main
    TextareaFocus();

    $("#image").change(function (event) {
      setThumbnail(event);
    });
  });
</script>
</body>
</html>
