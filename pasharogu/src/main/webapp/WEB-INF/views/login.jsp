<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="UTF-8">
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;700&family=Noto+Sans+JP:wght@400;700&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"> 
		<link rel="stylesheet" href="/css/login.css">
		<title>ログイン - パシャログ</title>
	</head>
	<body>
		<c:if test="${errorMessage != null && errorMessage != ''}">
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
					        <i id="togglePassword" class="fa-solid fa-eye toggle-password"></i>
						    </div>
	                    </div>
	                    
	                    <div class="form-group remember-me">
						    <input type="checkbox" id="rememberId">
						    <label for="rememberId">IDを記憶する</label>
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
			<script src="/js/login.js"></script>
		</body>
</html>