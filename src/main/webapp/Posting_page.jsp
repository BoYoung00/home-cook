<!-- 최초 작성자 : 김예지 -->
<!-- 최초 작성일 : 2023.10.25. -->
<!-- 최초 변경일 : 2023.10.25. -->
<!-- 목적 : 게시글 작성 페이지 -->
<!-- 개정 이력 :
김보영, 2023.10.25.(var. 01)
김보영, 2023.10.25.(var. 02)
-->
<!-- 저작권 : 없음 -->

<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link rel="icon" href="Default/img/icon.png" type="image/x-icon">
    <script src="https://code.jquery.com/jquery-3.7.1.slim.js" integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc=" crossorigin="anonymous"></script>
    <link href="Default/CSS/Posting_page.css" rel="stylesheet" type="text/css">

    <title>게시물 작성</title>
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
<jsp:include page="Default/Header.jsp"></jsp:include>

<!-- 포스팅 영역 -->
<div class="posting_area">
    <form action="Action/Posting_action.jsp" method="post" enctype="multipart/form-data" id="postingForm">
        <h1 style="text-align: center; margin-bottom: 50px;">글 쓰기</h1>
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
    function setThumbnail(event) {
        var reader = new FileReader();
        var img = document.createElement("img");
        var container = document.getElementById("image_container");

        reader.onload = function (event) {
            img.src = event.target.result;

            img.onload = function () {
                var maxWidth = container.offsetWidth;
                var maxHeight = container.offsetHeight;
                var width = img.width;
                var height = img.height;
                var ratio = 1;

                if (width > maxWidth || height > maxHeight) {
                    ratio = Math.min(maxWidth / width, maxHeight / height);
                }
                img.style.width = width * ratio + "px";
                img.style.height = height * ratio + "px";
            };

            container.style.display = "block";
            container.innerHTML = ""; // 이미지를 새로운 이미지로 대체
            container.appendChild(img);
        };
        reader.readAsDataURL(event.target.files[0]);
    }

    var imageInput = document.getElementById("image");
    if (imageInput) {
        imageInput.addEventListener("change", function (event) {
            setThumbnail(event);
        });
    }
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