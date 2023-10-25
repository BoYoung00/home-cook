<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: Bo
  Date: 2023-10-25
  Time: 오후 6:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포스팅 페이지</title>
    <link rel="stylesheet" href="posting_page.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link rel="icon" href="Default/img/icon.png" type="image/x-icon">
    <script src="https://code.jquery.com/jquery-3.7.1.slim.js" integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc=" crossorigin="anonymous"></script>

    <style>
        *{
            font-family: 'Hi Melody', sans-serif;

        }
        /* 헤더 */
        .LOGO{
            width: 200px;
            height: 90px;
        }

        .header_bg{
            background-color: #000;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 100;
        }

        .header{
            width:80%;
            margin-left: 50px;
            height: 86px;
        }

        /* 포스팅 영역 */
        .posting_area{
            width: 100%;
            height: 1500px;
            background-color: #FFFFE0;
            position: absolute;
            margin-left: -10px;
        }

        form {
            text-align: center;
            width: 1000px;
            height: 600px;
            margin-top: 150px;
            margin: 150px auto auto auto;

        }
        .prImageFile{
            float: left;
        }

        #title{
            width: 88%;
            height: 4%;
            resize: none;

        }

        #content_container {
            border: 1px solid black;
            height: 700px;
            overflow: auto;
            background-color: #fff;
        }


        #category{
            padding: 4px 20px 4px 20px;
            margin-right: 10px;
        }

        img {
            max-width: 100%;
            max-height: 100%;
            margin: auto;
        }

        textarea, textarea:focus {
            border: none;
            outline: none;
        }

        textarea {
            width: 100%;
            height: 70%;
            font-size: 18px;
            resize: none;
            overflow: auto;
        }

        #image_container {
            height: 250px;
            width: 100%;
            display: none
        }

        /* 글쓰기 버튼 */
        .ok_button{
            font-size: 20px;
            width: 100px;
            height: 40px;
            margin: auto;
            margin-top: 20px;
            background-color: #dc143c;
            color: #fff;
            border: none;
            border-radius: 10px;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
            cursor: pointer;
        }

        .clicked  {
            background-color: #FFFFE0;
            color: #dc143c;
            border: 2px solid #dc143c;
        }
    </style>
</head>
<body>
<%
    // 로그인 유무 확인
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

<!-- 헤더 -->
<div class="header_bg">
    <div class="header" id="link_header">
        <p><img src="img/logo.png" class="LOGO"></p>
    </div>
</div>
<!-- 포스팅 영역 -->
<div class="posting_area">
    <form action="Posting_action.jsp" method="post" enctype="multipart/form-data">
        <h1 style="text-align: center;">글 쓰기</h1>
        <select name="category" id="category">
            <option value="food">식사</option>
            <option value="dessert">디저트</option>
            <option value="drink">음료</option>
        </select>
        <input type="text" name="title" id="title" placeholder="글 제목" maxlength="50">
        <br><br>
        <input class="prImageFile" name="imageFile" type="file" id="image" accept="image/*" onchange="setThumbnail(event)" />
        <br><br>
        <div id="content_container">
            <div id="image_container">
                <img id="thumbnail" src="" alt="Image">
            </div>
            <textarea type="text" name="content" id="content" placeholder="글을 작성해주세요."></textarea>
        </div>
        <br>
        <br>
        <p><input type="submit" value="글쓰기" id= "myButton" class="ok_button"></p>
        <br>
        <br>
    </form>
</div>

<script>
    const button = document.getElementById('myButton');

    button.addEventListener('mousedown', function() {
        button.classList.add('clicked');
    });

    button.addEventListener('mouseup', function() {
        button.classList.remove('clicked');
    });

    button.addEventListener('mouseout', function() {
        button.classList.remove('clicked');
    });
</script>

<%--이미지 미리보기 기능--%>
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

        $("#image").change(function (event) {
            setThumbnail(event);
        });
    });
</script>

<%--옵션 자동 선택--%>
<script>
    // URL에서 "category" 파라미터 값을 가져옵니다.
    const urlParams = new URLSearchParams(window.location.search);
    const categoryParam = urlParams.get("category");

    // 만약 "category" 파라미터가 존재하면, 해당 값을 사용하여 select 요소를 선택합니다.
    if (categoryParam) {
        const categorySelect = document.getElementById("category");
        const options = categorySelect.options;
        for (let i = 0; i < options.length; i++) {
            if (options[i].value === categoryParam) {
                options[i].selected = true;
                break;  // 일치하는 옵션을 찾았으므로 루프를 종료합니다.
            }
        }
    }
</script>

</body>
</html>