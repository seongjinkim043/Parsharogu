function blinkMessage(element) {
    element.style.animation = "blink 0.3s ease-in-out 3";
}

function validateForm() {
    let isValid = true;
    let firstInvalidField = null;

    const idRegex = /^[a-z0-9]{6,12}$/;
    const passwordRegex = /^[A-Za-z0-9]{6,12}$/;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    const loginId = document.getElementById("loginId");
    const nickname = document.getElementById("nickname");
    const email = document.getElementById("email");
    const password = document.getElementById("password");
    const passwordConfirm = document.getElementById("passwordConfirm");

    const idMessage = document.getElementById("loginId-message");
    const nickMessage = document.getElementById("nickname-message");
    const emailMessage = document.getElementById("email-message");
    const pwMessage = document.getElementById("password-message");
    const pwConfirmMessage = document.getElementById("passwordConfirm-message");

    // ID 검사
    if (!idRegex.test(loginId.value)) {
        idMessage.textContent = "6〜12文字の小文字英数字で入力してください。";
        idMessage.style.color = "red";
        blinkMessage(idMessage);
        if (!firstInvalidField) firstInvalidField = loginId;
        isValid = false;
    }

    // 닉네임 검사
    if (!idRegex.test(nickname.value)) {
        nickMessage.textContent = "6〜12文字の小文字英数字で入力してください。";
        nickMessage.style.color = "red";
        blinkMessage(nickMessage);
        if (!firstInvalidField) firstInvalidField = nickname;
        isValid = false;
    }

    // 이메일 검사
    if (!emailRegex.test(email.value)) {
        emailMessage.textContent = "正しいメールアドレスを入力してください。";
        emailMessage.style.color = "red";
        blinkMessage(emailMessage);
        if (!firstInvalidField) firstInvalidField = email;
        isValid = false;
    }

    // 비밀번호 검사
    if (!passwordRegex.test(password.value)) {
        pwMessage.textContent = "6〜12文字の英数字で入力してください。";
        pwMessage.style.color = "red";
        blinkMessage(pwMessage);
        if (!firstInvalidField) firstInvalidField = password;
        isValid = false;
    }

    // 비밀번호 일치 검사
    if (password.value !== passwordConfirm.value) {
        pwConfirmMessage.textContent = "パスワードが一致しません。";
        pwConfirmMessage.style.color = "red";
        blinkMessage(pwConfirmMessage);
        if (!firstInvalidField) firstInvalidField = passwordConfirm;
        isValid = false;
    }

    if (!isValid && firstInvalidField) {
        firstInvalidField.focus(); // 가장 먼저 잘못된 항목에 포커스
    }

    return isValid;
}

function checkLoginId() {
    const loginIdInput = document.getElementById("loginId");
    const checkMsg = document.getElementById("loginid-check-msg");
    const loginid = loginIdInput.value;

    if (!loginid) {
        checkMsg.textContent = "IDを入力してください。";
        checkMsg.style.color = "red";
        return;
    }

    const url = "/check-username?loginid=" + encodeURIComponent(loginid);
    fetch(url)
        .then(res => res.json())
        .then(data => {
            if (data.exists) {
                checkMsg.textContent = "重複されているIDです。";
                checkMsg.style.color = "red";
            } else {
                checkMsg.textContent = "重複しないIDです。";
                checkMsg.style.color = "green";
            }
        })
        .catch(() => {
            checkMsg.textContent = "サーバーエラーが発生しました。";
            checkMsg.style.color = "red";
        });
}

document.addEventListener("DOMContentLoaded", function () {
    const imageInput = document.getElementById("imageInput");
    const previewImg = document.getElementById("profilePreview");
    const profileImage = document.querySelector(".profile-image");

    const loginId = document.getElementById("loginId");
    const nickname = document.getElementById("nickname");
    const email = document.getElementById("email");
    const password = document.getElementById("password");
    const passwordConfirm = document.getElementById("passwordConfirm");

    const idRegex = /^[a-z0-9]{6,12}$/;
    const passwordRegex = /^[A-Za-z0-9]{6,12}$/;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    const idMessage = document.getElementById("loginId-message");
    const nickMessage = document.getElementById("nickname-message");
    const emailMessage = document.getElementById("email-message");
    const pwMessage = document.getElementById("password-message");
    const pwConfirmMessage = document.getElementById("passwordConfirm-message");

    loginId.addEventListener("input", function () {
        if (!idRegex.test(this.value)) {
            idMessage.textContent = "6〜12文字の小文字英数字で入力してください。";
            idMessage.style.color = "red";
        } else {
            idMessage.textContent = "生成条件に当たるIDです。";
            idMessage.style.color = "green";
        }
    });

    nickname.addEventListener("input", function () {
        if (!idRegex.test(this.value)) {
            nickMessage.textContent = "6〜12文字の小文字英数字で入力してください。";
            nickMessage.style.color = "red";
        } else {
            nickMessage.textContent = "生成条件に当たるニックネームです。";
            nickMessage.style.color = "green";
        }
    });

    email.addEventListener("input", function () {
        if (!emailRegex.test(this.value)) {
            emailMessage.textContent = "正しいメールアドレスを入力してください。";
            emailMessage.style.color = "red";
        } else {
            emailMessage.textContent = "使用可能なメール形式です。";
            emailMessage.style.color = "green";
        }
    });

    password.addEventListener("input", function () {
        if (!passwordRegex.test(this.value)) {
            pwMessage.textContent = "6〜12文字の英数字で入力してください。";
            pwMessage.style.color = "red";
        } else {
            pwMessage.textContent = "安全なパスワードです。";
            pwMessage.style.color = "green";
        }

        checkPasswordMatch();
    });

    passwordConfirm.addEventListener("input", checkPasswordMatch);

    function checkPasswordMatch() {
        if (password.value !== passwordConfirm.value) {
            pwConfirmMessage.textContent = "パスワードが一致しません。";
            pwConfirmMessage.style.color = "red";
        } else if (password.value && passwordConfirm.value) {
            pwConfirmMessage.textContent = "一致しました。";
            pwConfirmMessage.style.color = "green";
        } else {
            pwConfirmMessage.textContent = "";
        }
    }

	imageInput.addEventListener("change", function () {
	    const file = this.files[0];
	    const previewImg = document.getElementById("profilePreview");
	    const allowedExtensions = ['jpg', 'jpeg', 'png'];
	    const maxSize = 3 * 1024 * 1024; // 3MB
	    const maxWidth = 512;
	    const maxHeight = 512;

	    if (!file) return;

	    const fileName = file.name.toLowerCase();
	    const extension = fileName.split('.').pop();

	    // 확장자 검사
	    if (!allowedExtensions.includes(extension)) {
	        alert("画像ファイル（jpg, jpeg, png）のみアップロード可能です。");
	        resetImageInput();
	        return;
	    }

	    // 용량 검사
	    if (file.size > maxSize) {
	        alert("ファイルサイズは3MB以下にしてください。");
	        resetImageInput();
	        return;
	    }

	    // 해상도 검사
	    const reader = new FileReader();
	    reader.onload = function (e) {
	        const img = new Image();
	        img.onload = function () {
	            if (img.width > maxWidth || img.height > maxHeight) {
	                alert("画像サイズは512×512ピクセル以下にしてください。");
	                resetImageInput();
	                return;
	            }

	            // 모든 조건 통과 시 미리보기 표시
	            previewImg.src = e.target.result;
	            previewImg.style.display = "block";
	            document.querySelector(".profile-image").style.backgroundImage = "none";
	        };
	        img.src = e.target.result;
	    };
	    reader.readAsDataURL(file);

	    function resetImageInput() {
	        imageInput.value = "";
	        previewImg.src = "";
	        previewImg.style.display = "none";
	    }
	});

	const defaultImageSrc = "/img/default-profile.png";

	    window.deleteProfileImage = function () {
	        imageInput.value = "";
	        previewImg.src = "";
	        previewImg.style.display = defaultImageSrc;
	    };
	});
