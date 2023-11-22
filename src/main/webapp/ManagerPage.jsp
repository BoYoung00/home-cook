<%--
  Created by IntelliJ IDEA.
  User: qhdud
  Date: 2023-11-22
  Time: 오후 1:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원관리</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
</head>
<body>
<div class="header">
    <img src="Default/img/logo.png" alt="">
    <a href="Main.jsp">로그아웃</a>
</div>
<div class="sidetap">
    <input type="submit" value="회원 관리" id="Button1" class="ok_button" onclick="showSection('userlist')">
    <input type="submit" value="게시물 관리" id="Button2" class="ok_button" onclick="showSection('postlist')">
</div>
<div class="userlist" id="userlist">
    <h2>회원 목록</h2>
    <p><input type="submit" value="저장" class="save" class="ok_button"></p>
    <br>
    <br>
    <table>
        <thead>
        <tr>
            <th>이름</th>
            <th>이메일</th>
            <th>ID</th>
            <th>비밀번호</th>
            <th>비고</th>
            <th>삭제</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>이주연</td>
            <td>LY115@naver.com</td>
            <td>jy980115</td>
            <td>junyang98</td>
            <td></td>
            <td><input type="submit" value="삭제" class="delete" class="ok_button"></td>
        </tr>
        <tr>
            <td>김방전</td>
            <td>yosinori@naver.com</td>
            <td>yosi515</td>
            <td>yotnyang00</td>
            <td></td>
            <td><input type="submit" value="삭제" class="delete" class="ok_button"></td>
        </tr>
        </tbody>
    </table>
    <br>
    <br>
</div>

<div class="postlist" id="postlist">
    <h2>게시물 목록</h2>
    <p><input type="submit" value="저장" class="save" class="ok_button"></p>
    <br>
    <br>
    <table>
        <thead>
        <tr>
            <th>제목</th>
            <th>작성자</th>
            <th>작성시간</th>
            <th>카테고리</th>
            <th>비고</th>
            <th>삭제</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>김치볶음밥</td>
            <td>이주연</td>
            <td>1998-01-15</td>
            <td>식사</td>
            <td></td>
            <td><input type="submit" value="삭제" class= "delete" class="ok_button"></td>
        </tr>
        <tr>
            <td>타코야키</td>
            <td>김방전</td>
            <td>2000-05-15</td>
            <td>식사</td>
            <td></td>
            <td><input type="submit" value="삭제" class= "delete" class="ok_button"></td>
        </tr>
        </tbody>
    </table>
    <br>
    <br>
</div>


<script>
    function showSection(sectionId) {
        // 모든 섹션을 숨깁니다.
        document.getElementById('userlist').style.display = 'none';
        document.getElementById('postlist').style.display = 'none';

        // 클릭한 버튼에 해당하는 섹션을 표시합니다.
        document.getElementById(sectionId).style.display = 'block';
    }
</script>

<style>
    .save{
        width: 100px; height: 40px;
        float: right;
        margin-right: 50px;
    }
    .delete{
        width: 150px; height: 50px;
    }
    #Button1, #Button2{
        width: 250px; height: 60px;
        margin-top: 10px;
        margin-left: 15px;
    }
    img{
        width: 200px;
        height: 90px;
        margin-left: 10px;
    }
    a{
        float: right;
        margin-top: 40px;
    }
    .header{
        padding-right: 30px;
    }
    .sidetap{
        width: 280px; height: 600px;
        border: 1px solid black;
        display: inline;
        float: left;
        margin-left: 10px;
    }
    .postlist{
        border: 1px solid black;
        width: 1200px;
        margin-left: 300px;
        display: none;

    }
    .userlist{
        border: 1px solid black;
        width: 1200px;
        margin-left: 300px;
    }
    h2{
        font-size: 30px;
        margin-left: 40px;
    }
    *{
        font-size: 20px;
        font-family: 'Hi Melody', sans-serif;

    }
    th, td{
        padding: 5px 5px 5px 10px;
        border: 1px solid black;
        text-align: center;
    }
    table{
        margin: auto;
        border: 1px solid black;
        width: 1100px;
    }
</style>

</body>
</html>