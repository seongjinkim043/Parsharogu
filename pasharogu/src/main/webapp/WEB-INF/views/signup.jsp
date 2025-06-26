<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 

<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>会員登録 - パシャログ</title>
		<link rel="stylesheet" href="/css/signup.css"> 
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;700&family=Noto+Sans+JP:wght@400;700&display=swap" rel="stylesheet">
	</head>
	<body>
	    <div class="container">
	        <header class="header">
	        <a href="/" class="logo">パシャログ</a>
	</header>
	        <c:if test="${not empty errorMessage}">
	    <script>
	        alert('${errorMessage}');
	    </script>
			</c:if>
	        
	        <main class="main-form">
	            <div class="form-container">
	                <h1 class="form-title">新規会員登録</h1>
	              <form id="signupForm" action="/signup" method="post" onsubmit="return validateForm()" enctype="multipart/form-data">
				  <div class="profile-image-wrapper">
				  <label for="profile-image" class="form-label">プロフィールイメージ</label>
					  <div class="profile-image">
					    <img id="profilePreview" src="/img/default_profile.svg" alt="選択しないと基本イメージになります" 
					         style="width: 100%; height: 100%; object-fit: cover; border-radius: 10px;">	 
					  </div>
					  <div class="profile-image-buttons">
					    <input type="file" id="imageInput" name="profileImg" accept="image/*" style="display: none;">
					    <button type="button" class="image-action-button" onclick="document.getElementById('imageInput').click()">画像選択</button>
					    <button type="button" class="image-action-button" onclick="deleteProfileImage()">削除</button>
					  </div>
					</div>
	
				    <div class="form-group">
				        <label for="loginId" class="form-label">ID</label>
				        <input type="text" id="loginId" name="loginid" class="form-input" placeholder="ログインIDを入力" required>
					        <div class="input-guide">※半角英数字で6~12文字で入力してください</div>
					        <div class="input-message" id="loginId-message"></div>
					        	<button type="button" class="btn-check-id" onclick="checkLoginId()">ID 重複チェック</button>
				        <p id="loginid-check-msg" style="margin-top: 5px;"></p>
				    </div>
	
				    <div class="form-group">
				        <label for="nickname" class="form-label">ニックネーム</label>
				        <input type="text" id="nickname" name="nickname" class="form-input" placeholder="ニックネーム入力" required>
				        	<div class="input-guide">※半角英数字で6~12文字で入力してください</div>
				        	<div class="input-message" id="nickname-message"></div>
				        		<button type="button" class="btn-check-nickname" onclick="checkNickname()">ニックネーム 重複チェック</button>
				        <p id="nickname-check-msg" style="margin-top: 5px;"></p>
				    </div>
	
				    <div class="form-group">
				        <label for="email" class="form-label">メール</label>
				        <input type="email" id="email" name="email" class="form-input" placeholder="メールアドレスを入力" required>
				        	<div class="input-guide">※正しいメール形式で入力してください</div>
				        	<div class="input-message" id="email-message"></div>
				    </div>
	
				    <div class="form-group">
				        <label for="password" class="form-label">パスワード</label>
				          <div class="password-wrapper">
						    <input type="password" id="password" name="password" class="form-input" placeholder="パスワードを入力" required>
						    <i id="togglePassword" class="fa-solid fa-eye toggle-password"></i>
						  </div>
				        	<div class="input-guide">※英数字で6~12文字で入力してください</div>
				        	<div class="input-message" id="password-message"></div>
				    </div>
	
				    <div class="form-group">
				        <label for="passwordConfirm" class="form-label">パスワード(再確認)</label>
				        <input type="password" id="passwordConfirm" class="form-input" placeholder="パスワードを入力" required oninput="checkPasswordMatch()">
				        <div class="input-message" id="passwordConfirm-message"></div>
				    </div>
	
	    				<button type="submit" class="submit-button">会員登録する</button>
				</form>
	            </div>
	        </main>
	    </div>
		<script src="/js/signup.js"></script>
	</body>
</html>