<!-- 최초 작성자 : 김보영 -->
<!-- 최초 작성일 : 2023.11.07. -->
<!-- 최초 변경일 : 2023.11.07. -->
<!-- 목적 : 게시글 수정 페이지 -->
<!-- 개정 이력 :
김보영, 2023.11.07.(var. 01)
-->
<!-- 저작권 : 없음 -->

<%@ page import="java.io.PrintWriter" %>
<%@ page import="User.UserDao" %>
<%@ page import="Post.PostDto" %>
<%@ page import="Post.PostDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포스팅 페이지</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link rel="icon" href="Default/img/icon.png" type="image/x-icon">
    <script src="https://code.jquery.com/jquery-3.7.1.slim.js" integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc=" crossorigin="anonymous"></script>
    <link href="Default/CSS/Post_update.css" rel="stylesheet" type="text/css">

</head>
<body>
<%
    // 로그인 유무 확인
    PrintWriter script = response.getWriter();
    String userID = null;

    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }

    // 페이지 넘버 받아오기
    int postId = Integer.parseInt(request.getParameter("postId"));

    // 게시글 내용 가져오기
    PostDao postDao = new PostDao();
    PostDto post = postDao.selectView(postId); // 게시글 값들 가져오기

    // 로그인이 안되어 있을 시
    if (userID == null ) {
        script.println("<script>");
        script.println("alert('글 수정은 로그인 후에 사용해주세요.')");
        script.println("location.href='Login.jsp'");
        script.println("</script>");
        script.close();
    }

    // 해당 게시글 작성자가 아닐 시
    if (!userID.equals(post.getPostUserId())) {
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
    }
%>

<!-- 헤더 -->
<jsp:include page="Default/Header.jsp"></jsp:include>

<!-- 포스팅 영역 -->
<div class="posting_area">
    <form action="Action/Post_update_action.jsp?postId=<%=post.getPostId()%>" method="post" enctype="multipart/form-data" id="postingForm">
        <h1 style="text-align: center; margin-bottom: 50px;">글 수정</h1>
        <select name="category" id="category">
            <option value="food">식사</option>
            <option value="dessert">디저트</option>
            <option value="drink">음료</option>
        </select>
        <input type="text" name="title" id="title" placeholder="글 제목" maxlength="50" value="<%=post.getTitle()%>">
        <br><br>
        <!--실제로 파일이름 값을 넘겨주는 태그 -->
        <input type="hidden" name="fileName" id="imageFile" value="">
        <input type="hidden" name="oldFileName" value="<%=post.getFileName()%>">

        <!-- 파일 선택 버튼 -->
        <input type="button" value="파일 선택" id="fileSelectButton">
        <!-- 숨겨진 파일 업로드 필드 -->
        <input type="file" class="prImageFile" name="fileBtn" id="fileBtn" style="display: none;" accept="image/*" onchange="readURL(this)" />
        <br><br>
        <div id="content_container">
            <div id="image_container">
                <img id="thumbnail" src="" alt="Image">
            </div>
            <textarea type="text" name="content" id="content" placeholder="글을 작성해주세요."><%=post.getContent()%></textarea>
        </div>
        <br>
        <br>
        <p><input type="submit" value="수정하기" id="myButton" class="ok_button"></p>
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
    // 실제 액션 jsp로 넘어가는 파일이름 값
    var imageFile = document.getElementById('imageFile');

    // 페이지 로드 시 이미지 보이기
    window.addEventListener('load', function() {
        var thumbnail = document.getElementById('thumbnail');
        var fileName = '<%=post.getFileName()%>'; // 이미지 파일 경로를 가져옴

        if (fileName) {
            thumbnail.src = fileName;
            imageFile.value = fileName;
            thumbnail.style.display = 'block';
        } else {
            imageFile.value = "";
            thumbnail.style.display = 'none';
        }
    });

    // 파일 바꿀 시 이미지 바꾸기
    function readURL(input) {
        var thumbnail = document.getElementById('thumbnail');
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                thumbnail.src = e.target.result;
                thumbnail.style.display = 'block';

                // 파일 이름을 가져와서 imageFile.value에 저장
                var fileName = input.files[0].name;
                imageFile.value = "uploadFile/" + fileName;
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            thumbnail.src = "";
            imageFile.value = "";
            thumbnail.style.display = 'none';
        }
    }

    // 파일 선택 버튼을 클릭할 때 파일 업로드 필드를 클릭하도록 설정
    document.getElementById('fileSelectButton').addEventListener('click', function () {
        document.getElementById('fileBtn').click();
    });
</script>

<%-- 카테고리 자동 선택 --%>
<script>
    const categoryParam = '<%= post.getCategory() %>'; // post.getCategory()를 사용하여 카테고리 값을 가져옴
    const categorySelect = document.getElementById("category");
    const options = categorySelect.options;

    for (let i = 0; i < options.length; i++) {
        if (options[i].value === categoryParam) {
            options[i].selected = true; // 일치하는 옵션을 선택
            break; // 일치하는 옵션을 찾으면 종료
        }
    }
</script>

</body>
</html>