function validateForm() {
    let isValid = true;
    const idRegex = /^[a-z0-9]{6,12}$/;
    const passwordRegex = /^[A-Za-z0-9]{6,12}$/;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    // 입력 요소들
    const loginId = document.getElementById("loginId");
    const nickname = document.getElementById("nickname");
    const email = document.getElementById("email");
    const password = document.getElementById("password");
    const passwordConfirm = document.getElementById("passwordConfirm");

    // 메시지 출력 요소들
    const idMessage = document.getElementById("loginId-message");
    const nickMessage = document.getElementById("nickname-message");
    const emailMessage = document.getElementById("email-message");
    const pwMessage = document.getElementById("password-message");
    const pwConfirmMessage = document.getElementById("passwordConfirm-message");

    // ID 검사
    if (!idRegex.test(loginId.value)) {
        idMessage.textContent = "6〜12文字の小文字英数字で入力してください。";
        idMessage.style.color = "red";
        isValid = false;
    }

    // 닉네임 검사
    if (!idRegex.test(nickname.value)) {
        nickMessage.textContent = "6〜12文字の小文字英数字で入力してください。";
        nickMessage.style.color = "red";
        isValid = false;
    }

    // 이메일 검사
    if (!emailRegex.test(email.value)) {
        emailMessage.textContent = "正しいメールアドレスを入力してください。";
        emailMessage.style.color = "red";
        isValid = false;
    }

    // 비밀번호 검사
    if (!passwordRegex.test(password.value)) {
        pwMessage.textContent = "6〜12文字の英数字で入力してください。";
        pwMessage.style.color = "red";
        isValid = false;
    }

    // 비밀번호 일치 검사
    if (password.value !== passwordConfirm.value) {
        pwConfirmMessage.textContent = "パスワードが一致しません。";
        pwConfirmMessage.style.color = "red";
        isValid = false;
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
	const defaultImageSrc = "/img/default-profile.png";

    window.deleteProfileImage = function () {
        imageInput.value = "";
        previewImg.src = "";
        previewImg.style.display = defaultImageSrc;
    };
});
