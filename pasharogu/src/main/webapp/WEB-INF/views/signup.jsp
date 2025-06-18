<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> --%>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>アカウント制作 - パシャログ</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;500;700&display=swap" rel="stylesheet">
 <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans JP', sans-serif;
            background-color: #E3F2FD;
            min-height: 100vh;
            position: relative;
        }

        .container {
            width: 100%;
            max-width: 1920px;
            margin: 0 auto;
            position: absolute;
            min-height: 100vh;
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
            width: 100%;
        }

        .logo {
            font-size: 36px;
            font-weight: 700;
            color: #1976D2;
            line-height: 1.2;
            text-decoration: none; /* 링크 스타일 제거 */
        }

        .main-form {
            position: absolute;
            top: 190px;
            left: 460px;
            width: 1000px;
            height: 1237px;
            background-color: #FFFFFF;
            border-radius: 10px;
            padding: 107px 135px;
        }

        .form-container {
            width: 730px;
            height: 1023px;
        }

        .form-title {
            font-size: 36px;
            font-weight: 400;
            color: #64B5F6;
            text-align: center;
            margin-bottom: 120px;
            line-height: 1.2;
        }

        .profile-image {
		    width: 160px;
		    height: 160px;
		    background-color: #64B5F6;
		    border-radius: 10px;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    position: relative;
		    cursor: pointer;
		    transition: background-color 0.2s ease;
		}

        .profile-image::after {
		    content: 'イメージ　選択';
		    font-size: 12px;
		    color: #000000;
		    font-weight: 400;
		    line-height: 1.2;
		}

        .form-group {
            margin-bottom: 40px;
            position: relative;
        }

        .form-group:last-of-type {
            margin-bottom: 84px;
        }

        .form-label {
            font-size: 24px;
            font-weight: 500;
            color: #42A5F5;
            margin-bottom: 10px;
            display: block;
            line-height: 1.2;
        }

        .form-input {
            width: 100%;
            height: 60px;
            background-color: #BBDEFB;
            border: none;
            border-radius: 10px;
            padding: 0 20px;
            font-size: 24px;
            font-weight: 400;
            color: #FFFFFF;
            font-family: 'Noto Sans JP', sans-serif;
            line-height: 1.2;
        }

        .form-input::placeholder {
            color: #FFFFFF;
            opacity: 1;
        }

        .form-input:focus {
            outline: none;
            background-color: #BFBFBF;
        }

        .submit-button {
            width: 100%;
            height: 60px;
            background-color: #42A5F5;
            border: none;
            border-radius: 10px;
            font-size: 24px;
            font-weight: 500;
            color: #FFFFFF;
            cursor: pointer;
            font-family: 'Noto Sans JP', sans-serif;
            line-height: 1.2;
            transition: background-color 0.3s ease;
        }

        .submit-button:hover {
            background-color: #6D6D6D;
        }

        .submit-button:active {
            background-color: #5D5D5D;
        }
        .profile-image-wrapper {
			    position: relative;
			    display: inline-block;
			    margin-bottom: 40px;
			}

          .delete-image-button {
		    position: absolute;
		    bottom: 0;
		    right: 0;
		    transform: translate(90%, 90%); /* 정확히 "바깥 우하단" */
		    font-size: 14px;
		    background-color: #64B5F6;
		    color: #000000;
		    border: none;
		    border-radius: 8px;
		    padding: 6px 10px;
		    cursor: pointer;
		    transition: background-color 0.2s ease;
		}

        .delete-image-button:hover {
		    background-color: #C0C0C0;
		}

        .password-message {
            font-size: 16px;
            margin-top: 8px;
            font-weight: 400;
            line-height: 1.2;
            min-height: 20px;
        }

        .password-message.match {
            color: #4CAF50;
        }

        .password-message.no-match {
            color: #8B4513;
        }
        
        .input-message {
		    font-weight: 400;
		    line-height: 1.2;
		    min-height: 20px;
		}

        /* Responsive design */
        @media (max-width: 1400px) {
            .main-form {
                left: 50%;
                transform: translateX(-50%);
            }
            
            
        }

        @media (max-width: 1080px) {
            .main-form {
                width: 90%;
                max-width: 800px;
                padding: 60px 40px;
            }
            
            .form-container {
                width: 100%;
            }
            
            
        }

        @media (max-width: 768px) {
            .main-form {
                top: 20px;
                padding: 40px 20px;
                min-height: calc(100vh - 40px);
            }
            
            .form-title {
                font-size: 28px;
                margin-bottom: 60px;
            }
            
            .form-label {
                font-size: 20px;
            }
            
            .form-input {
                font-size: 18px;
                height: 50px;
            }
            
            .submit-button {
                font-size: 20px;
                height: 50px;
            }
            
            .profile-image {
                width: 120px;
                height: 120px;
                margin: 0 auto 30px;
            }

            .password-message {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header class="header">
        <a href="/" class="logo">パシャログ</a>
</header>
        
        <main class="main-form">
            <div class="form-container">
                <h1 class="form-title">アカウント制作</h1>
                
                <form id="signupForm" action="/signup" method="post" onsubmit="return validateForm()" enctype="multipart/form-data">
				    <div class="profile-image-wrapper">
				        <div class="profile-image" onclick="document.getElementById('imageInput').click()">
						    <img id="profilePreview" src="" alt="選択された画像" style="width: 100%; height: 100%; object-fit: cover; display: none; border-radius: 10px;">
						    <input type="file" id="imageInput" name="profileImg" accept="image/*" style="display: none;">
						</div>
				        <button type="button" class="delete-image-button" onclick="deleteProfileImage()">削除</button>
				    </div>

				    <div class="form-group">
				        <label for="loginId" class="form-label">ID</label>
				        <input type="text" id="loginId" name="loginid" class="form-input" placeholder="ログインIDを入力" required>
									    
				    </div>

				    <div class="form-group">
				        <label for="nickname" class="form-label">ニックネーム</label>
				        <input type="text" id="nickname" name="nickname" class="form-input" placeholder="ニックネーム入力" required>
				    	
				    </div>
				    	

				    <div class="form-group">
				        <label for="email" class="form-label">メール</label>
				        <input type="email" id="email" name="email" class="form-input" placeholder="メールアドレスを入力" required>
				    	
				    </div>

				    <div class="form-group">
				        <label for="password" class="form-label">パスワード</label>
				        <input type="password" id="password" name="password" class="form-input" placeholder="パスワードを入力" required>
				    	
				    </div>

				    <div class="form-group">
				        <label for="passwordConfirm" class="form-label">パスワード(再確認)</label>
				        <input type="password" id="passwordConfirm" class="form-input" placeholder="パスワードを入力" required oninput="checkPasswordMatch()">
				        <div id="passwordMessage" class="password-message"></div>
				    </div>

				    <button type="submit" class="submit-button">アカウント制作完了</button>
				</form>
            </div>
        </main>
    </div>
<script>
    function validateForm() {
        const loginId = document.getElementById("loginId");
        const nickname = document.getElementById("nickname");
        const password = document.getElementById("password");
        const passwordConfirm = document.getElementById("passwordConfirm");

        const idRegex = /^[a-z0-9]{6,12}$/;
        const passwordRegex = /^[A-Za-z0-9]{6,12}$/;

        if (!idRegex.test(loginId.value)) {
            alert("IDが条件に一致しません。");
            return false;
        }

        if (!idRegex.test(nickname.value)) {
            alert("ニックネームが条件に一致しません。");
            return false;
        }

        if (!passwordRegex.test(password.value)) {
            alert("パスワードが条件に一致しません。");
            return false;
        }

        if (password.value !== passwordConfirm.value) {
            alert("パスワードが一致していません。");
            return false;
        }

        return true;
    }

    // ✅ 여기는 validateForm 함수 밖에 있어야 함!
    document.addEventListener("DOMContentLoaded", function () {
        const imageInput = document.getElementById("imageInput");
        const previewImg = document.getElementById("profilePreview");
        const profileImage = document.querySelector(".profile-image");

        const loginId = document.getElementById("loginId");
        const nickname = document.getElementById("nickname");
        const password = document.getElementById("password");
        const passwordConfirm = document.getElementById("passwordConfirm");
        const passwordMessage = document.getElementById("passwordMessage");

        const addMessageSpan = (inputElem) => {
            let span = document.createElement("div");
            span.className = "input-message";
            span.style.fontSize = "14px";
            span.style.marginTop = "6px";
            span.style.height = "20px";
            span.style.color = "#8B4513";
            inputElem.parentElement.appendChild(span);
            return span;
        };

        const idMessage = addMessageSpan(loginId);
        const nickMessage = addMessageSpan(nickname);
        const pwMessage = addMessageSpan(password);

        const idRegex = /^[a-z0-9]{6,12}$/;
        const passwordRegex = /^[A-Za-z0-9]{6,12}$/;

        loginId.addEventListener("input", function () {
            if (!idRegex.test(this.value)) {
                idMessage.textContent = "6〜12文字の小文字英数字で入力してください。";
                idMessage.style.color = "#8B4513";
            } else {
                idMessage.textContent = "使用可能なIDです。";
                idMessage.style.color = "green";
            }
        });

        nickname.addEventListener("input", function () {
            if (!idRegex.test(this.value)) {
                nickMessage.textContent = "6〜12文字の小文字英数字で入力してください。";
                nickMessage.style.color = "#8B4513";
            } else {
                nickMessage.textContent = "使用可能なニックネームです。";
                nickMessage.style.color = "green";
            }
        });

        password.addEventListener("input", function () {
            if (!passwordRegex.test(this.value)) {
                pwMessage.textContent = "6〜12文字の英数字で入力してください。";
                pwMessage.style.color = "#8B4513";
            } else {
                pwMessage.textContent = "安全なパスワードです。";
                pwMessage.style.color = "green";
            }

            checkPasswordMatch();
        });

        passwordConfirm.addEventListener("input", checkPasswordMatch);

        function checkPasswordMatch() {
            if (password.value !== passwordConfirm.value) {
                passwordMessage.textContent = "パスワードが一致しません。";
                passwordMessage.style.color = "red";
            } else if (password.value && passwordConfirm.value) {
                passwordMessage.textContent = "一致しました。";
                passwordMessage.style.color = "green";
            } else {
                passwordMessage.textContent = "";
            }
        }

        imageInput.addEventListener("change", function () {
            if (this.files && this.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    previewImg.src = e.target.result;
                    previewImg.style.display = "block";
                    profileImage.style.backgroundImage = "none";
                };
                reader.readAsDataURL(this.files[0]);
            }
        });

        window.deleteProfileImage = function () {
            imageInput.value = "";
            previewImg.src = "";
            previewImg.style.display = "none";
        };
    });
</script>




  
</body>
</html>