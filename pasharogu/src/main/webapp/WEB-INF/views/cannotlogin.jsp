<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>ログインができない方</title>
<link rel="stylesheet" href="/css/cannotlogin.css">  
</head>
<body>

<!-- 페이지 최상단에 로고 하나만 -->
<a href="/" class="logo">パシャログ</a>

<div class="container">
    <!-- 왼쪽 박스 -->
    <div class="box">
    <div class="info-text">アカウントがいない方は</div>
    <a href="/signup" class="btn">新規会員登録</a>
	</div>

    <!-- 오른쪽 박스 -->
    <div class="box">
        <div class="info-text">IDあるいはパスワードを忘れる方は</div>
        <div class="btn-group">
            <button class="btn">IDを探す</button>
            <button class="btn">パスワードをさがす</button>
        </div>
    </div>
</div>
<footer class="footer" style="text-align:center; margin-top: 60px; font-size: 16px; color: #89b5ff;">
        パシャログをご利用いただきありがとうございます。
</footer>
</body>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const buttons = document.querySelectorAll(".btn-group .btn");

        buttons.forEach(button => {
            button.addEventListener("click", function () {
                alert("開発予定の機能です。");
            });
        });
    });
</script>
</html>
