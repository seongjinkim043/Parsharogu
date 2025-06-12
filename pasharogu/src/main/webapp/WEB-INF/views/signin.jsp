<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            color: #8D8D8D;
            text-align: center;
            margin-bottom: 120px;
            line-height: 1.2;
        }

        .profile-image {
            width: 160px;
            height: 160px;
            background-color: #D9D9D9;
            border-radius: 10px;
            margin-bottom: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            cursor: pointer;
        }

        .profile-image::after {
            content: 'イメージ';
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

        .submit-button {
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

        .submit-button:hover {
            background-color: #6D6D6D;
        }

        .submit-button:active {
            background-color: #5D5D5D;
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
            
            .header {
                position: static;
                text-align: center;
                padding: 20px;
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
                <h1 class="form-title">アカウント制作</h1>
                
                <form id="signupForm">
                    <div class="profile-image" onclick="document.getElementById('imageInput').click()">
                        <input type="file" id="imageInput" accept="image/*" style="display: none;">
                    </div>
                    
                    <div class="form-group">
                        <label for="nickname" class="form-label">ニックネーム</label>
                        <input type="text" id="nickname" name="nickname" class="form-input" placeholder="ニックネーム入力" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="loginId" class="form-label">ID</label>
                        <input type="text" id="loginId" name="loginId" class="form-input" placeholder="ログインIDを入力" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password" class="form-label">パスワード</label>
                        <input type="password" id="password" name="password" class="form-input" placeholder="パスワードを入力" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="passwordConfirm" class="form-label">パスワード(再確認)</label>
                        <input type="password" id="passwordConfirm" name="passwordConfirm" class="form-input" placeholder="パスワードを入力" required>
                    </div>
                    
                    <button type="submit" class="submit-button">アカウント制作完了</button>
                </form>
            </div>
        </main>
    </div>

    <script>
        // 이미지 업로드 기능
        document.getElementById('imageInput').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const profileImage = document.querySelector('.profile-image');
                    profileImage.style.backgroundImage = `url(${e.target.result})`;
                    profileImage.style.backgroundSize = 'cover';
                    profileImage.style.backgroundPosition = 'center';
                    profileImage.innerHTML = ''; // 텍스트 제거
                };
                reader.readAsDataURL(file);
            }
        });

        // 폼 제출 처리
        document.getElementById('signupForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const password = document.getElementById('password').value;
            const passwordConfirm = document.getElementById('passwordConfirm').value;
            
            if (password !== passwordConfirm) {
                alert('パスワードが一致しません。');
                return;
            }
            
            // 여기에 실제 회원가입 로직을 구현할 수 있습니다
            alert('アカウント制作が完了しました！');
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
    </script>
</body>
</html>