<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
		<head>
		    <meta charset="UTF-8">
		    <meta name="viewport" content="width=device-width, initial-scale=1.0">
		    	<title>ログイン - パシャログ</title>
				    <link rel="stylesheet" href="/css/login.css">
		</head>
<body>
		<c:if test="${not empty errorMessage}">
		    <script>
		        alert("${errorMessage}");
		    </script>
		</c:if>
		<c:if test="${param.message eq 'login_required'}">
		    <script>alert('ログインしてください。');</script>
		</c:if>
    <div class="container">       
	    <header class="header">
	        <a href="/" class="logo">パシャログ</a>
	    </header>
	</div>
        <main class="main-form">
            <div class="form-container">
                <h1 class="form-title">ログイン</h1>
               
                <form id="loginForm" action="/login" method="post">
                    
                    <div class="form-group">
                        <label class="form-label" for="loginId">ログインID</label>
                        <input type="text" id="username" name="loginid" class="form-input" placeholder="ログインIDを入力" required autofocus>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="password">パスワード (半角英数字)</label>
                        <div class="password-wrapper">
					        <input type="password" id="password" name="password" class="form-input" placeholder="パスワードを入力してください" required>
					        <span class="toggle-password" onclick="togglePassword()">👁</span>
					    </div>
                    </div>
                    
                    <div class="forgot-link">
                        <a href="http://localhost:8080/signup" class="forgot-password-link">ログインができない方はこちら</a>
                    </div>
                    
                    <div class="alert-password">
                        <a type="text">※パスワードは定期的に推測されにくいものへご変更をお願いします。</a>
                    </div>

                    <button type="submit" class="login-button">ログインする</button>
                 
                </form>
            </div>
          
        </main>	
        <div class="footer_container">
        <footer style="E3F2FD: #f1f1f1; padding: 10px 0; text-align: center; font-size: 14px; color: #666;">
    		All rights reserved by Pasharogu Team
		</footer>  
		</div>
	</body>
		<script src="/js/login.js"></script>
</html>