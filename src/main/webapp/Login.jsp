<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 최초 작성자 : 김예지 -->
<!-- 최초 작성일 : 2023.10.10. -->
<!-- 최초 변경일 : 2023.10.12. -->
<!-- 목적 : 로그인 -->
<!-- 개정 이력 :
김예지, 2023.10.10.(var. 01)
김보영, 2023.10.12.(var. 02)
-->
<!-- 저작권 : 없음 -->

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link rel="icon" href="Default/img/icon.png" type="image/x-icon">

    <link href="Default/CSS/Login.css" rel="stylesheet" type="text/css">

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var tabLinks = document.querySelectorAll(".tabs a");
            var panels = document.querySelectorAll(".panel");

            tabLinks.forEach(function(tabLink, idx) {
                tabLink.addEventListener("click", function() {
                    tabLinks.forEach(function(link) {
                        link.classList.remove("on");
                    });
                    this.classList.add("on");

                    panels.forEach(function(panel) {
                        panel.style.display = "none";
                    });
                    panels[idx].style.display = "block";
                });
            });

            // 사용자 로그인 버튼
            const userButton = document.getElementById('userLoginButton');

            // 관리자 로그인 버튼
            const adminButton = document.getElementById('adminLoginButton');

            userButton.addEventListener('mousedown', function() {
                userButton.classList.add('clicked');
            });

            userButton.addEventListener('mouseup', function() {
                userButton.classList.remove('clicked');
            });

            userButton.addEventListener('mouseout', function() {
                userButton.classList.remove('clicked');
            });

            adminButton.addEventListener('mousedown', function() {
                adminButton.classList.add('clicked');
            });

            adminButton.addEventListener('mouseup', function() {
                adminButton.classList.remove('clicked');
            });

            adminButton.addEventListener('mouseout', function() {
                adminButton.classList.remove('clicked');
            });
        });
    </script>
</head>
<body>
<!-- 상단 탭 -->
<div class="tabSet">
    <ul class="tabs">
        <a href="#panel1" class="on">사용자</a>
        <a href="#panel1">관리자</a>
    </ul>
    <!-- 탭 클릭시 나오는 패널 -->
    <div class="panels">
        <div class="panel on">
            <!-- 사용자 로그인 페이지 -->
            <form class="user" action="Action/Login_user_action.jsp" method="post">
                <img src="Default/img/logo.png" alt="로고" class="logo">
                <p class="login_text">사용자 로그인</p>
                <!-- 텍스트 박스 -->
                <input type="id" class="login_textbox" name="userId" placeholder= "  아이디를 입력해주세요." size="20" required
                       oninvalid="this.setCustomValidity('아이디를 입력해주세요.')" oninput="this.setCustomValidity('')"><br/>
                <input type = "password" class="login_textbox" name="userPassword"  placeholder="  비밀번호를 입력해주세요." size="20" required
                       oninvalid="this.setCustomValidity('비밀번호를 입력해주세요.')" oninput="this.setCustomValidity('')"><br/>
                <!-- 로그인 버튼 -->
                <p><button id="userLoginButton" class="ok_button">로그인</button></p>
                <!-- 회원가입 하러 가기 -->
                <p class="Sign_up">아직 회원이 아니시라면</p>
                <p><a href="Sign_up.jsp" id="Sign_up_but">회원가입 →</a></p>
            </form>
        </div>
        <div class="panel">
            <!-- 관리자 로그인 페이지 -->
            <form class="manager" action="Action/Manager_login_action.jsp" method="post">
                <img src="Default/img/logo.png" alt="로고" class="logo">
                <p class="login_text">관리자 로그인</p>
                <!-- 텍스트 박스 -->
                <input type="id" class="login_textbox" name="managerID" placeholder= "  아이디를 입력해주세요." size="20" required
                       oninvalid="this.setCustomValidity('아이디를 입력해주세요.')" oninput="this.setCustomValidity('')"><br/>
                <input type = "password" class="login_textbox" name="managerPassword" placeholder="  비밀번호를 입력해주세요." size="20" required
                       oninvalid="this.setCustomValidity('비밀번호를 입력해주세요.')" oninput="this.setCustomValidity('')"><br/>
                <!-- 로그인 버튼 -->
                <p><button id="adminLoginButton" class="ok_button">로그인</button></p>
            </form>
        </div>
    </div>
</div>

</body>
</html>