<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


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
            position: relative;
        }

        .container {
            width: 100%;
            max-width: 1920px;
            margin: 0 auto;
            position: relative;
            min-height: 100vh;
        }

        .header {
            position: absolute;
            top: 73px;
            right: 460px;
            z-index: 10;
        }

        .logo {
            font-size: 36px;
            font-weight: 700;
            color: #000000;
            line-height: 1.2;
        }

        .main-form {
            position: absolute;
            top: 190px;
            left: 460px;
            width: 1000px;
            height: 800px;
            background-color: #FFFFFF;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-container {
            width: 730px;
            height: 501px;
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

        .footer-links {
            position: absolute;
            bottom: 212px;
            left: 722px;
            font-size: 20px;
            font-weight: 500;
            color: #46A6FF;
            line-height: 1.2;
            text-decoration: none;
            cursor: pointer;
        }

        .footer-links:hover {
            text-decoration: underline;
        }

        .link-separator {
            margin: 0 20px;
            color: #46A6FF;
        }

        .signup-link, .help-link {
            color: #46A6FF;
            text-decoration: none;
        }

        .signup-link:hover, .help-link:hover {
            text-decoration: underline;
        }

        /* Responsive design */
        @media (max-width: 1400px) {
            .main-form {
                left: 50%;
                transform: translateX(-50%);
            }
            
            .header {
                right: 50%;
                transform: translateX(50%);
            }
            
            .footer-links {
                left: 50%;
                transform: translateX(-50%);
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
                position: static;
                text-align: center;
                padding: 20px;
            }
            
            .footer-links {
                position: static;
                text-align: center;
                margin-top: 40px;
                display: block;
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
            
            .footer-links {
                font-size: 16px;
                margin-top: 30px;
            }
        }

        @media (max-width: 480px) {
            .footer-links {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 10px;
            }
            
            .link-separator {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header class="header">
            <div class="logo">パシャログ</div>
        </header>
        
        <main class="main-form">
            <div class="form-container">
                <h1 class="form-title">ログイン</h1>
                
                <form id="loginForm">
                    <div class="form-group">
                        <label for="loginId" class="form-label">ログインID</label>
                        <input type="text" id="loginId" name="loginId" class="form-input" placeholder="ログインIDを入力" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password" class="form-label">パスワード</label>
                        <input type="password" id="password" name="password" class="form-input" placeholder="パスワードを入力" required>
                    </div>
                    
                    <button type="submit" class="login-button">ログインする</button>
                </form>
            </div>
        </main>
        
        <footer class="footer-links">
            <a href="#" class="signup-link">アカウント制作</a>
            <span class="link-separator">·</span>
            <a href="#" class="help-link">ログインができない方はこちら</a>
        </footer>
    </div>

    <script>
        // 폼 제출 처리
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const loginId = document.getElementById('loginId').value;
            const password = document.getElementById('password').value;
            
            if (!loginId || !password) {
                alert('ログインIDとパスワードを入力してください。');
                return;
            }
            
            // 여기에 실제 로그인 로직을 구현할 수 있습니다
            console.log('Login attempt:', { loginId, password });
            alert('ログイン処理中...');
        });

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