<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
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

    <title>Document</title>
</head>
<body>
    <!-- footer 시작 -->
    <footer>
        <div>
            <img src="Default/img/logo.png" class="footer_logo">
        </div>
        <div>
            CEO. 집밥의 민족 <br>
            Addr. 부천대학교 컴퓨터 소프트웨어과.<br>
            Tel. 010-XXXX-XXXX
        </div>
    </footer>
</body>
</html>
