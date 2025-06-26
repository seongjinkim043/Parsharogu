document.addEventListener("DOMContentLoaded", function () {
  // DOM 요소 참조
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

  const imageInput = document.getElementById("imageInput");
  const previewImg = document.getElementById("profilePreview");
  const defaultImageSrc = "/img/default-profile.png";

  const idRegex = /^[a-z0-9]{6,12}$/;
  const passwordRegex = /^[A-Za-z0-9]{6,12}$/;
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  // 실시간 입력 검사
  loginId.addEventListener("input", function () {
    if (!idRegex.test(this.value)) {
      idMessage.textContent = "6〜12文字の半角英数字で入力してください。";
      idMessage.style.color = "red";
    } else {
      idMessage.textContent = "生成条件に当たるIDです。";
      idMessage.style.color = "green";
    }
  });

  nickname.addEventListener("input", function () {
    if (!idRegex.test(this.value)) {
      nickMessage.textContent = "6〜12文字の半角英数字で入力してください。";
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

  // 눈 아이콘 클릭 시 비밀번호 보기 토글
  const toggle = document.getElementById("togglePassword");
  if (toggle) {
    toggle.addEventListener("click", function () {
      const isPassword = password.type === "password";
      password.type = isPassword ? "text" : "password";
      toggle.classList.toggle("fa-eye");
      toggle.classList.toggle("fa-eye-slash");
    });
  }

  // 이미지 업로드 미리보기
  imageInput.addEventListener("change", function () {
    const file = this.files[0];
    if (!file) return;

    const fileName = file.name.toLowerCase();
    const extension = fileName.split('.').pop();
    const allowedExtensions = ['jpg', 'jpeg', 'png'];
    const maxSize = 3 * 1024 * 1024;
    const maxWidth = 512;
    const maxHeight = 512;

    if (!allowedExtensions.includes(extension)) {
      alert("画像ファイル（jpg, jpeg, png）のみアップロード可能です。");
      resetImageInput();
      return;
    }

    if (file.size > maxSize) {
      alert("ファイルサイズは3MB以下にしてください。");
      resetImageInput();
      return;
    }

    const reader = new FileReader();
    reader.onload = function (e) {
      const img = new Image();
      img.onload = function () {
        if (img.width > maxWidth || img.height > maxHeight) {
          alert("画像サイズは512×512ピクセル以下にしてください。");
          resetImageInput();
          return;
        }
        previewImg.src = e.target.result;
        previewImg.style.display = "block";
        document.querySelector(".profile-image").style.backgroundImage = "none";
      };
      img.src = e.target.result;
    };
    reader.readAsDataURL(file);
  });

  function resetImageInput() {
    imageInput.value = "";
    previewImg.src = "";
    previewImg.style.display = "none";
  }

  // 이미지 삭제 버튼 동작
  window.deleteProfileImage = function () {
    resetImageInput();
    previewImg.src = defaultImageSrc;
  };
});

// 유효성 검사 함수 (form onsubmit 연결용)
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

  function blinkMessage(element) {
    element.style.animation = "blink 0.3s ease-in-out 3";
  }

  if (!idRegex.test(loginId.value)) {
    idMessage.textContent = "6〜12文字の半角字英数字で入力してください。";
    idMessage.style.color = "red";
    blinkMessage(idMessage);
    if (!firstInvalidField) firstInvalidField = loginId;
    isValid = false;
  }

  if (!idRegex.test(nickname.value)) {
    nickMessage.textContent = "6〜12文字の半角字英数字で入力してください。";
    nickMessage.style.color = "red";
    blinkMessage(nickMessage);
    if (!firstInvalidField) firstInvalidField = nickname;
    isValid = false;
  }

  if (!emailRegex.test(email.value)) {
    emailMessage.textContent = "正しいメールアドレスを入力してください。";
    emailMessage.style.color = "red";
    blinkMessage(emailMessage);
    if (!firstInvalidField) firstInvalidField = email;
    isValid = false;
  }

  if (!passwordRegex.test(password.value)) {
    pwMessage.textContent = "6〜12文字の英数字で入力してください。";
    pwMessage.style.color = "red";
    blinkMessage(pwMessage);
    if (!firstInvalidField) firstInvalidField = password;
    isValid = false;
  }

  if (password.value !== passwordConfirm.value) {
    pwConfirmMessage.textContent = "パスワードが一致しません。";
    pwConfirmMessage.style.color = "red";
    blinkMessage(pwConfirmMessage);
    if (!firstInvalidField) firstInvalidField = passwordConfirm;
    isValid = false;
  }

  if (!isValid && firstInvalidField) {
    alert("入力内容に誤りがあります。内容を確認してください。");
    firstInvalidField.focus();
  }

  return isValid;
}

// ID 중복 체크
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

// 닉네임 중복 체크
function checkNickname() {
  const nicknameInput = document.getElementById("nickname");
  const checkMsg = document.getElementById("nickname-check-msg");
  const nickname = nicknameInput.value;

  if (!nickname) {
    checkMsg.textContent = "ニックネームを入力してください。";
    checkMsg.style.color = "red";
    return;
  }

  const url = "/check-nickname?nickname=" + encodeURIComponent(nickname);
  fetch(url)
    .then(res => res.json())
    .then(data => {
      if (data.exists) {
        checkMsg.textContent = "重複されているニックネームです。";
        checkMsg.style.color = "red";
      } else {
        checkMsg.textContent = "重複しないニックネームです。";
        checkMsg.style.color = "green";
      }
    })
    .catch(() => {
      checkMsg.textContent = "サーバーエラーが発生しました。";
      checkMsg.style.color = "red";
    });
}
