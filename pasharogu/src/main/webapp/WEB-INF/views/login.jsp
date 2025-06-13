<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
            background-color: #F4F4F4;
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
            text-align: center;
            margin-bottom: 40px;
            width: 100%;
        }

       .logo {
            font-size: 36px;
            font-weight: 700;
            color: #000000;
            line-height: 1.2;
            display: inline-block;
            text-decoration: none; 
        }


       
        .main-form {
            width: 100%;
            max-width: 1000px;
            background-color: #FFFFFF;
            border-radius: 10px;
            padding: 80px 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            margin: 0 auto;
        }

        .form-container {
            width: 100%;
            max-width: 730px;
        }

        .form-title {
            font-size: 36px;
            font-weight: 400;
            color: #8D8D8D;
            text-align: center;
            margin-bottom: 80px;
            line-height: 1.2;
        }

        .form-group {
            margin-bottom: 40px;
            position: relative;
        }

        .form-group:last-of-type {
            margin-bottom: 80px;
        }

        .form-label {
            font-size: 24px;
            font-weight: 500;
            color: #8D8D8D;
            margin-bottom: 10px;
            display: block;
            line-height: 1.2;
        }

        .form-input {
            width: 100%;
            height: 60px;
            background-color: #D9D9D9;
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

        .login-button {
            width: 100%;
            height: 60px;
            background-color: #8D8D8D;
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

        .login-button:hover {
            background-color: #6D6D6D;
        }

        .login-button:active {
            background-color: #5D5D5D;
        }

        .forgot-link {
            text-align: center;
            margin-top: -20px;   
            margin-bottom: 40px; 
        }

        .forgot-password-link {
            font-size: 16px;
            color: #5C4033; 
            text-decoration: none;
        }

        .forgot-password-link:hover {
            text-decoration: underline;
        }




        /* Responsive design */
       @media (max-width: 1400px) {
    .main-form {
    
        left: unset;
        transform: none;
            }
    }
        @media (max-width: 1080px) {
            .main-form {
                width: 90%;
                max-width: 800px;
                padding: 60px 40px;
                height: auto;
                min-height: 600px;
            }
            
            .form-container {
                width: 100%;
            }
            
             .header {
                right: unset;
                transform: none;
            }
        }

        @media (max-width: 768px) {
            .main-form {
                top: 20px;
                padding: 40px 20px;
                min-height: calc(100vh - 140px);
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
    <div class="container">
    <header class="header">
       
        <a href="/" class="logo">パシャログ</a>
    </header>
</div>
        
             
        <main class="main-form">
            <div class="form-container">
                <h1 class="form-title">ログイン</h1>
                
                <c:if test="${not empty error}">
		            <div style="color: red; margin-bottom: 20px; font-weight: bold;">
		                ${error}
		            </div>
		        </c:if>
                <!-- 이부분으로 로그인 정보가 들어온다. -->
                <form id="loginForm" action="/user/login" method="post">
                    <div class="form-group">
                        <label class="form-label" for="loginId">ログインID</label>
                        <input type="text" id="username" name="loginId" class="form-input" placeholder="ログインIDを入力" required autofocus>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="password">パスワード (半角英数字)</label>
                        <input type="password" id="password" class="form-input" placeholder="パスワードを入力してください">
                    </div>
                    
                    <div class="forgot-link">
                        <a href="#" class="forgot-password-link">ログインができない方はこちら</a>
                    </div>
                    <div class="alert-password">
                        <a type="text">※パスワードは定期的に推測されにくいものへご変更をお願いします。</a>
                    </div>

                    <button type="submit" class="login-button">ログインする</button>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
                </form>
            </div>
        </main>
        
        
        
   

    <script>

        // 입력 필드 포커스 효과
        const inputs = document.querySelectorAll('.form-input');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.style.backgroundColor = '#BFBFBF';
            });
            
            input.addEventListener('blur', function() {
                this.style.backgroundColor = '#D9D9D9';
            });
        });

        // 회원가입 링크 클릭 처리
        document.querySelector('.signup-link').addEventListener('click', function(e) {
            e.preventDefault();
            alert('アカウント制作ページに移動します。');
            // 실제로는 회원가입 페이지로 이동
            // window.location.href = '/signup';
        });

        // 도움말 링크 클릭 처리
        document.querySelector('.help-link').addEventListener('click', function(e) {
            e.preventDefault();
            alert('パスワードリセットページに移動します。');
            // 실제로는 비밀번호 재설정 페이지로 이동
            // window.location.href = '/forgot-password';
        });
    </script>
</body>
</html>