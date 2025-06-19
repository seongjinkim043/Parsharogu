<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ログイン - パシャログ</title>
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
            display: flex;
            flex-direction: column; 
            align-items: center;
            justify-content: center;
            overflow-x: hidden; 
        }

        .container {
            width: 100%;
            max-width: 1920px;
            padding: 60px 20px;
        }

        .header {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    margin-bottom: 40px;
        }

        .logo {
            
            font-size: 36px;
            font-weight: 700;
            color: #1976D2;
            text-decoration: none; 
        }

        .main-form {
            width: 100%;
            max-width: 1000px;
            background-color: #FFFFFF;
            border-radius: 10px;
            padding: 80px 60px;
            display: flex;
            justify-content: center;
            box-shadow: 0 4px 20px rgba(25, 118, 210, 0.15);
            margin: 0 auto;
        }

        .form-container {
            width: 100%;
            max-width: 730px;
        }

        .form-title {
            font-size: 36px;
            font-weight: 400;
            color: #64B5F6;
            text-align: center;
            margin-bottom: 80px;
        }

        .form-group {
            margin-bottom: 40px;
        }

        .form-label {
            font-size: 24px;
            font-weight: 500;
            color: #42A5F5;
            margin-bottom: 10px;
            display: block;
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
            line-height: 1.2;
        }

        .form-input::placeholder {
            color: #FFFFFF;
            opacity: 1
        }

        .form-input:focus {
            outline: none;
            background-color: #BFBFBF; /* 갈색 */
        }

        .login-button {
            width: 100%;
            height: 60px;
            background-color: #42A5F5;
            border: none;
            border-radius: 10px;
            font-size: 24px;
            color: #FFFFFF;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .login-button:hover {
            background-color: #2196F3;
        }

        .login-button:active {
            background-color: #1976D2;
        }

        .forgot-link {
            text-align: center;
            margin-top: -20px;
            margin-bottom: 40px;
        }

        .forgot-password-link {
            font-size: 16px;
            color: #1976D2;
            text-decoration: none;
        }

        .forgot-password-link:hover {
            text-decoration: underline;
        }

        .alert-password {
            font-size: 14px;
            color: #444;
            text-align: center;
            margin-bottom: 40px;
        }

        @media (max-width: 768px) {
            .main-form {
                padding: 40px 20px;
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

            .login-button {
                font-size: 20px;
                height: 50px;
            }
        }
    </style>
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
                        <input type="password" id="password" name="password" class="form-input" placeholder="パスワードを入力してください" required>
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
	   <script>
	   </script>
	</body>
</html>