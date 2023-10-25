<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Post.PostDao" %>
<%@ page import="java.util.List" %>
<%@ page import="Post.PostDto" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인 홈페이지</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&display=swap" rel="stylesheet">
    <style>
        *{
            font-family: 'Hi Melody', sans-serif;
            list-style: none;
            text-decoration: none;
            border-collapse: collapse;
            margin: 0px;
            padding: 0px;
            color: #000;
        }

        /* 글씨들 조정정 */
        h1{
            font-size: 48px;
            font-weight: 100;
        }

        .contents1{
            font-size: 20PX;
            font-weight: lighter;
        }

        .contents3{
            font-size: 14px;
            font-weight: 100;
        }

        .contents1_bold{
            font-size: 18px;
            font-weight: bold;
        }

        /*  상단 탭 (고정) */
        .LOGO{
            width: 200px;
            height: 90px;

        }

        .header_bg{
            background-color: #000;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 100;
        }

        .header{
            display: flex;
            width:80%;
            margin: auto;
            height: 86px;
        }

        .nav{
            display: flex;
            justify-content: flex-end;
            line-height: 86px;
            width: calc(1280px - 300px);
        }

        .nav > li {
            margin-left:64px ;
        }

        .nav > li > a {
            color: #fff;
        }

        /*로그아웃 버튼*/
        #logout {
            font-family: 'Hi Melody', sans-serif;
            font-size: 16px;
            background-color: transparent;
            color: white;
            padding-left: 50px;
            border: none;
            cursor: pointer;
        }

        /* 상단 인트로 */
        .intro_bg{
            width: 100%;
            height: 718px;
            background-color: lightblue;
            padding-top: 86px;
        }

        .intro_text{
            width: 100%;
            margin: 231px auto 231px auto;
            text-align: center;
        }

        .intro_text > h1 {
            color: #fff;
        }


        /* 생활비 소개글 */
        .amount{
            position: relative;
            top: -66px;
            display: flex;
            width: 1280px;
            background-color: #fff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            margin: auto;
        }

        .amount>li{
            flex: 1;
            height: 132px;
        }

        .amount> li > div{
            text-align: center;
            margin-top: 37px;
            height: 57px;
        }

        .amount > li > div:not(:last-child){
            border-right: 1px solid #E1E1E1;

        }

        .result{
            font-size: 24PX;
        }

        /* food Preview */

        .food{
            height: 601px;
            margin-top: -132px;
            background: #f1f3f3;
        }

        .food > h1{
            padding-top: 116px;
            text-align: center;
        }

        .Preview{
            white-space: nowrap; /* 요소가 가로로 나란히 정렬되도록 설정 */
            display: flex;
            width: 1280px;
            height: 302px;
            margin: auto;
        }

        .Preview > .imgHoverEvent{
            flex: 1;
            height: 302px;
            margin-top: 49px;
            background: #000;
            text-align: center;
            position: relative;
            overflow: hidden;
            display: inline-block;
        }

        .Preview > .imgHoverEvent:not(:last-child){
            margin-right: 20px;
        }

        .imgHoverEvent .imgBox{
            width: 210px;
            text-align: center;
            /*background:url(http://gahyun.wooga.kr/portfolio/triple/resources/img/city00.jpg);*/
            /*no-repeat: 50% 50%;*/
            background-size: auto 100%;
            margin: auto;
            letter-spacing: -1px;
            padding-top: 5px;
            color: #fff;
        }

        /*미리보기 이미지 크기*/
        .preview_img {
            position: absolute;
            max-width: 300px;
            height: auto;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            margin: auto;
        }

        .imgHoverEvent .hoverBox{
            width: 441px;
            height: 150px;
            line-height: 30px;
            position: relative;
            bottom: -154px;
        }

        /* hoverbox 안에 제목과 내용 */
        .hoverBox p.p1{
            text-align:center;
            font-size:18px;
            color: #fff;
            margin-right: 20px;
        }
        .hoverBox p.p2{
            color: #fff;
            text-align:center;
            margin-top: 20px;
            margin-right: 20px;

        }
        /* hover 이벤트 */
        .event1 .hoverBox{
            background: linear-gradient(to bottom, rgba(0,0,0,0) 5%,rgba(255,255,255,1) 90%);
            transform: translateY(70%);
            transition: 0.5s;
            opacity: 0;
        }

        .event1:hover .hoverBox{
            transform: translateY(0);
            opacity: 1;
        }

        .event1:hover { cursor: pointer; }

        .dessert{
            height: 601px;
            width: 100%;
            background: #fff;
        }

        .dessert > h1{
            padding-top: 60px;
            text-align: center;
        }

        .drink{
            height: 601px;
            background: #f1f3f3;
            margin-top: -60px;
            margin-bottom: -20px;
        }

        .drink > h1{
            padding-top: 60px;
            text-align: center;
        }

        /* 더보기 */
        .show_more{
            position: relative;
            top: 10px;
            left: 1500px;
        }

        /* main_text1 */

        .main_text1 > h1{
            padding-top: 50px;
            text-align: center;
        }

        .main_text1 > .contents1{
            text-align: center;
        }

        .service{
            width: 1280px;
            display: flex;
            margin: 49px auto;
            height: 427px;
            /* background: skyblue; */
        }

        .service > .contents2{
            padding: 20px;
        }

        .service > .contents2 >h2{
            margin-bottom: 27px;
        }

        /* main_text2 */

        /*.main_text2{*/
        /*    width: 100%;*/
        /*    height: 418px;*/
        /*    background-image: url("image/마스크\ 그룹\ 1.png");*/
        /*}*/

        .main_text2 > ul {
            display: flex;
            padding-top: 138px;
        }

        .main_text2 > ul > li{
            flex: 1;
            text-align: center;
        }

        .main_text2 > ul > li > div,
        .main_text2 > ul > li > div > h1{
            color: #fff;
        }


        .more2 {
            width: 220px;
            height: 40px;
            border: 1px solid #fff;
            color: #fff;
            line-height: 40px;
            cursor: pointer;
            margin: 16px auto;
        }

        /* footer */
        footer{
            display: flex;
            background: #1f1f1f ;
            padding: 30px;
        }

        footer > div:first-child{
            flex: 3;
            text-align: center;
            color: #fff;
        }

        footer > div:last-child{
            flex: 9;
            color: #fff;
        }

        .footer_logo{
            width: 200px;
            height: 90px;

        }
    </style>
</head>
<body>

<%
    // 로그인 섹션
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }

    // 글 목록
    PostDao postDao = new PostDao();
    List<PostDto> posts = postDao.selectAll();
    int displayCount = 3; // 표시할 게시글 개수
%>

<!-- 페이지 상단 부분 -->
<div class="wrap">
    <div class="intro_bg">
        <div class="header_bg">
            <div class="header" id="link_header">
                <p><img src="img/logo.png" class="LOGO"></p>
                <!-- 상단 탭 바 -->
                <ul class="nav">
                    <li><a href="#">홈</a></li>
                    <li><a href="#link_food">식사</a></li>
                    <li><a href="#link_dessert">디저트</a></li>
                    <li><a href="#link_drink">음료</a></li>
                    <%
                        if (userID == null) {
                    %>
                    <li><a href="Login.jsp">로그인</a></li>
                    <%
                    } else {
                    %>
                        <li><a href="#">마이페이지</a></li>
                        <form action="Logout_action.jsp" method="post">
                            <li><a><input type="submit" id="logout" value="로그아웃"></a></li>
                        </form>
                    <% } %>
                </ul>
            </div>
        </div>
        <div class="intro_text">
            <h1>물가 상승에 맞서, <br>
                모두가 함께 아끼자! 💰</h1>
        </div>
    </div>
</div>

<!-- 중간 소개글 -->
<ul class="amount">
    <li>
        <div>
            <div class="contents1">4인 가구 기준 월 평균 식비</div>
            <div class="result">1,500,000원</div>
        </div>
    </li>
    <li>
        <div>
            <div class="contents1">4인 가구 기준 월 평균 생활비</div>
            <div class="result">2,500,000원</div>
        </div>
    </li>
    <li>
        <div>
            <div class="contents1">1인 가구 기준 월 평균 식비</div>
            <div class="result">500,000원</div>
        </div>
    </li>
    <li>
        <div>
            <div class="contents1">1인 가구 기준 월 평균 생활비</div>
            <div class="result">1,000,000원</div>
        </div>
    </li>
</ul>

<!-- 식사 레시피 미리보기 -->

<div class="food" id="link_food">
    <h1>식사 레시피</h1>
    <p><a href="" class="show_more">더보기</a></p>
    <ul class="Preview">
        <% for (int i = 0; i < posts.size() && i < displayCount; i++) {
            PostDto post = posts.get(i);
            if (post.getCategory().equals("식사")) { %>
            <li class="imgHoverEvent event1" onclick="location='Post_view.jsp?no=<%=post.getPostId()%>'">
                <div class="contents1_bold">firework</div>
                <div class="imgBox">
                    <img class="preview_img" src="<%="uploadFile/" + post.getFileName() %>" alt="이미지">
                </div>
                <div class="hoverBox">
                    <p class="p1"><%= post.getTitle() %></p>
                    <p class="p2"><%= post.getContent() %></p>
                </div>
            </li>
        <% }
        } %>
    </ul>
</div>

<!-- 식사 레시피 미리보기 -->
<div class="dessert" id="link_dessert">
    <h1>디저트 레시피</h1>
    <p><a href="" class="show_more">더보기</a></p>
    <ul class="Preview">
        <% for (int i = 0; i < posts.size() && i < displayCount; i++) {
            PostDto post = posts.get(i);
            if (post.getCategory().equals("디저트")) { %>
        <li class="imgHoverEvent event1" onclick="location='Post_view.jsp?no=<%=post.getPostId()%>'">
            <div class="contents1_bold">firework</div>
            <div class="imgBox">
                <img class="preview_img" src="<%="uploadFile/" + post.getFileName() %>" alt="이미지">
            </div>
            <div class="hoverBox">
                <p class="p1"><%= post.getTitle() %></p>
                <p class="p2"><%= post.getContent() %></p>
            </div>
        </li>
        <% }
        } %>
    </ul>
</div>

<!-- 식사 레시피 미리보기 -->
<div class="drink" id="link_drink">
    <h1>음료 레시피</h1>
    <p><a href="" class="show_more">더보기</a></p>
    <ul class="Preview">
        <% for (int i = 0; i < posts.size() && i < displayCount; i++) {
            PostDto post = posts.get(i);
            if (post.getCategory().equals("음료")) { %>
        <li class="imgHoverEvent event1"  onclick="location='Post_view.jsp?no=<%=post.getPostId()%>'">
            <div class="contents1_bold">firework</div>
            <div class="imgBox">
                <img class="preview_img" src="<%="uploadFile/" + post.getFileName() %>" alt="이미지">
            </div>
            <div class="hoverBox">
                <p class="p1"><%= post.getTitle() %></p>
                <p class="p2"><%= post.getContent() %></p>
            </div>
        </li>
        <% }
        } %>
<%--        <li class="imgHoverEvent event1">--%>
<%--            <div class="contents1_bold">drowning</div>--%>
<%--            <div class="imgBox">--%>
<%--                메인사진--%>
<%--            </div>--%>
<%--            <div class="hoverBox">--%>
<%--                <p class="p1">제목</p>--%>
<%--                <p class="p2">내용내용내용내용내용내용</p>--%>
<%--            </div>--%>
<%--        </li>--%>
    </ul>
</div>


<!-- 사이트 소개 글 -->
<div class="main_text1" id="link_main_text1">
    <div class="service">
        <div class="fooh_photo">
            <img src="img/main1.jpg" alt="" width="400" height="400">
        </div>
        <div class="contents2">
            <h2>집밥의 민족 소개글</h2>

            "집밥의 민족"은 물가 상승으로 인해 생활비 부담을 <br>
            덜어주기 위해 탄생한 공간입니다. <br><br>

            요리 레시피를 공유하고 경제적인 요리의 즐거움을 함꼐 나누며, <br>
            집에서 요리하는 스킬을 향상시키는 곳이에요. <br>
            아낄 수 있는 비법을 배우고 레시피를 공유하며, <br>
            더 현명한 요리를 통해 더 많은 가정이 행복한 식사를 누릴 수 있도록 돕습니다.<br><br>

            집밥의 민족과 함께하면 요리가 더욱 즐겁고 경제적으로 <br>
            현명한 선택이 될 것입니다. <br>
        </div>
    </div>

    <!-- footer 시작 -->
    <footer>
        <div>
            <img src="img/logo.png" class="footer_logo">
        </div>
        <div>
            CEO. 집밥의 민족 <br>
            Addr. 부천대학교 컴퓨터 소프트웨어과.<br>
            Tel. 010-XXXX-XXXX
        </div>
    </footer>
</div>
</body>
</html>