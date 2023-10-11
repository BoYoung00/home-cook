<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="login.css">
    <!-- 최초 작성자 : 김예지 -->
    <!-- 최초 작성일 : 2023.10.10. -->
    <!-- 최초 변경일 : 2023.10.12. -->
    <!-- 목적 : 로그인 -->
    <!-- 개정 이력 : 김예지, 2023.10.12.(var. 01) -->
    <!-- 저작권 : 없음 -->

    <style>
        /* 페이지 전체 css , 폰트 설정 */
        *{
            margin: 0;
            padding: 0;
            font-family: 'Hi Melody', cursive;
        }
        /* 상단 탭 */
        .tabSet{
            margin: auto;
            width: 400px;
            height: 500px;
        }

        ul{
            padding: 20px 0 0 0;
            overflow: hidden;
            margin: auto;
        }

        a{
            text-decoration: none;
            float: left;
            border-radius: 10px 10px 0 0;
            padding: 15px 75.6px;
            background-color: #d3d3d3;
            color: #000;
            font-size: 20px;
            font-weight: bold;
        }

        a.on{
            background-color: #FFFFE0;
            color: black;
        }

        /* 패널 */
        .panel.on{
            display: block;
            background-color: #FFFFE0;
            margin: auto;
            border-radius: 0px 0px 20px 20px;
        }
        .panel{
            padding: 30px 30px;
            font-size: 18px;
            display: none;
            margin: auto;
            background-color: #FFFFE0;
            border-radius: 0px 0px 20px 20px;
            height: 500px;

        }
        /* 로고 */
        img{
            margin-left: 20%;
            width: 200px;
            height: 100px;
        }

        /* 텍스트 */
        p{
            text-align: center;
            font-size: 20px;
        }

        .Sign_up{
            margin-top: 30px;
        }

        .login_text{
            font-size: 40px;
        }

        /* 회원가입 하러 가기 */
        h3{
            text-align: center;
            font-size: 20px;
            text-decoration: underline;
            margin-top: 10px;
        }

        h3:hover{
            cursor: pointer;
        }

        .manager_sign_up{
            margin-top: 60px;
        }


        /* 텍스트 박스 */
        .login_textbox{
            margin-top: 35px;
            border: 0.5px solid #dc143c;
            border-radius: 15px 15px 15px 15px;
            width: 328px;
            height: 40px;
            padding-left: 10px;
        }


        /* 버튼 */
        .ok_button{
            font-size: 20px;
            width: 100px;
            height: 40px;
            margin: auto;
            margin-top: 70px;
            background-color: #dc143c;
            color: #fff;
            border: none;
            border-radius: 10px;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
            cursor: pointer;
        }
        /* 버튼 클릭시  */
        .clicked  {
            background-color: #FFFFE0;
            color: #dc143c;
            border: 2px solid #dc143c;
        }
    </style>
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
            <form class="user" action="Login_user_action.jsp" method="post">
                <img src="img/로고누끼.png" alt="">
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
                <h3 href="#" onclick="window.open('Sign_up.html')">회원가입 →</h3>
            </form>
        </div>
        <div class="panel">
            <!-- 관리자 로그인 페이지 -->
            <form class="manager" action="Manager_login_action.jsp" method="post">
                <img src="img/로고누끼.png " alt="">
                <p class="login_text">관리자 로그인</p>
                <!-- 텍스트 박스 -->
                <input type="id" class="login_textbox" name="managerID" placeholder= "  아이디를 입력해주세요." size="20" required
                       oninvalid="this.setCustomValidity('아이디를 입력해주세요.')" oninput="this.setCustomValidity('')"><br/>
                <input type = "password" class="login_textbox" name="managerPassword" placeholder="  비밀번호를 입력해주세요." size="20" required
                       oninvalid="this.setCustomValidity('비밀번호를 입력해주세요.')" oninput="this.setCustomValidity('')"><br/>
                <!-- 로그인 버튼 -->
                <p><button id="adminLoginButton" class="ok_button">로그인</button></p>
                <!-- 회원가입 하러 가기 -->
                <h3 class="manager_sign_up" href="#" onclick="window.open('Sign_up.html')">관리자 회원가입 →</h3>
            </form>
        </div>
    </div>
</div>
</body>
</html>