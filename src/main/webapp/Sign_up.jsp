<!-- 최초 작성자 : 김예지 -->
<!-- 최초 작성일 : 2023.10.04. -->
<!-- 최초 변경일 : 2023.10.11. -->
<!-- 목적 : 회원가입 페이지 -->
<!-- 개정 이력 :
김보영, 2023.10.04.(var. 01)
김보영, 2023.10.11.(var. 02)
-->
<!-- 저작권 : 없음 -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
  <link rel="icon" href="Default/img/icon.png" type="image/x-icon">
  <link href="Default/CSS/Sign_up.css" rel="stylesheet" type="text/css">
  <title>회원가입</title>
</head>
<body>
<div class="Sign_up_page">
  <img src="Default/img/logo.png">
  <p>회 원 가 입</p>
  <form action="Action/Sign_up_action.jsp" method="post">
    <input type="text" class="signup_text" id="name" name="name" placeholder="  이름을 입력해주세요." size="50" required
           oninvalid="this.setCustomValidity('올바른 이름을 입력해주세요.')" oninput="this.setCustomValidity('')"><br/>

    <input type="text" class="signup_text" id="email" name="email" placeholder="  이메일을 입력해주세요." size="50" required
           oninvalid="this.setCustomValidity('유효한 이메일을 입력해주세요.')" oninput="this.setCustomValidity('')"><br/>

    <input type="text" class="signup_text" id="id" name="id" placeholder="  아이디를 입력해주세요." size="20" required
           oninvalid="this.setCustomValidity('올바른 아이디를 입력해주세요.')" oninput="this.setCustomValidity('')"><br/>

    <input type="password" class="signup_text" id="password" name="password" placeholder="  비밀번호를 입력해주세요." size="20" required
           oninvalid="this.setCustomValidity('비밀번호를 입력해주세요.')" oninput="this.setCustomValidity('')"><br/>

    <input type="password" class="signup_text" id="rePassword" placeholder="  비밀번호를 다시 입력해주세요." size="20" required
           oninvalid="this.setCustomValidity('비밀번호가 일치하지 않습니다.')" oninput="this.setCustomValidity('')"><br/>

    <label class="checkbox-container">
      <input type="checkbox"> 회원가입 개인정보 수집 및 이용 동의
    </label><br/>
    <p><input type="submit" id= "myButton" class="ok_button" value="확인"></p>
  </form>

  <script>
    // 버튼 액션 메서드
    function ClickSetup() {
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
    }

    // 유효성 검사 메인 메서드
    function ValidationMain() {
      // 폼 요소 가져오기
      const form = document.querySelector('form');
      const emailInput = document.querySelector('input[id="email"]');
      const passwordInput = document.querySelector('input[id="password"]');
      const confirmPasswordInput = document.querySelector('input[id="rePassword"]');
      const checkbox = document.querySelector('input[type="checkbox"]');
      const myButton = document.getElementById('myButton');

      // 폼 제출 시 유효성 검사 함수 호출
      form.addEventListener('submit', function (event) {
        if (!validateForm()) {
          event.preventDefault(); // 폼 제출을 중단
        }
      });

      // 폼 유효성 검사 함수
      function validateForm() {
        let isValid = true;

        // 이메일 필드 유효성 검사
        const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        if (!emailPattern.test(emailInput.value.trim())) {
          isValid = false;
          emailInput.setCustomValidity('유효한 이메일을 입력해주세요.');
        } else {
          emailInput.setCustomValidity('');
        }

        // 비밀번호 확인 필드 유효성 검사
        if (confirmPasswordInput.value !== passwordInput.value) {
          isValid = false;
          confirmPasswordInput.setCustomValidity('비밀번호가 일치하지 않습니다.');
        } else {
          confirmPasswordInput.setCustomValidity('');
        }

        // 동의 체크 필드 유효성 검사
        if (!checkbox.checked) {
          isValid = false;
          alert('약관에 동의해주세요.');
        }
        return isValid;
      }
    }

    // main
    ValidationMain();
    ClickSetup();

  </script>
</div>
</body>
</html>